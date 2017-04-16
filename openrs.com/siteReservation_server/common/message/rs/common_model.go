package rs

type CommonResult struct {
	Code   uint32      `json:"code"`
	Msg    string      `json:"message"`
	Result interface{} `json:"result"`
}

type BasicElements struct {
	Elements []*BasicElement `json:"elements"`
}

type BasicElement struct {
	Id      string `json:"id"`
	Version uint64 `json:"version"`
}

type Ids struct {
	Ids []string `json:"ids"`
}

var (
	ErrTemp        = "{\"code\":%d, \"message\":\"%s\"}"
	ErrNoAction    = "{\"code\":11, \"message\":\"no such action\"}"
	ErrMarshalJson = "{\"code\":10, \"message\":\"marshal json err\"}"
	ErrReqParam    = "{\"code\":9, \"message\":\"request param invalid\"}"
	ErrDb          = "{\"code\":8, \"message\":\"db err\"}"
)
