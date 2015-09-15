//
//  detailView.h
//  LOLAnalyzer
//
//  Created by soppysonny on 15/8/15.
//  Copyright (c) 2015年 soppysonny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeroModel.h"
@class detailView;
@protocol detailViewDelegate <NSObject>

-(CGRect)getFrame;
-(HeroModel *)getLeftTop;
-(HeroModel *)getLeftJun;
-(HeroModel *)getLeftMid;
-(HeroModel *)getLeftAd;
-(HeroModel *)getLeftSup;
-(HeroModel *)getRightTop;
-(HeroModel *)getRightJun;
-(HeroModel *)getRightMid;
-(HeroModel *)getRightAd;
-(HeroModel *)getRightSup;


@end
@interface detailView : UIView

@property (weak, nonatomic)id<detailViewDelegate>delegate;

@property (strong, nonatomic)UIButton* laningDetailBut;
@property (strong, nonatomic)UIButton* teamFightDetailBut;
@property (strong, nonatomic)UIButton* soloPushDetailBut;

@property (strong, nonatomic)UIView* leftTopScore;
@property (strong, nonatomic)UIView* leftJunScore;
@property (strong, nonatomic)UIView* leftMidScore;
@property (strong, nonatomic)UIView* leftAdScore;
@property (strong, nonatomic)UIView* leftSupScore;

@property (strong, nonatomic)UIView* rightTopScore;
@property (strong, nonatomic)UIView* rightJunScore;
@property (strong, nonatomic)UIView* rightMidScore;
@property (strong, nonatomic)UIView* rightAdScore;
@property (strong, nonatomic)UIView* rightSupScore;

@property (strong, nonatomic)UIImageView* leftTopM;
@property (strong, nonatomic)UIImageView* leftJunM;
@property (strong, nonatomic)UIImageView* leftMidM;
@property (strong, nonatomic)UIImageView* leftAdM;
@property (strong, nonatomic)UIImageView* leftSupM;

@property (strong, nonatomic)UIImageView* rightTopM;
@property (strong, nonatomic)UIImageView* rightJunM;
@property (strong, nonatomic)UIImageView* rightMidM;
@property (strong, nonatomic)UIImageView* rightAdM;
@property (strong, nonatomic)UIImageView* rightSupM;



@end
