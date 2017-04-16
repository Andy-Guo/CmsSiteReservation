package cfg

import (
	"fmt"
	"os"
)

var (
	LogConfig    *LogConf
	DBConfig     *MysqlConf
	ServerConfig *ServerConf
)

func Setup(pathMap map[string]string) {
	for k, v := range pathMap {
		var err error = nil
		switch k {
		case "logconf":
			LogConfig, err = LogConfFac{Path: &v}.ParseConfig()
		case "dbconf":
			DBConfig, err = MysqlConfFac{Path: &v}.ParseConfig()
		case "serverconf":
			ServerConfig, err = ServerConfFac{Path: &v}.ParseConfig()
		default:
		}
		if err != nil {
			fmt.Println("parse config err: ", err.Error())
			os.Exit(1)
		}
	}
}
