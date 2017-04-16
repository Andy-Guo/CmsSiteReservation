package handler

import (
	"net/http"

	cc_cons "jd.com/cc/jstack-cc-common/constant"
	"openrs.com/siteReservation_server/api/log"
	"openrs.com/siteReservation_server/api/service"
	. "openrs.com/siteReservation_server/api/utils"
	"openrs.com/siteReservation_server/common/constant"
	"openrs.com/siteReservation_server/common/url"
	"openrs.com/siteReservation_server/model"
)

type UserHandler struct {
	CCHandler
}

var (
	userRegisterAttrM = map[string]*Attribute{
		"name":      &Attribute{T_String, nil, true, nil},
		"password":  &Attribute{T_String, nil, true, nil},
		"desc":      &Attribute{T_String, nil, false, nil},
		"phone_num": &Attribute{T_String, nil, false, nil},
		"email":     &Attribute{T_String, nil, false, nil},
	}

	userCreateAttrM = map[string]*Attribute{
		"name":       &Attribute{T_String, nil, true, nil},
		"password":   &Attribute{T_String, nil, true, nil},
		"desc":       &Attribute{T_String, nil, false, nil},
		"role_id":    &Attribute{T_Int, nil, false, nil},
		"count_rank": &Attribute{T_Int, nil, false, nil},
		"paid":       &Attribute{T_Float, nil, false, nil},
		"phone_num":  &Attribute{T_String, nil, false, nil},
		"email":      &Attribute{T_String, nil, false, nil},
	}

	userDeleteAttrM = map[string]*Attribute{
		"id": &Attribute{T_String, nil, true, nil},
	}

	userDescAttrM = map[string]*Attribute{
		"filter": &Attribute{T_Filter, nil, false, map[string]*Attribute{
			"ids": &Attribute{T_Array, nil, false, &Attribute{T_Uuid, nil, false, nil}},
		}},
		"orders": &Attribute{T_Order, nil, false, map[string]*Attribute{
			"created_at": &Attribute{T_Int, nil, false, nil},
			"updated_at": &Attribute{T_Int, nil, false, nil},
		}}}

	userModifyAttrM = map[string]*Attribute{
		"id":         &Attribute{T_String, nil, true, nil},
		"name":       &Attribute{T_String, nil, false, nil},
		"password":   &Attribute{T_String, nil, false, nil},
		"desc":       &Attribute{T_String, nil, false, nil},
		"role_id":    &Attribute{T_Int, nil, false, nil},
		"count_rank": &Attribute{T_Int, nil, false, nil},
		"paid":       &Attribute{T_Float, nil, false, nil},
		"phone_num":  &Attribute{T_String, nil, false, nil},
		"email":      &Attribute{T_String, nil, false, nil},
	}
)

func (u *UserHandler) Register(r *url.UrlRouter) {
	r.RegisterFunc("RegisterUser", u.RegisterUser)
	r.RegisterFunc("CreateUser", u.Create)
	r.RegisterFunc("DeleteUser", u.Delete)
	r.RegisterFunc("DescribeUsers", u.Describes)
	r.RegisterFunc("ModifyUser", u.Modify)
}

func (u *UserHandler) RegisterUser(w http.ResponseWriter, r *http.Request) {
	params := new(model.RegisterParams)
	if ce := ValiAttr(userRegisterAttrM, r.Body, ErrUserInfo, params); ce != nil {
		log.Warn("[User/handler/Register] [ValiAttr: params validate failed.]")
		u.Response(w, ce, nil)
		return
	}
	if !ValidateEmail(*params.Email) {
		log.Error("[User/handler/Create] [Valiate: params email value error.]")
		u.Response(w, NE(ErrUserInfo, ErrInvalid, ErrEmail, "params email value error."), nil)
		return
	}
	if !ValidatePhoneNum(*params.PhoneNum) {
		log.Error("[User/handler/Create] [Valiate: params phone_num value error.]")
		u.Response(w, NE(ErrUserInfo, ErrInvalid, ErrPhone, "params phone_num value error."), nil)
		return
	}
	uv, ce := service.UserInfo.Register(params)
	if ce == nil {
		log.Info("[User/handler/Register] [User.Create: successfully]")
		u.Response(w, nil, uv)
		return
	}
	u.Response(w, ce, nil)
}

func (u *UserHandler) Create(w http.ResponseWriter, r *http.Request) {
	params := new(model.CreatUserInfoParams)
	if ce := ValiAttr(userCreateAttrM, r.Body, ErrUserInfo, params); ce != nil {
		log.Warn("[User/handler/Create] [ValiAttr: params validate failed.]")
		u.Response(w, ce, nil)
		return
	}
	if *params.CountRank != constant.USER_COUNT_RANK_GOLD_VIP || *params.CountRank != constant.USER_COUNT_RANK_SILVER_VIP ||
		*params.CountRank != constant.USER_COUNT_RANK_VIP || *params.CountRank != constant.USER_COUNT_RANK_PLATINUM_VIP {
		log.Error("[User/handler/Create] [Valiate: params count_rank value error.]")
		u.Response(w, NE(ErrUserInfo, ErrInvalid, ErrCountRank, "params count_rank value error."), nil)
		return
	}
	if *params.RoleId != constant.USER_ROLE_TYPE_MEM || *params.RoleId != constant.USER_ROLE_TYPE_MGMT ||
		*params.RoleId != constant.USER_ROLE_TYPE_ADMIN {
		log.Error("[User/handler/Create] [Valiate: params role_id value error.]")
		u.Response(w, NE(ErrUserInfo, ErrInvalid, ErrRoleId, "params role_id value error."), nil)
		return
	}
	if !ValidateEmail(*params.Email) {
		log.Error("[User/handler/Create] [Valiate: params email value error.]")
		u.Response(w, NE(ErrUserInfo, ErrInvalid, ErrEmail, "params email value error."), nil)
		return
	}
	if !ValidatePhoneNum(*params.PhoneNum) {
		log.Error("[User/handler/Create] [Valiate: params phone_num value error.]")
		u.Response(w, NE(ErrUserInfo, ErrInvalid, ErrPhone, "params phone_num value error."), nil)
		return
	}
	uv, ce := service.UserInfo.Create(params)
	if ce == nil {
		log.Info("[User/handler/Create] [User.Create: successfully]")
		u.Response(w, nil, uv)
		return
	}
	u.Response(w, ce, nil)
}

func (u *UserHandler) Delete(w http.ResponseWriter, r *http.Request) {
	params := &model.DeleteParams{}
	if ce := ValiAttr(userDeleteAttrM, r.Body, ErrUserInfo, params); ce != nil {
		log.Warn("[User/handler/Delete] [ValiAttr: params validate failed.]")
		u.Response(w, ce, nil)
		return
	}
	// Call service
	ce := service.UserInfo.Delete(params)
	if ce == nil {
		log.Info("[User/handler/Delete] [User.Delete: successfully, id: %s]", *params.Id)
		u.Response(w, nil, nil)
		return
	}
	u.Response(w, ce, nil)
}
func (h *UserHandler) Describes(w http.ResponseWriter, r *http.Request) {
	params := &model.DescribesParams{}
	if ce := ValiAttr(userDescAttrM, r.Body, ErrUserInfo, params); ce != nil {
		log.Warn("[User/handler/Describes] [ValiAttr: params validate failed.]")
		h.Response(w, ce, nil)
		return
	}
	// Default params
	if len(params.Order) < 1 {
		or := "created_at"
		od := cc_cons.Order_Desc
		params.Order = append(params.Order, &model.OrderItem{&or, &od})
	}
	if params.DescLimit == nil || params.DescOffset == nil {
		var of, od int = 0, -1
		params.DescOffset = &of
		params.DescLimit = &od
	}
	// Call service
	views, count, ce := service.UserInfo.Describes(params)
	if ce != nil {
		log.Debug("[User/handler/Describes] [User.Describes: %s]", ce.Detail())
		h.Response(w, ce, nil)
		return
	}
	log.Info("[User/handler/Describes] [User.Describes: successfully]")
	h.Response(w, nil, &DescData{count, views})
}

func (u *UserHandler) Modify(w http.ResponseWriter, r *http.Request) {
	params := new(model.ModifyUserInfoParams)
	if ce := ValiAttr(userModifyAttrM, r.Body, ErrUserInfo, params); ce != nil {
		log.Warn("[User/handler/Modify] [ValiAttr: params validate failed.]")
		u.Response(w, ce, nil)
		return
	}
	ce := service.UserInfo.Modify(params)
	if ce == nil {
		log.Info("[User/handler/Modify] [User.Modify: successfully]")
	}
	u.Response(w, ce, nil)
}
