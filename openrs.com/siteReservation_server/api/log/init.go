package log

import (
	rs_log "openrs.com/siteReservation_server/common/log"
)

var (
	l *rs_log.Logger
)

var LevelTrace, LevelDebug, LevelInfo, LevelWarn, LevelError, LevelFatal int

func Setup(lc *rs_log.Logger) {
	l = lc
	LevelTrace = rs_log.LevelTrace
	LevelDebug = rs_log.LevelDebug
	LevelInfo = rs_log.LevelInfo
	LevelWarn = rs_log.LevelWarn
	LevelError = rs_log.LevelError
	LevelFatal = rs_log.LevelFatal
}

func Debug(format string, v ...interface{}) {
	l.Output(2, LevelDebug, format, v...)
}

func Error(format string, v ...interface{}) {
	l.Output(2, LevelError, format, v...)
}

func Info(format string, v ...interface{}) {
	l.Output(2, LevelInfo, format, v...)
}

func Warn(format string, v ...interface{}) {
	l.Output(2, LevelWarn, format, v...)
}
