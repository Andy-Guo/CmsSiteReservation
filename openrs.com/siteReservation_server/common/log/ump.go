package log

import (
	"fmt"
	// "os"
	"strconv"
	"time"
)

var (
	UMP_BUS_TYPE    = "5"
	UMP_BUS_VALUE   = "0"
	UMP_TIME_FORMAT = "20060102150405"

	logger *Logger
)

type Business struct {
	Time     string `json:"time"`
	Key      string `json:"key"`
	HostName string `json:"hostname"`
	Type     string `json:"type"`
	Value    string `json:"value"`
	Detail   string `json:"detail"`
	Rtx      string `json:"RTX"`
	Mail     string `json:"MAIL"`
	Sms      string `json:"SMS"`
}

func SaveUmpLog(bus *Business) {
	logger.FatalJson(bus)
}

func NewBus() *Business {
	bus := new(Business)
	bus.Type = UMP_BUS_TYPE
	bus.Value = UMP_BUS_VALUE
	return bus
}

func NewBusWithTime(t time.Time) *Business {
	bus := new(Business)
	bus.Type = UMP_BUS_TYPE
	bus.Value = UMP_BUS_VALUE
	bus.Time = t.Format(UMP_TIME_FORMAT) + strconv.Itoa(t.Nanosecond()/1000000)
	return bus
}

func UmpTimeStr(t time.Time) string {
	return t.Format(UMP_TIME_FORMAT) + strconv.Itoa(t.Nanosecond()/1000000)
}

func UmpLogInit(fileName string, logSize int, Level int) error {
	h, err := NewRotatingFileHandler(fileName, logSize, 10)
	if err != nil {
		fmt.Printf("log new file handler err(%s)\n", err.Error())
		return err
	}
	logger = NewDefault(h)
	logger.SetLevel(Level)
	return nil
}
