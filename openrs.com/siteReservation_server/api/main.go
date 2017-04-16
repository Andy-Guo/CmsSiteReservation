package main

import (
	"flag"
	"fmt"
	"net/http"
	"runtime"
	"strconv"

	"openrs.com/siteReservation_server/api/cfg"
	dao "openrs.com/siteReservation_server/api/db"
	"openrs.com/siteReservation_server/api/dbtool"
	"openrs.com/siteReservation_server/api/handler"
	"openrs.com/siteReservation_server/api/log"
	"openrs.com/siteReservation_server/api/service"
	"openrs.com/siteReservation_server/common/url"
)

func main() {
	var LogConfFile = flag.String("logconf", "/etc/rs_server/logconfig.json", "Log config file name")
	var MysqlConfFile = flag.String("dbconf", "/etc/rs_server/mysqlconfig.json", "Db config file name")
	var ServerConfFile = flag.String("serverconf", "/etc/rs_server/serverconfig.json", "Server config file name")
	flag.Parse()
	// Setup global config first
	pathMap := map[string]string{"logconf": *LogConfFile, "dbconf": *MysqlConfFile, "serverconf": *ServerConfFile}
	cfg.Setup(pathMap)
	// Modules Setup
	logger, err := cfg.LogFac{Logconf: cfg.LogConfig}.NewLogger()
	if err != nil {
		fmt.Println("[Init] new logger err: ", err.Error())
		return
	}
	log.Setup(logger)

	db, err := cfg.MysqlInstance{Conf: cfg.DBConfig}.NewMysqlInstance()
	if err != nil {
		fmt.Println("[Init] Create Db connection error: ", err.Error())
		return
	}
	dbtool.Setup(db)
	dao.Setup()
	service.Setup()

	r := &url.UrlRouter{logger, make(map[string]http.HandlerFunc)}
	http.Handle(cfg.ServerConfig.BaseUrl, r)
	if err = handlerInit(r); err != nil {
		fmt.Println("[Init] Handler registe error: ", err.Error())
		return
	}

	runtime.GOMAXPROCS(cfg.ServerConfig.Cores)
	err = http.ListenAndServe(":"+strconv.Itoa(cfg.ServerConfig.Port), nil)
	if err != nil {
		fmt.Println("[Init] http server exit, error: %s", err.Error())
	}
}

func handlerInit(r *url.UrlRouter) error {

	// user
	userInfoHandler := &handler.UserHandler{}
	userInfoHandler.Register(r)

	return nil
}
