package lib

import (
	"fmt"
)

type Entity interface {
	Run()

	Name() string
	Status() uint
	MsgChan() chan *Message
}

type ErrorEntity struct {
	Type uint
	Inst Entity
	Args error
}

const (
	ENTITY_STATUS_INVALID = iota
	ENTITY_STATUS_RUNNING
	ENTITY_STATUS_MAX
)

const (
	ENTITY_ERROR_ARGS = iota
	ENTITY_ERROR_STATUS
	ENTITY_ERROR_SYSTEM
	ENTITY_ERROR_MAX
)

const ENTITY_MSGCHAN_CAP = 64

func (e *ErrorEntity) Error() string {
	err := fmt.Sprintf("Entity %s error: %d\n", e.Inst.Name(), e.Type)

	switch e.Type {
	case ENTITY_ERROR_ARGS:
		return err + fmt.Sprint(e.Inst)

	case ENTITY_ERROR_STATUS:
		return err + fmt.Sprintf("Status is %d", e.Inst.Status())

	case ENTITY_ERROR_SYSTEM:
		return err + e.Args.Error()
	}

	return err + "Controller BUG"
}
