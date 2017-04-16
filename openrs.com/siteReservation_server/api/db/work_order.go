package db

import (
	"strings"
	"time"

	"openrs.com/siteReservation_server/api/dbtool"
	"openrs.com/siteReservation_server/api/log"
	"openrs.com/siteReservation_server/model"
)

//工单表
type WorkOrderFlowDao struct {
}

//id,role_id,appointment_id,staus
var (
	workOrderFlowTN      = "work_order"
	workOrderFlowField   = []string{"id", "role_id", "appointment_id", "status"}
	workOrderFlowScanner = func(r dbtool.DbScanner, d interface{}) error {
		wof := d.(*model.WorkOrderFlow)
		return r.Scan(&wof.Id, &wof.RoleId, &wof.AppointmentId, &wof.Status)
	}
)

func (dao *WorkOrderFlowDao) Create(do dbtool.DbOperator, w *model.WorkOrderFlow) error {
	strSql := "insert into " + workOrderFlowTN + "(" + strings.Join(workOrderFlowField, ",") + ") values (?,?,?,?)"
	log.Debug("[WorkOrderFlow/db/Create] [SQL: '%s', values[%s, %s, %s, %s,]", strSql, w.Id, w.RoleId, w.AppointmentId, w.Status)
	start := time.Now()
	defer func() {
		log.Info("[WorkOrderFlow/db/Create] [SqlElapsed: %v]", time.Since(start))
	}()
	if _, err := do.Exec(strSql, w.Id, w.RoleId, w.AppointmentId, w.Status); err != nil {
		log.Error("[WorkOrderFlow/db/Create] [DB.Exec: %s]", err.Error())
		return err
	}
	return nil
}

func (dao *WorkOrderFlowDao) Get(do dbtool.DbOperator, id string) (*model.WorkOrderFlow, error) {
	w := &model.WorkOrderFlow{}
	start := time.Now()
	defer func() {
		log.Info("[WorkOrderFlow/db/Get] [SqlElapsed: %v]", time.Since(start))
	}()
	return w, GetDb(do, workOrderFlowScanner, workOrderFlowField, workOrderFlowTN, id, w)
}

func (dao *WorkOrderFlowDao) List(do dbtool.DbOperator, filter map[string]interface{}, limit int, offset int, order string, od int) ([]*model.WorkOrderFlow, error) {
	wofs := make([]*model.WorkOrderFlow, 0, 10)
	start := time.Now()
	defer func() {
		log.Info("[WorkOrderFlow/db/List] [SqlElapsed: %v]", time.Since(start))
	}()
	result, err := ListDb(do, workOrderFlowTN, workOrderFlowField, filter, limit, offset, order, od)
	if err != nil {
		log.Error("[WorkOrderFlow/db/List] [ListDb: %s]", err.Error())
		return wofs, err
	}
	defer result.Close()
	for result.Next() {
		wof := new(model.WorkOrderFlow)
		if err := workOrderFlowScanner(result, wofs); err != nil {
			log.Error("[WorkOrderFlow/db/List] [workOrderFlowScanner: %s]", err.Error())
			return wofs, err
		}
		wofs = append(wofs, wof)
	}
	return wofs, err
}

func (dao *WorkOrderFlowDao) Delete(do dbtool.DbOperator, id string) error {
	start := time.Now()
	defer func() {
		log.Info("[WorkOrderFlow/db/Delete] [SqlElapsed: %v]", time.Since(start))
	}()
	return DeleteDb(do, workOrderFlowTN, map[string]interface{}{"Id": id})
}

func (dao *WorkOrderFlowDao) Count(do dbtool.DbOperator, filter map[string]interface{}) (int64, error) {
	start := time.Now()
	defer func() {
		log.Info("[WorkOrderFlow/db/Count] [SqlElapsed: %v]", time.Since(start))
	}()
	return CountDb(do, workOrderFlowTN, filter)
}

func (dao *WorkOrderFlowDao) Update(do dbtool.DbOperator, id string, kv map[string]interface{}) error {
	start := time.Now()
	defer func() {
		log.Info("[WorkOrderFlow/db/Update] [SqlElapsed: %v]", time.Since(start))
	}()
	return UpdateDb(do, workOrderFlowTN, id, kv)
}
