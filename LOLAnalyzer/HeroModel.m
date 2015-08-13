//
//  HeroModel.m
//  LOLAnalyzer
//
//  Created by soppysonny on 15/8/2.
//  Copyright (c) 2015年 soppysonny. All rights reserved.
//

#import "HeroModel.h"

@implementation HeroModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }return self;
}

+(instancetype)heroModelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}
@end
