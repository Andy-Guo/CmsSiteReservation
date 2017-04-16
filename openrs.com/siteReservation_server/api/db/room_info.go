package db

import (
	"strings"
	"time"

	"openrs.com/siteReservation_server/api/dbtool"
	"openrs.com/siteReservation_server/api/log"
	"openrs.com/siteReservation_server/model"
)

// 预定房间表
type RoomDao struct {
}

//id,name,desc,created_at,updated_at
var (
	roomTN      = "room"
	roomField   = []string{"id", "name", "desc", "created_at", "updated_at"}
	roomScanner = func(r dbtool.DbScanner, d interface{}) error {
		room := d.(*model.Room)
		return r.Scan(&room.Id, &room.Name, &room.Desc, &room.CreatedAt, &room.UpdatedAt)
	}
)

func (dao *RoomDao) Create(do dbtool.DbOperator, roomInfo *model.Room) error {
	strSql := "insert into " + roomTN + "(" + strings.Join(roomField, ",") + ") values (?,?,?,now(), now())"
	log.Debug("[Roomdb/Create] [SQL: '%s', values[%s, %s, %s,]", strSql, roomInfo.Id, roomInfo.Name, roomInfo.Desc)
	start := time.Now()
	defer func() {
		log.Info("[Room/db/Create] [SqlElapsed: %v]", time.Since(start))
	}()
	if _, err := do.Exec(strSql, roomInfo.Id, roomInfo.Name, roomInfo.Desc); err != nil {
		log.Error("[Room/db/Create] [DB.Exec: %s]", err.Error())
		return err
	}
	return nil
}

func (dao *RoomDao) Get(do dbtool.DbOperator, id string) (*model.Room, error) {
	ri := &model.Room{}
	start := time.Now()
	defer func() {
		log.Info("[Room/db/Get] [SqlElapsed: %v]", time.Since(start))
	}()
	return ri, GetDb(do, roomScanner, roomField, roomTN, id, ri)
}

func (dao *RoomDao) List(do dbtool.DbOperator, filter map[string]interface{}, limit int, offset int, order string, od int) ([]*model.Room, error) {
	rInfos := make([]*model.Room, 0, 10)
	start := time.Now()
	defer func() {
		log.Info("[Room/db/List] [SqlElapsed: %v]", time.Since(start))
	}()
	result, err := ListDb(do, roomTN, roomField, filter, limit, offset, order, od)
	if err != nil {
		log.Error("[Room/db/List] [ListDb: %s]", err.Error())
		return rInfos, err
	}
	defer result.Close()
	for result.Next() {
		rinfo := new(model.Room)
		if err := roomScanner(result, rinfo); err != nil {
			log.Error("[Room/db/List] [roomScanner: %s]", err.Error())
			return rInfos, err
		}
		rInfos = append(rInfos, rinfo)
	}
	return rInfos, err
}

func (dao *RoomDao) Delete(do dbtool.DbOperator, id string) error {
	start := time.Now()
	defer func() {
		log.Info("[Room/db/Delete] [SqlElapsed: %v]", time.Since(start))
	}()
	return DeleteDb(do, roomTN, map[string]interface{}{"Id": id})
}

func (dao *RoomDao) Count(do dbtool.DbOperator, filter map[string]interface{}) (int64, error) {
	start := time.Now()
	defer func() {
		log.Info("[Room/db/Count] [SqlElapsed: %v]", time.Since(start))
	}()
	return CountDb(do, roomTN, filter)
}

func (dao *RoomDao) Update(do dbtool.DbOperator, id string, kv map[string]interface{}) error {
	start := time.Now()
	defer func() {
		log.Info("[Room/db/Update] [SqlElapsed: %v]", time.Since(start))
	}()
	return UpdateDb(do, roomTN, id, kv)
}
