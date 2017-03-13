//
//  LTDataBaseCommDef.h
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-15.
//
//

#ifndef LetvIpadClient_LTDataBaseCommDef_h
#define LetvIpadClient_LTDataBaseCommDef_h

// 云播放记录每次上传条数
#define LT_SUBMITTOCLOUD_BATCHNUM    (60)

// 播放记录
#define LT_DB_CREATE_HISTORY (@"CREATE TABLE ltPlayHistory(\
\
ID integer primary key autoincrement unique,\
movie_id varchar(20), \
nameCn varchar(64),\
subTitle varchar(64),\
icon varchar(255),\
score varchar(4),\
cid varchar(4) default '86',\
type varchar(4),\
at integer default 1,\
releaseDate varchar(20), \
directory varchar(64),\
starring varchar(255),\
desc varchar(255),\
area varchar(255),\
subCategory varchar(64),\
playTv varchar(64),\
school varchar(64),\
pid varchar(20),\
vid varchar(20),\
vnameCn varchar(64),\
vmid varchar(20),\
vepisode integer default 0,\
vporder integer default 0,\
vicon varchar(255),\
vtype varchar(8),\
pay varchar(1),\
duration integer default 0,\
offset integer default 0,\
updateTime timestamp default (datetime('now', 'localtime'))\
\
);")

// 播放记录
#define LT_DB_CREATE_HISTORY_VID (@"CREATE TABLE ltPlayHistoryVid(\
\
ID integer primary key autoincrement unique,\
movie_id varchar(20), \
nameCn varchar(64),\
subTitle varchar(64),\
icon varchar(255),\
score varchar(4),\
cid varchar(4) default '86',\
type varchar(4),\
at integer default 1,\
releaseDate varchar(20), \
directory varchar(64),\
starring varchar(255),\
desc varchar(255),\
area varchar(255),\
subCategory varchar(64),\
playTv varchar(64),\
school varchar(64),\
pid varchar(20),\
vid varchar(20),\
vnameCn varchar(64),\
vmid varchar(20),\
vepisode integer default 0,\
vporder integer default 0,\
vicon varchar(255),\
vtype varchar(8),\
pay varchar(1),\
duration integer default 0,\
offset integer default 0,\
updateTime timestamp default (datetime('now', 'localtime')),\
deviceFrom varchar(8)\
\
);")

// V3.8下载
#define LT_DB_CREATE_DOWNLOADHISTORY38 @"CREATE TABLE LTDownloadHistory (\
ID integer primary key autoincrement unique,\
a_id varchar(255),\
v_id varchar(255),\
m_id varchar(255),\
c_id varchar(20),\
video_number varchar(20),\
video_index varchar(20),\
video_source varchar(4),\
video_type varchar(4),\
score varchar(20),\
is_end varchar(4),\
duration varchar(20),\
director varchar(255),\
actor varchar(255),\
area varchar(255),\
sub_category varchar(255),\
play_tv varchar(50),\
school varchar(50),\
control_area varchar(255),\
disable_type varchar(4),\
need_pay varchar(4),\
single_price varchar(4),\
allow_month varchar(4),\
stamp varchar(4),\
btime integer default 0,\
etime integer default 0,\
desc text,\
a_title text,\
v_title text,\
icon varchar(255),\
release_date varchar(4),\
video_code integer default 0,\
down_url varchar(255),\
add_time timestamp default (datetime('now', 'localtime')),\
file_size varchar(20),\
download_size varchar(20),\
download_status varchar(2),\
locale_file_path varchar(255),\
finish_time timestamp default (datetime('now', 'localtime')));"   //sourceType 1 竖图  2横图

//字幕音轨记忆
#define LT_DB_CREATE_SUBTITLEAUDIOTRACK @"CREATE TABLE LTSubtitleAudioTrack (\
ID integer primary key autoincrement unique,\
pid  varchar(255),\
subtitlekey varchar(255),\
audiokey varchar(255));"



/* 5.1.2
 * SQL_UPDATE512_ADD_DOWNLOADHISTORY_STOREPATH 增加storepath字段，唯一标识下载源
 * SQL_UPDATE512_ADD_DOWNLOADHISTORY_SUBICON  增加subIcon字段，标识指定vid下的下载ICon
 */
#define SQL_UPDATE512_ADD_DOWNLOADHISTORY_STOREPATH     @"ALTER TABLE LTDownloadHistory ADD COLUMN storepath varchar(255) default '';"
#define SQL_UPDATE512_ADD_DOWNLOADHISTORY_SUBICON     @"ALTER TABLE LTDownloadHistory ADD COLUMN subIcon varchar(255) default '';"

/*
 *5.2.2
 *下载改为多线程多任务，需要数据库中存储每片的下载大小，已下载大小以数据库存储为准
 */
#define SQL_UPDATE522_ADD_DOWNLOADHISTORY_SIZE0     @"ALTER TABLE LTDownloadHistory ADD COLUMN download_size0 varchar(20) default '';"
#define SQL_UPDATE522_ADD_DOWNLOADHISTORY_SIZE1     @"ALTER TABLE LTDownloadHistory ADD COLUMN download_size1 varchar(20) default '';"
#define SQL_UPDATE522_ADD_DOWNLOADHISTORY_SIZE2     @"ALTER TABLE LTDownloadHistory ADD COLUMN download_size2 varchar(20) default '';"

/* 数据库表 liveOrder | V5.3添加 */
#define SQL_LIVEORDER @"CREATE TABLE liveOrder(ID integer primary key autoincrement unique,orderName varchar(255),playTime varchar(255),channel_code varchar(20),orderDate timestamp default (datetime('now', 'localtime')),channel_name varchar(20));"
#endif

/**
 5.5修改ltPlayHistory
 */
#define SQL_UpdatePlayHistoryForAddColumn @"ALTER TABLE ltPlayHistory ADD COLUMN deviceFrom varchar(8) default '';"
/**
 5.6修改LTDownloadHistory  增加是否播放过该缓存视频 is_play 字段
 */
#define SQL_UPDATE56_ADD_DOWNLOADHISTORY_ISPALY     @"ALTER TABLE LTDownloadHistory ADD COLUMN is_play varchar(2) default '0';"
/**
 5.9修改ltPlayHistory 添加新的column nvid 代表下一集的vid信息
 */
#define SQL_UpdatePlayHistoryForAddNextnVidColumn @"ALTER TABLE ltPlayHistory ADD COLUMN nvid varchar(8) default '';"

#define SQL_UPDATE56_ADD_DOWNLOADHISTORY_DOWNLOAD     @"ALTER TABLE LTDownloadHistory ADD COLUMN need_download varchar(4) default '0';"

#define SQL_UPDATE56_ADD_DOWNLOADHISTORY_BRLIST     @"ALTER TABLE LTDownloadHistory ADD COLUMN brlist blob;"

#define SQL_UPDATE56_ADD_DOWNLOADHISTORY_VIDEO_SINGLE_TYPE     @"ALTER TABLE LTDownloadHistory ADD COLUMN video_single_type varchar(4) default '0';"
#define SQL_UPDATE56_ADD_DOWNLOADHISTORY_PIC_COLLECTIONS_TYPE  @"ALTER TABLE LTDownloadHistory ADD COLUMN pic_collections blob;"

/**
 5.6修改LTDownloadHistory  增加片源videoTypeKey 字段
 */
#define SQL_UPDATE56_ADD_DOWNLOADHISTORY_VIDEOTYPEKEY     @"ALTER TABLE LTDownloadHistory ADD COLUMN videotypekey varchar(255) default '';"


#ifdef LT_MERGE_FROM_IPAD_CLIENT
/**
 5.5修改LTDownloadHistory  增加片源videoTypeKey 字段
 */
#define SQL_UPDATE55_ADD_DOWNLOADHISTORY_VIDEOTYPEKEY     @"ALTER TABLE LTDownloadHistory ADD COLUMN videotypekey varchar(255) default '';"

/**
 5.5修改LTDownloadHistory  增加是否播放过该缓存视频 is_play 字段
 */
#define SQL_UPDATE55_ADD_DOWNLOADHISTORY_ISPALY     @"ALTER TABLE LTDownloadHistory ADD COLUMN is_play varchar(2) default '0';"

#define SQL_UPDATE55_ADD_DOWNLOADHISTORY_DOWNLOAD     @"ALTER TABLE LTDownloadHistory ADD COLUMN need_download varchar(4) default '0';"

#define SQL_UPDATE55_ADD_DOWNLOADHISTORY_BRLIST     @"ALTER TABLE LTDownloadHistory ADD COLUMN brlist blob;"

#define SQL_UPDATE55_ADD_DOWNLOADHISTORY_VIDEO_SINGLE_TYPE     @"ALTER TABLE LTDownloadHistory ADD COLUMN video_single_type varchar(4) default '0';"
#define SQL_UPDATE55_ADD_DOWNLOADHISTORY_PIC_COLLECTIONS_TYPE  @"ALTER TABLE LTDownloadHistory ADD COLUMN pic_collections blob;"



#endif
