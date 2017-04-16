package db

import (
	"strings"
	"time"

	"openrs.com/siteReservation_server/api/dbtool"
	"openrs.com/siteReservation_server/api/log"
	"openrs.com/siteReservation_server/model"
)

//房间时间预定状态表
type RoomTimeStatusDao struct {
}

//id,r_id,t_id,user_id,is_order,has_order,created_at,updated_at
var (
	roomTimeStatusTN      = "root_time_state"
	roomTimeStatusField   = []string{"id", "room_id", "time_id", "user_id", "is_order", "has_order", "created_at", "updated_at"}
	roomTimeStatusScanner = func(r dbtool.DbScanner, d interface{}) error {
		rts := d.(*model.RoomTimeStaus)
		return r.Scan(&rts.Id, &rts.RoomId, &rts.TimeDescId, &rts.UserId, &rts.IsOrder, &rts.HasOrder, &rts.CreatedAt, &rts.UpdatedAt)
	}
)

func (dao *RoomTimeStatusDao) Create(do dbtool.DbOperator, rts *model.RoomTimeStaus) error {
	strSql := "insert into " + roomTimeStatusTN + "(" + strings.Join(roomTimeStatusField, ",") + ") values (?,?,?,?,?,?,now(), now())"
	log.Debug("[RoomTimeStatus/db/Create] [SQL: '%s', values[%s, %s, %s,%s, %s, %s,]", strSql, rts.Id, rts.RoomId, rts.TimeDescId, rts.UserId, rts.IsOrder, rts.HasOrder)
	start := time.Now()
	defer func() {
		log.Info("[RoomTimeStatus/db/Create] [SqlElapsed: %v]", time.Since(start))
	}()
	if _, err := do.Exec(strSql, rts.Id, rts.RoomId, rts.TimeDescId, rts.UserId, rts.IsOrder, rts.HasOrder); err != nil {
		log.Error("[RoomTimeStatus/db/Create] [DB.Exec: %s]", err.Error())
		return err
	}
	return nil
}

func (dao *RoomTimeStatusDao) Get(do dbtool.DbOperator, id string) (*model.RoomTimeStaus, error) {
	rts := &model.RoomTimeStaus{}
	start := time.Now()
	defer func() {
		log.Info("[RoomTimeStatus/db/Get] [SqlElapsed: %v]", time.Since(start))
	}()
	return rts, GetDb(do, roomTimeStatusScanner, roomTimeStatusField, roomTimeStatusTN, id, rts)
}

func (dao *RoomTimeStatusDao) List(do dbtool.DbOperator, filter map[string]interface{}, limit int, offset int, order string, od int) ([]*model.RoomTimeStaus, error) {
	rtss := make([]*model.RoomTimeStaus, 0, 10)
	start := time.Now()
	defer func() {
		log.Info("[RoomTimeStatus/db/List] [SqlElapsed: %v]", time.Since(start))
	}()
	result, err := ListDb(do, roomTimeStatusTN, roomTimeStatusField, filter, limit, offset, order, od)
	if err != nil {
		log.Error("[RoomTimeStatus/db/List] [ListDb: %s]", err.Error())
		return rtss, err
	}
	defer result.Close()
	for result.Next() {
		rts := new(model.RoomTimeStaus)
		if err := roomTimeStatusScanner(result, rts); err != nil {
			log.Error("[RoomTimeStatus/db/List] [roomTimeStatusScanner: %s]", err.Error())
			return rtss, err
		}
		rtss = append(rtss, rts)
	}
	return rtss, err
}

func (dao *RoomTimeStatusDao) Delete(do dbtool.DbOperator, id string) error {
	start := time.Now()
	defer func() {
		log.Info("[RoomTimeStatus/db/Delete] [SqlElapsed: %v]", time.Since(start))
	}()
	return DeleteDb(do, roomTimeStatusTN, map[string]interface{}{"Id": id})
}

func (dao *RoomTimeStatusDao) Count(do dbtool.DbOperator, filter map[string]interface{}) (int64, error) {
	start := time.Now()
	defer func() {
		log.Info("[RoomTimeStatus/db/Count] [SqlElapsed: %v]", time.Since(start))
	}()
	return CountDb(do, roomTimeStatusTN, filter)
}

func (dao *RoomTimeStatusDao) Update(do dbtool.DbOperator, id string, kv map[string]interface{}) error {
	start := time.Now()
	defer func() {
		log.Info("[RoomTimeStatus/db/Update] [SqlElapsed: %v]", time.Since(start))
	}()
	return UpdateDb(do, roomTimeStatusTN, id, kv)
}
