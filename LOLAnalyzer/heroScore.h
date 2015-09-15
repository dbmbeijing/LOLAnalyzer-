//
//  heroScore.h
//  LOLAnalyzer
//
//  Created by soppysonny on 15/8/14.
//  Copyright (c) 2015年 soppysonny. All rights reserved.
///Users/soppysonny/Desktop/LOLAnalyzer/LOLAnalyzer/Images.xcassets: The launch image set named "LaunchImage" did not have any applicable content.file:///Users/soppysonny/Desktop/LOLAnalyzer/LOLAnalyzer/Images.xcassets/: warning: Ambiguous Content: LaunchImage.launchimage/launch-Nidalee_4.0.png is 640x1136 but should be 640x960.


#import <Foundation/Foundation.h>
#import "HeroModel.h"
@interface heroScore : NSObject

@property (strong, nonatomic) NSNumber* damage;
@property (strong, nonatomic) NSNumber* control;
@property (strong, nonatomic) NSNumber* AOE;
@property (strong, nonatomic) NSNumber* movement;
@property (strong, nonatomic) NSNumber* makemoved;
@property (getter = isCloseFighter, nonatomic) BOOL closeFighter;
@property (getter = isRelife, nonatomic) BOOL reLife;
@property (getter = isMakeRelife, nonatomic) BOOL makeRelife;
@property (strong, nonatomic) NSNumber* shield;
@property (strong, nonatomic) NSNumber* makeShielded;
//@property (getter = isMakeFly, nonatomic) BOOL MakeFly;
@property (getter = isGlobal, nonatomic) BOOL global;
@property (strong, nonatomic) NSNumber* resistance;
@property (strong, nonatomic) NSNumber* teamResistance;
@property (strong, nonatomic) NSNumber* hitPick;
@property (getter = isGlobal, nonatomic) BOOL TeamAccelerate;
@property (getter = isDodge, nonatomic) BOOL dodge;
@property (getter = isMakeDodge, nonatomic) BOOL makeDodge;
@property (getter = isInvisible, nonatomic) BOOL invisible;
@property (getter = isInterrupt, nonatomic) BOOL interrupt;
@property (strong, nonatomic)NSArray* rates;

-(instancetype)initWithDict:(NSDictionary*)dict;

+(NSNumber *)scoreForTop:(HeroModel *)model;
+(NSNumber *)scoreForJun:(HeroModel *)model;
+(NSNumber *)scoreForMid:(HeroModel *)model;
+(NSNumber *)scoreForAd:(HeroModel *)model;
+(NSNumber *)scoreForSup:(HeroModel *)model;

@end
