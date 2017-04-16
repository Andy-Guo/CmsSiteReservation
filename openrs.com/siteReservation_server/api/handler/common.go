package handler

import (
	"regexp"

	"openrs.com/siteReservation_server/api/log"
	. "openrs.com/siteReservation_server/api/utils"
)

var (
	// Parameter format
	pf_base = map[string]*Attribute{
		"tenant_id": &Attribute{T_Uuid, nil, true, nil},
		"id":        &Attribute{T_Uuid, nil, true, nil},
	}
	emailRegexpStr = "^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(.[a-zA-Z0-9_-]+)+$"
	/*
	 * 验证手机号码正则
	 *
	 * 移动号码段:139、138、137、136、135、134、150、151、152、157、158、159、182、183、187、188、147
	 * 联通号码段:130、131、132、136、185、186、145
	 * 电信号码段:133、153、180、189
	 */
	phoneNumRegexpStr = "^((13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(18[0,5-9]))\\d{8}$"
)

func ValidateEmail(email string) bool {
	isEmail := false
	var err error
	isEmail, err = regexp.MatchString(emailRegexpStr, email)
	if err != nil {
		log.Error("[handler/common] [ValidateEmail: %s]", err.Error())
		isEmail = false
	}
	return isEmail
}

func ValidatePhoneNum(phoneNum string) bool {
	isPhone := false
	var err error
	isPhone, err = regexp.MatchString(phoneNumRegexpStr, phoneNum)
	if err != nil {
		log.Error("[handler/common] [ValidatePhoneNum: %s]", err.Error())
		isPhone = false
	}
	return isPhone
}
