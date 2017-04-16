package log

import (
	"time"
)

var (
	APP_TIME_FORMAT = "2006-01-02 15:04:05:999"
)

type AppLog struct {
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

func AppTimeStr(t time.Time) string {
	return t.Format(UMP_TIME_FORMAT)
}

func AppTimeNowStr() string {
	t := time.Now()
	return t.Format(APP_TIME_FORMAT)
}
