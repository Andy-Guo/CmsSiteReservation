package utils

import (
	"reflect"
)

// Return value of pointer direct, if pointer is nil, return default value.
// (dxf) support int/string/uint pointer currently.
func GetPtrVal(ptr interface{}, defaultV interface{}) interface{} {
	switch n := ptr.(type) {
	case *int:
		if n == nil {
			return defaultV
		} else {
			return *n
		}
	case *string:
		if n == nil {
			return defaultV
		} else {
			return *n
		}
	case *uint:
		if n == nil {
			return defaultV
		} else {
			return *n
		}
	default:
		panic("Unsupport pointer type")
	}
}

// Like operator (?:)
func CondOp(cond bool, left, right interface{}) interface{} {
	if cond {
		return left
	} else {
		return right
	}
}

// Uinque an silice, return an new slice without repeated elements.
func Unique(slice interface{}) interface{} {
	val := reflect.ValueOf(slice)
	if val.Kind() != reflect.Slice {
		panic("Unique function parameter type error: should be slice not " + val.Kind().String())
	}
	ret := reflect.MakeSlice(reflect.TypeOf(slice), val.Len(), val.Len())
	uniMap := make(map[interface{}]bool)
	index := 0
	for i := 0; i < val.Len(); i++ {
		ele := val.Index(i).Interface()
		if _, ok := uniMap[ele]; ok {
			continue
		}
		uniMap[ele] = true
		ret.Index(index).Set(reflect.ValueOf(ele))
		index++
	}
	return ret.Slice(0, index).Interface()
}
