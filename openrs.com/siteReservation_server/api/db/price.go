package db

import (
	"strings"
	"time"

	"openrs.com/siteReservation_server/api/dbtool"
	"openrs.com/siteReservation_server/api/log"
	"openrs.com/siteReservation_server/model"
)

//价格表
type PriceDao struct {
}

//id,name,desc,count_rank,room_id,time_id,price,created_at,updated_at
var (
	priceTN      = "price"
	priceField   = []string{"id", "name", "desc", "count_rank", "room_id", "time_id", "price", "created_at", "updated_at"}
	priceScanner = func(r dbtool.DbScanner, d interface{}) error {
		price := d.(*model.Price)
		return r.Scan(&price.Id, &price.Name, &price.Desc, &price.CountRank, &price.RoomId, &price.TimeDescId, &price.Price, &price.CreatedAt, &price.UpdatedAt)
	}
)

func (dao *PriceDao) Create(do dbtool.DbOperator, p *model.Price) error {
	strSql := "insert into " + priceTN + "(" + strings.Join(priceField, ",") + ") values (?,?,?,?,?,?,?,now(), now())"
	log.Debug("[Price/db/Create] [SQL: '%s', values[%s, %s, %s, %s, %s, %s, %s,]", strSql, p.Id, p.Name, p.Desc, p.CountRank, p.RoomId, p.TimeDescId, p.Price)
	start := time.Now()
	defer func() {
		log.Info("[Price/db/Create] [SqlElapsed: %v]", time.Since(start))
	}()
	if _, err := do.Exec(strSql, p.Id, p.Name, p.Desc, p.CountRank, p.RoomId, p.TimeDescId, p.Price); err != nil {
		log.Error("[Price/db/Create] [DB.Exec: %s]", err.Error())
		return err
	}
	return nil
}

func (dao *PriceDao) Get(do dbtool.DbOperator, id string) (*model.Price, error) {
	p := &model.Price{}
	start := time.Now()
	defer func() {
		log.Info("[Price/db/Get] [SqlElapsed: %v]", time.Since(start))
	}()
	return p, GetDb(do, priceScanner, priceField, priceTN, id, p)
}

func (dao *PriceDao) List(do dbtool.DbOperator, filter map[string]interface{}, limit int, offset int, order string, od int) ([]*model.Price, error) {
	ps := make([]*model.Price, 0, 10)
	start := time.Now()
	defer func() {
		log.Info("[Price/db/List] [SqlElapsed: %v]", time.Since(start))
	}()
	result, err := ListDb(do, priceTN, priceField, filter, limit, offset, order, od)
	if err != nil {
		log.Error("[Price/db/List] [ListDb: %s]", err.Error())
		return ps, err
	}
	defer result.Close()
	for result.Next() {
		p := new(model.Price)
		if err := priceScanner(result, p); err != nil {
			log.Error("[Price/db/List] [priceScanner: %s]", err.Error())
			return ps, err
		}
		ps = append(ps, p)
	}
	return ps, err
}

func (dao *PriceDao) Delete(do dbtool.DbOperator, id string) error {
	start := time.Now()
	defer func() {
		log.Info("[Price/db/Delete] [SqlElapsed: %v]", time.Since(start))
	}()
	return DeleteDb(do, priceTN, map[string]interface{}{"Id": id})
}

func (dao *PriceDao) Count(do dbtool.DbOperator, filter map[string]interface{}) (int64, error) {
	start := time.Now()
	defer func() {
		log.Info("[Price/db/Count] [SqlElapsed: %v]", time.Since(start))
	}()
	return CountDb(do, priceTN, filter)
}

func (dao *PriceDao) Update(do dbtool.DbOperator, id string, kv map[string]interface{}) error {
	start := time.Now()
	defer func() {
		log.Info("[Price/db/Update] [SqlElapsed: %v]", time.Since(start))
	}()
	return UpdateDb(do, priceTN, id, kv)
}
