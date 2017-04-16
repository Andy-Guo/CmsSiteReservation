package lib

type Message struct {
	Type uint
	Orig Entity
	Body interface{}
}

const (
	// System
	MSG_SYS_QUIT = iota
	MSG_SYS_SYNC_DB

	// JDConf
	MSG_JDC_LB_SYNC
	MSG_JDC_LB_UPDATE
	MSG_JDC_LB_CFGERR
	MSG_JDC_LB_PROCERR
	MSG_JDC_LB_KEEPALIVE
	MSG_JDC_LB_STATS
)

var JDCMSGRAW2ID = map[uint16]uint{
	1: MSG_JDC_LB_SYNC,
	2: MSG_JDC_LB_UPDATE,
	3: MSG_JDC_LB_CFGERR,
	4: MSG_JDC_LB_PROCERR,
	5: MSG_JDC_LB_KEEPALIVE,
	6: MSG_JDC_LB_STATS,
}



