package cfg

import (
	"database/sql"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
	"openrs.com/siteReservation_server/common/constant"
	"openrs.com/siteReservation_server/api/log"
	. "openrs.com/siteReservation_server/api/utils"
	"os"
	"time"
)

var (
	mysqlconf_pf = map[string]*Attribute{
		"Ip":            &Attribute{T_String, nil, true, nil},
		"Port":          &Attribute{T_Int, ValIntRange(constant.PORT_MIN, constant.PORT_MAX), true, nil},
		"User":          &Attribute{T_String, nil, true, nil},
		"Passwd":        &Attribute{T_String, nil, false, nil},
		"DB":            &Attribute{T_String, nil, true, nil},
		"Timeout":       &Attribute{T_Int, nil, true, nil},
		"MaxConnection": &Attribute{T_Int, nil, true, nil},
		"MaxLifetime":   &Attribute{T_Int, nil, true, nil},
	}
)

type MysqlConfFac struct {
	Path *string
}

type MysqlConf struct {
	Ip            string
	Port          int
	User          string
	Passwd        string
	DB            string
	Timeout       int
	MaxConnection int
	MaxLifetime   int
}

func (fac MysqlConfFac) ParseConfig() (*MysqlConf, error) {
	file, err := os.Open(*fac.Path)
	if err != nil {
		return nil, err
	}
	config := &MysqlConf{}
	err = ValiAttr(mysqlconf_pf, file, "mysql_config", config)
	if err != nil {
		return nil, err
	}
	return config, nil
}

type MysqlInstance struct {
	Conf *MysqlConf
}

func (ins MysqlInstance) NewMysqlInstance() (*sql.DB, error) {
	strConn := "%s:%s@tcp(%s:%d)/%s?autocommit=true&parseTime=true&timeout=%dms&loc=Asia%%2FShanghai&tx_isolation='READ-COMMITTED'"
	url := fmt.Sprintf(strConn, ins.Conf.User, ins.Conf.Passwd,
		ins.Conf.Ip, ins.Conf.Port, ins.Conf.DB, ins.Conf.Timeout)
	var db *sql.DB
	var err error
	db, err = sql.Open("mysql", url)
	if err != nil {
		log.Error("[Mysql/cfg/NewMysqlInstance] [sql.Open: %s, url: %s]", err.Error(), url)
		return nil, err
	}
	log.Info("open mysql success\n")
	db.SetMaxOpenConns(ins.Conf.MaxConnection)
	db.SetMaxIdleConns(ins.Conf.MaxConnection)
	db.SetConnMaxLifetime(time.Second * time.Duration(ins.Conf.MaxLifetime))

	err = db.Ping()
	if err != nil {
		log.Error("[Mysql/cfg/NewMysqlInstance] [db.Ping: %s]", err.Error())
		return nil, err
	}

	log.Debug("[Mysql/cfg/NewMysqlInstance] [info: MySQLInit, configure: %+v]", ins.Conf)
	return db, nil
}
