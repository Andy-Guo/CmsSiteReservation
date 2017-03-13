//
//  LTChannelTypeModel.m
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-7-4.
//
//

#import "LTChannelTypeModel.h"
//#import "NSObject+ObjectEmpty.h"

@implementation SubCateModel @end

@implementation CateModel @end

@implementation AreaModel @end

@implementation OrderPropertyModel @end

@implementation OrderModel @end

@implementation VideoTypeModel @end

@implementation YearTypeModel @end

@implementation LTChannelTypeModel


- (NSArray *)getCateArray:(NSString *)cid
{
//    return [[[self.dataDictionary valueForKey:@"cate"] valueForKey:_cId] valueForKey:@"sub"];

    NSDictionary *dict =  (NSDictionary *)self.cate;
    NSDictionary  *dic=dict[cid];
    CateModel *model=[[CateModel alloc]initWithDictionary:dic error:nil];
    return model.sub;
}

- (NSArray *)getYearArray:(NSString *)cid
{
    NSDictionary *dict =  (NSDictionary *)self.year;
      return (NSArray *)dict[cid];
    
}

- (NSArray *)getAreaArray:(NSString *)cid
{

    NSDictionary *dict =  (NSDictionary *)self.area;
    return (NSArray *)dict[cid];
    
}

- (NSArray *)getVideoTypeArray:(NSString *)cid
{
    NSDictionary *dict =  (NSDictionary *)self.videotype;
    NSDictionary  *dic=dict[cid];
    VideoTypeModel *model =[[VideoTypeModel alloc]initWithDictionary:dic error:nil];
    return  model.type;
    
}


- (NSArray *)resetSortArray:(NSString *)cid
{

    NSDictionary *dict =  (NSDictionary *)self.order;
    NSDictionary  *dic=dict[cid];
    if ([cid isEqualToString:kCidEntertainment])
    {
//        _sortArray = [[[self.dataDictionary valueForKey:@"order"] valueForKey:_cId] valueForKey:@"ptvvideo"];
       
        OrderModel *model= [[OrderModel alloc]initWithDictionary:dic error:nil];
        return model.ptvvideo;

    }
    else if([cid isEqualToString:kCidMusic]|| [cid isEqualToString:kCidFinacial] || [cid isEqualToString:kCidCar] || [cid isEqualToString:kCidTour])
    {
        OrderModel *model= [[OrderModel alloc]initWithDictionary:dic error:nil];
        return model.vrsvideo;
    }
    else
    {
        OrderModel *model= [[OrderModel alloc]initWithDictionary:dic error:nil];
        return model.album;
    }

}

- (NSString*)getSortNameByIdx:(NSInteger)index Cid:(NSString *)cid
{
    NSArray *_sortArray =[self resetSortArray:cid];
    if (![_sortArray count]||[_sortArray count]<index) {
        return @"";
    }
    
    NSDictionary *dict=_sortArray[index];
    if (![NSObject empty:dict]) {
        return [NSString safeString:[dict valueForKey:@"shortname"]];
    }else{
        return @"";
    }
   
}


- (NSString*)getSortIdByIdx:(NSInteger)index Cid:(NSString *)cid
{
    NSArray *_sortArray =[self resetSortArray:cid];
    if (![_sortArray count]||[_sortArray count]<index) {
        return @"";
    }
    NSDictionary *dict=_sortArray[index];
    if (![NSObject empty:dict]) {
        return [NSString safeString:[dict valueForKey:@"id"]];
    }else{
        return @"";
    }
    
    //    return [NSString safeString:[[_sortArray objectAtIndex:index] valueForKey:@"id"]];
}

-(NSInteger)getSortCount:(NSString *)cid
{
    return [self resetSortArray:cid].count;
}
@end
