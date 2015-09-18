//
//  HeroModel.h
//  LOLAnalyzer
//
//  Created by soppysonny on 15/8/2.
//  Copyright (c) 2015年 soppysonny. All rights reserved.
///Users/soppysonny/Desktop/LOLAnalyzer/LOLAnalyzer/Images.xcassets: The launch image set named "LaunchImage" did not have any applicable content.

#import <Foundation/Foundation.h>
//英雄模型,全部英雄列表参照plist文件
@interface HeroModel : NSObject

@property (copy, nonatomic)NSString *name;
@property (copy, nonatomic)NSString *icon;

//各个位置的优先顺位, 数值越大优先级越高
@property (copy, nonatomic)NSNumber *topIndex;
@property (copy, nonatomic)NSNumber *jungleIndex;
@property (copy, nonatomic)NSNumber *midIndex;
@property (copy, nonatomic)NSNumber *adIndex;
@property (copy, nonatomic)NSNumber *supIndex;
//英雄的被克制/克制英雄
@property (strong, nonatomic)NSArray *countedBy;
@property (strong, nonatomic)NSArray *partner;
//各个段位胜率的数组
@property (strong, nonatomic)NSArray* rates;
//英雄属性
@property (strong, nonatomic)NSDictionary* heroProp;
//英雄编号
@property (strong, nonatomic)NSNumber *heroTag;//仅供conclusionview用
//字典转模型
+(instancetype)heroModelWithDict:(NSDictionary*)dict;
-(instancetype)initWithDict:(NSDictionary*)dict;
@end
