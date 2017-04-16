package model

import (
	"time"
)

type CommResp struct {
	Code    int         `json:"code"`
	Message string      `json:"message"`
	Detail  string      `json:"detail"`
	Data    interface{} `json:"data"`
}

type UserInfo struct {
	Id        string
	Name      string
	Password  string
	Desc      string
	RoleId    int //mem, admin, managment
	CountRank int //vip, silver vip, gold vip,platinum vip
	Paid      float64
	PhoneNum  string
	Email     string
	CreatedAt time.Time
	UpdatedAt time.Time
}

type Room struct {
	Id        string
	Name      string
	Desc      string
	CreatedAt time.Time
	UpdatedAt time.Time
}

type TimeDur struct {
	Id           string
	TimeDuration int64
	Date         string // y-m-d
}

type RoomTimeStaus struct {
	Id         string
	RoomId     string
	TimeDescId string
	UserId     string
	IsOrder    int
	HasOrder   int
	CreatedAt  time.Time
	UpdatedAt  time.Time
}

type Role struct {
	Id   string
	Name string
	Desc string
}

type Price struct {
	Id         string
	Name       string
	Desc       string
	CountRank  int
	RoomId     string
	TimeDescId string
	Price      float64
	CreatedAt  time.Time
	UpdatedAt  time.Time
}

type Appointment struct {
	Id               string
	RoomTimeStatusId string
	PriceId          string  //价格
	PayFee           float64 //费用
	Rate             float64 //折扣率[0,1]
	Status           int     //订单预约状态: 0:预约中; 1:完成; 2:取消
	CreatedAt        time.Time
	UpdatedAt        time.Time
}

type WorkOrderFlow struct {
	Id            string
	RoleId        string
	AppointmentId string
	Status        string // 0 待审核 1 已审核 2 已取消
}
