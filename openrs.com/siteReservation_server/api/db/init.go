package db

var (
	UserDao           *UserInfoDao
	TimedurDao        *TimeDurDao
	RoomtimeStatusDao *RoomTimeStatusDao
	RoomsDao          *RoomDao
	PricesDao         *PriceDao
	RolesDao          *RoleDao
	WorkOrderflowDao  *WorkOrderFlowDao
	AppointmentsDao   *AppointmentDao
)

func Setup() {
	UserDao = &UserInfoDao{}
	TimedurDao = &TimeDurDao{}
	RoomtimeStatusDao = &RoomTimeStatusDao{}
	RoomsDao = &RoomDao{}
	PricesDao = &PriceDao{}
	RolesDao = &RoleDao{}
	WorkOrderflowDao = &WorkOrderFlowDao{}
	AppointmentsDao = &AppointmentDao{}
}
