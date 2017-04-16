package db

import (
	"strings"
	"time"

	"openrs.com/siteReservation_server/api/dbtool"
	"openrs.com/siteReservation_server/api/log"
	"openrs.com/siteReservation_server/model"
)

// 时间段表
type TimeDurDao struct {
}

//id,time_duration,date(y-m-d)
var (
	timeDurTN      = "time"
	timeDurField   = []string{"id", "time_duration", "date"}
	timeDurScanner = func(r dbtool.DbScanner, d interface{}) error {
		t := d.(*model.TimeDur)
		return r.Scan(&t.Id, &t.TimeDuration, &t.Date)
	}
)

func (dao *TimeDurDao) Create(do dbtool.DbOperator, timeDur *model.TimeDur) error {
	strSql := "insert into " + timeDurTN + "(" + strings.Join(timeDurField, ",") + ") values (?,?,?)"
	log.Debug("[TimeDuration/db/Create] [SQL: '%s', values[%s, %s, %s]", strSql, timeDur.Id, timeDur.TimeDuration, timeDur.Date)
	start := time.Now()
	defer func() {
		log.Info("[TimeDuration/db/Create] [SqlElapsed: %v]", time.Since(start))
	}()
	if _, err := do.Exec(strSql, timeDur.Id, timeDur.TimeDuration, timeDur.Date); err != nil {
		log.Error("[TimeDuration/db/Create] [DB.Exec: %s]", err.Error())
		return err
	}
	return nil
}

func (dao *TimeDurDao) Get(do dbtool.DbOperator, id string) (*model.TimeDur, error) {
	td := &model.TimeDur{}
	start := time.Now()
	defer func() {
		log.Info("[TimeDuration/db/Get] [SqlElapsed: %v]", time.Since(start))
	}()
	return td, GetDb(do, timeDurScanner, timeDurField, timeDurTN, id, td)
}

func (dao *TimeDurDao) List(do dbtool.DbOperator, filter map[string]interface{}, limit int, offset int, order string, od int) ([]*model.TimeDur, error) {
	tds := make([]*model.TimeDur, 0, 10)
	start := time.Now()
	defer func() {
		log.Info("[TimeDuration/db/List] [SqlElapsed: %v]", time.Since(start))
	}()
	result, err := ListDb(do, timeDurTN, timeDurField, filter, limit, offset, order, od)
	if err != nil {
		log.Error("[TimeDuration/db/List] [ListDb: %s]", err.Error())
		return tds, err
	}
	defer result.Close()
	for result.Next() {
		td := new(model.TimeDur)
		if err := timeDurScanner(result, td); err != nil {
			log.Error("[TimeDuration/db/List] [timeDurScanner: %s]", err.Error())
			return tds, err
		}
		tds = append(tds, td)
	}
	return tds, err
}

func (dao *TimeDurDao) Delete(do dbtool.DbOperator, id string) error {
	start := time.Now()
	defer func() {
		log.Info("[TimeDuration/db/Delete] [SqlElapsed: %v]", time.Since(start))
	}()
	return DeleteDb(do, timeDurTN, map[string]interface{}{"Id": id})
}

func (dao *TimeDurDao) Count(do dbtool.DbOperator, filter map[string]interface{}) (int64, error) {
	start := time.Now()
	defer func() {
		log.Info("[TimeDuration/db/Count] [SqlElapsed: %v]", time.Since(start))
	}()
	return CountDb(do, timeDurTN, filter)
}

func (dao *TimeDurDao) Update(do dbtool.DbOperator, id string, kv map[string]interface{}) error {
	start := time.Now()
	defer func() {
		log.Info("[TimeDuration/db/Update] [SqlElapsed: %v]", time.Since(start))
	}()
	return UpdateDb(do, timeDurTN, id, kv)
}
