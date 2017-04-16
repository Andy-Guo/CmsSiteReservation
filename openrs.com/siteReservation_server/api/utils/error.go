package utils

const (
	ErrNull = ""
)

const (
	ErrSystem    = "system"
	ErrFilter    = "filter"
	ErrDesc      = "desc"
	ErrOrder     = "order"
	ErrUserInfo  = "user"
	ErrCountRank = "count_rank"
	ErrRoleId    = "role_id"
	ErrEmail     = "email"
	ErrPhone     = "phone_num"
)

const (
	ErrError       = "error"
	ErrMantaining  = "mantaining"
	ErrInvalid     = "invalid"
	ErrMiss        = "miss"
	ErrMalformed   = "malformed"
	ErrNotFound    = "notfound"
	ErrInuse       = "inuse"
	ErrConflict    = "conflict"
	ErrUnsupported = "unsupported"
	ErrForbidden   = "forbidden"
	ErrLimit       = "limit"
	ErrExceeded    = "exceeded"
	ErrDuplicate   = "duplicate"
	ErrNorse       = "norse"
)

const (
	ErrField = "field"
	ErrType  = "type"
	ErrName  = "name"
	ErrPath  = "path"
	ErrPort  = "port"
)

type CcErrObj struct {
	R string
	T string
	P string
	D string
}

type CcError interface {
	Error() string
	Detail() string
}

func (e *CcErrObj) Error() string {
	s := e.R + "." + e.T
	if e.P != ErrNull {
		s += "." + e.P
	}
	return s
}

func (e *CcErrObj) Detail() string {
	return e.D
}

func NE(r, t, p, d string) CcError {
	return &CcErrObj{r, t, p, d}
}

func NewSysErr(err error) CcError {
	return &CcErrObj{ErrSystem, ErrError, ErrNull, err.Error()}
}
