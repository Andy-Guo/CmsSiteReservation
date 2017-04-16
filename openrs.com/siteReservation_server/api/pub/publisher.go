package pub

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"io/ioutil"
	"net/http"
	"sync"

	"time"

	"jd.com/cc/jstack-cc-common/message/north/mq"
	"openrs.com/siteReservation_server/api/log"
)

type Publisher struct {
	gwClient   *http.Client
	ctrlClient *http.Client
	gwSyncUrl  string
	ctrlUrl    string
	ctrlPort   int
	waitGroup  sync.WaitGroup

	quit chan struct{}

	msg2Gw   chan *PublishInfo
	msg2Ctrl chan *PublishInfo
}
type PublishInfo struct {
	TopicList []string
	Message   []byte
}

func (p *Publisher) Publish(topicList []string, msg *mq.NotifyMsg) error {
	log.Debug("[Publisher/pub/Publish] [NotifyMsg: %+v, topicList: %+v]", *msg, topicList)
	msgJson, err := json.Marshal(msg)
	if err != nil {
		log.Error("[Publisher/pub/Publish] [json.Marshal: %s, data: %+v]", err.Error(), *msg)
		return err
	}
	var info = &PublishInfo{TopicList: topicList, Message: msgJson}
	select {
	case p.msg2Gw <- info:
		log.Info("[Publisher/pub/Publish] [enQueue: msg2Gw, len: %d]", len(p.msg2Gw))
		return nil
	default:
		log.Warn("[Publisher/pub/Publish] [enQueue:Publish channel is full, topicList: %+v, queue: msg2Gw]", topicList)
		log.Debug("[Publisher/pub/Publish] [enQueue: Current size of channel is 1024!, queue: msg2Gw")
		return errors.New("Publish channel is full")
	}
}

func (p *Publisher) Close() {
	if p.quit != nil {
		close(p.quit)
		p.quit = nil
		p.waitGroup.Wait()
		close(p.msg2Gw)
		close(p.msg2Ctrl)
		log.Info("[Publisher/pub/Close] [info: recv quit signal]")
	}
}

func (p *Publisher) runGw() {
	log.Debug("[Publisher/pub/runGw] [info: Create gw success]")
	defer p.waitGroup.Done()
	for {
		select {
		case <-p.quit:
			log.Info("[Publisher/pub/runGw] [info: recv quit signal]")
			return
		case info := <-p.msg2Gw:
			log.Debug("[Publisher/pub/runGw] [deQueue: msg2Gw, message: %s, topicList: %+v]", string(info.Message), info.TopicList)
			p.notifyGw(info)
			unique := make(map[string]bool)
			for i := 0; i < len(info.TopicList); i++ {
				if _, ok := unique[info.TopicList[i]]; ok {
					continue
				}
				unique[info.TopicList[i]] = true
				msg := &PublishInfo{TopicList: info.TopicList[i : i+1], Message: info.Message}
				p.msg2Ctrl <- msg
				log.Info("[Publisher/pub/runGw] [enQueue: msg2Ctrl, len: %d]", len(p.msg2Ctrl))
			}
			log.Info("[Publisher/pub/runGw] [info: notify control msg, topicList: %+v, message: %s]",
				info.TopicList, string(info.Message))
		}
	}
}

func (p *Publisher) notifyGw(info *PublishInfo) error {
	start := time.Now()
	req, err := http.NewRequest("POST", p.gwSyncUrl, bytes.NewReader(info.Message))
	if err != nil {
		log.Error("[Publisher/pub/notifyGw] [errType: NewRequest error, url: %v, topicList: %v, message: %s, err: %s]",
			p.gwSyncUrl, info.TopicList, string(info.Message), err.Error())
		return err
	}
	req.Header.Add("Content-Type", "application/json")
	response, err := p.gwClient.Do(req)
	if err != nil {
		log.Warn("[Publisher/pub/notifyGw] [errorType: Do error, url: %v, topicList: %v, message: %s, err: %s]",
			p.gwSyncUrl, info.TopicList, string(info.Message), err.Error())
		return err
	}
	defer response.Body.Close()
	_, err = ioutil.ReadAll(response.Body)
	if err != nil {
		log.Warn("[Publisher/pub/notifyGw] [errType: ReadAll error, url: %v, topicList: %v, message: %s, err: %s]",
			p.gwSyncUrl, info.TopicList, string(info.Message), err.Error())
		return err
	}
	log.Info("[Publisher/pub/notifyGw] [info: publish msg, url: %v, topicList: %v, message: %s, elapsed: %v]",
		p.gwSyncUrl, info.TopicList, string(info.Message), time.Since(start))
	return nil
}

func (p *Publisher) runCtrl() {
	log.Debug("[Publisher/pub/runCtrl] [info: Create ctrl success]")
	defer p.waitGroup.Done()
	for {
		select {
		case <-p.quit:
			log.Info("[Publisher/pub/runCtr] [info: recv quit signal]")
			return
		case info := <-p.msg2Ctrl:
			log.Debug("[Publisher/pub/runCtr] [deQueue: msg2Ctrl, msg: %s, toplist: %+v]", string(info.Message), info.TopicList)
			p.notifyCtrl(info)
		}
	}
}

func (p *Publisher) notifyCtrl(info *PublishInfo) error {
	for _, address := range info.TopicList {
		start := time.Now()
		url := fmt.Sprintf(p.ctrlUrl, address, p.ctrlPort)
		req, err := http.NewRequest("POST", url, bytes.NewReader(info.Message))
		if err != nil {
			log.Error("[Publisher/pub/notifyCtrl] [errType:NewRequest error, url: %v, topic: %v, message: %s, err: %s]",
				url, address, string(info.Message), err.Error())
			return err
		}
		req.Header.Add("Content-Type", "application/json")
		response, err := p.ctrlClient.Do(req)
		if err != nil {
			log.Warn("[Publisher/pub/notifyCtrl] [errType:do error, url: %v, topic: %v, message: %s, err: %s]",
				url, address, string(info.Message), err.Error())
			continue
		}
		defer response.Body.Close()
		_, err = ioutil.ReadAll(response.Body)
		if err != nil {
			log.Warn("[Publisher/pub/notifyCtrl] [errType: ReadAll error, url: %v, topic: %v, message: %s, err: %s]",
				url, address, string(info.Message), err.Error())
			continue
		}
		response.Body.Close()
		log.Info("[Publisher/pub/notifyCtrl] [info: success, url: %v, topic: %v, message: %s, elapsed: %v]",
			url, address, string(info.Message), time.Since(start))
	}
	return nil
}
