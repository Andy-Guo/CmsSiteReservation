//
//  LTPlayCountModel.h
//  LetvIpadClient
//
//  Created by bob on 14-9-16.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>

@protocol LTPlayCountElem @end

@interface LTPlayCountElem : JSONModel

@property (nonatomic, strong) NSString<Optional> *id;
@property (nonatomic, strong) NSString<Optional> *play_count;
@property (nonatomic, strong) NSString<Optional> *plist_score;
@property (nonatomic, strong) NSString<Optional> *plist_count;

@end


@interface LTPlayCountModel : JSONModel

@property (nonatomic, strong) NSArray<LTPlayCountElem, Optional> *result;

@end
