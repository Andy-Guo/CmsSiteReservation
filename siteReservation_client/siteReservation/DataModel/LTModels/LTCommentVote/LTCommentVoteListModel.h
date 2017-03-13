//
//  LTCommentVoteListModel.h
//  LeTVMobileDataModel
//
//  Created by 彦芳 张 on 15/11/3.
//  Copyright © 2015年 Kerberos Zhang. All rights reserved.
//

#import <LetvMobileOpenSource/LetvMobileOpenSource.h>

@protocol LTCommentVoteOptionModel <NSObject>
@end

@interface LTCommentVoteOptionModel: JSONModel
@property (nonatomic,strong)NSString *option_id;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *subtitle;
@property (nonatomic,strong)NSString *remarks;
@property (nonatomic,strong)NSString  *img;
@property (nonatomic,strong)NSString  *num;
@property (nonatomic,strong)NSString  *is_vote;
@property (nonatomic,strong)NSString  *url;
@end



@interface LTCommentVoteListModel : JSONModel
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *subtitle;
@property (nonatomic,strong)NSString *second;
@property (nonatomic,strong)NSString *lifestart;
@property (nonatomic,strong)NSString *lifeend;
@property (nonatomic,strong)NSString *vote_id;
@property (nonatomic,strong)NSString *rule;
@property (nonatomic,strong)NSString *vid;
@property (nonatomic,strong)NSString *pid;
@property (nonatomic,strong)NSMutableArray <LTCommentVoteOptionModel> *options;
@property (nonatomic,strong)LTCommentVoteOptionModel  *share;
@property (nonatomic,strong)LTCommentVoteOptionModel  *effect;
@end


