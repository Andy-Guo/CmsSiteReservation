package model

import (
	"time"
)

type DescData struct {
	Tc       int64       `json:"total_count"`
	Elements interface{} `json:"elements"`
}

type UserInfoView struct {
	Id        string    `json:"id"`
	Name      string    `json:"name"`
	Password  string    `json:"password"`
	Desc      string    `json:"description"`
	RoleId    int       `json:"role_id"`
	CountRank int       `json:"count_rank"`
	Paid      float64   `json:"paid"`
	PhoneNum  string    `json:"phone_num"`
	Email     string    `json:"email"`
	CreatedAt time.Time `json:"created_at"`
	UpdatedAt time.Time `json:"updated_at"`
}
