package pub

import (
	"fmt"
	"net"
	"net/http"
	"time"

	"jd.com/cc/jstack-cc-common/message/north/mq"
	"openrs.com/siteReservation_server/api/cfg"
	"openrs.com/siteReservation_server/api/log"
)

var (
	publisher *Publisher
)

func Setup() {
	var err error
	publisher, err = getPublisher(cfg.RpcConfig)
	if err != nil {
		panic(err.Error())
	}
}

func getPublisher(config *cfg.RpcConf) (*Publisher, error) {
	var err error = nil

	publisher := &Publisher{}
	publisher.quit = make(chan struct{})

	//init gw client
	{
		gwTransport := &http.Transport{
			DialContext: (&net.Dialer{
				Timeout: time.Duration(*config.GwClient.ConnectTimeout) * time.Millisecond,
			}).DialContext,
			MaxIdleConnsPerHost:   *config.GwClient.MaxIdleConnsPerHost,
			MaxIdleConns:          *config.GwClient.MaxIdleConns,
			IdleConnTimeout:       time.Duration(*config.GwClient.IdleConnTimeout) * time.Millisecond,
			ResponseHeaderTimeout: time.Duration(*config.GwClient.ResponseHeaderTimeout) * time.Millisecond,
		}
		gwClient := &http.Client{Transport: gwTransport, Timeout: time.Duration(*config.GwClient.ResponseTimeout) * time.Millisecond}
		publisher.gwClient = gwClient
		publisher.msg2Gw = make(chan *PublishInfo, *config.GwClient.MsgQueueLen)
		log.Info("[pub/getPublisher] [info: gwclient, timeout: %v, MaxIdleConnsPerHost: %v, MaxIdleConns: %v, IdleConnTimeout: %v, ResponseHeaderTimeout: %v, ResponseTimeout: %v, MsgQueueLen: %v, NumRoutine: %v]",
			*config.GwClient.ConnectTimeout, *config.GwClient.MaxIdleConnsPerHost,
			*config.GwClient.MaxIdleConns, *config.GwClient.IdleConnTimeout,
			*config.GwClient.ResponseHeaderTimeout, *config.GwClient.ResponseTimeout,
			*config.GwClient.MsgQueueLen, *config.GwClient.NumRoutine)
	}

	//init control client
	{
		ctrlTransport := &http.Transport{
			DialContext: (&net.Dialer{
				Timeout: time.Duration(*config.CtrlClient.ConnectTimeout) * time.Millisecond,
			}).DialContext,
			MaxIdleConnsPerHost:   *config.CtrlClient.MaxIdleConnsPerHost,
			MaxIdleConns:          *config.CtrlClient.MaxIdleConns,
			IdleConnTimeout:       time.Duration(*config.CtrlClient.IdleConnTimeout) * time.Millisecond,
			ResponseHeaderTimeout: time.Duration(*config.CtrlClient.ResponseHeaderTimeout) * time.Millisecond,
		}
		ctrlClient := &http.Client{Transport: ctrlTransport, Timeout: time.Duration(*config.CtrlClient.ResponseTimeout) * time.Millisecond}
		publisher.ctrlClient = ctrlClient
		publisher.msg2Ctrl = make(chan *PublishInfo, *config.CtrlClient.MsgQueueLen)
		log.Info("[pub/getPublisher] [info: ctrlClient, timeout: %v, MaxIdleConnsPerHost: %v, MaxIdleConns: %v, IdleConnTimeout: %v, ResponseHeaderTimeout: %v, ResponseTimeout: %v, MsgQueueLen: %v, NumRoutine: %v]",
			*config.CtrlClient.ConnectTimeout, *config.CtrlClient.MaxIdleConnsPerHost,
			*config.CtrlClient.MaxIdleConns, *config.CtrlClient.IdleConnTimeout,
			*config.CtrlClient.ResponseHeaderTimeout, *config.CtrlClient.ResponseTimeout,
			*config.CtrlClient.MsgQueueLen, *config.CtrlClient.NumRoutine)
	}

	publisher.gwSyncUrl = fmt.Sprintf(*config.GwUrl, *config.GwServerIp, *config.GwServerPort)
	publisher.ctrlUrl = *config.CtrlUrl
	publisher.ctrlPort = *config.CtrlServerPort
	for i := 0; i < *config.GwClient.NumRoutine; i++ {
		go publisher.runGw()
	}

	for i := 0; i < *config.CtrlClient.NumRoutine; i++ {
		publisher.waitGroup.Add(1)
		go publisher.runCtrl()
	}

	log.Info("[pub/getPublisher] [info: GetPublisher finish]")
	return publisher, err
}

func Publish(topics []string, msg *mq.NotifyMsg) error {
	return publisher.Publish(topics, msg)
}

func Close() {
	publisher.Close()
}
