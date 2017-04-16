package lib

import (
	"fmt"
	"strconv"
	"strings"
	"time"
)

type common interface {
	Open(name string) error
	Close() error

	Name() string
	Status() uint
}

type Stream interface {
	common

	Recv() (interface{}, error)
	Send(msg interface{}) error

	TimeoutProc() error
	Timeout() time.Duration
}

type PStream interface {
	common

	Accept() (Stream, error)
}

type ErrorStream struct {
	Type uint
	Inst common
	Args error
}

const (
	STREAM_STATUS_INVALID = iota
	STREAM_STATUS_ESTAB
	STREAM_STATUS_MAX
)

const (
	STREAM_ERROR_NAME = iota
	STREAM_ERROR_STATUS
	STREAM_ERROR_SYSTEM
	STREAM_ERROR_PROTO
	STREAM_ERROR_MAX
)

func (e *ErrorStream) Error() string {
	err := fmt.Sprintf("Stream %s error: %d\n", e.Inst.Name(), e.Type)

	switch e.Type {
	case STREAM_ERROR_NAME:
		return err + "Stream Name Format:\n" +
			"Proto://Trans:[Host:Port]|[Path]\n" +
			"  Proto:\n" +
			"    openflow | jdconf\n" +
			"  Trans:\n" +
			"    tcp | ptcp | unix | punix\n" +
			"  Host: (for SOCKET DOMAIN)\n" +
			"    specific ipv4 addr or empty (short for 0.0.0.0)\n" +
			"  Port: (for SOCKET DOMAIN)\n" +
			"    specific trans port" +
			"  Path: (for UNIX DOMAIN)\n" +
			"    specific path for sock file"

	case STREAM_ERROR_STATUS:
		return err + fmt.Sprintf("Status is %d", e.Inst.Status())

	case STREAM_ERROR_SYSTEM, STREAM_ERROR_PROTO:
		return err + e.Args.Error()
	}

	return err + "Controller BUG"
}

func parseName(name, proto string, isPStream bool) (
string, string) {
	var idx, port int
	var trans string
	var params []string

	// Parse proto
	proto = strings.ToLower(proto) + "://"
	if !strings.HasPrefix(name, proto) {
		goto out
	}

	// Parse trans
	name = strings.TrimPrefix(name, proto)
	if idx = strings.Index(name, ":") + 1; idx == 0 {
		goto out
	} else {
		trans = name[:idx]
	}

	switch trans {
	case "tcp:", "unix:":
		if isPStream {
			goto out
		}
	case "ptcp:", "punix:":
		if !isPStream {
			goto out
		}
	default:
		goto out
	}

	// Parse addr
	name = strings.TrimPrefix(name, trans)
	if trans == "unix:" || trans == "punix:" {
		return "unix", name
	}

	params = strings.Split(name, ":")
	if len(params) != 2 || params[1] == "" {
		goto out
	}

	port, _ = strconv.Atoi(params[1])
	if port <= 0 || port >= 65535 {
		goto out
	}

	if params[0] == "" {
		return "tcp", "0.0.0.0" + name
	} else {
		return "tcp", name
	}

	out:
	return "", ""
}
