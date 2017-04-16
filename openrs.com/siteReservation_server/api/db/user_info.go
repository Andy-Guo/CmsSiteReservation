package db

import (
	"strings"
	"time"

	"openrs.com/siteReservation_server/api/dbtool"
	"openrs.com/siteReservation_server/api/log"
	"openrs.com/siteReservation_server/model"
)

//用户信息表
type UserInfoDao struct {
}

//id,name,password,desc,role_id,count_rank,paid,phone_num,email
var (
	userInfoTN      = "user"
	userInfoField   = []string{"id", "name", "password", "description", "role_id", "count_rank", "paid", "phone_num", "email", "created_at", "updated_at"}
	userInfoScanner = func(r dbtool.DbScanner, d interface{}) error {
		uinfo := d.(*model.UserInfo)
		return r.Scan(&uinfo.Id, &uinfo.Name, &uinfo.Password, &uinfo.Desc, &uinfo.RoleId, &uinfo.CountRank, &uinfo.Paid, &uinfo.PhoneNum, &uinfo.Email, &uinfo.CreatedAt, &uinfo.UpdatedAt)
	}
)

func (dao *UserInfoDao) Create(do dbtool.DbOperator, userInfo *model.UserInfo) error {
	strSql := "insert into " + userInfoTN + "(" + strings.Join(userInfoField, ",") + ") values (?,?,?,?,?,?,?,?,?,now(), now())"
	log.Debug("[User/db/Create] [SQL: '%s', values[%s, %s, %s,%s, %d, %d, %f, %s, %s,]", strSql, userInfo.Id, userInfo.Name, userInfo.Password,
		userInfo.Desc, userInfo.RoleId, userInfo.CountRank, userInfo.Paid, userInfo.PhoneNum, userInfo.Email)
	start := time.Now()
	defer func() {
		log.Info("[User/db/Create] [SqlElapsed: %v]", time.Since(start))
	}()
	if _, err := do.Exec(strSql, userInfo.Id, userInfo.Name, userInfo.Password,
		userInfo.Desc, userInfo.RoleId, userInfo.CountRank, userInfo.Paid, userInfo.PhoneNum, userInfo.Email); err != nil {
		log.Error("[User/db/Create] [DB.Exec: %s]", err.Error())
		return err
	}
	return nil
}

func (dao *UserInfoDao) Get(do dbtool.DbOperator, id string) (*model.UserInfo, error) {
	ui := &model.UserInfo{}
	start := time.Now()
	defer func() {
		log.Info("[User/db/Get] [SqlElapsed: %v]", time.Since(start))
	}()
	return ui, GetDb(do, userInfoScanner, userInfoField, userInfoTN, id, ui)
}

func (dao *UserInfoDao) List(do dbtool.DbOperator, filter map[string]interface{}, limit int, offset int, order string, od int) ([]*model.UserInfo, error) {
	uInfos := make([]*model.UserInfo, 0, 10)
	start := time.Now()
	defer func() {
		log.Info("[User/db/List] [SqlElapsed: %v]", time.Since(start))
	}()
	result, err := ListDb(do, userInfoTN, userInfoField, filter, limit, offset, order, od)
	if err != nil {
		log.Error("[User/db/List] [ListDb: %s]", err.Error())
		return uInfos, err
	}
	defer result.Close()
	for result.Next() {
		uinfo := new(model.UserInfo)
		if err := userInfoScanner(result, uinfo); err != nil {
			log.Error("[User/db/List] [userInfoScanner: %s]", err.Error())
			return uInfos, err
		}
		uInfos = append(uInfos, uinfo)
	}
	return uInfos, err
}

func (dao *UserInfoDao) Delete(do dbtool.DbOperator, id string) error {
	start := time.Now()
	defer func() {
		log.Info("[User/db/Delete] [SqlElapsed: %v]", time.Since(start))
	}()
	return DeleteDb(do, userInfoTN, map[string]interface{}{"Id": id})
}

func (dao *UserInfoDao) Count(do dbtool.DbOperator, filter map[string]interface{}) (int64, error) {
	start := time.Now()
	defer func() {
		log.Info("[User/db/Count] [SqlElapsed: %v]", time.Since(start))
	}()
	return CountDb(do, userInfoTN, filter)
}

func (dao *UserInfoDao) Update(do dbtool.DbOperator, id string, kv map[string]interface{}) error {
	start := time.Now()
	defer func() {
		log.Info("[User/db/Update] [SqlElapsed: %v]", time.Since(start))
	}()
	return UpdateDb(do, userInfoTN, id, kv)
}
