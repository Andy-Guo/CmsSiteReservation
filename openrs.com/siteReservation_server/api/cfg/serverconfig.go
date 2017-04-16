package cfg

import (
	"openrs.com/siteReservation_server/common/constant"
	. "openrs.com/siteReservation_server/api/utils"
	"os"
)

var (
	servconf_pf = map[string]*Attribute{
		"Port":    &Attribute{T_Int, ValIntRange(constant.PORT_MIN, constant.PORT_MAX), true, nil},
		"Cores":   &Attribute{T_Int, nil, true, nil},
		"BaseUrl": &Attribute{T_String, nil, true, nil},
	}
)

type ServerConfFac struct {
	Path *string
}

type ServerConf struct {
	Port    int
	Cores   int
	BaseUrl string
}

func (fac ServerConfFac) ParseConfig() (*ServerConf, error) {
	file, err := os.Open(*fac.Path)
	if err != nil {
		return nil, err
	}
	config := &ServerConf{}
	err = ValiAttr(servconf_pf, file, "server_config", config)
	if err != nil {
		return nil, err
	}
	return config, nil
}
