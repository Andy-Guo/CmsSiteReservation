package service

import (
	//	"strconv"
	//	"time"
	"database/sql"

	"openrs.com/siteReservation_server/api/db"
	"openrs.com/siteReservation_server/api/dbtool"
	"openrs.com/siteReservation_server/api/log"
	. "openrs.com/siteReservation_server/api/utils"
	cons "openrs.com/siteReservation_server/common/constant"
	"openrs.com/siteReservation_server/model"
)

type UserInfoService struct {
}

func (u *UserInfoService) Register(params *model.RegisterParams) (*model.UserInfoView, CcError) {
	memRole := cons.USER_ROLE_TYPE_MEM
	vipCountRank := cons.USER_COUNT_RANK_VIP
	initPaid := 0.0
	p := &model.CreatUserInfoParams{Name: params.Name, Password: params.Password,
		Desc: params.Desc, RoleId: &memRole, CountRank: &vipCountRank, Paid: &initPaid}
	p.PhoneNum = params.PhoneNum
	p.Email = params.Email
	uv, ce := u.Create(p)
	if ce != nil {
		log.Debug("[User/service/Register] [Create：%s]", ce.Detail())
		return nil, ce
	}
	return uv, nil
}

func (u *UserInfoService) Create(params *model.CreatUserInfoParams) (*model.UserInfoView, CcError) {
	userInfo := &model.UserInfo{Id: USER + "-" + Uuid()}
	userInfo.Name = *params.Name
	userInfo.Password = encrypt(*params.Password, cons.ENCRIPT_ALGORITHM_NULL)
	userInfo.Desc = *params.Desc
	userInfo.CountRank = *params.CountRank
	userInfo.RoleId = *params.RoleId
	userInfo.Paid = *params.Paid
	userInfo.PhoneNum = *params.PhoneNum
	userInfo.Email = *params.Email
	err := db.UserDao.Create(dbtool.DB, userInfo)
	if err != nil {
		log.Debug("[User/service/Create] [UserDao.Create: %s]", err.Error())
		return nil, NewSysErr(err)
	}
	um, err := db.UserDao.Get(dbtool.DB, userInfo.Id)
	switch err {
	case nil:
	case sql.ErrNoRows:
		log.Warn("[User/service/Create] [User.Get: %s, id: %s]", err.Error(), userInfo.Id)
		return nil, NE(ErrUserInfo, ErrNotFound, ErrNull, ErrNull)
	default:
		log.Error("[User/service/Create] [User.Get: %s, id: %s]", err.Error(), userInfo.Id)
		return nil, NewSysErr(err)
	}
	return u.modelToView(um), nil
}

func (u *UserInfoService) Delete(p *model.DeleteParams) CcError {

	return nil
}

func (u *UserInfoService) Modify(p *model.ModifyUserInfoParams) CcError {

	return nil
}

func (u *UserInfoService) Describes(p *model.DescribesParams) ([]*model.UserInfoView, int64, CcError) {
	var uivs []*model.UserInfoView = make([]*model.UserInfoView, 0, 5)
	filter := map[string]interface{}{}
	for _, f := range p.Filter {
		switch *f.Field {
		case "ids":
			filter["id"] = f.Value
		default:
			filter[*f.Field] = f.Value
		}
	}
	// Get count
	count, err := db.UserDao.Count(dbtool.DB, filter)
	if err != nil {
		log.Debug("[UserInfo/service/Describes] [UserInfo.Count: %s, filter: %v]", err.Error(), filter)
		return uivs, count, NewSysErr(err)
	}
	// Get elements
	uims, err := db.UserDao.List(dbtool.DB, filter, *p.DescLimit, *p.DescOffset, *p.Order[0].Field, *p.Order[0].Direction)
	if err != nil {
		log.Debug("[UserInfo/service/Describes] [UserInfo.List: %s, filter: %v]", err.Error(), filter)
		return uivs, count, NewSysErr(err)
	}
	for _, uim := range uims {
		uivs = append(uivs, u.modelToView(uim))
	}
	return uivs, count, nil
}

func (u *UserInfoService) modelToView(um *model.UserInfo) *model.UserInfoView {
	return &model.UserInfoView{um.Id, um.Name, um.Password, um.Desc, um.RoleId, um.CountRank, um.Paid, um.PhoneNum, um.Email, um.CreatedAt, um.UpdatedAt}
}
