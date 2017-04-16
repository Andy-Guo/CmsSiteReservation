package service

var (
	UserInfo *UserInfoService
)

func Setup() {
	UserInfo = &UserInfoService{}
}
