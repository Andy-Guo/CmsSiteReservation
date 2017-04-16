package url

import (
	"bytes"
	"io/ioutil"
	"net/http"
	"strings"
	"time"

	"openrs.com/siteReservation_server/common/log"
	"openrs.com/siteReservation_server/common/message/rs"
)

type UrlRouter struct {
	Logger *log.Logger
	HF     map[string]http.HandlerFunc
}

func (u *UrlRouter) RegisterFunc(action string, f http.HandlerFunc) {
	u.HF[action] = f
}

func (u *UrlRouter) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	defer func() {
		if err := recover(); err != nil {
			u.Logger.Error("[url/handler] [method: %v, url: %v, remote_addr:%v, panic: %v, x-forwarded-for: %v]", r.Method,
				r.URL.RequestURI(), r.RemoteAddr, err, r.Header.Get("X-Forwarded-For"))
			panic(err)
		}
	}()
	start := time.Now()
	w.Header().Set("Content-Type", "application/json")
	action := r.FormValue("Action")
	if action == "" {
		u.Logger.Error("[url/handler] [method: %v, url: %v, remote_addr:%v, action: %v, x-forwarded-for: %v]", r.Method,
			r.URL.RequestURI(), r.RemoteAddr, action, r.Header.Get("X-Forwarded-For"))
		w.Write([]byte(rs.ErrReqParam))
		return
	}

	if action == "SetLogLevel" {
		u.SetLogLevel(w, r)
		return
	}

	f, ok := u.HF[action]
	if !ok {
		u.Logger.Error("[url/handler] [method: %v, url: %v,remote_addr:%v, action: %v, x-forwarded-for: %v]", r.Method,
			r.URL.RequestURI(), r.RemoteAddr, action, r.Header.Get("X-Forwarded-For"))
		w.Write([]byte(rs.ErrNoAction))
		return
	}
	body, err := ioutil.ReadAll(r.Body)
	if err != nil {
		u.Logger.Error("[url/handler] [method: %v, url: %v, remote_addr:%v, action: %v, x-forwarded-for: %v]", r.Method,
			r.URL.RequestURI(), r.RemoteAddr, action, r.Header.Get("X-Forwarded-For"))
		return
	}
	r.Body = ioutil.NopCloser(bytes.NewBuffer(body))
	f(w, r)
	elapsed := time.Since(start)
	u.Logger.Info("[url/handler] [method: %v, url: %v,  body: %v, remote_addr:%v, action: %v, x-forwarded-for: %v, elapsed: %v]", r.Method,
		r.URL.RequestURI(), r.RemoteAddr, string(body), action, r.Header.Get("X-Forwarded-For"), elapsed)

}

func (p *UrlRouter) SetLogLevel(w http.ResponseWriter, r *http.Request) {
	level := r.FormValue("level")
	if level == "" {
		p.Logger.Error("[url/handler] [level: empty]")
		w.Write([]byte(rs.ErrReqParam))
		return
	}

	var logLevel int
	switch strings.ToLower(level) {
	case "trace":
		logLevel = log.LevelTrace
	case "debug":
		logLevel = log.LevelDebug
	case "info":
		logLevel = log.LevelInfo
	case "warn":
		logLevel = log.LevelWarn
	case "error":
		logLevel = log.LevelError
	case "fatal":
		logLevel = log.LevelFatal
	default:
		p.Logger.Error("[url/handler] [level: %v]", level)
		w.Write([]byte(rs.ErrReqParam))
		return
	}
	p.Logger.Info("[url/handler] [newLevel: %v]", level)
	p.Logger.SetLevel(logLevel)
}
