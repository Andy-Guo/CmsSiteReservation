//
//  MovieInfo.m
//  Letv
//
//  Created by iBokanWisdom on 10-6-19.
//  Copyright 2010 iBokanWisdom. All rights reserved.
//

#import "MovieInfo.h"

#ifndef LT_MERGE_FROM_IPAD_CLIENT

@implementation MovieInfo


- (NSString *)getSubTitleInfo
{
    return @"";    
}

- (NSString *)getOtherTitleInfo
{
    return @"";
}


@synthesize ID = _ID,
			movie_ID = _movie_ID,
			p_ID = _p_ID,
			mmsID = _mmsID,
            cid = _cid,
			title = _title,
			file_size = _file_size,
			icon = _icon,
			time_length = _time_length,
            curr_time = _curr_time,
			play_times = _play_times,
			sourceType = _sourceType,
			intro = _intro,
			lp_url = _lp_url,
			hp_url = _hp_url,
			download_url = _download_url,
			download_size = _download_size,
			tags = _tags,
			release_year = _release_year,
			director = _director,
			actor = _actor,
			score = _score,
			movie_cate = _movie_cate,
			movie_area = _movie_area,
			data_type = _data_type,		
			tag_num = _tag_num,
            local_path = _local_path,
            updating = _updating,
            v_ID = _v_ID,
            br = _br,
            databaseVersion = _databaseVersion,
            videoType = _videoType,
            btime = _btime,
            etime = _etime,
            atTag = _atTag,
            albumType=_albumType,
            payfrom=_payfrom,
            allowmonth=_allowmonth,
            paydate = _paydate,
            singleprice = _singleprice,
            aidTitle = _aidTitle,
            pay = _pay,
            c_ID = _c_ID,
            vType = _vType,
            offset = _offset,
            bUpdating = _bUpdating,
            needpay = _needpay,
            viptag = _viptag,
            mainTitle = _mainTitle,
            deviceFromType=_deviceFromType,
            lastRecordTime=_lastRecordTime;



@end


#else

@implementation MovieInfo
@synthesize ID = _ID,
			movie_ID = _movie_ID,
            p_ID = _p_ID,
			v_ID = _v_ID,
			mmsID = _mmsID,
			title = _title,
            mainTitle = _mainTitle,
			icon = _icon,
			time_length = _time_length,
			play_times = _play_times,
			sourceType = _sourceType,
			intro = _intro,
			lp_url = _lp_url,
			hp_url = _hp_url,
			tags = _tags,
			release_year = _release_year,
			director = _director,
			actor = _actor,
			score = _score,
			movie_cate = _movie_cate,
			movie_area = _movie_area,
			data_type = _data_type,
            cid = _cid,
			vType = _vType,
			offset = _offset,
            bUpdating = _bUpdating,
			download_url = _download_url,
            btime = _btime,
            etime = _etime,
            needpay = _needpay,
            viptag = _viptag,
            aid = _aid,
            deviceFromType=_deviceFromType,
            lastRecordTime=_lastRecordTime;


@end

#endif




