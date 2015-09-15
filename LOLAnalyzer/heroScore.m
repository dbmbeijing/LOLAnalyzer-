//
//  heroScore.m
//  LOLAnalyzer
//
//  Created by soppysonny on 15/8/14.
//  Copyright (c) 2015年 soppysonny. All rights reserved.
//file:///Users/soppysonny/Desktop/LOLAnalyzer/LOLAnalyzer/Images.xcassets/: warning: Ambiguous Content: LaunchImage.launchimage/launchImg4.png is 320x480 but should be 768x1024.



#import "heroScore.h"

@implementation heroScore
-(instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }return self;
}

+(NSNumber *)scoreForTop:(HeroModel *)model{
    NSDictionary* dict = model.heroProp;
    heroScore* score = [[self alloc]initWithDict:dict];
    NSNumber* scoreNum = score.damage;
    return scoreNum;
}

+(NSNumber *)scoreForJun:(HeroModel *)model{
    NSDictionary* dict = model.heroProp;
    heroScore* score = [[self alloc]initWithDict:dict];
    NSNumber* scoreNum = score.damage;
    return scoreNum;
}

+(NSNumber *)scoreForMid:(HeroModel *)model{
    NSDictionary* dict = model.heroProp;
    heroScore* score = [[self alloc]initWithDict:dict];
    NSNumber* scoreNum = score.damage;
    return scoreNum;
}

+(NSNumber *)scoreForAd:(HeroModel *)model{
    NSDictionary* dict = model.heroProp;
    heroScore* score = [[self alloc]initWithDict:dict];
    NSNumber* scoreNum = score.damage;
    return scoreNum;
}

+(NSNumber *)scoreForSup:(HeroModel *)model{
    NSDictionary* dict = model.heroProp;
    heroScore* score = [[self alloc]initWithDict:dict];
    NSNumber* scoreNum = score.damage;
    return scoreNum;
}

@end
