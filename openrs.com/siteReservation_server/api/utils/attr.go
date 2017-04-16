package utils

import (
	"encoding/json"
	"io"
	"io/ioutil"
	"net"
	"regexp"
	"unicode/utf8"
)

const (
	T_String = iota
	T_Int
	T_Bool
	T_Uuid
	T_Struct
	T_Filter
	T_Order
	T_Array
	T_Domain
	T_UrlPath
	T_Text
	T_IP
	T_UuidNull
	T_HostName
	T_Float
)

var (
	uuidP         string = `^[a-z0-9]([a-z0-9-])*$`
	textP         string = `^([a-zA-Z0-9\_-]|[\p{Han}])*$`
	domainP       string = `^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}$`
	urlpathP      string = `^\/[a-z0-9\/\.\%\?\#\&\=]*$`
	hnParaPattern string = `^([a-zA-Z0-9\_\-\.])*$`
	textRe        *regexp.Regexp
	uuidRe        *regexp.Regexp
	domainRe      *regexp.Regexp
	urlpathRe     *regexp.Regexp
	hnRe          *regexp.Regexp
)

type Validater func(d interface{}) bool

type Attribute struct {
	Type     int
	Val      Validater
	Required bool
	SubAttr  interface{}
}

func validate_string(d interface{}) bool {
	_, ok := d.(string)
	return ok
}

func validate_bool(d interface{}) bool {
	_, ok := d.(bool)
	return ok
}

func validate_int(d interface{}) bool {
	_, ok := d.(float64)
	return ok
}

func validate_uuid(d interface{}) bool {
	if id, ok := d.(string); ok {
		return uuidRe.Match([]byte(id))
	}
	return false
}

func validate_uuidNull(d interface{}) bool {
	if id, ok := d.(string); ok {
		return id == "" || uuidRe.Match([]byte(id))
	}
	return false
}

func validate_domain(d interface{}) bool {
	if domain, ok := d.(string); ok {
		return domain == "" || domainRe.Match([]byte(domain))
	}
	return false
}

func validate_urlpath(d interface{}) bool {
	if path, ok := d.(string); ok {
		return urlpathRe.Match([]byte(path))
	}
	return false
}

func validate_text(d interface{}) bool {
	if s, ok := d.(string); ok {
		return textRe.Match([]byte(s))
	}
	return false
}

func validate_ip(d interface{}) bool {
	if s, ok := d.(string); ok {
		return net.ParseIP(s) != nil
	}
	return false
}

func ValIntRange(s, e int) Validater {
	return func(d interface{}) bool {
		df, ok := d.(float64)
		if !ok {
			return false
		}
		di := int(df)
		return di >= s && di <= e
	}
}

func ValFloatRange(s, e float64) Validater {
	return func(d interface{}) bool {
		df, ok := d.(float64)
		if !ok {
			return false
		}
		return df >= s && df <= e
	}
}

func ValIntEles(eles ...int) Validater {
	em := make(map[int]bool)
	for _, ele := range eles {
		em[ele] = true
	}
	return func(d interface{}) bool {
		df, ok := d.(float64)
		if !ok {
			return false
		}
		di := int(df)
		_, val := em[di]
		return val
	}
}

func ValRegExp(ptn string) Validater {
	return func(d interface{}) bool {
		if s, ok := d.(string); ok {
			matched, err := regexp.MatchString(ptn, s)
			return err == nil && matched
		}
		return false
	}
}

func ValStrLen(le int) Validater {
	return func(d interface{}) bool {
		if s, ok := d.(string); ok {
			return len(s) <= le
		}
		return false
	}
}

func ValTextLen(le int) Validater {
	return func(d interface{}) bool {
		if s, ok := d.(string); ok {
			return utf8.RuneCountInString(s) <= le
		}
		return false
	}
}

func ValStrEq(s string) Validater {
	return func(d interface{}) bool {
		if sd, ok := d.(string); ok {
			return sd == s
		}
		return false
	}
}

func MultiValid(valids ...Validater) Validater {
	return func(d interface{}) bool {
		for _, valid := range valids {
			if !valid(d) {
				return false
			}
		}
		return true
	}
}

func validate_array(a []interface{}, attr *Attribute, r string) (bool, CcError) {
	if attr.Required && len(a) == 0 {
		return false, nil
	}
	for _, ele := range a {
		if valid, ce := validate_data(ele, attr, r); !valid {
			return false, ce
		}
	}
	return true, nil
}

func validate_data(p interface{}, attr *Attribute, r string) (bool, CcError) {
	var valid bool
	var ce CcError = nil
	switch attr.Type {
	case T_Int:
		valid = validate_int(p)
	case T_String:
		valid = validate_string(p) && (!attr.Required || p.(string) != "")
	case T_Uuid:
		valid = validate_uuid(p)
	case T_UuidNull:
		valid = validate_uuidNull(p)
	case T_Domain:
		valid = validate_domain(p)
	case T_UrlPath:
		valid = validate_urlpath(p)
	case T_Text:
		valid = validate_text(p) && (!attr.Required || p.(string) != "")
	case T_IP:
		valid = validate_ip(p)
	case T_HostName:
		valid = validate_hostname(p)
	case T_Float:
		valid = validate_int(p)
	case T_Bool:
		valid = validate_bool(p)
	case T_Struct:
		if s, ok := p.(map[string]interface{}); ok {
			valid, ce = validate_struct(s, attr.SubAttr.(map[string]*Attribute), r)
		} else {
			valid = false
		}
	case T_Filter:
		if fs, ok := p.([]interface{}); ok {
			valid, ce = validate_filter(fs, attr.SubAttr.(map[string]*Attribute), r)
		} else {
			valid = false
			ce = NE(r, ErrInvalid, ErrFilter, ErrNull)
		}
	case T_Order:
		if fs, ok := p.([]interface{}); ok {
			valid, ce = validate_order(fs, attr.SubAttr.(map[string]*Attribute), r)
		} else {
			valid = false
			ce = NE(r, ErrInvalid, ErrOrder, ErrNull)
		}

	case T_Array:
		if a, ok := p.([]interface{}); ok {
			valid, ce = validate_array(a, attr.SubAttr.(*Attribute), r)
		} else {
			valid = false
		}
	default:
		panic("Parameter Format Invalid")
	}
	if valid {
		valid = (attr.Val == nil) || attr.Val(p)
	}
	return valid, ce
}

func validate_struct(m map[string]interface{}, attrs map[string]*Attribute, r string) (bool, CcError) {
	for k, v := range attrs {
		if p, ok := m[k]; ok && p != nil {
			if valid, ce := validate_data(p, v, k); !valid {
				if ce == nil {
					ce = NE(r, ErrInvalid, k, ErrNull)
				}
				return false, ce
			}
		} else {
			if v.Required {
				return false, NE(r, ErrMiss, k, ErrNull)
			}
		}
	}
	return true, nil
}

func ValiAttr(attrs map[string]*Attribute, rr io.Reader, r string, d interface{}) CcError {
	bt, err := ioutil.ReadAll(rr)
	if err != nil {
		return NE(r, ErrMalformed, ErrNull, err.Error())
	}
	var f interface{}
	if err := json.Unmarshal(bt, &f); err != nil {
		return NE(r, ErrMalformed, ErrNull, err.Error())
	}
	m := f.(map[string]interface{})
	if _, ce := validate_struct(m, attrs, r); ce != nil {
		return ce
	}
	if err := json.Unmarshal(bt, d); err != nil {
		return NE(r, ErrMalformed, ErrNull, err.Error())
	}
	return nil
}

func validate_filter(fs []interface{}, attrs map[string]*Attribute, r string) (bool, CcError) {
	return validate_fo(fs, attrs, r, "field", "value")
}

func validate_order(fs []interface{}, attrs map[string]*Attribute, r string) (bool, CcError) {
	return validate_fo(fs, attrs, r, "field", "direction")
}

func validate_fo(fs []interface{}, attrs map[string]*Attribute, r string, key string, value string) (bool, CcError) {
	for _, f := range fs {
		if fm, ok := f.(map[string]interface{}); !ok {
			return false, NE(r, ErrInvalid, ErrFilter, ErrNull)
		} else {
			field, ok := fm[key]
			if !ok {
				return false, nil
			}
			value, ok := fm[value]
			if !ok {
				return false, nil
			}
			subattr, ok := attrs[field.(string)]
			if !ok {
				return false, nil
			}
			if valid, ce := validate_data(value, subattr, r); !valid {
				return valid, ce
			}
		}
	}
	return true, nil
}

func validate_hostname(d interface{}) bool {
	if hostname, ok := d.(string); ok {
		return hnRe.Match([]byte(hostname))
	}
	return false
}
