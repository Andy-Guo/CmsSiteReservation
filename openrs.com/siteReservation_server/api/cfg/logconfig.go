package cfg

import (
	"fmt"
	"os"

	rs_log "openrs.com/siteReservation_server/api/log"
	. "openrs.com/siteReservation_server/api/utils"
	"openrs.com/siteReservation_server/common/log"
)

var (
	loglevel_validator = ValIntEles(rs_log.LevelTrace, rs_log.LevelDebug, rs_log.LevelInfo, rs_log.LevelWarn, rs_log.LevelError, rs_log.LevelFatal)
	logconf_pf         = map[string]*Attribute{
		"Level":       &Attribute{T_Int, ValIntRange(1, 4), true, nil},
		"FileName":    &Attribute{T_String, nil, true, nil},
		"FileMaxSize": &Attribute{T_Int, nil, true, nil},
		"FileCount":   &Attribute{T_Int, nil, true, nil},
	}
)

type LogConfFac struct {
	Path *string
}

type LogConf struct {
	Level       int
	FileName    string
	FileMaxSize int
	FileCount   int
}

func (fac LogConfFac) ParseConfig() (*LogConf, error) {
	file, err := os.Open(*fac.Path)
	if err != nil {
		return nil, err
	}
	config := &LogConf{}
	err = ValiAttr(logconf_pf, file, "log_config", config)
	if err != nil {
		return nil, err
	}
	return config, nil
}

type LogFac struct {
	Logconf *LogConf
}

func (fac LogFac) NewLogger() (*log.Logger, error) {
	var h log.Handler
	var err error
	h, err = log.NewRotatingFileHandler(fac.Logconf.FileName, fac.Logconf.FileMaxSize, fac.Logconf.FileCount)
	if err != nil {
		fmt.Printf("new log handler err: %v\n", err.Error())
		return nil, err
	}

	logger := log.NewDefault(h)
	logger.SetLevel(fac.Logconf.Level)

	return logger, nil
}
