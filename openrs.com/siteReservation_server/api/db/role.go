package db

import (
	"strings"
	"time"

	"openrs.com/siteReservation_server/api/dbtool"
	"openrs.com/siteReservation_server/api/log"
	"openrs.com/siteReservation_server/model"
)

//角色表
type RoleDao struct {
}

//id,name,desc
var (
	roleTN      = "role"
	roleField   = []string{"id", "name", "desc"}
	roleScanner = func(r dbtool.DbScanner, d interface{}) error {
		role := d.(*model.Role)
		return r.Scan(&role.Id, &role.Name, &role.Desc)
	}
)

func (dao *RoleDao) Create(do dbtool.DbOperator, r *model.Role) error {
	strSql := "insert into " + roleTN + "(" + strings.Join(roleField, ",") + ") values (?,?,?)"
	log.Debug("[Role/db/Create] [SQL: '%s', values[%s, %s, %s,]", strSql, r.Id, r.Name, r.Desc)
	start := time.Now()
	defer func() {
		log.Info("[Role/db/Create] [SqlElapsed: %v]", time.Since(start))
	}()
	if _, err := do.Exec(strSql, r.Id, r.Name, r.Desc); err != nil {
		log.Error("[Role/db/Create] [DB.Exec: %s]", err.Error())
		return err
	}
	return nil
}

func (dao *RoleDao) Get(do dbtool.DbOperator, id string) (*model.Role, error) {
	r := &model.Role{}
	start := time.Now()
	defer func() {
		log.Info("[Role/db/Get] [SqlElapsed: %v]", time.Since(start))
	}()
	return r, GetDb(do, roleScanner, roleField, roleTN, id, r)
}

func (dao *RoleDao) List(do dbtool.DbOperator, filter map[string]interface{}, limit int, offset int, order string, od int) ([]*model.Role, error) {
	rs := make([]*model.Role, 0, 10)
	start := time.Now()
	defer func() {
		log.Info("[Role/db/List] [SqlElapsed: %v]", time.Since(start))
	}()
	result, err := ListDb(do, roleTN, roleField, filter, limit, offset, order, od)
	if err != nil {
		log.Error("[Role/db/List] [ListDb: %s]", err.Error())
		return rs, err
	}
	defer result.Close()
	for result.Next() {
		r := new(model.Role)
		if err := roleScanner(result, r); err != nil {
			log.Error("[Role/db/List] [roleScanner: %s]", err.Error())
			return rs, err
		}
		rs = append(rs, r)
	}
	return rs, err
}

func (dao *RoleDao) Delete(do dbtool.DbOperator, id string) error {
	start := time.Now()
	defer func() {
		log.Info("[Role/db/Delete] [SqlElapsed: %v]", time.Since(start))
	}()
	return DeleteDb(do, roleTN, map[string]interface{}{"Id": id})
}

func (dao *RoleDao) Count(do dbtool.DbOperator, filter map[string]interface{}) (int64, error) {
	start := time.Now()
	defer func() {
		log.Info("[Role/db/Count] [SqlElapsed: %v]", time.Since(start))
	}()
	return CountDb(do, roleTN, filter)
}

func (dao *RoleDao) Update(do dbtool.DbOperator, id string, kv map[string]interface{}) error {
	start := time.Now()
	defer func() {
		log.Info("[Role/db/Update] [SqlElapsed: %v]", time.Since(start))
	}()
	return UpdateDb(do, roleTN, id, kv)
}
