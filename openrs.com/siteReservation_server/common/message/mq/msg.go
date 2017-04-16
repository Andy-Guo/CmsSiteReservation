package mq

import "time"

type NotifyMsg struct {
	ResourceType int       `json:"resourceType"` //jstack-cc-common/constant/const.go
	ResourceId   string    `json:"resourceId"`   //subnet_id, router_id, floatingip_id, segment_id
	Ops          int       `json:"ops"`          //update、add、delete、replace
	Version      uint64    `json:"version"`      //最新的版本号
	CreatedAt    time.Time `json:"createdAt"`
}
