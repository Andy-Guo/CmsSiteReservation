package handler

import (
	"encoding/json"
	"net/http"

	"openrs.com/siteReservation_server/api/utils"
	"openrs.com/siteReservation_server/model"
)

type DescData struct {
	Tc       int64       `json:"total_count"`
	Elements interface{} `json:"elements"`
}

type CCHandler struct{}

func (h *CCHandler) Response(w http.ResponseWriter, ce utils.CcError, data interface{}) {
	rsp := model.CommResp{Code: 0, Data: data}
	if ce != nil {
		rsp.Code = -1
		rsp.Message = ce.Error()
		rsp.Detail = ce.Detail()
	}

	jsonRsp, _ := json.Marshal(&rsp)
	w.Header().Set("Content-Type", "application/json")
	w.Write(jsonRsp)
}
