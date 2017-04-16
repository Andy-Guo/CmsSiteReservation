package service

import (
	"database/sql"

	"openrs.com/siteReservation_server/api/db"
	"openrs.com/siteReservation_server/api/dbtool"
	"openrs.com/siteReservation_server/api/log"
	. "openrs.com/siteReservation_server/api/utils"
	"openrs.com/siteReservation_server/common/constant"
	"openrs.com/siteReservation_server/model"
)

var (
	USER = "user"
)

func err2ce(e error, r string) (ce CcError) {
	switch e {
	case nil:
	case sql.ErrNoRows:
		return NE(r, ErrNotFound, ErrNull, ErrNull)
	default:
		return NewSysErr(e)
	}
	return nil
}

func getUserInfo(do dbtool.DbOperator, id string) (*model.UserInfo, CcError) {
	switch a, err := db.UserDao.Get(do, id); {
	case err == sql.ErrNoRows:
		return nil, NE(ErrUserInfo, ErrNotFound, ErrNull,
			"Unable to find User with id '"+id+"'")
	case err != nil:
		log.Error("[service/getUserInfo] [UserDao.Get: %s, id: %s]", err.Error(), id)
		return nil, NewSysErr(err)
	default:
		return a, nil
	}
}

//TODO
func encrypt(sourceStr string, algorithm string) (encptResult string) {
	switch algorithm {
	case constant.ENCRIPT_ALGORITHM_MD5:
		log.Error("[service/encrypt] [encrypt: MD5 encrypt anlgorithm unsupport.]")
		encptResult = ""
	case constant.ENCRIPT_ALGORITHM_BASE64:
		log.Error("[service/encrypt] [encrypt: BASE64 encrypt anlgorithm unsupport.]")
		encptResult = ""
	case constant.ENCRIPT_ALGORITHM_AES:
		log.Error("[service/encrypt] [encrypt: AES encrypt anlgorithm unsupport.]")
		encptResult = ""
	case constant.ENCRIPT_ALGORITHM_NULL:
		log.Info("[service/encrypt] [encrypt: password has not used encrypt anlgorithm.]")
		encptResult = sourceStr
	default:
		log.Error("[service/encrypt] [encrypt: anlgorithm unsupport.]")
		encptResult = ""
	}
	return
}
