package constant

const (
	PORT_MIN = 0
	PORT_MAX = 65535
)

const (
	USER_ROLE_TYPE_MEM = iota
	USER_ROLE_TYPE_ADMIN
	USER_ROLE_TYPE_MGMT
)

const (
	USER_COUNT_RANK_VIP = iota
	USER_COUNT_RANK_SILVER_VIP
	USER_COUNT_RANK_GOLD_VIP
	USER_COUNT_RANK_PLATINUM_VIP
)

const (
	ENCRIPT_ALGORITHM_MD5    = "MD5"
	ENCRIPT_ALGORITHM_AES    = "AES"
	ENCRIPT_ALGORITHM_BASE64 = "BASE64"
	ENCRIPT_ALGORITHM_NULL   = "NULL"
)
