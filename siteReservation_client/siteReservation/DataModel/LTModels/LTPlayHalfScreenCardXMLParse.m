//
//  LTPlayHalfScreenCardXMLParse.m
//  LetvIphoneClient
//
//  Created by liuxuan on 15/8/25.
//  Copyright (c) 2015年 liuxuan. All rights reserved.
//

#import "LTPlayHalfScreenCardXMLParse.h"
#import <LeTVMobileDataModel/LeTVMobileDataModel.h>

@interface LTPlayHalfScreenCardXMLParse ()

@property(strong,nonatomic)NSDictionary * xmlDict;
@property(strong,nonatomic)NSDictionary * cardTemplates;
@property(strong,nonatomic)NSDictionary * cardModels;

@end

@implementation LTPlayHalfScreenCardXMLParse

+(void)checkHalfScreenCardXMLUpdate
{
    NSString * xmlFile = [self getXmlFile];
    LTPlayHalfScreenCardXMLParse * parse = [[LTPlayHalfScreenCardXMLParse alloc]init];
    
    if (![NSString isBlankString:xmlFile]) {
        parse.xmlDict = [[[XMLDictionaryParser alloc]init]dictionaryWithFile:xmlFile];
    }
    NSString *localVersion = [parse getVersion];
    if ([NSString isBlankString:localVersion]) {
        return;
    }
    
    NSArray *arrayParamValues = [NSArray arrayWithObjects:localVersion,@"play",nil];
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_HalfScreen_PageCardXMLData
                               andDynamicValues:arrayParamValues
                                    isNeedCache:NO
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *bodyDict, NSString *markid) {
                                  NSLog(@"completionHandler");
                                  if ([NSObject empty:bodyDict]) {
                                      return ;
                                  }
                                  if (![bodyDict isKindOfClass:[NSDictionary class]]) {
                                      return;
                                  }
                                  NSDictionary *resultDic = [bodyDict objectForKey:@"result"];
                                  
                                  if ([NSObject empty:resultDic]) {
                                       return ;
                                  }
                                  if (![resultDic isKindOfClass:[NSDictionary class]]) {
                                      return;
                                  }
                                  NSString *serverVersion = [resultDic objectForKey:@"pcversion"];
                                  if ([serverVersion compare:localVersion] == NSOrderedDescending) {
                                      NSString *xmlData = [resultDic objectForKey:@"xmlData"];
                                      if (![NSString isBlankString:xmlData]) {
                                          NSString *xmlFilePath = [self getAppCacheXmlPath];
                                          NSString *fullPathSandBox = [xmlFilePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xml",PlayHalfScreenCardConfig]];
                                          BOOL bResult = [xmlData writeToFile:fullPathSandBox atomically:YES encoding:NSUTF8StringEncoding error:nil];
                                          if (bResult) {
                                              NSString *errlog = [NSString stringWithFormat:@"半屏XML:服务器版本写入成功,serverVersion%@,localversion%@", serverVersion, localVersion];
                                              [LTDataCenter writeToErrorLogFile:errlog];
                                          }else{
                                              NSString *errlog = [NSString stringWithFormat:@"半屏XML:服务器版本写入失败,serverVersion%@,localversion%@", serverVersion, localVersion];
                                              [LTDataCenter writeToErrorLogFile:errlog];
                                          }
                                          
                                      }
                                  }
                                  
                                  
                              }
                                nochangeHandler:^{
                                    NSLog(@"nochangeHandler");
                                    
                                }
                                   emptyHandler:^{
                                       NSLog(@"emptyHandler");
                                       
                                   }
                             tokenExpiredHander:nil
                                   errorHandler:^(NSError *error) {
                                       NSLog(@"errorHandler");
                                       
                                       
                                   }];
}

+(NSString*)getXmlFile
{
    NSFileManager * fileMannager = [NSFileManager defaultManager];
    NSString * xmlFilePath = nil;
    NSString *sandboxPath = nil;
    NSString *bundlePath = [self getBundleXmlPath];
    if ([fileMannager fileExistsAtPath:[self getAppCacheXmlPath]]) {
        xmlFilePath = [self getAppCacheXmlPath];
        NSString *fullPathSandBox = [xmlFilePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xml",PlayHalfScreenCardConfig]];
        sandboxPath = fullPathSandBox;
        xmlFilePath = sandboxPath;
    }
    
    BOOL isCopyToSandBox = NO;
    if ([NSString isBlankString:sandboxPath]) { //沙盒路径为空，需要从bundle把xml文件copy到沙盒
        isCopyToSandBox = YES;
    }else { //沙盒版本号低于bundle版本号，需要从bundle把xml文件copy到沙盒
        LTPlayHalfScreenCardXMLParse * parse = [[LTPlayHalfScreenCardXMLParse alloc]init];
        if (![NSString isBlankString:sandboxPath]) {
            parse.xmlDict = [[[XMLDictionaryParser alloc]init]dictionaryWithFile:sandboxPath];
        }
        NSString *sandBoxVersion = [[parse getVersion] copy];
        
        if (![NSString isBlankString:bundlePath]) {
            parse.xmlDict = [[[XMLDictionaryParser alloc]init]dictionaryWithFile:bundlePath];
        }
        NSString *bundleVersion = [[parse getVersion] copy];
        
        if ([NSString isBlankString:sandBoxVersion]) {
            isCopyToSandBox = YES;
        }
        
        if (![NSString isBlankString:sandBoxVersion] &&
            ![NSString isBlankString:bundleVersion] &&
            ([sandBoxVersion compare:bundleVersion] == NSOrderedAscending)) {
            isCopyToSandBox = YES;
        }
    }
    
    if (isCopyToSandBox) {
        if([fileMannager fileExistsAtPath:[self getBundleXmlPath]]){
            if ([FileManager createDirectory:[self getAppCacheXmlPath]]) {
                xmlFilePath = [self getAppCacheXmlPath];
                NSString *fullPathSandBox = [xmlFilePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xml",PlayHalfScreenCardConfig]];
                // 删除沙盒路径原先的文件
                [fileMannager removeItemAtPath:fullPathSandBox error:nil];
                NSError * error = nil;
                // 把bundle文件复制到沙盒
                BOOL flag = [fileMannager copyItemAtPath:[self getBundleXmlPath] toPath:fullPathSandBox error:&error];
                NSString *errlog = [NSString stringWithFormat:@"半屏XML:xml从bundle复制到sandbox 结果%ld", flag];
                [LTDataCenter writeToErrorLogFile:errlog];
                if (flag) {
                    xmlFilePath = fullPathSandBox;
                }
            }
        }
    }
    return xmlFilePath;
}

+(NSString*)getAppCacheXmlPath
{
    NSString *pageCardMXLPath = [[FileManager appDocumentPath] stringByAppendingPathComponent:PageCardXML];
    return pageCardMXLPath;
}

+(NSString*)getBundleXmlPath
{
    NSString *fullPathBundle = [[NSBundle mainBundle]pathForResource:PlayHalfScreenCardConfig ofType:@"xml"];
    return fullPathBundle;
}

#pragma mark -- 创建单例对象
+(instancetype)shareCardParse
{
    @synchronized(self){
        static LTPlayHalfScreenCardXMLParse * parse = nil;
        if (!parse) {
            parse = [[LTPlayHalfScreenCardXMLParse alloc]init];
            NSString * xmlFilePath = [self getXmlFile];
            if (![NSString isBlankString:xmlFilePath]) {
                parse.xmlDict = [[[XMLDictionaryParser alloc]init]dictionaryWithFile:xmlFilePath];
                [parse getVersion];
                parse.cardModels = [parse creatCardModels:[parse.xmlDict childNodes]];
                parse.cardTemplates = [parse creatTemplates:[parse.xmlDict childNodes]];
                
                NSData *data = [NSData dataWithContentsOfFile:xmlFilePath];
                NSString *errlog = [NSString stringWithFormat:@"半屏XML:xml解析 xmlFilePath%@, dataLength%ld", xmlFilePath, [data length]];
                [LTDataCenter writeToErrorLogFile:errlog];
            }
        }
        return parse;
    }
    return nil;
}


+(instancetype)allocWithZone:(NSZone *)zone;
{
    @synchronized(self){
        static LTPlayHalfScreenCardXMLParse * mannger=nil;
        
        if (mannger==nil) {
            mannger=[[super allocWithZone:zone]init];
        }
        return mannger;
    }
    
    return nil;
}


-(instancetype)copyWithZone:(NSZone *)zone{
    return self;
}

-(NSString*)getVersion
{
    return  _xmlVersion = [self.xmlDict attributes][@"version"];

}


-(NSDictionary*)creatCardModels:(NSDictionary*)rootDict
{
    if ([NSObject empty:rootDict]) {
        return nil;
    }
    NSArray * cards = [rootDict arrayValueForKeyPath:@"cards.card"];
    if ([NSObject empty:cards]) {
        return nil;
    }
    NSMutableDictionary * cardModels = [[NSMutableDictionary alloc]init];
    [cards enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary * card = (NSDictionary*)obj;
        if (![NSObject empty:card]) {
            LTXMLPlayCardModel * model = [[LTXMLPlayCardModel alloc]init];
            NSDictionary * attr = [card attributes];
            model.name = attr[@"name"];
            model.cardID = attr[@"cardID"];
            model.direction = attr[@"direction"];
            model.cardTypes = [self creatTypeArray:card];
            model.cardStyles = [self creatCardStyleArray:card];
            if (model && ![NSString isBlankString:model.cardID]) {
                [cardModels setObject:model forKey:model.cardID];
            }
        }
    }];
    return cardModels;
}

-(NSArray*)creatTypeArray:(NSDictionary*)dict
{
    if ([NSObject empty:dict]) {
        return nil;
    }
    NSArray * types = [dict arrayValueForKeyPath:@"types.type"];
    if ([NSObject empty:types]) {
        return nil;
    }
    NSMutableArray * typeModels = [[NSMutableArray alloc]init];
    [types enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary * dict = (NSDictionary*)obj;
        if (![NSObject empty:dict]) {
            LTXMLPlayCardTypeModel * type = [[LTXMLPlayCardTypeModel alloc]init];
            type.type = [dict attributes][@"type"];
            type.title_simp = dict[@"title_simp"];
            type.title_trad = dict[@"title_trad"];
            type.cell_style = dict[@"cell_style"];
            [typeModels addObject:type];
        }
    }];
    return typeModels;
}

- (NSArray *)creatCardStyleArray:(NSDictionary *)dict
{
    if ([NSObject empty:dict]) {
        return nil;
    }
    NSArray *styles = [dict arrayValueForKeyPath:@"styles.style"];
    if ([NSObject empty:styles]) {
        return nil;
    }
    NSMutableArray *styleModels = [[NSMutableArray alloc] init];
    [styles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![NSObject empty:obj]) {
             LTXMLPlayCardStyleModel *styleModel = [[LTXMLPlayCardStyleModel alloc] init];
            if ([obj isKindOfClass:[NSString class]]) {
                styleModel.styleID = obj;
            }else if ([obj isKindOfClass:[NSDictionary class]]) {
                styleModel.episodeStyle = [(NSDictionary *)obj attributes][@"episodestyle"];
                styleModel.styleID = ((NSDictionary *)obj)[XMLDictionaryTextKey];
            }
            [styleModels addObject:styleModel];
        }
    }];
    return styleModels;
}

-(NSDictionary*)creatTemplates:(NSDictionary*)dict
{
    if ([NSObject empty:dict]) {
        return nil;
    }
    NSArray * templates = [dict arrayValueForKeyPath:@"Templates.Template"];
    if ([NSObject empty:templates]) {
        return nil;
    }
    NSMutableDictionary * templateModels = [[NSMutableDictionary alloc]init];
    [templates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary * dict1 = (NSDictionary*)obj;
        if (![NSObject empty:dict1]) {
            __block LTXMLPlayCardTemplateModel * model = [[LTXMLPlayCardTemplateModel alloc]init];
            model.templateName = [dict1 attributes][@"templateName"];
            model.cid = [dict1 attributes][@"cid"];
            
            LTXMLPlaySubTemplateModel * modelA = [[LTXMLPlaySubTemplateModel alloc]init];
            NSString * list1 = dict1[@"TemplateA"][@"CardList"];
            modelA.cardList = [list1 componentsSeparatedByString:@"-"];
#ifdef LT_IPAD_CLIENT
            NSString * bottomList1 = dict1[@"TemplateA"][@"BottomCardList"];
            modelA.bottomCardList = [bottomList1 componentsSeparatedByString:@"-"];
            NSString * rightList1 = dict1[@"TemplateA"][@"RightCardList"];
            modelA.rightCardList = [rightList1 componentsSeparatedByString:@"-"];
            modelA.videoInfoRowCount = [(NSDictionary*)dict1[@"TemplateA"] attributes][@"videoInfoRowCount"];
            modelA.isShowComment = [(NSDictionary*)dict1[@"TemplateA"] attributes][@"isShowComment"];
            modelA.isShowDownload = [(NSDictionary*)dict1[@"TemplateA"] attributes][@"isShowDownload"];
            modelA.isShowFav = [(NSDictionary*)dict1[@"TemplateA"] attributes][@"isShowFav"];
            modelA.isShowShare = [(NSDictionary*)dict1[@"TemplateA"] attributes][@"isShowShare"];
            modelA.isShowLike = [(NSDictionary*)dict1[@"TemplateA"] attributes][@"isShowLike"];
            modelA.isShowUnlike = [(NSDictionary*)dict1[@"TemplateA"] attributes][@"isShowUnlike"];
            modelA.name = [(NSDictionary*)dict1[@"TemplateA"] attributes][@"name"];
            
            LTXMLPlaySubTemplateModel * modelB = [[LTXMLPlaySubTemplateModel alloc]init];
            NSString * list2 = dict1[@"TemplateB"][@"CardList"];
            modelB.cardList = [list2 componentsSeparatedByString:@"-"];
            NSString * bottomList2 = dict1[@"TemplateB"][@"BottomCardList"];
            modelB.bottomCardList = [bottomList2 componentsSeparatedByString:@"-"];
            NSString * rightList2 = dict1[@"TemplateB"][@"RightCardList"];
            modelB.rightCardList = [rightList2 componentsSeparatedByString:@"-"];
#else


            modelA.videoInfoRowCount = [(NSDictionary*)dict1[@"TemplateA"] attributes][@"videoInfoRowCount"];
            modelA.isShowComment = [(NSDictionary*)dict1[@"TemplateA"] attributes][@"isShowComment"];
            modelA.isShowDownload = [(NSDictionary*)dict1[@"TemplateA"] attributes][@"isShowDownload"];
            modelA.isShowFav = [(NSDictionary*)dict1[@"TemplateA"] attributes][@"isShowFav"];
            modelA.isShowShare = [(NSDictionary*)dict1[@"TemplateA"] attributes][@"isShowShare"];
            modelA.isShowLike = [(NSDictionary*)dict1[@"TemplateA"] attributes][@"isShowLike"];
            modelA.isShowUnlike = [(NSDictionary*)dict1[@"TemplateA"] attributes][@"isShowUnlike"];
            modelA.name = [(NSDictionary*)dict1[@"TemplateA"] attributes][@"name"];
            
            LTXMLPlaySubTemplateModel * modelB = [[LTXMLPlaySubTemplateModel alloc]init];
            NSString * list2 = dict1[@"TemplateB"][@"CardList"];
            modelB.cardList = [list2 componentsSeparatedByString:@"-"];
#endif
            modelB.videoInfoRowCount = [(NSDictionary*)dict1[@"TemplateB"] attributes][@"videoInfoRowCount"];
            modelB.isShowComment = [(NSDictionary*)dict1[@"TemplateB"] attributes][@"isShowComment"];
            modelB.isShowDownload = [(NSDictionary*)dict1[@"TemplateB"] attributes][@"isShowDownload"];
            modelB.isShowFav = [(NSDictionary*)dict1[@"TemplateB"] attributes][@"isShowFav"];
            modelB.isShowShare = [(NSDictionary*)dict1[@"TemplateB"] attributes][@"isShowShare"];
            modelB.isShowLike = [(NSDictionary*)dict1[@"TemplateB"] attributes][@"isShowLike"];
            modelB.isShowUnlike = [(NSDictionary*)dict1[@"TemplateB"] attributes][@"isShowUnlike"];
            modelB.name = [(NSDictionary*)dict1[@"TemplateB"] attributes][@"name"];

            model.templateB = modelB;
            model.templateA = modelA;
            NSArray * templates = [dict1 arrayValueForKeyPath:@"DefaultRowCount.CardID"];
            if (![NSObject empty:templates]) {
                NSMutableDictionary * defaultRowDict = [[NSMutableDictionary alloc]init];
                [templates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    NSDictionary * dict3 = (NSDictionary*)obj;
                    LTXMLPlayTemplateDefaultRowCountModel * rowModel = [[LTXMLPlayTemplateDefaultRowCountModel alloc]init];
                    rowModel.defaultRowCountA = [dict3 attributes][@"defaultRowCountA"];
                    rowModel.defaultRowCountB = [dict3 attributes][@"defaultRowCountB"];
                    rowModel.cardID = dict3[XMLDictionaryTextKey];
                    rowModel.cid = model.cid;
                    if (rowModel && ![NSString isBlankString:rowModel.cardID]) {
                        [defaultRowDict setObject:rowModel forKey:rowModel.cardID];
                    }
                }];
                model.defaultRowCounts = defaultRowDict;
            }
            
            NSArray *cardTypes = [dict1 arrayValueForKeyPath:@"CardType.type"];
            if (![NSObject empty:cardTypes]) {
                NSMutableDictionary *cardTypeDict = [[NSMutableDictionary alloc] init];
                [cardTypes enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    LTXMLPlayTemplateCardTypeModel *typeModel = [[LTXMLPlayTemplateCardTypeModel alloc] init];
                    typeModel.templateA = [obj attributes][@"templateA"];
                    typeModel.templateB = [obj attributes][@"templateB"];
                    typeModel.cardID = obj[XMLDictionaryTextKey];
                    typeModel.cid = model.cid;
                    if (typeModel && ![NSString isBlankString:typeModel.cardID]) {
                        [cardTypeDict setObject:typeModel forKey:typeModel.cardID];
                    }
                }];
                model.cardTypes = cardTypeDict;
            }
            
            if (model && ![NSString isBlankString:model.cid]) {
                [templateModels setObject:model forKey:model.cid];
            }
        }
    }];
    return templateModels;
}

#pragma mark -- 获取某个模板
-(LTXMLPlayCardTemplateModel*)getCardTemplateWithCid:(NSInteger)cid
{
    return [self.cardTemplates objectForKey:[NSString stringWithFormat:@"%ld",(long)cid]];
}

#pragma mark -- 获取某个card
-(LTXMLPlayCardModel*)getCardModelWithCardID:(NSInteger)cardID
{
    return [self.cardModels objectForKey:[NSString stringWithFormat:@"%ld",(long)cardID]];
}

@end

@implementation LTXMLPlayToolBarCardModel


@end

@implementation LTXMLPlayVideoInfoCardModel


@end

@implementation LTXMLPlayLikeBtnCardModel


@end

@implementation LTXMLPlayTemplateDefaultRowCountModel


@end

@implementation LTXMLPlayTemplateCardTypeModel


@end

@implementation LTXMLPlayCardModel

- (LTXMLPlayCardStyleModel *)getAvalibleCardStyleForStyleID:(NSString *)styleID
                                               episodeStyle:(NSInteger)episodeStyle
{
    if ([NSObject empty:self.cardStyles]) {
        return nil;
    }
    if ([NSString isBlankString:styleID]) {
        return nil;
    }
    
    if ([self.cardID integerValue] == 4) {  // 剧集card 需要判断剧集样式和样式id
        if (episodeStyle <= 0) {
            return nil;
        }
        for (int i=0; i<self.cardStyles.count; i++) {
            LTXMLPlayCardStyleModel *styleModel = OBJECT_OF_ATINDEX(self.cardStyles,i);
            if (([styleModel.episodeStyle integerValue] == episodeStyle) &&
                [styleModel.styleID isEqualToString:styleID]) {
                return styleModel;
            }
        }
        
    } else {
        for (int i=0; i<self.cardStyles.count; i++) {
            LTXMLPlayCardStyleModel *styleModel = OBJECT_OF_ATINDEX(self.cardStyles,i);
            if ([styleModel.styleID isEqualToString:styleID]) {
                return styleModel;
            }
        }
    }
    return nil;
}
@end

@implementation LTXMLPlayCardTemplateModel


-(LTXMLPlayTemplateDefaultRowCountModel*)getDefaultRowCountWithCardID:(NSInteger)cardID
{
    return [self.defaultRowCounts objectForKey:[NSString stringWithFormat:@"%ld",(long)cardID]];
}

- (LTXMLPlayTemplateCardTypeModel *)getXMLPlayTemplateCardTypeModelWithCardID:(NSInteger)cardID
{
    return [self.cardTypes objectForKey:[NSString stringWithFormat:@"%ld",(long)cardID]];
}

@end

@implementation LTXMLPlayCardTypeModel

-(NSString*)getTitleForLocalLanguage
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    
    NSString * currentLanuage = OBJECT_OF_ATINDEX(allLanguages, 0);
    
    if ([currentLanuage hasPrefix:@"zh-Hans"]) {
        return self.title_simp;
    }else if([currentLanuage hasPrefix:@"zh-Hant"] || [currentLanuage hasPrefix:@"zh-HK"]){
        return self.title_trad;
    }
    return self.title_simp;
}

@end

@implementation LTXMLPlayCardStyleModel


@end

@implementation LTXMLPlaySubTemplateModel


@end
