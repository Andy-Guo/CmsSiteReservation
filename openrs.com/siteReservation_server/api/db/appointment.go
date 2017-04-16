package db

import (
	"strings"
	"time"

	"openrs.com/siteReservation_server/api/dbtool"
	"openrs.com/siteReservation_server/api/log"
	"openrs.com/siteReservation_server/model"
)

//预定表
type AppointmentDao struct {
}

//id,r_t_id,price_id,pay_fee,rate,status,created_at,updated_at
var (
	appointmentTN      = "price"
	appointmentField   = []string{"id", "room_time_id", "price_id", "pay_fee", "rate", "status", "created_at", "updated_at"}
	appointmentScanner = func(r dbtool.DbScanner, d interface{}) error {
		appmt := d.(*model.Appointment)
		return r.Scan(&appmt.Id, &appmt.RoomTimeStatusId, &appmt.PriceId, &appmt.PayFee, &appmt.Rate, &appmt.Status, &appmt.CreatedAt, &appmt.UpdatedAt)
	}
)

func (dao *AppointmentDao) Create(do dbtool.DbOperator, a *model.Appointment) error {
	strSql := "insert into " + appointmentTN + "(" + strings.Join(appointmentField, ",") + ") values (?,?,?,?,?,?,now(), now())"
	log.Debug("[Appointment/db/Create] [SQL: '%s', values[%s, %s, %s, %s, %s, %s,]", strSql, a.Id, a.RoomTimeStatusId, a.PriceId, a.PayFee, a.Rate, a.Status)
	start := time.Now()
	defer func() {
		log.Info("[Appointment/db/Create] [SqlElapsed: %v]", time.Since(start))
	}()
	if _, err := do.Exec(strSql, a.Id, a.RoomTimeStatusId, a.PriceId, a.PayFee, a.Rate, a.Status); err != nil {
		log.Error("[Appointment/db/Create] [DB.Exec: %s]", err.Error())
		return err
	}
	return nil
}

func (dao *AppointmentDao) Get(do dbtool.DbOperator, id string) (*model.Appointment, error) {
	a := &model.Appointment{}
	start := time.Now()
	defer func() {
		log.Info("[Appointment/db/Get] [SqlElapsed: %v]", time.Since(start))
	}()
	return a, GetDb(do, appointmentScanner, appointmentField, appointmentTN, id, a)
}

func (dao *AppointmentDao) List(do dbtool.DbOperator, filter map[string]interface{}, limit int, offset int, order string, od int) ([]*model.Appointment, error) {
	as := make([]*model.Appointment, 0, 10)
	start := time.Now()
	defer func() {
		log.Info("[Appointment/db/List] [SqlElapsed: %v]", time.Since(start))
	}()
	result, err := ListDb(do, appointmentTN, appointmentField, filter, limit, offset, order, od)
	if err != nil {
		log.Error("[Appointment/db/List] [ListDb: %s]", err.Error())
		return as, err
	}
	defer result.Close()
	for result.Next() {
		a := new(model.Appointment)
		if err := appointmentScanner(result, a); err != nil {
			log.Error("[Appointment/db/List] [appointmentScanner: %s]", err.Error())
			return as, err
		}
		as = append(as, a)
	}
	return as, err
}

func (dao *AppointmentDao) Delete(do dbtool.DbOperator, id string) error {
	start := time.Now()
	defer func() {
		log.Info("[Appointment/db/Delete] [SqlElapsed: %v]", time.Since(start))
	}()
	return DeleteDb(do, appointmentTN, map[string]interface{}{"Id": id})
}

func (dao *AppointmentDao) Count(do dbtool.DbOperator, filter map[string]interface{}) (int64, error) {
	start := time.Now()
	defer func() {
		log.Info("[Appointment/db/Count] [SqlElapsed: %v]", time.Since(start))
	}()
	return CountDb(do, appointmentTN, filter)
}

func (dao *AppointmentDao) Update(do dbtool.DbOperator, id string, kv map[string]interface{}) error {
	start := time.Now()
	defer func() {
		log.Info("[Appointment/db/Update] [SqlElapsed: %v]", time.Since(start))
	}()
	return UpdateDb(do, appointmentTN, id, kv)
}
