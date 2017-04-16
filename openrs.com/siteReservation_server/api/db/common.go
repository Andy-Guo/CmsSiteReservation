package db

import (
	"database/sql"
	"errors"
	"openrs.com/siteReservation_server/api/dbtool"
	"openrs.com/siteReservation_server/api/log"
	"strings"
)

type Scanner func(r dbtool.DbScanner, d interface{}) error

func transferFilterSql(filter map[string]interface{}) ([]string, []interface{}) {
	var fk []string
	var fv []interface{}

	handleArrFilter := func(arr []interface{}, s *string) (fv []interface{}) {
		for i, ki := range arr {
			if i == 0 {
				*s += "?"
			} else {
				*s += ", ?"
			}
			fv = append(fv, ki)
		}
		return
	}

	for k, v := range filter {
		tmpK := "`" + camelToUnix(k) + "`"
		switch v.(type) {
		case float64, int, string, int64:
			fk = append(fk, tmpK+"=?")
			fv = append(fv, v)
		case []int:
			tmpK += " IN ("
			arr := []interface{}{}
			if vl, ok := v.([]int); ok {
				for _, ki := range vl {
					arr = append(arr, ki)
				}
			}
			tmpFv := handleArrFilter(arr, &tmpK)
			tmpK += ")"
			fv = append(fv, tmpFv...)
			fk = append(fk, tmpK)
		case []string:
			tmpK += " IN ("
			arr := []interface{}{}
			if vl, ok := v.([]string); ok {
				for _, ki := range vl {
					arr = append(arr, ki)
				}
			}
			tmpFv := handleArrFilter(arr, &tmpK)
			tmpK += ")"
			fv = append(fv, tmpFv...)
			fk = append(fk, tmpK)
		case []interface{}:
			tmpK += " IN ("
			tmpFv := handleArrFilter(v.([]interface{}), &tmpK)
			tmpK += ")"
			fv = append(fv, tmpFv...)
			fk = append(fk, tmpK)
		}
	}
	return fk, fv
}

func GetDb(do dbtool.DbOperator, s Scanner, field []string, tn string, id string, d interface{}) error {
	strSql := "select `" + strings.Join(field, "`,`") + "` from `" + tn + "` where `id`=?"
	log.Debug("[db/GetDb] [SQL: '%s', values: [%s]]", strSql, id)
	return s(do.QueryRow(strSql, id), d)
}

func DeleteDb(do dbtool.DbOperator, tn string, filter map[string]interface{}) error {
	strSql := "delete from `" + tn + "`"
	var fk []string
	var fv []interface{}

	fk, fv = transferFilterSql(filter)

	if len(filter) > 0 {
		strSql += " where " + strings.Join(fk, " and ")
	}

	log.Debug("[db/DeleteDb] [SQL: '%s', values: %v]", strSql, fv)
	_, err := do.Exec(strSql, fv...)
	return err
}

func ListDb(do dbtool.DbOperator, tn string, field []string, filter map[string]interface{}, limit int, offset int, order string, od int) (*sql.Rows, error) {
	fields := "`" + strings.Join(field, "`,`") + "`"
	strSql := "select " + fields + " from `" + tn + "`"
	var fk []string
	var fv []interface{}

	fk, fv = transferFilterSql(filter)

	if len(filter) > 0 {
		strSql += " where " + strings.Join(fk, " and ")
	}
	if order != "" {
		order = camelToUnix(order)
		strSql += " order by `" + string(order) + "`"
		if od == 0 {
			strSql += " desc"
		}
	}
	if limit >= 0 {
		if offset >= 0 {
			strSql += " LIMIT ?, ?"
			fv = append(fv, offset)
			fv = append(fv, limit)
		} else {
			strSql += " LIMIT ?"
			fv = append(fv, limit)
		}
	}

	log.Debug("[db/ListDb] [SQL: '%s', values: %v]", strSql, fv)
	return do.Query(strSql, fv...)
}

func CountDb(do dbtool.DbOperator, tn string, filter map[string]interface{}) (int64, error) {
	strSql := "select count(`id`) from `" + tn + "`"
	var fk []string
	var fv []interface{}
	var count int64

	fk, fv = transferFilterSql(filter)
	if len(filter) > 0 {
		strSql += " where " + strings.Join(fk, " and ")
	}
	log.Debug("[db/CountDb] [SQL: '%s', values: %v]", strSql, fv)
	err := do.QueryRow(strSql, fv...).Scan(&count)
	return count, err
}

func UpdateDb(do dbtool.DbOperator, tn string, id string, kv map[string]interface{}) error {
	if len(kv) == 0 {
		return nil
	}
	strSql := "update `" + tn + "`"
	var fk []string
	var fv []interface{}
	for k, v := range kv {
		tmpK := camelToUnix(k)
		switch tmpK {
		case "updated_at":
			fk = append(fk, "`updated_at`=now()")
		case "version":
			fk = append(fk, "`version`=`version`+1")
		default:
			switch v.(type) {
			case float64, int, string:
				fk = append(fk, "`"+tmpK+"`=?")
				fv = append(fv, v)
			default:
				return errors.New("Unsupport value type.")
			}
		}

	}
	strSql += " set " + strings.Join(fk, ",")
	strSql += " where `id`=?"
	fv = append(fv, id)

	log.Debug("[db/UpdateDb] [SQL: '%s', values: %v]", strSql, fv)
	_, err := do.Exec(strSql, fv...)
	return err
}

func camelToUnix(s string) string {
	var tmp string
	for i, c := range s {
		if c >= 65 && c <= 90 {
			if i != 0 {
				tmp += "_" + string(c+32)
			} else {
				tmp += string(c + 32)
			}
		} else {
			tmp += string(c)
		}
	}
	return tmp
}
