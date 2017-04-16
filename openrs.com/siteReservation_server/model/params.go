package model

type FilterItem struct {
	Field *string     `json:"field"`
	Value interface{} `json:"value"`
}

type OrderItem struct {
	Field     *string `json:"field"`
	Direction *int    `json:"direction"`
}

type DescribesParams struct {
	Filter     []*FilterItem `json:"filter"`
	Order      []*OrderItem  `json:"orders"`
	DescOffset *int          `json:"desc_offset"`
	DescLimit  *int          `json:"desc_limit"`
}

type DeleteParams struct {
	Id *string `json:"id"`
}

type RegisterParams struct {
	Name     *string `json:"name"`
	Password *string `json:"password"`
	Desc     *string `json:"description"`
	PhoneNum *string `json:"phone_num"`
	Email    *string `json:"email"`
}

type CreatUserInfoParams struct {
	Name      *string  `json:"name"`
	Password  *string  `json:"password"`
	Desc      *string  `json:"description"`
	RoleId    *int     `json:"role_id"`
	CountRank *int     `json:"count_rank"`
	Paid      *float64 `json:"paid"`
	PhoneNum  *string  `json:"phone_num"`
	Email     *string  `json:"email"`
}

type ModifyUserInfoParams struct {
	Id        *string  `json:"id"`
	Name      *string  `json:"name"`
	Password  *string  `json:"password"`
	Desc      *string  `json:"description"`
	RoleId    *int     `json:"role_id"`
	CountRank *int     `json:"count_rank"`
	Paid      *float64 `json:"paid"`
	PhoneNum  *string  `json:"phone_num"`
	Email     *string  `json:"email"`
}
