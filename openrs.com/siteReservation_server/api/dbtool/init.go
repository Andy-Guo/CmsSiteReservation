package dbtool

import (
	"database/sql"
)

type DbOperator interface {
	Prepare(query string) (*sql.Stmt, error)
	Exec(query string, args ...interface{}) (sql.Result, error)
	Query(query string, args ...interface{}) (*sql.Rows, error)
	QueryRow(query string, args ...interface{}) *sql.Row
}

type DbScanner interface {
	Scan(dest ...interface{}) error
}

var (
	DB *sql.DB
)

func Setup(db *sql.DB) {
	DB = db
}
