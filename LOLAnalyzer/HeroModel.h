//
//  HeroModel.h
//  LOLAnalyzer
//
//  Created by soppysonny on 15/8/2.
//  Copyright (c) 2015年 soppysonny. All rights reserved.
///Users/soppysonny/Desktop/LOLAnalyzer/LOLAnalyzer/Images.xcassets: The launch image set named "LaunchImage" did not have any applicable content.

#import <Foundation/Foundation.h>

@interface HeroModel : NSObject
@property (copy, nonatomic)NSString *name;
@property (copy, nonatomic)NSString *icon;


@property (copy, nonatomic)NSNumber *topIndex;
@property (copy, nonatomic)NSNumber *jungleIndex;
@property (copy, nonatomic)NSNumber *midIndex;
@property (copy, nonatomic)NSNumber *adIndex;
@property (copy, nonatomic)NSNumber *supIndex;

@property (strong, nonatomic)NSArray *countedBy;
@property (strong, nonatomic)NSArray *partner;

@property (strong, nonatomic)NSArray* rates;

@property (strong, nonatomic)NSDictionary* heroProp;
@property (strong, nonatomic)NSNumber *heroTag;//仅供conclusionview用

+(instancetype)heroModelWithDict:(NSDictionary*)dict;
-(instancetype)initWithDict:(NSDictionary*)dict;
@end
