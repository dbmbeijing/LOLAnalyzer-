//
//  ConlusionView.m
//  LOLAnalyzer
//
//  Created by soppysonny on 15/8/8.
//  Copyright (c) 2015年 soppysonny. All rights reserved.





#import "ConlusionView.h"
#define btnSize [UIScreen mainScreen].bounds.size.height*0.09
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define txtpicGap 160

@implementation ConlusionView

#pragma mark 代理方法

-(void)bannerView:(ADBannerView *)banner
didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"%s",__func__);

}

-(CGRect)getFrame{
    CGRect rect = CGRectMake(0, 0, screenWidth, screenHeight);
    return rect;
}
#pragma mark 初始化
-(instancetype)initWithFrame:(CGRect)frame{
    self.adView.delegate = self;
    self.WeiboWeb.delegate = self;
  UIBlurEffect*effect =   [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self = [super initWithEffect:effect];
    self.frame = frame;
    
    [self addSubview:self.l1];
    [self addSubview:self.l2];
    [self addSubview:self.l3];
    [self addSubview:self.l4];
    [self addSubview:self.l5];
    [self addSubview:self.l6];
    [self addSubview:self.l7];
    [self addSubview:self.l8];
    [self addSubview:self.l9];
    [self addSubview:self.l10];
    [self addSubview:self.leftTop];
    [self addSubview:self.leftJun];
    [self addSubview:self.leftMid];
    [self addSubview:self.leftAd];
    [self addSubview:self.leftSup];
    
    [self addSubview:self.rightTop];
    [self addSubview:self.rightJun];
    [self addSubview:self.rightMid];
    [self addSubview:self.rightAd];
    [self addSubview:self.rightSup];
    
    [self addSubview:self.memberA1];
    [self addSubview:self.memberA2];
    [self addSubview:self.memberA3];
    [self addSubview:self.memberA4];
    [self addSubview:self.memberA5];
    
    [self addSubview:self.memberB1];
    [self addSubview:self.memberB2];
    [self addSubview:self.memberB3];
    [self addSubview:self.memberB4];
    [self addSubview:self.memberB5];

    [self addSubview:self.clearButton];
    
    [self addSubview:self.calcButton];
    [self addSubview:self.tipLable];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UILabel animateWithDuration:0.4 animations:^{
            
            self.tipLable.transform = CGAffineTransformMakeTranslation(screenWidth, 0);
        }completion:^(BOOL finished){
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               
                [UILabel animateWithDuration:0.7 animations:^{
                    self.tipLable.transform = CGAffineTransformMakeTranslation(0, 0);
                }completion:nil];
            });
        }];

    });
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}
#pragma mark 计算方法
//计算并添加View
-(int)comparewithRight:(HeroModel*)modelLeft :(HeroModel*)modelRight{
    NSArray* leftCountedArr = modelLeft.countedBy;
    NSArray* rightCountedArr = modelRight.countedBy;
    NSNumber* leftTag = modelLeft.heroTag;
    NSNumber* rightTag = modelRight.heroTag;
    int point = 0;
    for (NSNumber *num in leftCountedArr) {
         @autoreleasepool {
        if (num==rightTag) {
            point-=50;
        }}
    }
    for (NSNumber* num in rightCountedArr) { @autoreleasepool {
        if (num==leftTag) {
            point+=50;
        }}

    }
    return point;
}

-(void)calcTopTeamColumn  {
    CGFloat numA = [[self singleModelTeamPoint:self.allMember[0]] floatValue];
    CGFloat numB = [[self singleModelTeamPoint:self.allMember[5]] floatValue];
    
    CGFloat proportion = numA/(numA+numB);
     CGFloat leftScore = 100* proportion;
    CGFloat rightScore = 100 - leftScore;
    CGFloat xLeft = (self.widthLeft -15)*proportion;
    CGFloat xRight = self.widthLeft -15 -xLeft;
    if(!_leftTopScore){
    self.a1score.frame =  CGRectMake(0.06*screenHeight+5, screenHeight*0.7, xLeft, screenHeight*0.05);
   self.b1score.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.7, xRight, screenHeight*0.05);
    self.a1score.text =[NSString stringWithFormat:@"%.2f",leftScore];
    self.b1score.text =[NSString stringWithFormat:@"%.2f",rightScore];
        
    self.leftTopScore.frame = CGRectMake(0.06*screenHeight+5, screenHeight*0.7, xLeft, screenHeight*0.05);
    self.rightTopScore.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.7, xRight, screenHeight*0.05);
    [self addSubview:self.leftTopScore];
    [self addSubview:self.rightTopScore];
        [self insertSubview:self.a1score aboveSubview:self.leftTopScore];
        [self insertSubview:self.b1score aboveSubview:self.rightTopScore];
    }else{
        self.a1score.text =[NSString stringWithFormat:@"%.2f",leftScore];
        self.b1score.text = [NSString stringWithFormat:@"%.2f",rightScore];
        self.a1score.frame =  CGRectMake(0.06*screenHeight+5, screenHeight*0.7, xLeft, screenHeight*0.05);
        self.b1score.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.7, xRight, screenHeight*0.05);
        [UIView animateWithDuration:0.3 animations:^{
       
            
                self.leftTopScore.frame = CGRectMake(0.06*screenHeight+5, screenHeight*0.7, xLeft, screenHeight*0.05);
                self.rightTopScore.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.7, xRight, screenHeight*0.05);
               
            }];
        }
}
-(void)calcJunTeamColumn{

    CGFloat numA = [[self singleModelTeamPoint:self.allMember[1]] floatValue];
    CGFloat numB = [[self singleModelTeamPoint:self.allMember[6]] floatValue];
    CGFloat proportion = numA/(numA+numB);
    CGFloat leftScore = 100* proportion;
    CGFloat rightScore = 100 - leftScore;
    CGFloat xLeft = (self.widthLeft -15)*proportion;
    CGFloat xRight = self.widthLeft -15 -xLeft;
    if (!_leftJunScore) {
    self.a2score.frame =  CGRectMake(0.06*screenHeight+5, screenHeight*0.7625, xLeft, screenHeight*0.05);
    self.b2score.frame =CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.7625, xRight, screenHeight*0.05);
    self.a2score.text =[NSString stringWithFormat:@"%.2f",leftScore];
    self.b2score.text =[NSString stringWithFormat:@"%.2f",rightScore];
    self.leftJunScore.frame = CGRectMake(0.06*screenHeight+5, screenHeight*0.7625, xLeft, screenHeight*0.05);
    self.rightJunScore.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.7625, xRight, screenHeight*0.05);
    [self addSubview:self.leftJunScore];
    [self addSubview:self.rightJunScore];
    [self insertSubview:self.a2score aboveSubview:self.leftJunScore];
    [self insertSubview:self.b2score aboveSubview:self.rightJunScore];
                }else {
    self.a2score.frame =  CGRectMake(0.06*screenHeight+5, screenHeight*0.7625, xLeft, screenHeight*0.05);
    self.b2score.frame =CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.7625, xRight, screenHeight*0.05);
    self.a2score.text =[NSString stringWithFormat:@"%.2f",leftScore];
    self.b2score.text =[NSString stringWithFormat:@"%.2f",rightScore];
        
    [UIView animateWithDuration:0.3 animations:^{
    self.leftJunScore.frame = CGRectMake(0.06*screenHeight+5, screenHeight*0.7625, xLeft, screenHeight*0.05);
    self.rightJunScore.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.7625, xRight, screenHeight*0.05); }];
        }
}

-(void)calcMidTeamColumn{
    CGFloat numA = [[self singleModelTeamPoint:self.allMember[2]] floatValue];
    CGFloat numB = [[self singleModelTeamPoint:self.allMember[7]] floatValue];
    CGFloat proportion = numA/(numA+numB);
    CGFloat leftScore = 100* proportion;
    CGFloat rightScore = 100 - leftScore;
    
    CGFloat xLeft = (self.widthLeft -15)*proportion;
    CGFloat xRight = self.widthLeft -15 -xLeft;
    if (!_leftMidScore) {
        self.a3score.frame =  CGRectMake(0.06*screenHeight+5, screenHeight*0.825, xLeft, screenHeight*0.05);
        self.b3score.frame =CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.825, xRight, screenHeight*0.05);
        self.a3score.text =[NSString stringWithFormat:@"%.2f",leftScore];
        self.b3score.text =[NSString stringWithFormat:@"%.2f",rightScore];
    self.leftMidScore.frame = CGRectMake(0.06*screenHeight+5, screenHeight*0.825, xLeft, screenHeight*0.05);
    self.rightMidScore.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.825, xRight, screenHeight*0.05);
    [self addSubview:self.leftMidScore];
    [self addSubview:self.rightMidScore];
    [self insertSubview:self.a3score aboveSubview:self.leftMidScore];
    [self insertSubview:self.b3score aboveSubview:self.rightMidScore];
    
    }else{
    self.a3score.frame =  CGRectMake(0.06*screenHeight+5, screenHeight*0.825, xLeft, screenHeight*0.05);
    self.b3score.frame =  CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.825, xRight, screenHeight*0.05);
    self.a3score.text =[NSString stringWithFormat:@"%.2f",leftScore];
    self.b3score.text =[NSString stringWithFormat:@"%.2f",rightScore];
    [UIView animateWithDuration:0.3 animations:^{
    self.leftMidScore.frame = CGRectMake(0.06*screenHeight+5, screenHeight*0.825, xLeft, screenHeight*0.05);
    self.rightMidScore.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.825, xRight, screenHeight*0.05);
    }];
    }
}

-(void)calcAdTeamColumn{
    CGFloat numA = [[self singleModelTeamPoint:self.allMember[3]] floatValue];
    CGFloat numB = [[self singleModelTeamPoint:self.allMember[8]] floatValue];
    
    CGFloat proportion = numA/(numA+numB);
    CGFloat leftScore = 100* proportion;
    CGFloat rightScore = 100 - leftScore;

    CGFloat xLeft = (self.widthLeft -15)*proportion;
    CGFloat xRight = self.widthLeft -15 -xLeft;
    if(!_leftAdScore){
    self.a4score.frame =  CGRectMake(0.06*screenHeight+5, screenHeight*0.8875, xLeft, screenHeight*0.05);
    self.b4score.frame =CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.8875, xRight, screenHeight*0.05);
    self.a4score.text =[NSString stringWithFormat:@"%.2f",leftScore];
    self.b4score.text =[NSString stringWithFormat:@"%.2f",rightScore];
        
    self.leftAdScore.frame = CGRectMake(0.06*screenHeight+5, screenHeight*0.8875, xLeft, screenHeight*0.05);
    self.rightAdScore.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.8875, xRight, screenHeight*0.05);
    
    [self addSubview:self.leftAdScore];
    [self addSubview:self.rightAdScore];
    [self insertSubview:self.a4score aboveSubview:self.leftAdScore];
    [self insertSubview:self.b4score aboveSubview:self.rightAdScore];

    }else {
        self.a4score.text =[NSString stringWithFormat:@"%.2f",leftScore];
        self.b4score.text =[NSString stringWithFormat:@"%.2f",rightScore];
        self.a4score.frame =  CGRectMake(0.06*screenHeight+5, screenHeight*0.8875, xLeft, screenHeight*0.05);
        self.b4score.frame =CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.8875, xRight, screenHeight*0.05);
   
        [UIView animateWithDuration:0.3 animations:^{
        self.leftAdScore.frame = CGRectMake(0.06*screenHeight+5, screenHeight*0.8875, xLeft, screenHeight*0.05);
        self.rightAdScore.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.8875, xRight, screenHeight*0.05);
        }];
    }
    }
-(void)calcSupTeamColumn{
    CGFloat numA = [[self singleModelTeamPoint:self.allMember[4]] floatValue];
    CGFloat numB = [[self singleModelTeamPoint:self.allMember[9]] floatValue];
    CGFloat proportion = numA/(numA+numB);
    CGFloat leftScore = 100* proportion;
    CGFloat rightScore = 100 - leftScore;
    CGFloat xLeft = (self.widthLeft -15)*proportion;
    CGFloat xRight = self.widthLeft -15 -xLeft;
    
    if(!_leftSupScore){
        self.a5score.frame =  CGRectMake(0.06*screenHeight+5, screenHeight*0.95, xLeft, screenHeight*0.05);
        self.b5score.frame =CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.95, xRight, screenHeight*0.05);
        self.a5score.text =[NSString stringWithFormat:@"%.2f",leftScore];
        self.b5score.text =[NSString stringWithFormat:@"%.2f",rightScore];
        
    self.leftSupScore.frame = CGRectMake(0.06*screenHeight+5, screenHeight*0.95, xLeft, screenHeight*0.05);
    self.rightSupScore.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.95, xRight, screenHeight*0.05);
    
    [self addSubview:self.leftSupScore];
    [self addSubview:self.rightSupScore];
    [self insertSubview:self.a5score aboveSubview:self.leftSupScore];
    [self insertSubview:self.b5score aboveSubview:self.rightSupScore];
    }else {
        [UIView animateWithDuration:0.3 animations:^{
            self.a5score.frame =  CGRectMake(0.06*screenHeight+5, screenHeight*0.95, xLeft, screenHeight*0.05);
            self.b5score.frame =CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.95, xRight, screenHeight*0.05);
            self.a5score.text =[NSString stringWithFormat:@"%.2f",leftScore];
            self.b5score.text =[NSString stringWithFormat:@"%.2f",rightScore];
            
            self.leftSupScore.frame = CGRectMake(0.06*screenHeight+5, screenHeight*0.95, xLeft, screenHeight*0.05);
            self.rightSupScore.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.95, xRight, screenHeight*0.05);
        }];
    }

}
-(void)calcTopLaneColumn{
    CGFloat numA = [[self singleModelLanePoint:self.allMember[0]] floatValue];
    CGFloat numB = [[self singleModelLanePoint:self.allMember[5]] floatValue];
    
    CGFloat proportion = numA/(numA+numB);
    CGFloat leftScore = 100* proportion;
    CGFloat rightScore = 100 - leftScore;
    CGFloat xLeft = (self.widthLeft -15)*proportion;
    CGFloat xRight = self.widthLeft -15 -xLeft;

    
    self.a1score.text = [NSString stringWithFormat:@"%.2f",leftScore];
    self.b1score.text =[NSString stringWithFormat:@"%.2f",rightScore];
    self.a1score.frame =  CGRectMake(0.06*screenHeight+5, screenHeight*0.7, xLeft, screenHeight*0.05);
    self.b1score.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.7, xRight, screenHeight*0.05);

    [UIView animateWithDuration:0.3 animations:^{

        self.leftTopScore.frame = CGRectMake(0.06*screenHeight+5, screenHeight*0.7, xLeft, screenHeight*0.05);
        self.rightTopScore.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.7, xRight, screenHeight*0.05);
        [self layoutIfNeeded];
    }];
 
//    [self addSubview:self.leftTopScore];
//    [self addSubview:self.rightTopScore];
}
-(void)calcJunLaneColumn{
    CGFloat numA = [[self singleModelLanePoint:self.allMember[1]] floatValue];
    CGFloat numB = [[self singleModelLanePoint:self.allMember[6]] floatValue];
    CGFloat proportion = numA/(numA+numB);
    CGFloat leftScore = 100* proportion;
    CGFloat rightScore = 100 - leftScore;
    CGFloat xLeft = (self.widthLeft -15)*proportion;
    CGFloat xRight = self.widthLeft -15 -xLeft;
    self.a2score.frame =  CGRectMake(0.06*screenHeight+5, screenHeight*0.7625, xLeft, screenHeight*0.05);
    self.b2score.frame =CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.7625, xRight, screenHeight*0.05);
    self.a2score.text =[NSString stringWithFormat:@"%.2f",leftScore];
    self.b2score.text =[NSString stringWithFormat:@"%.2f",rightScore];
      [UIView animateWithDuration:0.3 animations:^{
 
    self.leftJunScore.frame = CGRectMake(0.06*screenHeight+5, screenHeight*0.7625, xLeft, screenHeight*0.05);
    self.rightJunScore.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.7625, xRight, screenHeight*0.05);
      }];

}

-(void)calcMidLaneColumn{
    CGFloat numA = [[self singleModelLanePoint:self.allMember[2]] floatValue];
    CGFloat numB = [[self singleModelLanePoint:self.allMember[7]] floatValue];
    CGFloat proportion = numA/(numA+numB);
    CGFloat leftScore = 100* proportion;
    CGFloat rightScore = 100 - leftScore;
    
    CGFloat xLeft = (self.widthLeft -15)*proportion;
    CGFloat xRight = self.widthLeft -15 -xLeft;
    self.a3score.frame =  CGRectMake(0.06*screenHeight+5, screenHeight*0.825, xLeft, screenHeight*0.05);
    self.b3score.frame =  CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.825, xRight, screenHeight*0.05);
    self.a3score.text =[NSString stringWithFormat:@"%.2f",leftScore];
    self.b3score.text =[NSString stringWithFormat:@"%.2f",rightScore];
    [UIView animateWithDuration:0.3 animations:^{
        self.leftMidScore.frame = CGRectMake(0.06*screenHeight+5, screenHeight*0.825, xLeft, screenHeight*0.05);
        self.rightMidScore.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.825, xRight, screenHeight*0.05);
        [self layoutIfNeeded];
    }];
}

-(void)calcAdLaneColumn{
    CGFloat numA = [[self singleModelLanePoint:self.allMember[3]] floatValue];
    CGFloat numB = [[self singleModelLanePoint:self.allMember[8]] floatValue];
    CGFloat proportion = numA/(numA+numB);
    CGFloat leftScore = 100* proportion;
    CGFloat rightScore = 100 - leftScore;
    
    CGFloat xLeft = (self.widthLeft -15)*proportion;
    CGFloat xRight = self.widthLeft -15 -xLeft;
    self.a4score.text =[NSString stringWithFormat:@"%.2f",leftScore];
    self.b4score.text =[NSString stringWithFormat:@"%.2f",rightScore];
    self.a4score.frame =  CGRectMake(0.06*screenHeight+5, screenHeight*0.8875, xLeft, screenHeight*0.05);
    self.b4score.frame =CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.8875, xRight, screenHeight*0.05);

    [UIView animateWithDuration:0.3 animations:^{
        self.leftAdScore.frame = CGRectMake(0.06*screenHeight+5, screenHeight*0.8875, xLeft, screenHeight*0.05);
        self.rightAdScore.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.8875, xRight, screenHeight*0.05);
        [self layoutIfNeeded];
    }];
}

-(void)calcSupLaneColumn{
    CGFloat numA = [[self singleModelLanePoint:self.allMember[4]] floatValue];
    CGFloat numB = [[self singleModelLanePoint:self.allMember[9]] floatValue];
    CGFloat proportion = numA/(numA+numB);
    CGFloat leftScore = 100* proportion;
    CGFloat rightScore = 100 - leftScore;
    
    CGFloat xLeft = (self.widthLeft -15)*proportion;
    CGFloat xRight = self.widthLeft -15 -xLeft;
    self.a5score.text =[NSString stringWithFormat:@"%.2f",leftScore];
    self.b5score.text =[NSString stringWithFormat:@"%.2f",rightScore];
    self.a5score.frame =  CGRectMake(0.06*screenHeight+5, screenHeight*0.95, xLeft, screenHeight*0.05);
    self.b5score.frame =CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.95, xRight, screenHeight*0.05);
   
    [UIView animateWithDuration:0.3 animations:^{
        self.leftSupScore.frame = CGRectMake(0.06*screenHeight+5, screenHeight*0.95, xLeft, screenHeight*0.05);
        self.rightSupScore.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.95, xRight, screenHeight*0.05);
        [self layoutIfNeeded];
    }];
}

-(void)calcTopSoloColumn{
    CGFloat numA = [[self singleModelPushPoint:self.allMember[0]] floatValue];
    CGFloat numB = [[self singleModelPushPoint:self.allMember[5]] floatValue];
    
    CGFloat proportion = numA/(numA+numB);
    CGFloat leftScore = 100* proportion;
    CGFloat rightScore = 100 - leftScore;
    CGFloat xLeft = (self.widthLeft -15)*proportion;
    CGFloat xRight = self.widthLeft -15 -xLeft;
    self.a1score.text =[NSString stringWithFormat:@"%.2f",leftScore];
    self.b1score.text = [NSString stringWithFormat:@"%.2f",rightScore];
    self.a1score.frame =  CGRectMake(0.06*screenHeight+5, screenHeight*0.7, xLeft, screenHeight*0.05);
    self.b1score.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.7, xRight, screenHeight*0.05);
    [UIView animateWithDuration:0.3 animations:^{

        
        self.leftTopScore.frame = CGRectMake(0.06*screenHeight+5, screenHeight*0.7, xLeft, screenHeight*0.05);
        self.rightTopScore.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.7, xRight, screenHeight*0.05);
    }];
}
-(void)calcJunSoloColumn{
    CGFloat numA = [[self singleModelPushPoint:self.allMember[1]] floatValue];
    CGFloat numB = [[self singleModelPushPoint:self.allMember[6]] floatValue];
    CGFloat proportion = numA/(numA+numB);
    CGFloat leftScore = 100* proportion;
    CGFloat rightScore = 100 - leftScore;
    
    CGFloat xLeft = (self.widthLeft -15)*proportion;
    CGFloat xRight = self.widthLeft -15 -xLeft;
    self.a2score.frame =  CGRectMake(0.06*screenHeight+5, screenHeight*0.7625, xLeft, screenHeight*0.05);
    self.b2score.frame =CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.7625, xRight, screenHeight*0.05);
    self.a2score.text =[NSString stringWithFormat:@"%.2f",leftScore];
    self.b2score.text =[NSString stringWithFormat:@"%.2f",rightScore];
    [UIView animateWithDuration:0.3 animations:^{

        self.leftJunScore.frame = CGRectMake(0.06*screenHeight+5, screenHeight*0.7625, xLeft, screenHeight*0.05);
        self.rightJunScore.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.7625, xRight, screenHeight*0.05);
        [self layoutIfNeeded];
    }];
   
}
-(void)calcMidSoloColumn{
    CGFloat numA = [[self singleModelPushPoint:self.allMember[2]] floatValue];
    CGFloat numB = [[self singleModelPushPoint:self.allMember[7]] floatValue];
    CGFloat proportion = numA/(numA+numB);
    CGFloat leftScore = 100* proportion;
    CGFloat rightScore = 100 - leftScore;
    CGFloat xLeft = (self.widthLeft -15)*proportion;
    CGFloat xRight = self.widthLeft -15 -xLeft;
    
    self.a3score.frame =  CGRectMake(0.06*screenHeight+5, screenHeight*0.825, xLeft, screenHeight*0.05);
    self.b3score.frame =  CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.825, xRight, screenHeight*0.05);
    self.a3score.text =[NSString stringWithFormat:@"%.2f",leftScore];
    self.b3score.text =[NSString stringWithFormat:@"%.2f",rightScore];
    [UIView animateWithDuration:0.3 animations:^{
        self.leftMidScore.frame = CGRectMake(0.06*screenHeight+5, screenHeight*0.825, xLeft, screenHeight*0.05);
        self.rightMidScore.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.825, xRight, screenHeight*0.05);
        [self layoutIfNeeded];
    }];
}
-(void)calcAdSoloColumn{
    CGFloat numA = [[self singleModelPushPoint:self.allMember[3]] floatValue];
    CGFloat numB = [[self singleModelPushPoint:self.allMember[8]] floatValue];
    CGFloat proportion = numA/(numA+numB);
    
    CGFloat xLeft = (self.widthLeft -15)*proportion;
    CGFloat xRight = self.widthLeft -15 -xLeft;
    [UIView animateWithDuration:0.3 animations:^{
        self.leftAdScore.frame = CGRectMake(0.06*screenHeight+5, screenHeight*0.8875, xLeft, screenHeight*0.05);
        self.rightAdScore.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.8875, xRight, screenHeight*0.05);
        [self layoutIfNeeded];
    }];
}
-(void)calcSupSoloColumn{
    CGFloat numA = [[self singleModelPushPoint:self.allMember[4]] floatValue];
    CGFloat numB = [[self singleModelPushPoint:self.allMember[9]] floatValue];
    CGFloat proportion = numA/(numA+numB);
    CGFloat leftScore = 100* proportion;
    CGFloat rightScore = 100 - leftScore;
    CGFloat xLeft = (self.widthLeft -15)*proportion;
    CGFloat xRight = self.widthLeft -15 -xLeft;
    self.a5score.frame =  CGRectMake(0.06*screenHeight+5, screenHeight*0.95, xLeft, screenHeight*0.05);
    self.b5score.frame =CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.95, xRight, screenHeight*0.05);
    self.a5score.text =[NSString stringWithFormat:@"%.2f",leftScore];
    self.b5score.text =[NSString stringWithFormat:@"%.2f",rightScore];
    [UIView animateWithDuration:0.3 animations:^{
        self.leftSupScore.frame = CGRectMake(0.06*screenHeight+5, screenHeight*0.95, xLeft, screenHeight*0.05);
        self.rightSupScore.frame = CGRectMake(0.06*screenHeight+xLeft+10, screenHeight*0.95, xRight, screenHeight*0.05);
        [self layoutIfNeeded];
    }];
}

-(CGFloat)leftIsBlue{
    if (!_leftIsBlue) {
        _leftIsBlue = 0;
    }return _leftIsBlue;
}
-(void)colorSetWithFloat:(CGFloat)final{
    
    if (final>0.5&&final<0.7) {

        self.lableRateLeft.backgroundColor = [UIColor whiteColor];
        self.lableRateRight.backgroundColor = [UIColor grayColor];
        self.lableRateLeftX.backgroundColor = [UIColor whiteColor];
        self.lableRateRightX.backgroundColor = [UIColor grayColor];
        self.lableRateLeftX.textColor =[UIColor blackColor];
        self.lableRateRightX.textColor =[UIColor blackColor];
        self.lableRateRight.textColor = [UIColor blackColor];
        self.lableRateLeft.textColor = [UIColor blackColor];
        
    }else if(final>=0.7){
        self.lableRateLeft.backgroundColor = [UIColor redColor];
        self.lableRateRight.backgroundColor = [UIColor blackColor];
        self.lableRateLeftX.backgroundColor = [UIColor redColor];
        self.lableRateRightX.backgroundColor = [UIColor blackColor];
        self.lableRateLeftX.textColor =[UIColor blackColor];
        self.lableRateLeft.textColor = [UIColor blackColor];
        self.lableRateRightX.textColor =[UIColor redColor];
        self.lableRateRight.textColor = [UIColor redColor];

    }else if(final<0.5&&final>0.3){
        self.lableRateLeft.backgroundColor = [UIColor grayColor];
        self.lableRateRight.backgroundColor = [UIColor whiteColor];
        self.lableRateLeftX.backgroundColor = [UIColor grayColor];
        self.lableRateRightX.backgroundColor = [UIColor whiteColor];
        self.lableRateLeftX.textColor =[UIColor blackColor];
        self.lableRateRightX.textColor =[UIColor blackColor];
        self.lableRateRight.textColor = [UIColor blackColor];
        self.lableRateLeft.textColor = [UIColor blackColor];
        
    }else if(final<=0.3){
        self.lableRateLeft.backgroundColor = [UIColor blackColor];
        self.lableRateRight.backgroundColor = [UIColor redColor];
        self.lableRateLeftX.backgroundColor = [UIColor blackColor];
        self.lableRateRightX.backgroundColor = [UIColor redColor];
        self.lableRateRight.textColor = [UIColor blackColor];
        self.lableRateRightX.textColor = [UIColor blackColor];
        self.lableRateLeft.textColor = [UIColor redColor];
        self.lableRateLeftX.textColor = [UIColor redColor];
    }else if( final == 0.5){
        self.lableRateLeft.backgroundColor = [UIColor whiteColor];
        self.lableRateRight.backgroundColor = [UIColor whiteColor];
        self.lableRateLeftX.backgroundColor = [UIColor whiteColor];
        self.lableRateRightX.backgroundColor = [UIColor whiteColor];
        self.lableRateLeftX.textColor =[UIColor blackColor];
        self.lableRateRightX.textColor =[UIColor blackColor];
        self.lableRateRight.textColor = [UIColor blackColor];
        self.lableRateLeft.textColor = [UIColor blackColor];
    }
}

-(void)calc{
    CGFloat temp = self.leftRateALL + self.teamFightProportion.floatValue + self.soloPushProportion.floatValue + self.laningProportion.floatValue+self.leftIsBlue;
    CGFloat final = floor(temp*10000)/10000;
    
        self.lableRateLeft.text = [NSString stringWithFormat:@"%.2f",final*100];
        self.lableRateRight.text = [NSString stringWithFormat:@"%.2f",(1-final)*100];
    [self colorSetWithFloat:final];


}
-(void)calcBrz{

    
    CGFloat temp = self.BrzRateALL + self.teamFightProportion.floatValue + self.soloPushProportion.floatValue + self.laningProportion.floatValue+self.leftIsBlue;
    CGFloat finalBrz =floor(temp*10000)/10000;
    self.lableRateLeft.text = [NSString stringWithFormat:@"%.2f",finalBrz*100];
        self.lableRateRight.text = [NSString stringWithFormat:@"%.2f",(1-finalBrz)*100];
    [self colorSetWithFloat:finalBrz];
    
}
-(void)calcSlv{
    CGFloat temp = self.SlvRateALL + self.teamFightProportion.floatValue + self.soloPushProportion.floatValue + self.laningProportion.floatValue+self.leftIsBlue;
    CGFloat finalSlv = floor(temp*10000)/10000;
    self.lableRateLeft.text = [NSString stringWithFormat:@"%.2f",finalSlv*100];
    self.lableRateRight.text = [NSString stringWithFormat:@"%.2f",(1-finalSlv)*100];
    [self colorSetWithFloat:finalSlv];

}
-(void)calcGld{
    CGFloat temp = self.GldRateALL + self.teamFightProportion.floatValue + self.soloPushProportion.floatValue + self.laningProportion.floatValue+self.leftIsBlue;
    CGFloat finalGld = floor(temp*10000)/10000;
    self.lableRateLeft.text = [NSString stringWithFormat:@"%.2f",finalGld*100];
    self.lableRateRight.text = [NSString stringWithFormat:@"%.2f",(1-finalGld)*100];
    [self colorSetWithFloat:finalGld];

}
-(void)calcPlt{
    CGFloat temp = self.PltRateALL + self.teamFightProportion.floatValue + self.soloPushProportion.floatValue + self.laningProportion.floatValue+self.leftIsBlue;
    CGFloat finalPlt = floor(temp*10000)/10000;
    self.lableRateLeft.text = [NSString stringWithFormat:@"%.2f",finalPlt*100];
    self.lableRateRight.text = [NSString stringWithFormat:@"%.2f",(1-finalPlt)*100];
    [self colorSetWithFloat:finalPlt];
}
-(void)calcDmd{
    CGFloat temp = self.DmdRateALL + self.teamFightProportion.floatValue + self.soloPushProportion.floatValue + self.laningProportion.floatValue+self.leftIsBlue;
    CGFloat finalDmd = floor(temp*10000)/10000;
    self.lableRateLeft.text = [NSString stringWithFormat:@"%.2f",finalDmd*100];
    self.lableRateRight.text = [NSString stringWithFormat:@"%.2f",(1-finalDmd)*100];
    [self colorSetWithFloat:finalDmd];

}
-(void)calcKng{
    CGFloat temp = self.KngRateALL + self.teamFightProportion.floatValue + self.soloPushProportion.floatValue + self.laningProportion.floatValue+self.leftIsBlue;
    CGFloat finalKng = floor(temp*10000)/10000;
    self.lableRateLeft.text = [NSString stringWithFormat:@"%.2f",finalKng*100];
    self.lableRateRight.text = [NSString stringWithFormat:@"%.2f",(1-finalKng)*100];
    [self colorSetWithFloat:finalKng];
}

//胜率
-(CGFloat)leftRateALL{
    if (!_leftRateALL) {
     _leftRateALL =  ([self getAveRate:self.allMember[0]]+[self getAveRate:self.allMember[1]]+[self getAveRate:self.allMember[2]]+[self getAveRate:self.allMember[3]]+[self getAveRate:self.allMember[4]])/([self getAveRate:self.allMember[0]]+[self getAveRate:self.allMember[1]]+[self getAveRate:self.allMember[2]]+[self getAveRate:self.allMember[3]]+[self getAveRate:self.allMember[4]]+[self getAveRate:self.allMember[5]]+[self getAveRate:self.allMember[6]]+[self getAveRate:self.allMember[7]]+[self getAveRate:self.allMember[8]]+[self getAveRate:self.allMember[9]]) ;
    }return _leftRateALL;
}

-(CGFloat)BrzRateALL{
    if (!_BrzRateALL) {
      _BrzRateALL = ([self getBrzRate:self.allMember[0]]+[self getBrzRate:self.allMember[1]]+[self getBrzRate:self.allMember[2]]+[self getBrzRate:self.allMember[3]]+[self getBrzRate:self.allMember[4]])/([self getBrzRate:self.allMember[0]]+[self getBrzRate:self.allMember[1]]+[self getBrzRate:self.allMember[2]]+[self getBrzRate:self.allMember[3]]+[self getBrzRate:self.allMember[4]]+[self getBrzRate:self.allMember[5]]+[self getBrzRate:self.allMember[6]]+[self getBrzRate:self.allMember[7]]+[self getBrzRate:self.allMember[8]]+[self getBrzRate:self.allMember[9]]);
    }return _BrzRateALL;
}
-(CGFloat)SlvRateALL{
    if (!_SlvRateALL) {
        _SlvRateALL = ([self getSlvRate:self.allMember[0]]+[self getSlvRate:self.allMember[1]]+[self getSlvRate:self.allMember[2]]+[self getSlvRate:self.allMember[3]]+[self getSlvRate:self.allMember[4]])/([self getSlvRate:self.allMember[0]]+[self getSlvRate:self.allMember[1]]+[self getSlvRate:self.allMember[2]]+[self getSlvRate:self.allMember[3]]+[self getSlvRate:self.allMember[4]]+[self getSlvRate:self.allMember[5]]+[self getSlvRate:self.allMember[6]]+[self getSlvRate:self.allMember[7]]+[self getSlvRate:self.allMember[8]]+[self getSlvRate:self.allMember[9]]);
    }return _SlvRateALL;
}
-(CGFloat)GldRateALL{
    if (!_GldRateALL) {
        _GldRateALL = ([self getGldRate:self.allMember[0]]+[self getGldRate:self.allMember[1]]+[self getGldRate:self.allMember[2]]+[self getGldRate:self.allMember[3]]+[self getGldRate:self.allMember[4]])/([self getGldRate:self.allMember[0]]+[self getGldRate:self.allMember[1]]+[self getGldRate:self.allMember[2]]+[self getGldRate:self.allMember[3]]+[self getGldRate:self.allMember[4]]+[self getGldRate:self.allMember[5]]+[self getGldRate:self.allMember[6]]+[self getGldRate:self.allMember[7]]+[self getGldRate:self.allMember[8]]+[self getGldRate:self.allMember[9]]);
    }return _GldRateALL;
}
-(CGFloat)PltRateALL{
    if (!_PltRateALL) {
        _PltRateALL = ([self getPltRate:self.allMember[0]]+[self getPltRate:self.allMember[1]]+[self getPltRate:self.allMember[2]]+[self getPltRate:self.allMember[3]]+[self getPltRate:self.allMember[4]])/([self getPltRate:self.allMember[0]]+[self getPltRate:self.allMember[1]]+[self getPltRate:self.allMember[2]]+[self getPltRate:self.allMember[3]]+[self getPltRate:self.allMember[4]]+[self getPltRate:self.allMember[5]]+[self getPltRate:self.allMember[6]]+[self getPltRate:self.allMember[7]]+[self getPltRate:self.allMember[8]]+[self getPltRate:self.allMember[9]]);
    }return _PltRateALL;
}
-(CGFloat)DmdRateALL{
    if (!_DmdRateALL) {
        _DmdRateALL = ([self getDmdRate:self.allMember[0]]+[self getDmdRate:self.allMember[1]]+[self getDmdRate:self.allMember[2]]+[self getDmdRate:self.allMember[3]]+[self getDmdRate:self.allMember[4]])/([self getDmdRate:self.allMember[0]]+[self getDmdRate:self.allMember[1]]+[self getDmdRate:self.allMember[2]]+[self getDmdRate:self.allMember[3]]+[self getDmdRate:self.allMember[4]]+[self getDmdRate:self.allMember[5]]+[self getDmdRate:self.allMember[6]]+[self getDmdRate:self.allMember[7]]+[self getDmdRate:self.allMember[8]]+[self getDmdRate:self.allMember[9]]);
    }return _DmdRateALL;
}
-(CGFloat)KngRateALL{
    if (!_KngRateALL) {
        _KngRateALL = ([self getKngRate:self.allMember[0]]+[self getKngRate:self.allMember[1]]+[self getKngRate:self.allMember[2]]+[self getKngRate:self.allMember[3]]+[self getKngRate:self.allMember[4]])/([self getKngRate:self.allMember[0]]+[self getKngRate:self.allMember[1]]+[self getKngRate:self.allMember[2]]+[self getKngRate:self.allMember[3]]+[self getKngRate:self.allMember[4]]+[self getKngRate:self.allMember[5]]+[self getKngRate:self.allMember[6]]+[self getKngRate:self.allMember[7]]+[self getKngRate:self.allMember[8]]+[self getKngRate:self.allMember[9]]);
    }return _KngRateALL;
}


//需要添加团队配合
- (NSNumber *)singleModelTeamPoint:(HeroModel*)model{
    CGFloat point = 0;
    point += [self getDamagefromModel:model]*0.04;
    point += [self getControlFromModel:model]*10.0;
    point += [self getAOEfromModel:model]*0.2;
    if ([self isMovement:model]) {
       point += 150;
    }
    point += [self getMakeMovement:model]*10.0;
    if ([self isreLifeAble:model]) {
            point += 15;
    }

    if ([self isMakeReLifeAble:model]) {
            point+= 30;
    }
    point+= [self getShieldFromModel:model]*0.1;
       point += [self getMksldFromModel:model]*0.2;
    if ([self isGlobal:model]) {
        point+= 70;
    }
    point +=[self getResistance:model]*7;
    point +=[self getTeamResistance:model]*15;
    point +=[self getHitPick:model]*8;
    if ([self isTeamAcc:model]) {
        point+=70;
    }
    if ([self isDodge:model]) {
        point+=86;
    }
    if ([self isMakeDodge:model]) {
        point+=100;
    }
    if ([self isInvisible:model]) {
        point+=10;
    }
    return [NSNumber numberWithFloat:point];
}
//需添加对线对手克制分数
- (NSNumber *)singleModelLanePoint:(HeroModel*)model{
    CGFloat point = 0;
    //除3
 point+= [self getDamagefromModel:model];
    //要乘2
point+= [self getControlFromModel:model]*20;
    //要除10
point+= [self getAOEfromModel:model];
    //要×30

    if([self isMovement:model]){
point+= 130;
    }
    //makemoved 1~5 *20
point += [self getMakeMovement:model]*20;
    //自己复活(蛮,赛)+20

    if ([self isreLifeAble:model]) {
        
point+= 70;
    }
    //队友复活or无敌+20

    if([self isMakeReLifeAble:model]){
point+= 50;
    }
    //shield 按单次护盾的0.2算
point+= [self getShieldFromModel:model];
    //makeshield(cure算0.05) 按0.2算
point+= [self getMksldFromModel:model]*0.5;
    //resistance (or reduce damage)1~3 *12
point+= [self getResistance:model]*12;
    //teamresis 1~3 5
point+=[self getResistance:model]*5;
    //hitPicj 1~3 8
point+= [self getHitPick:model]*8;
    //teamacc 15

    if ([self isTeamAcc:model]) {
point+= 15;
    }
    //dodge 25

    if ([self isDodge:model]) {
point+= 195;
    }
    //makedodge 10

    if ([self isMakeDodge:model]) {
point+= 50;
    }
    //invis -10

    if ([self isInvisible:model]) {
point+= -10;
    }

    if ([self isInterrupt:model]) {
point+= 120;
    }
    
        return [NSNumber numberWithFloat:point];

}
- (NSNumber *)singleModelPushPoint:(HeroModel*)model{
    CGFloat point = 0;
    //*1
point+= [self getDamagefromModel:model];
    //除3
point+= [self getControlFromModel:model]*5;
    //要*2
point+= [self getAOEfromModel:model]*0.1;
    //要×80
    if([self isMovement:model]){
point+= 280;
    }
    //makemoved 1~5 *20
point+= [self getMakeMovement:model]*20;
//远程全球流:卡牌

    if([self isGlobal:model]&&(![self isCloseFighter:model])){
point+= 80;
    }
    //近战全球流:90

    if ([self isGlobal:model]&&[self isCloseFighter:model]) {
point+= 100;
    }
    //自己复活(蛮,赛)+80
    if ([self isreLifeAble:model]) {
point+= 80;
    }
    //队友复活or无敌+70
    if([self isMakeReLifeAble:model]){
point+= 70;
    }
    //shield 按单次护盾的1算
point+= [self getShieldFromModel:model];
    //无需makeshield
    //resistance (or reduce damage)1~3 *30
point+= [self getResistance:model]*30;
    //teamresis 无需
    //hitPicj 1~3 20
point+= [self getHitPick:model]*20;
    //teamacc 40

    if ([self isTeamAcc:model]) {
point+= 70;
    }
    //dodge 60
    if ([self isDodge:model]) {
point+= 60;
    }
    //makedodge 无需
    //invis +50
    if ([self isInvisible:model]) {
point+= 70;
    }

    if ([self isInterrupt:model]) {
point+= 30;
    }
    return [NSNumber numberWithFloat:point];
}
- (NSNumber *)teamFightProportion{
    if(!_teamFightProportion){
        //左右分数算出来,右/左-1得到百分比
        //伤害:每分钟的平均伤害
        
        //队形:乘20
        int teamStructureLeftPoint = (self.leftCoped.intValue+self.rightCounted.intValue);
        int teamsTructureRightPoint = (self.rightCoped.intValue+self.leftCounted.intValue);
        //除10
        int damageLeftPoint = 0;
        int damageRightPoint = 0;
        //要乘3
        int controlLeftPoint = 0;
        int controlRightPoint = 0;
        //要除10
        int AOELeft = 0;
        int AOERight = 0;
        //要×15
        int moveCountLeft = 0;
        int moveCountRight = 0;
        //makemoved 1~5 *10
        int makemovedLeft = 0;
        int makemovedRight = 0;
        //自己复活(蛮,赛)+15
        int relifeCountLeft = 0;
        int relifeCountRight = 0;
        //队友复活or无敌+30
        int makeRelifeLeft = 0;
        int makeRelifeRight = 0;
        //shield 按单次护盾的0.1算
        int shieldLeft = 0;
        int shieldRight = 0;
        //makeshield(cure算0.05) 按0.2算
        int shieldCureLeft = 0;
        int shieldCureRight = 0;
        //globalcount 30
        int globalCountLeft = 0;
        int globalCountRight = 0;
        //resistance (or reduce damage)1~3 *7
        int resistanceLeft = 0;
        int resistanceRight = 0;
        //teamresis 1~4 15
        int teamResisLeft = 0;
        int teamResisRight = 0;
        //hitPicj 1~3 8
        int hitPickLeft = 0;
        int hitPickRight = 0;
        //teamacc 30
        int accLeft = 0;
        int accRight = 0;
        //dodge 16
        int dodgeLeft = 0;
        int dodgeRight = 0;
        //makedodge 20
        int makedoLeft = 0;
        int makedoRight = 0;
        //invis 10
        int invisLeft = 0;
        int invisRight = 0;
        
        for (int i = 0; i<5; i++) { @autoreleasepool {
            HeroModel*a = self.allMember[i];
            HeroModel*b = self.allMember[i+5];
            damageLeftPoint += [self getDamagefromModel:a];
            damageRightPoint +=[self getDamagefromModel:b];
            controlLeftPoint += [self getControlFromModel:a];
            controlRightPoint += [self getControlFromModel:b];
            AOELeft += [self getAOEfromModel:a];
            AOERight += [self getAOEfromModel:b];
            if ([self isMovement:a]) {
                moveCountLeft++;
            }
            if ([self isMovement:b]) {
                moveCountRight++;
            }
            makemovedLeft += [self getMakeMovement:a];
            makemovedRight += [self getMakeMovement:b];
            if ([self isreLifeAble:a]) {
                relifeCountLeft++;
            }
            if ([self isreLifeAble:b]) {
                relifeCountRight++;
            }
            if ([self isMakeReLifeAble:a]) {
                makeRelifeLeft++;
            }
            if ([self isMakeReLifeAble:b]) {
                makeRelifeRight++;
            }
            
            shieldLeft += [self getShieldFromModel:a];
            shieldRight += [self getShieldFromModel:b];
            
            shieldCureLeft += [self getMksldFromModel:a];
            shieldCureRight += [self getMksldFromModel:b];
            
            if ([self isGlobal:a]) {
                globalCountLeft++;
            }
            if ([self isGlobal:b]) {
                globalCountRight++;
            }
            
            resistanceLeft += [self getResistance:a];
            resistanceRight += [self getResistance:b];
            
            teamResisLeft += [self getTeamResistance:a];
            teamResisRight +=[self getTeamResistance:b];
            
            hitPickLeft += [self getHitPick:a];
            hitPickRight +=[self getHitPick:b];
            
            if ([self isTeamAcc:a]) {
                accLeft++;
            }
            if ([self isTeamAcc:b]) {
                accRight++;
            }
            if ([self isDodge:a]) {
                dodgeLeft++;
            }
            if ([self isDodge:b]) {
                dodgeRight++;
            }
            if ([self isMakeDodge:a]) {
                makedoLeft++;
            }
            if ([self isMakeDodge:b]) {
                makedoRight++;
            }
            if ([self isInvisible: a]) {
                invisLeft++;
            }
            if ([self isTeamAcc:b]) {
                invisRight++;
            }
        }
        }
    
        CGFloat leftPoint = teamStructureLeftPoint*20+damageLeftPoint*1+controlLeftPoint*3+AOELeft*2+moveCountLeft*80+makemovedLeft*50+relifeCountLeft*55+makeRelifeLeft*50+shieldLeft*1+shieldCureLeft*1+globalCountLeft*30+resistanceLeft*7+teamResisLeft*15+hitPickLeft*8+accLeft*30+dodgeLeft*16+makedoLeft*20+invisLeft*170;
        CGFloat a= leftPoint;
        CGFloat rightPoint = teamsTructureRightPoint*20+damageRightPoint*1+controlRightPoint*3+AOERight*2+moveCountRight*80+makemovedRight*50+relifeCountRight*55+makeRelifeRight*50+shieldRight*1+shieldCureRight*1+globalCountRight*30+resistanceRight*7+teamResisRight*15+hitPickRight*8+accRight*30+dodgeRight*16+makedoRight*20+invisRight*170;
        CGFloat b = rightPoint;
        _teamFightProportion = [NSNumber numberWithFloat: (a/(a+b)-0.5)];
    }

    return _teamFightProportion;
}
- (NSNumber*)laningProportion{
    if (!_laningProportion) {
        
        
        float leftNum = [[self singleModelLanePoint:self.allMember[0]] floatValue]+[[self singleModelLanePoint:self.allMember[1]] floatValue]+[[self singleModelLanePoint:self.allMember[2]] floatValue]+[[self singleModelLanePoint:self.allMember[3]] floatValue]+[[self singleModelLanePoint:self.allMember[4]] floatValue]+self.rightCounted.floatValue*50;

        float rightNum = [[self singleModelLanePoint:self.allMember[5]] floatValue]+[[self singleModelLanePoint:self.allMember[6]] floatValue]+[[self singleModelLanePoint:self.allMember[7]] floatValue]+[[self singleModelLanePoint:self.allMember[8]] floatValue]+[[self singleModelLanePoint:self.allMember[9]] floatValue]+self.leftCounted.floatValue*50;
       
        _laningProportion = [NSNumber numberWithFloat:(leftNum/(leftNum+rightNum)-0.5)];
    }return _laningProportion;
}

-(NSNumber *)soloPushProportion{
    if (!_soloPushProportion) {
//        float leftNum = [[self singleModelPushPoint:self.allMember[0]] floatValue]+[[self singleModelPushPoint:self.allMember[1]] floatValue]+[[self singleModelPushPoint:self.allMember[2]] floatValue]+[[self singleModelPushPoint:self.allMember[3]] floatValue]+[[self singleModelPushPoint:self.allMember[4]] floatValue];
//        float rightNum = [[self singleModelPushPoint:self.allMember[5]] floatValue]+[[self singleModelPushPoint:self.allMember[6]] floatValue]+[[self singleModelPushPoint:self.allMember[7]] floatValue]+[[self singleModelPushPoint:self.allMember[8]] floatValue]+[[self singleModelPushPoint:self.allMember[9]] floatValue];
        float leftNum = [[self singleModelPushPoint:self.allMember[0]] floatValue]+[[self singleModelPushPoint:self.allMember[1]] floatValue]+[[self singleModelPushPoint:self.allMember[2]]floatValue]+[[self singleModelPushPoint:self.allMember[3]] floatValue]+[[self singleModelPushPoint:self.allMember[4]] floatValue];
        float rightNum = [[self singleModelPushPoint:self.allMember[5]] floatValue]+[[self singleModelPushPoint:self.allMember[6]] floatValue]+[[self singleModelPushPoint:self.allMember[7]]floatValue]+[[self singleModelPushPoint:self.allMember[8]] floatValue]+[[self singleModelPushPoint:self.allMember[9]] floatValue];
        
        _soloPushProportion = [NSNumber numberWithFloat:(leftNum/(leftNum+rightNum)-0.5)];
    }return _soloPushProportion;
}


#pragma mark 详细属性和胜率
-(NSArray*)getAllRate:(HeroModel*)model{
    return [model.heroProp objectForKey:@"rates"];
}
-(CGFloat)getAveRate:(HeroModel*)model{
    NSArray *temp = [self getAllRate:model];
    return [temp[0] floatValue];
}
-(CGFloat)getBrzRate:(HeroModel*)model{
    NSArray *temp = [self getAllRate:model];
    return [temp[1] floatValue];
}
-(CGFloat)getSlvRate:(HeroModel*)model{
    NSArray *temp = [self getAllRate:model];
    return [temp[2] floatValue];
}
-(CGFloat)getGldRate:(HeroModel*)model{
    NSArray *temp = [self getAllRate:model];
    return [temp[3] floatValue];
}
-(CGFloat)getPltRate:(HeroModel*)model{
    NSArray *temp = [self getAllRate:model];
    return [temp[4] floatValue];
}
-(CGFloat)getDmdRate:(HeroModel*)model{
    NSArray *temp = [self getAllRate:model];
    return [temp[5] floatValue];
}
-(CGFloat)getKngRate:(HeroModel*)model{
    NSArray *temp = [self getAllRate:model];
    return [temp[6] floatValue];
}
-(int)getDamagefromModel:(HeroModel*)model{
    //除5
    return   [[model.heroProp objectForKey:@"damage"] intValue];
}
-(int)getAOEfromModel:(HeroModel*)model{
    //除10
    return [[model.heroProp objectForKey:@"AOE"] intValue];
}
-(int)getControlFromModel:(HeroModel*)model{
    //乘3
    return [[model.heroProp objectForKey:@"control"] intValue];
}
-(BOOL)isMovement:(HeroModel*)model{
    return (BOOL)[model.heroProp objectForKey:@"movement"];
}
-(int)getMakeMovement:(HeroModel*)model{
    return [[model.heroProp objectForKey:@"makemoved"] intValue];
}
-(BOOL)isreLifeAble:(HeroModel*)model{//*15蛮\赛
    return (BOOL)[model.heroProp objectForKey:@"reLife"];
}
-(BOOL)isMakeReLifeAble:(HeroModel*)model{//*30
    return (BOOL)[model.heroProp objectForKey:@"makeRelife"];
}
-(int)getShieldFromModel:(HeroModel*)model{     //shield 按单次护盾的0.1算
    return [[model.heroProp objectForKey:@"shield"] intValue];
}
-(int)getMksldFromModel:(HeroModel*)model{
            //makeshield(cure算0.05) 按0.2算
    return [[model.heroProp objectForKey:@"makeShielded"] intValue];
}
-(BOOL)isGlobal:(HeroModel*)model{//30
       return(BOOL) [model.heroProp objectForKey:@"global"];
}
-(int)getResistance:(HeroModel*)model{//1~3*7
    return [[model.heroProp objectForKey:@"resistance"] intValue];
}
-(int)getTeamResistance:(HeroModel*)model{//1~3*15
    return [[model.heroProp objectForKey:@"teamResistance"] intValue];
}
-(int)getHitPick:(HeroModel*)model{//1~3*8(刷兵速度)
    return [[model.heroProp objectForKey:@"hitPick"] intValue];
}
-(BOOL)isTeamAcc:(HeroModel*)model{//30
    return (BOOL)[model.heroProp objectForKey:@"TeamAccelerate"];
}
-(BOOL)isDodge:(HeroModel*)model{//16
    return (BOOL)[model.heroProp objectForKey:@"dodge"];
}
-(BOOL)isMakeDodge:(HeroModel*)model{//救人而不带输出 复仇之毛or巴德 5
    return(BOOL) [model.heroProp objectForKey:@"makeDodge"];
}
-(BOOL)isInvisible:(HeroModel*)model{//1个+10,2个不加,3个扣10,4个扣20
    return (BOOL)[model.heroProp objectForKey:@"invisible"];
}
-(BOOL)isInterrupt:(HeroModel*)model{
    return (BOOL)[model.heroProp objectForKey:@"intrrupt"];
}
-(BOOL)isCloseFighter:(HeroModel*)model{//近战遇到控减分
    return (BOOL)[model.heroProp objectForKey:@"closeFighter"];
}



-(NSNumber *)leftCoped{
    if(!_leftCoped){
    int temp = 0;
    HeroModel* tempModel = [HeroModel new];
    HeroModel* tempModelCompared = [HeroModel new];
    NSMutableArray* arrTemp = [NSMutableArray arrayWithCapacity:20];
    for (int i = 0; i<4; i++) { @autoreleasepool {
        tempModel =  self.allMember[i];
        for (int j = i+1; j<5 ; j++) {
            tempModelCompared = self.allMember[j];
            arrTemp = (NSMutableArray*)tempModelCompared.partner;
            for (NSNumber* num in arrTemp) {
                if (num == tempModelCompared.heroTag) {
                    temp++;
                }
            }
        }}
    }
        _leftCoped = [NSNumber numberWithInt:temp];}
    return _leftCoped;
}
-(NSNumber *)rightCoped{
    if(!_rightCoped){
        int temp = 0;
        HeroModel* tempModel = [HeroModel new];
        HeroModel* tempModelCompared = [HeroModel new];
        NSMutableArray* arrTemp = [NSMutableArray arrayWithCapacity:20];
        for (int i = 5; i<9; i++) { @autoreleasepool {
            tempModel =  self.allMember[i];
            for (int j = i+1; j<10 ; j++) {
                tempModelCompared = self.allMember[j];
                arrTemp = (NSMutableArray*)tempModelCompared.partner;
                for (NSNumber* num in arrTemp) {
                    if (num == tempModelCompared.heroTag) {
                        temp++;
                    }
                }
            }}
        }
        _rightCoped = [NSNumber numberWithInt:temp];}
    return _rightCoped;
}
-(NSNumber *)rightCounted{
    if (!_rightCounted) {
        int temp = 0;
        HeroModel* tempModel = [HeroModel new];
        HeroModel* tempModelCompared = [HeroModel new];
        NSMutableArray* arrTemp = [NSMutableArray arrayWithCapacity:20];
        for (int i = 5; i<10; i++) { @autoreleasepool {
            tempModel = self.allMember[i];
            arrTemp = (NSMutableArray*)tempModel.countedBy;
            for (int j = 0; j<5; j++) {
                tempModelCompared = self.allMember[j];
                for (NSNumber*num in arrTemp) {
                    if (num==tempModelCompared.heroTag) {
                        temp++;
                    }
                }}
            }
        }_rightCounted = [NSNumber numberWithInt:temp];
    }return _rightCounted;
}
-(NSNumber *)leftCounted{
    if (!_leftCounted) {
        int temp = 0;
        HeroModel* tempModel = [HeroModel new];
        HeroModel* tempModelCompared = [HeroModel new];
        NSMutableArray* arrTemp = [NSMutableArray arrayWithCapacity:20];
        for (int i = 0; i<5; i++) { @autoreleasepool {
            tempModel = self.allMember[i];
            arrTemp = (NSMutableArray*)tempModel.countedBy;
            for (int j = 5; j<10; j++) {
                tempModelCompared = self.allMember[j];
                for (NSNumber*num in arrTemp) {
                    if (num==tempModelCompared.heroTag) {
                        temp++;
                    }
                }}
            }
        }_leftCounted = [NSNumber numberWithInt:temp];
    }return _leftCounted;
}
#pragma mark 点击方法
-(void)removeWeb {
    [UIWebView animateWithDuration:0.7 animations:^{
        self.WeiboWeb.transform = CGAffineTransformMakeTranslation(-screenWidth, 0);
    }];

}

-(void)loadWeb{
        NSURLRequest* rq = [[NSURLRequest alloc]initWithURL:[[NSURL alloc]initWithString:@"http://weibo.com/u/5508247150"] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:0];
    if (self.WeiboWeb.frame.origin.x==0) {
        [self addSubview:self.WeiboWeb];
        [UIWebView animateWithDuration:0.7 animations:^{
            self.WeiboWeb.transform = CGAffineTransformMakeTranslation(0, -screenHeight+20);
        }];
        [self.CloseWebBtn addTarget:self action:@selector(removeWeb) forControlEvents:UIControlEventTouchUpInside];
        [self.WeiboWeb addSubview:self.CloseWebBtn];
        [self.WeiboWeb loadRequest:rq];
    }else{
        [UIView animateWithDuration:0.7 animations:^{
            self.WeiboWeb.transform = CGAffineTransformMakeTranslation(0, 0);
        }];
    }
}



-(void)detailAClick{
    [self.laningDetailBut setEnabled:NO];
    [self.teamFightDetailBut setEnabled:YES];
    [self.soloPushDetailBut setEnabled:YES];
    [self calcTopLaneColumn];
    [self calcJunLaneColumn];
    [self calcMidLaneColumn];
    [self calcAdLaneColumn];
    [self calcSupLaneColumn];
    
}
-(void)detailBClick{
    [self.laningDetailBut setEnabled:YES];
    [self.teamFightDetailBut setEnabled:NO];
    [self.soloPushDetailBut setEnabled:YES];

    [self calcTopTeamColumn];
    [self calcJunTeamColumn];
    [self calcMidTeamColumn];
    [self calcAdTeamColumn];
    [self calcSupTeamColumn];
}
-(void)detailCClick{
    [self.laningDetailBut setEnabled:YES];
    [self.teamFightDetailBut setEnabled:YES];
    [self.soloPushDetailBut setEnabled:NO];
    [self calcTopSoloColumn];
    [self calcJunSoloColumn];
    [self calcMidSoloColumn];
    [self calcAdSoloColumn];
    [self calcSupSoloColumn];
}
-(void)brzClick{
    [self.brz setEnabled:NO];
    [self.slv setEnabled:YES];
    [self.gld setEnabled:YES];
    [self.plt setEnabled:YES];
    [self.dmd setEnabled:YES];
    [self.kng setEnabled:YES];
    [self calcBrz];
}
-(void)slvClick{
    [self.brz setEnabled:YES];
    [self.slv setEnabled:NO];
    [self.gld setEnabled:YES];
    [self.plt setEnabled:YES];
    [self.dmd setEnabled:YES];
    [self.kng setEnabled:YES];
    [self calcSlv];
}
-(void)gldClick{
    [self.brz setEnabled:YES];
    [self.slv setEnabled:YES];
    [self.gld setEnabled:NO];
    [self.plt setEnabled:YES];
    [self.dmd setEnabled:YES];
    [self.kng setEnabled:YES];
    [self calcGld];
}
-(void)pltClick{
    [self.brz setEnabled:YES];
    [self.slv setEnabled:YES];
    [self.gld setEnabled:YES];
    [self.plt setEnabled:NO];
    [self.dmd setEnabled:YES];
    [self.kng setEnabled:YES];
    [self calcPlt];
}
-(void)dmdClick{
    [self.brz setEnabled:YES];
    [self.slv setEnabled:YES];
    [self.gld setEnabled:YES];
    [self.plt setEnabled:YES];
    [self.dmd setEnabled:NO];
    [self.kng setEnabled:YES];
    [self calcDmd];
}
-(void)kngClick{
    [self.brz setEnabled:YES];
    [self.slv setEnabled:YES];
    [self.gld setEnabled:YES];
    [self.plt setEnabled:YES];
    [self.dmd setEnabled:YES];
    [self.kng setEnabled:NO];
    [self calcKng];
}

-(void)runRank{
    if ([self.brz isEnabled]&&[self.slv isEnabled]&&[self.gld isEnabled]&&[self.plt isEnabled]&&[self.dmd isEnabled]&&[self.kng isEnabled]) {
        [self calc];
    }else if (![self.brz isEnabled]) {
        [self calcBrz];
    }else if (![self.slv isEnabled]){
        [self calcSlv];
    }else if (![self.gld isEnabled]){
        [self calcGld];
    }else if (![self.plt isEnabled]){
        [self calcPlt];
    }else if (![self.dmd isEnabled]){
        [self calcDmd];
    }else if(![self.kng isEnabled]){
        [self calcKng];
    }
}

-(void)clickLeftSwitch{
    if(self.leftSwitch.isBlue){
        self.leftSwitch.isBlue = NO;
        self.leftIsBlue = -0.0431;
        [self runRank];
        [self.leftSwitch setBackgroundImage:[UIImage imageNamed:@"isPurple"] forState:UIControlStateNormal];
        self.rightSwitch.isBlue = YES;
        [self.rightSwitch setBackgroundImage:[UIImage imageNamed:@"isBlue"] forState:UIControlStateNormal];
        
    }else{
        self.leftSwitch.isBlue = YES;
        self.leftIsBlue = 0.0431;
        [self runRank];
        [self.leftSwitch setBackgroundImage:[UIImage imageNamed:@"isBlue"] forState:UIControlStateNormal];
        self.rightSwitch.isBlue = NO;
        [self.rightSwitch setBackgroundImage:[UIImage imageNamed:@"isPurple"] forState:UIControlStateNormal];
    }
}

-(void)clickRightSwitch{
    if(self.rightSwitch.isBlue){
        self.rightSwitch.isBlue = NO;
        self.leftIsBlue = 0.0431;
        [self runRank];
        [self.rightSwitch setBackgroundImage:[UIImage imageNamed:@"isPurple"] forState:UIControlStateNormal];
        self.leftSwitch.isBlue = YES;
        [self.leftSwitch setBackgroundImage:[UIImage imageNamed:@"isBlue"] forState:UIControlStateNormal];
    }else{
        self.rightSwitch.isBlue = YES;
        self.leftIsBlue = -0.0431;
        [self runRank];
        [self.rightSwitch setBackgroundImage:[UIImage imageNamed:@"isBlue"] forState:UIControlStateNormal];
        self.leftSwitch.isBlue = NO;
        [self.leftSwitch setBackgroundImage:[UIImage imageNamed:@"isPurple"] forState:UIControlStateNormal];
    }
}

-(void)destroyView{
      [self.delegate clearLeft];
      [self.delegate clearRight];
    [UIVisualEffectView animateWithDuration:1.0 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, screenHeight);
    }];
    [self.delegate destroy];
    
}


#pragma mark 加载结论方法
- (void)calculate{
    [UIView animateWithDuration:0.5 animations:^{
        self.memberA1.transform = CGAffineTransformMakeTranslation(-500, 0);
        self.memberA2.transform = CGAffineTransformMakeTranslation(-500, 0);
        self.memberA3.transform = CGAffineTransformMakeTranslation(-500, 0);
        self.memberA4.transform = CGAffineTransformMakeTranslation(-500, 0);
        self.memberA5.transform = CGAffineTransformMakeTranslation(-500, 0);
        self.l1.transform = CGAffineTransformMakeTranslation(-500, 0);
        self.l2.transform = CGAffineTransformMakeTranslation(-500, 0);
        self.l3.transform = CGAffineTransformMakeTranslation(-500, 0);
        self.l4.transform = CGAffineTransformMakeTranslation(-500, 0);
        self.l5.transform = CGAffineTransformMakeTranslation(-500, 0);
        self.memberB1.transform = CGAffineTransformMakeTranslation(500, 0);
        self.memberB2.transform = CGAffineTransformMakeTranslation(500, 0);
        self.memberB3.transform = CGAffineTransformMakeTranslation(500, 0);
        self.memberB4.transform = CGAffineTransformMakeTranslation(500, 0);
        self.memberB5.transform = CGAffineTransformMakeTranslation(500, 0);
        self.l6.transform = CGAffineTransformMakeTranslation(500, 0);
        self.l7.transform = CGAffineTransformMakeTranslation(500, 0);
        self.l8.transform = CGAffineTransformMakeTranslation(500, 0);
        self.l9.transform = CGAffineTransformMakeTranslation(500, 0);
        self.l10.transform = CGAffineTransformMakeTranslation(500, 0);
    }completion:^(BOOL finished){
    [self.memberA1 removeFromSuperview];
    [self.memberA2 removeFromSuperview];
    [self.memberA3 removeFromSuperview];
    [self.memberA4 removeFromSuperview];
    [self.memberA5 removeFromSuperview];
    [self.l1 removeFromSuperview];
    [self.l2 removeFromSuperview];
    [self.l3 removeFromSuperview];
    [self.l4 removeFromSuperview];
    [self.l5 removeFromSuperview];
    [self.memberB1 removeFromSuperview];
    [self.memberB2 removeFromSuperview];
    [self.memberB3 removeFromSuperview];
    [self.memberB4 removeFromSuperview];
    [self.memberB5  removeFromSuperview];
    [self.l6 removeFromSuperview];
    [self.l7 removeFromSuperview];
    [self.l8 removeFromSuperview];
    [self.l9 removeFromSuperview];
    [self.l10 removeFromSuperview];
    }];
    //此处添加动画效果,懒加载方法中把frame写在屏幕外,动画移入屏幕内
    
    [self calc];

    
    [self addSubview:self.detailView];
    [self calcTopTeamColumn];
    [self calcJunTeamColumn];
    [self calcMidTeamColumn];
    [self calcAdTeamColumn];
    [self calcSupTeamColumn];
    [self addSubview:self.leftTopM];
    [self addSubview:self.leftJunM];
    [self addSubview:self.leftMidM];
    [self addSubview:self.leftAdM];
    [self addSubview:self.leftSupM];
  
    [self addSubview:self.rightTopM];
    [self addSubview:self.rightJunM];
    [self addSubview:self.rightMidM];
    [self addSubview:self.rightAdM];
    [self addSubview:self.rightSupM];
    [self addSubview:self.buttonBar];
    
    
    [self addSubview:self.rightSwitch];
    [self addSubview:self.leftSwitch];
    [self.leftSwitch setEnabled:NO];
    [self addSubview:self.lableC];
    
    [self addSubview:self.brz];
    [self addSubview:self.slv];
    [self addSubview:self.gld];
    [self addSubview:self.plt];
    [self addSubview:self.dmd];
    [self addSubview:self.kng];
     [self addSubview:self.laningDetailBut];
    [self addSubview:self.teamFightDetailBut];
    [self addSubview:self.soloPushDetailBut];
    
    [self addSubview:self.topView];
    [self addSubview:self.contactMe];
    [self addSubview:self.contactMe2];
    [self addSubview:self.adView];
    [self addSubview:self.lableText];
    [self addSubview:self.lableRateLeft];
    [self addSubview:self.lableRateLeftX];
    [self addSubview:self.lableRateRight];
    [self addSubview:self.lableRateRightX];
    [self addSubview:self.reCalc];
  //  [self addSubview:self.destroyButton];



    
    
}

#pragma mark 懒加载
-(UILabel *)tipLable{
    if (!_tipLable) {
        _tipLable = [[UILabel alloc]initWithFrame:CGRectMake(-screenWidth,20  , screenWidth, 20)];
        _tipLable.textColor = [UIColor whiteColor];
        
        _tipLable.text = @"Tip:拖拽图标位置可调整位置~";
        _tipLable.backgroundColor = [UIColor clearColor];
        _tipLable.numberOfLines = 1;
    }
    return _tipLable;
}

-(UIButton *)CloseWebBtn{
    if (!_CloseWebBtn) {
        _CloseWebBtn = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth-btnSize, 64,44 , 44)];
        [_CloseWebBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    }return _CloseWebBtn;
    
}


-(UIWebView *)WeiboWeb{
    if (!_WeiboWeb) {
        _WeiboWeb = [[UIWebView alloc]initWithFrame:CGRectMake(0, screenHeight, screenWidth, screenHeight-20)];    }
    return _WeiboWeb;
}

-(UIButton *)contactMe{
    if (!_contactMe) {
        _contactMe = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, screenHeight*0.055, screenHeight*0.05)];
        [_contactMe setBackgroundImage:[UIImage imageNamed:@"contactLeft"] forState:UIControlStateNormal];
        [_contactMe addTarget:self action:@selector(loadWeb) forControlEvents:UIControlEventTouchUpInside];
    }return _contactMe;
}

-(UIButton *)contactMe2{
    if (!_contactMe2) {
        _contactMe2 = [[UIButton alloc]initWithFrame:CGRectMake(20+screenHeight*0.055, 30, screenHeight*0.14, screenHeight*0.05)];
        _contactMe2.backgroundColor = [UIColor clearColor];
        [_contactMe2 setTitle:@"联系作者" forState:UIControlStateNormal];
        _contactMe2.titleLabel.textColor=[UIColor whiteColor];
        _contactMe2.titleLabel.numberOfLines = 1;
        _contactMe2.titleLabel.font =[UIFont systemFontOfSize:15*screenWidth/320];
        [_contactMe2 addTarget:self action:@selector(loadWeb) forControlEvents:UIControlEventTouchUpInside];
    }return _contactMe2;
}



-(ADBannerView *)adView{
    if (!_adView) {
        _adView = [[ADBannerView alloc]init];
        _adView.frame = CGRectMake(0,screenHeight*0.65-screenWidth*0.125-70, screenWidth, screenHeight);

        [_adView setBackgroundColor:[UIColor clearColor]];
    }return _adView;
}

-(UILabel *)a1score{
    if (!_a1score) {
        _a1score = [[UILabel alloc]init];
        _a1score.backgroundColor = [UIColor clearColor];
    }return _a1score;
}
-(UILabel *)a2score{
    if (!_a2score) {
        _a2score = [[UILabel alloc]init];
        _a2score.backgroundColor = [UIColor clearColor];
    }return _a2score;
}
-(UILabel *)a3score{
    if (!_a3score) {
        _a3score = [[UILabel alloc]init];
        _a3score.backgroundColor = [UIColor clearColor];
    }return _a3score;
}
-(UILabel *)a4score{
    if (!_a4score) {
        _a4score = [[UILabel alloc]init];
        _a4score.backgroundColor = [UIColor clearColor];
    }return _a4score;
}-(UILabel *)a5score{
    if (!_a5score) {
        _a5score = [[UILabel alloc]init];
        _a5score.backgroundColor = [UIColor clearColor];
    }return _a5score;
}
-(UILabel *)b1score{
    if (!_b1score) {
        _b1score = [[UILabel alloc]init];
        _b1score.textAlignment = NSTextAlignmentRight;
        _b1score.backgroundColor = [UIColor clearColor];
    }return _b1score;
}
-(UILabel *)b2score{
    if (!_b2score) {
        _b2score = [[UILabel alloc]init];
        _b2score.backgroundColor = [UIColor clearColor];
        _b2score.textAlignment = NSTextAlignmentRight;
    }return _b2score;
}
-(UILabel *)b3score{
    if (!_b3score) {
        _b3score = [[UILabel alloc]init];
        _b3score.backgroundColor = [UIColor clearColor];
        _b3score.textAlignment = NSTextAlignmentRight;
    }return _b3score;
}
-(UILabel *)b4score{
    if (!_b4score) {
        _b4score = [[UILabel alloc]init];
        _b4score.backgroundColor = [UIColor clearColor];
        _b4score.textAlignment = NSTextAlignmentRight;
    }return _b4score;
}
-(UILabel *)b5score{
    if (!_b5score) {
        _b5score = [[UILabel alloc]init];
        _b5score.backgroundColor = [UIColor clearColor];
        _b5score.textAlignment = NSTextAlignmentRight;
    }return _b5score;
}

-(UIView *)leftTopScore{
    if (!_leftTopScore) {
        _leftTopScore = [[UIView alloc]init];
        [_leftTopScore setBackgroundColor:[UIColor colorWithRed:202/255.0 green:84/255.0 blue:101/255.0 alpha:0.9]];
    }return _leftTopScore;
}
-(UIView *)rightTopScore{
    if (!_rightTopScore) {
        _rightTopScore = [[UIView alloc]init];
        [_rightTopScore setBackgroundColor:[UIColor colorWithRed:126/255.0 green:137/255.0 blue:178/255.0 alpha:0.9]];
    }return _rightTopScore;
}
-(UIView *)leftJunScore{
    if (!_leftJunScore) {
        _leftJunScore = [[UIView alloc]init];
        [_leftJunScore setBackgroundColor:[UIColor colorWithRed:202/255.0 green:84/255.0 blue:101/255.0 alpha:0.9]];
    }return _leftJunScore;
}
-(UIView *)rightJunScore{
    if (!_rightJunScore) {
        _rightJunScore = [[UIView alloc]init];
        [_rightJunScore setBackgroundColor:[UIColor colorWithRed:126/255.0 green:137/255.0 blue:178/255.0 alpha:0.9]];
    }return _rightJunScore;
}
-(UIView *)leftMidScore{
    if (!_leftMidScore) {
        _leftMidScore = [[UIView alloc]init];
        [_leftMidScore setBackgroundColor:[UIColor colorWithRed:202/255.0 green:84/255.0 blue:101/255.0 alpha:0.9]];
    }return _leftMidScore;
}
-(UIView *)rightMidScore{
    if (!_rightMidScore) {
        _rightMidScore = [[UIView alloc]init];
        [_rightMidScore setBackgroundColor:[UIColor colorWithRed:126/255.0 green:137/255.0 blue:178/255.0 alpha:0.9]];
    }return _rightMidScore;
}
-(UIView*)leftAdScore{
    if (!_leftAdScore) {
        _leftAdScore = [[UIView alloc]init];
        [_leftAdScore setBackgroundColor:[UIColor colorWithRed:202/255.0 green:84/255.0 blue:101/255.0 alpha:0.9]];
    }return _leftAdScore;
}
-(UIView*)rightAdScore{
    if (!_rightAdScore) {
        _rightAdScore = [[UIView alloc]init];
        [_rightAdScore setBackgroundColor:[UIColor colorWithRed:126/255.0 green:137/255.0 blue:178/255.0 alpha:0.9]];
    }return _rightAdScore;
}
-(UIView*)leftSupScore{
    if (!_leftSupScore) {
        _leftSupScore = [[UIView alloc]init];
        [_leftSupScore setBackgroundColor:[UIColor colorWithRed:202/255.0 green:84/255.0 blue:101/255.0 alpha:0.9]];
    }return _leftSupScore;
}
-(UIView*)rightSupScore{
    if (!_rightSupScore) {
        _rightSupScore = [[UIView alloc]init];
        [_rightSupScore setBackgroundColor:[UIColor colorWithRed:126/255.0 green:137/255.0 blue:178/255.0 alpha:0.9]];
    }return _rightSupScore;
}
-(CGFloat)widthLeft{
    if (!_widthLeft) {
        _widthLeft = screenWidth - (self.leftTopM.frame.origin.x + self.leftTopM.frame.size.width)*2;
    }return _widthLeft;
}


-(NSArray *)allMember{
    if (!_allMember) {
        _allMember = [NSArray arrayWithObjects:self.leftTop.ButtonForPosition.HeroForButton,self.leftJun.ButtonForPosition.HeroForButton,self.leftMid.ButtonForPosition.HeroForButton,self.leftAd.ButtonForPosition.HeroForButton,self.leftSup.ButtonForPosition.HeroForButton,self.rightTop.ButtonForPosition.HeroForButton,self.rightJun.ButtonForPosition.HeroForButton,self.rightMid.ButtonForPosition.HeroForButton,self.rightAd.ButtonForPosition.HeroForButton,self.rightSup.ButtonForPosition.HeroForButton, nil];
    }return _allMember;
}

-(UIButton *)brz{
    if (!_brz) {
        _brz = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth*0.125, screenHeight*0.65-screenWidth*0.125, screenWidth*0.125, screenWidth*0.125)];
        [_brz setBackgroundImage:[UIImage imageNamed:@"ustage_1"] forState:UIControlStateNormal];
        [_brz setBackgroundImage:[UIImage imageNamed:@"stage_1"] forState:UIControlStateDisabled];
        [_brz addTarget:self action:@selector(brzClick) forControlEvents:UIControlEventTouchUpInside];
    }return _brz;
}
-(UIButton *)slv{
    if (!_slv) {
        _slv = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth*0.25, screenHeight*0.65-screenWidth*0.125, screenWidth*0.125, screenWidth*0.125)];
        [_slv setBackgroundImage:[UIImage imageNamed:@"ustage_2"] forState:UIControlStateNormal];
        [_slv setBackgroundImage:[UIImage imageNamed:@"stage_2"] forState:UIControlStateDisabled];
        [_slv addTarget:self action:@selector(slvClick) forControlEvents:UIControlEventTouchUpInside];
    }return _slv;
}
-(UIButton *)gld{
    if (!_gld) {
        _gld = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth*0.375, screenHeight*0.65-screenWidth*0.125, screenWidth*0.125, screenWidth*0.125)];
        [_gld setBackgroundImage:[UIImage imageNamed:@"ustage_3"] forState:UIControlStateNormal];
        [_gld setBackgroundImage:[UIImage imageNamed:@"stage_3"] forState:UIControlStateDisabled];
        [_gld addTarget:self action:@selector(gldClick) forControlEvents:UIControlEventTouchUpInside];
    }return _gld;
}
-(UIButton *)plt{
    if (!_plt) {
        _plt = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth*0.5, screenHeight*0.65-screenWidth*0.125, screenWidth*0.125, screenWidth*0.125)];
        [_plt setBackgroundImage:[UIImage imageNamed:@"ustage_4"] forState:UIControlStateNormal];
        [_plt setBackgroundImage:[UIImage imageNamed:@"stage_4"] forState:UIControlStateDisabled];
        [_plt addTarget:self action:@selector(pltClick) forControlEvents:UIControlEventTouchUpInside];
    }return _plt;
}
-(UIButton *)dmd{
    if (!_dmd) {
        _dmd = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth*0.625, screenHeight*0.65-screenWidth*0.125, screenWidth*0.125, screenWidth*0.125)];
        [_dmd setBackgroundImage:[UIImage imageNamed:@"ustage_5"] forState:UIControlStateNormal];
        [_dmd setBackgroundImage:[UIImage imageNamed:@"stage_5"] forState:UIControlStateDisabled];
        [_dmd addTarget:self action:@selector(dmdClick) forControlEvents:UIControlEventTouchUpInside];
    }return _dmd;
}
-(UIButton *)kng{
    if (!_kng) {
        _kng = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth*0.75, screenHeight*0.65-screenWidth*0.125, screenWidth*0.125, screenWidth*0.125)];
        [_kng setBackgroundImage:[UIImage imageNamed:@"ustage_6"] forState:UIControlStateNormal];
        [_kng setBackgroundImage:[UIImage imageNamed:@"stage_6"] forState:UIControlStateDisabled];
        [_kng addTarget:self action:@selector(kngClick) forControlEvents:UIControlEventTouchUpInside];
    }return _kng;
}



-(UILabel *)lableC{
    if (!_lableC) {
        _lableC = [[UILabel alloc]initWithFrame:CGRectMake(0, screenHeight*0.65-screenWidth*0.125-20, screenWidth, 20)];
        _lableC.text = @"点击选择阵营和段位,重新计算可提高准确度";
        _lableC.font = [UIFont systemFontOfSize:15*screenWidth/320];
        _lableC.backgroundColor = [UIColor colorWithWhite:3 alpha:3];
        _lableC.textColor = [UIColor blackColor];
        _lableC.textAlignment = NSTextAlignmentCenter;
    }return _lableC;
}


-(UILabel *)lableRateLeft{
    if (!_lableRateLeft) {
        _lableRateLeft = [[UILabel alloc]initWithFrame:CGRectMake(5, 50+btnSize, (screenWidth-10)*0.5,( 0.4*screenHeight - 50-btnSize-10)*2/3)];
        _lableRateLeft.font =[UIFont fontWithName:@"Bodoni 72 Smallcaps" size:48*(screenWidth/320)];
        _lableRateLeft.textAlignment = NSTextAlignmentCenter;

        _lableRateLeft.backgroundColor =[UIColor whiteColor];
         }return _lableRateLeft;
}
-(UILabel *)lableRateLeftX{
    if (!_lableRateLeftX) {
        _lableRateLeftX = [[UILabel alloc]initWithFrame:CGRectMake(5, 50+btnSize+(0.4*screenHeight - 50-btnSize-10)*2/3, (screenWidth-10)*0.5,(0.4*screenHeight - 50-btnSize-10)*1/3)];
        _lableRateLeftX.font =[UIFont fontWithName:@"Bodoni 72 Smallcaps" size:30*(screenWidth/320)];
        _lableRateLeftX.textAlignment = NSTextAlignmentRight;
        _lableRateLeftX.text = @"%";
        _lableRateLeftX.backgroundColor =[UIColor whiteColor];
    }return _lableRateLeftX;
}
-(UILabel *)lableRateRight{
    if (!_lableRateRight) {
        _lableRateRight = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth*0.5, 50+btnSize, (screenWidth-10)*0.5, ( 0.4*screenHeight - 50-btnSize-10)*2/3)];
        _lableRateRight.font =[UIFont fontWithName:@"Bodoni 72 Smallcaps" size:48*(screenWidth/320)];
        _lableRateRight.textAlignment = NSTextAlignmentCenter;
        _lableRateRight.backgroundColor =[UIColor grayColor];

        
    }return _lableRateRight;
}
-(UILabel *)lableRateRightX{
    if (!_lableRateRightX) {
        _lableRateRightX = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth*0.5, 50+btnSize+(0.4*screenHeight - 50-btnSize-10)*2/3, (screenWidth-10)*0.5, (0.4*screenHeight - 50-btnSize-10)*1/3)];
        _lableRateRightX.font =[UIFont fontWithName:@"Bodoni 72 Smallcaps" size:30*(screenWidth/320)];
        _lableRateRightX.backgroundColor =[UIColor grayColor];
        _lableRateRightX.textAlignment = NSTextAlignmentRight;
        _lableRateRightX.text = @"%";
        
    }return _lableRateRightX;
}
-(UILabel *)lableText{
    if (!_lableText) {
        _lableText = [[UILabel alloc]initWithFrame:CGRectMake(btnSize*0.8, 50, btnSize*3, btnSize)];
        
       
        _lableText.font = [UIFont fontWithName:@"Bodoni 72 Smallcaps" size:24];
        _lableText.text = @"Win Rate";
        _lableText.textColor = [UIColor whiteColor];
        _lableText.textAlignment = NSTextAlignmentCenter;
    }return _lableText;
}

-(UIImageView *)topView{
    if (!_topView) {
        
        _topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, screenWidth, screenHeight*0.65-screenWidth*0.125-90)];
        [_topView setImage:[UIImage imageNamed:@"conclusion_back1"]];
         _topView.contentMode = UIViewContentModeScaleToFill;
    }return _topView;
}

-(SideButton *)leftSwitch{
    if(!_leftSwitch){
        _leftSwitch = [[SideButton alloc]initWithFrame:CGRectMake(0, screenHeight*0.65-screenWidth*0.125, screenWidth*0.125, screenWidth*0.125)];
        
        [_leftSwitch setBackgroundImage:[UIImage imageNamed:@"isBlue"] forState:UIControlStateNormal];
        _leftSwitch.isBlue = YES;

        [_leftSwitch addTarget:self action:@selector(clickLeftSwitch) forControlEvents:UIControlEventTouchUpInside];
    }return _leftSwitch;
}


-(SideButton *)rightSwitch{
    if (!_rightSwitch) {
        _rightSwitch = [[SideButton alloc]initWithFrame:CGRectMake(screenWidth-screenWidth*0.125, screenHeight*0.65-screenWidth*0.125, screenWidth*0.125, screenWidth*0.125)];

        [_rightSwitch setBackgroundImage:[UIImage imageNamed:@"isPurple"] forState:UIControlStateNormal];
        _rightSwitch.isBlue = NO;
        [_rightSwitch addTarget:self action:@selector(clickRightSwitch) forControlEvents:UIControlEventTouchUpInside];
    }return _rightSwitch;
}


-(UIView *)buttonBar{
    if (!_buttonBar) {
        _buttonBar = [[UIView alloc]initWithFrame:CGRectMake(0, screenHeight*0.65, screenWidth, screenHeight*0.05)];
        _buttonBar.backgroundColor = [UIColor whiteColor];
    }return _buttonBar;
}

-(UIButton *)laningDetailBut{
    if (!_laningDetailBut) {
        _laningDetailBut = [[UIButton alloc]initWithFrame:CGRectMake((screenWidth - 0.45* screenHeight)/4, screenHeight*0.65, screenHeight*0.15, screenHeight*0.05)];
        [_laningDetailBut setBackgroundImage:[UIImage imageNamed:@"detailBtn"] forState:UIControlStateNormal];
        [_laningDetailBut setBackgroundImage:[UIImage imageNamed:@"ptnNormal"] forState:UIControlStateDisabled];
//        [_laningDetailBut setEnabled:NO];
        [_laningDetailBut setTitle:@"线上能力" forState:UIControlStateNormal];
        [_laningDetailBut addTarget:self action:@selector(detailAClick) forControlEvents:UIControlEventTouchUpInside];
    }return _laningDetailBut;
}

-(UIButton *)teamFightDetailBut{
    if (!_teamFightDetailBut) {
        _teamFightDetailBut = [[UIButton alloc]initWithFrame:CGRectMake((screenWidth - 0.45* screenHeight)*2/4+0.15*screenHeight, screenHeight*0.65, screenHeight*0.15, screenHeight*0.05)];

        [_teamFightDetailBut setBackgroundImage:[UIImage imageNamed:@"detailBtn"] forState:UIControlStateNormal];
        [_teamFightDetailBut setBackgroundImage:[UIImage imageNamed:@"ptnNormal"] forState:UIControlStateDisabled];
        [_teamFightDetailBut setEnabled:NO];
        [_teamFightDetailBut setTitle:@"团战能力" forState:UIControlStateNormal];
        [_teamFightDetailBut addTarget:self action:@selector(detailBClick) forControlEvents:UIControlEventTouchUpInside];
    }return _teamFightDetailBut;
}

-(UIButton *)soloPushDetailBut{
    if (!_soloPushDetailBut) {
        _soloPushDetailBut = [[UIButton alloc]initWithFrame:CGRectMake((screenWidth - 0.45* screenHeight)*3/4+0.3*screenHeight, screenHeight*0.65, screenHeight*0.15, screenHeight*0.05)];
        [_soloPushDetailBut setBackgroundImage:[UIImage imageNamed:@"detailBtn"] forState:UIControlStateNormal];
        [_soloPushDetailBut setBackgroundImage:[UIImage imageNamed:@"ptnNormal"] forState:UIControlStateDisabled];
        [_soloPushDetailBut setTitle:@"牵制能力" forState:UIControlStateNormal];
        [_soloPushDetailBut addTarget:self action:@selector(detailCClick) forControlEvents:UIControlEventTouchUpInside];
    }return _soloPushDetailBut;
}
//左
-(UIImageView *)leftTopM{
    if (!_leftTopM) {
        NSString* imgName = self.leftTop.ButtonForPosition.HeroForButton.icon ;
        UIImage* image = [UIImage imageNamed:imgName];
        _leftTopM = [[UIImageView alloc]initWithImage:image];
        _leftTopM.frame = CGRectMake(screenHeight*0.01,screenHeight*0.7,screenHeight*0.05,screenHeight*0.05 );
    }return _leftTopM;
}
-(UIImageView *)leftJunM{
    if (!_leftJunM) {
        NSString* imgName = self.leftJun.ButtonForPosition.HeroForButton.icon ;
        UIImage* image = [UIImage imageNamed:imgName];
        _leftJunM = [[UIImageView alloc]initWithImage:image];
        _leftJunM.frame = CGRectMake(screenHeight*0.01,screenHeight*0.7625,screenHeight*0.05,screenHeight*0.05 );
    }return _leftJunM;
}
-(UIImageView *)leftMidM{
    if (!_leftMidM) {
        NSString* imgName = self.leftMid.ButtonForPosition.HeroForButton.icon ;
        UIImage* image = [UIImage imageNamed:imgName];
        _leftMidM = [[UIImageView alloc]initWithImage:image];
        _leftMidM.frame = CGRectMake(screenHeight*0.01,screenHeight*0.825,screenHeight*0.05,screenHeight*0.05 );
    }return _leftMidM;
}
-(UIImageView *)leftAdM{
    if (!_leftAdM) {
        NSString* imgName = self.leftAd.ButtonForPosition.HeroForButton.icon ;
        UIImage* image = [UIImage imageNamed:imgName];
        _leftAdM = [[UIImageView alloc]initWithImage:image];
        _leftAdM.frame = CGRectMake(screenHeight*0.01,screenHeight*0.8875,screenHeight*0.05,screenHeight*0.05 );
    }return _leftAdM;
}
-(UIImageView *)leftSupM{
    if (!_leftSupM) {
        NSString* imgName = self.leftSup.ButtonForPosition.HeroForButton.icon ;
        UIImage* image = [UIImage imageNamed:imgName];
        _leftSupM = [[UIImageView alloc]initWithImage:image];
        _leftSupM.frame = CGRectMake(screenHeight*0.01,screenHeight*0.95,screenHeight*0.05,screenHeight*0.05 );
    }return _leftSupM;
}

//右
-(UIImageView *)rightTopM{
    if (!_rightTopM) {
        NSString* imgName = self.rightTop.ButtonForPosition.HeroForButton.icon ;
        UIImage* image = [UIImage imageNamed:imgName];
        _rightTopM = [[UIImageView alloc]initWithImage:image];
        _rightTopM.frame = CGRectMake(screenWidth-screenHeight*0.06,screenHeight*0.7,screenHeight*0.05,screenHeight*0.05 );
    }return _rightTopM;
}
-(UIImageView *)rightJunM{
    if (!_rightJunM) {
        NSString* imgName = self.rightJun.ButtonForPosition.HeroForButton.icon ;
        UIImage* image = [UIImage imageNamed:imgName];
        _rightJunM = [[UIImageView alloc]initWithImage:image];
        _rightJunM.frame = CGRectMake(screenWidth-screenHeight*0.06,screenHeight*0.7625,screenHeight*0.05,screenHeight*0.05 );
    }return _rightJunM;
}
-(UIImageView *)rightMidM{
    if (!_rightMidM) {
        NSString* imgName = self.rightMid.ButtonForPosition.HeroForButton.icon ;
        UIImage* image = [UIImage imageNamed:imgName];
        _rightMidM = [[UIImageView alloc]initWithImage:image];
        _rightMidM.frame = CGRectMake(screenWidth-screenHeight*0.06,screenHeight*0.825,screenHeight*0.05,screenHeight*0.05 );
    }return _rightMidM;
}
-(UIImageView *)rightAdM{
    if (!_rightAdM) {
        NSString* imgName = self.rightAd.ButtonForPosition.HeroForButton.icon ;
        UIImage* image = [UIImage imageNamed:imgName];
        _rightAdM = [[UIImageView alloc]initWithImage:image];
        _rightAdM.frame = CGRectMake(screenWidth-screenHeight*0.06,screenHeight*0.8875,screenHeight*0.05,screenHeight*0.05 );
    }return _rightAdM;
}
-(UIImageView *)rightSupM{
    if (!_rightSupM) {
        NSString* imgName = self.rightSup.ButtonForPosition.HeroForButton.icon ;
        UIImage* image = [UIImage imageNamed:imgName];
        _rightSupM = [[UIImageView alloc]initWithImage:image];
        _rightSupM.frame = CGRectMake(screenWidth-screenHeight*0.06,screenHeight*0.95,screenHeight*0.05,screenHeight*0.05 );
    }return _rightSupM;
}
-(UIView *)detailView{
    if (!_detailView) {
        _detailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0.7*screenHeight, screenWidth, screenHeight*0.3)];
        UIImageView* temp = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight*0.3)];
        temp.image = [UIImage imageNamed:@"conclusion_back2"];
        [_detailView addSubview:temp];
    }return _detailView;
}

-(UIButton *)calcButton{
    if (!_calcButton) {
        _calcButton =[[UIButton alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize*2, 40+(btnSize+20)*4+btnSize*3, btnSize, btnSize)];
        [_calcButton setBackgroundImage:[UIImage imageNamed:@"done"] forState:UIControlStateNormal];
        [_calcButton addTarget:self action:@selector(calculate) forControlEvents:UIControlEventTouchUpInside];
    }return _calcButton;
}

-(void)clearView{
    [UIVisualEffectView animateWithDuration:1.0 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, screenHeight);
    }];
}

-(UIButton *)reCalc{
    if (!_reCalc) {
        _reCalc = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth-btnSize, 30, btnSize*0.6, btnSize*0.6)];
        [_reCalc setBackgroundImage:[UIImage imageNamed:@"close2" ] forState:UIControlStateNormal];
        [_reCalc addTarget:self action:@selector(ajust) forControlEvents:UIControlEventTouchUpInside];
    }return _reCalc;
}
-(void)ajust{
    [self clearView];
    [self.delegate destroy];
}

-(UIButton *)destroyButton{
    if (!_destroyButton) {
        _destroyButton = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth-btnSize*1, 30, btnSize*0.6, btnSize*0.6)];
        [_destroyButton setBackgroundImage:[UIImage imageNamed:@"close" ] forState:UIControlStateNormal];
        [_destroyButton addTarget:self action:@selector(destroyView) forControlEvents:UIControlEventTouchUpInside];
    }return _destroyButton;
}

-(UIButton *)clearButton{
    if (!_clearButton) {
        _clearButton = [[UIButton alloc]initWithFrame:CGRectMake(5+btnSize, 40+(btnSize+20)*4+btnSize*3, btnSize, btnSize)];
        [_clearButton setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_clearButton addTarget:self action:@selector(clearView) forControlEvents:UIControlEventTouchUpInside];
    }return _clearButton;
}
//自定义的放弃
//-(detailView *)detailsView{
//    if (!_detailsView) {
//        _detailsView = [[detailView alloc]initWithFrame:CGRectMake(300, 102, 80, 64)];
//
//    }return _detailsView;
//}

-(UILabel *)l1{
    if (!_l1) {
        _l1 = [[UILabel alloc]initWithFrame:CGRectMake(5+btnSize, 40,btnSize*0.3, btnSize)];
        _l1.text = @"上单";
        _l1.numberOfLines = 0;
        _l1.backgroundColor = [UIColor colorWithRed:255/255.0 green:215/255.0 blue:0 alpha:0.9];
          _l1.font = [UIFont systemFontOfSize:14*(screenWidth/360)];
_l1.textColor = [UIColor whiteColor];
    }return _l1;
}
-(UILabel *)l6{
    if (!_l6) {
        _l6 = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize-0.3*btnSize, 40,btnSize*0.3, btnSize)];
        _l6.text = @"上单";
        _l6.numberOfLines = 0;
        _l6.backgroundColor = [UIColor colorWithRed:255/255.0 green:215/255.0 blue:0 alpha:0.9];
        _l6.font = [UIFont systemFontOfSize:14*(screenWidth/360)];
        _l6.textColor = [UIColor whiteColor];
    }return _l6;
}
-(UILabel *)l2{
    if (!_l2) {
        _l2 = [[UILabel alloc]initWithFrame:CGRectMake(5+btnSize, 40+btnSize+20,btnSize*0.3, btnSize)];
        _l2.text = @"打野";
        _l2.numberOfLines = 0;
        _l2.backgroundColor = [UIColor colorWithRed:105/255.0 green:197/255.0 blue:191/255.0 alpha:0.9];
        _l2.font = [UIFont systemFontOfSize:14*(screenWidth/360)];
        _l2.textColor = [UIColor whiteColor];
    }return _l2;
}
-(UILabel *)l7{
    if (!_l7) {
        _l7 = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize-0.3*btnSize, 40+btnSize+20,btnSize*0.3, btnSize)];
        _l7.text = @"打野";
        _l7.numberOfLines = 0;
        _l7.backgroundColor = [UIColor colorWithRed:105/255.0 green:197/255.0 blue:191/255.0 alpha:0.9];
        _l7.font = [UIFont systemFontOfSize:14*(screenWidth/360)];
        _l7.textColor = [UIColor whiteColor];
    }return _l7;
}
-(UILabel *)l3{
    if (!_l3) {
        _l3 = [[UILabel alloc]initWithFrame:CGRectMake(5+btnSize, 40+(btnSize+20)*2,btnSize*0.3, btnSize)];
        _l3.text = @"中单";
        _l3.numberOfLines = 0;
        _l3.backgroundColor = [UIColor colorWithRed:186/255.0 green:85/255.0 blue:211/255.0 alpha:1];
        _l3.font = [UIFont systemFontOfSize:14*(screenWidth/360)];
        _l3.textColor = [UIColor whiteColor];
    }return _l3;
}
-(UILabel *)l8{
    if (!_l8) {
        _l8 = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize-0.3*btnSize, 40+(btnSize+20)*2,btnSize*0.3, btnSize)];
        _l8.text = @"中单";
        _l8.numberOfLines = 0;
        _l8.backgroundColor = [UIColor colorWithRed:186/255.0 green:85/255.0 blue:211/255.0 alpha:1];
        _l8.font = [UIFont systemFontOfSize:14*(screenWidth/360)];
        _l8.textColor = [UIColor whiteColor];
    }return _l8;
}
-(UILabel *)l4{
    if (!_l4) {
        _l4 = [[UILabel alloc]initWithFrame:CGRectMake(5+btnSize, 40+(btnSize+20)*3,btnSize*0.3, btnSize)];
        _l4.text = @"射手";
        _l4.numberOfLines = 0;
        _l4.backgroundColor = [UIColor colorWithRed:255/255.0 green:69/255.0 blue:0/255.0 alpha:1];
        _l4.font = [UIFont systemFontOfSize:14*(screenWidth/360)];
        _l4.textColor = [UIColor whiteColor];
    }return _l4;
}
-(UILabel *)l9{
    if (!_l9) {
        _l9 = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize-0.3*btnSize, 40+(btnSize+20)*3,btnSize*0.3, btnSize)];
        _l9.text = @"射手";
        _l9.numberOfLines = 0;
        _l9.backgroundColor = [UIColor colorWithRed:255/255.0 green:69/255.0 blue:0/255.0 alpha:1];
        _l9.font = [UIFont systemFontOfSize:14*(screenWidth/360)];
        _l9.textColor = [UIColor whiteColor];
    }return _l9;
}
-(UILabel *)l5{
    if (!_l5) {
        _l5 = [[UILabel alloc]initWithFrame:CGRectMake(5+btnSize, 40+(btnSize+20)*4,btnSize*0.3, btnSize)];
        _l5.text = @"辅助";
        _l5.numberOfLines = 0;
        _l5.backgroundColor = [UIColor colorWithRed:46/255.0 green:138/255.0 blue:88/255.0 alpha:1];
        _l5.font = [UIFont systemFontOfSize:14*(screenWidth/360)];
        _l5.textColor = [UIColor whiteColor];
    }return _l5;
}
-(UILabel *)l10{
    if (!_l10) {
        _l10 = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize-0.3*btnSize, 40+(btnSize+20)*4,btnSize*0.3, btnSize)];
        _l10.text = @"辅助";
        _l10.numberOfLines = 0;
        _l10.backgroundColor = [UIColor colorWithRed:46/255.0 green:138/255.0 blue:88/255.0 alpha:1];
        _l10.font = [UIFont systemFontOfSize:14*(screenWidth/360)];
        _l10.textColor = [UIColor whiteColor];
    }return _l10;
}

-(PositionView *)leftTop{
    if (!_leftTop) {
        _leftTop = [[PositionView alloc]initWithFrame:CGRectMake(5,40 , btnSize, btnSize)];
        _leftTop.PositionKey = @"leftTop";
        _leftTop.ButtonForPosition = self.memberA1;
       
    }return _leftTop;
}
-(PositionView *)leftJun{
    if (!_leftJun) {
        _leftJun = [[PositionView alloc]initWithFrame:CGRectMake(5,40+btnSize+20 , btnSize, btnSize)];
        _leftJun.PositionKey = @"leftJun";
        _leftJun.ButtonForPosition = self.memberA2;
       

    }return _leftJun;
}
-(PositionView *)leftMid{
    if (!_leftMid) {
        _leftMid= [[PositionView alloc]initWithFrame:CGRectMake(5,40+(btnSize+20)*2 , btnSize, btnSize)];
        _leftMid.PositionKey = @"leftMid";
        _leftMid.ButtonForPosition = self.memberA3;
      
    }return _leftMid;
}
-(PositionView *)leftAd{
    if (!_leftAd) {
        _leftAd= [[PositionView alloc]initWithFrame:CGRectMake(5,40+(btnSize+20)*3 , btnSize, btnSize)];
        _leftAd.PositionKey = @"leftAd";
        _leftAd.ButtonForPosition = self.memberA4;
     
    }return _leftAd;
}
-(PositionView *)leftSup{
    if (!_leftSup) {
        _leftSup = [[PositionView alloc]initWithFrame:CGRectMake(5,40+(btnSize+20)*4, btnSize, btnSize)];
        _leftSup.PositionKey = @"leftSup";
        _leftSup.ButtonForPosition = self.memberA5;
     
    }return _leftSup;
}

-(PositionView *)rightTop{
    if (!_rightTop) {
        _rightTop = [[PositionView alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize,40 , btnSize, btnSize)];
        _rightTop.PositionKey = @"rightTop";
        _rightTop.ButtonForPosition = self.memberB1;
    }return _rightTop;
}
-(PositionView *)rightJun{
    if (!_rightJun) {
        _rightJun = [[PositionView alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize,40+btnSize+20 , btnSize, btnSize)];
        _rightJun.PositionKey = @"rightJun";
        _rightJun.ButtonForPosition = self.memberB2;
    }return _rightJun;
}
-(PositionView *)rightMid{
    if (!_rightMid) {
        _rightMid= [[PositionView alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize,40+(btnSize+20)*2 , btnSize, btnSize)];
        _rightMid.PositionKey = @"rightMid";
        _rightMid.ButtonForPosition = self.memberB3;
    }return _rightMid;
}
-(PositionView *)rightAd{
    if (!_rightAd) {
        _rightAd= [[PositionView alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize,40+(btnSize+20)*3 , btnSize, btnSize)];
        _rightAd.PositionKey = @"rightAd";
        _rightAd.ButtonForPosition = self.memberB4;
    }return _rightAd;
}
-(PositionView *)rightSup{
    if (!_rightSup) {
        _rightSup = [[PositionView alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize,40+(btnSize+20)*4, btnSize, btnSize)];
        _rightSup.PositionKey = @"rightSup";
        _rightSup.ButtonForPosition = self.memberB5;
    }return _rightSup;
}

-(UIPanGestureRecognizer *)ButtonGuestureA1{
    if (!_ButtonGuestureA1) {
        _ButtonGuestureA1 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragLeft:)];
        _ButtonGuestureA1.delegate = self;
        _ButtonGuestureA1.maximumNumberOfTouches = 1;
    }return _ButtonGuestureA1;
}
-(UIPanGestureRecognizer *)ButtonGuestureA2{
    if (!_ButtonGuestureA2) {
        _ButtonGuestureA2 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragLeft:)];
        _ButtonGuestureA2.delegate = self;
        _ButtonGuestureA2.maximumNumberOfTouches = 1;
    }return _ButtonGuestureA2;
}
-(UIPanGestureRecognizer *)ButtonGuestureA3{
    if (!_ButtonGuestureA3) {
        _ButtonGuestureA3 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragLeft:)];
        _ButtonGuestureA3.delegate = self;
        _ButtonGuestureA3.maximumNumberOfTouches = 1;
    }return _ButtonGuestureA3;
}
-(UIPanGestureRecognizer *)ButtonGuestureA4{
    if (!_ButtonGuestureA4) {
        _ButtonGuestureA4 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragLeft:)];
        _ButtonGuestureA4.delegate = self;
        _ButtonGuestureA4.maximumNumberOfTouches = 1;
    }return _ButtonGuestureA4;
}
-(UIPanGestureRecognizer *)ButtonGuestureA5{
    if (!_ButtonGuestureA5) {
        _ButtonGuestureA5 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragLeft:)];
        _ButtonGuestureA5.delegate = self;
        _ButtonGuestureA5.maximumNumberOfTouches = 1;
    }return _ButtonGuestureA5;
}

-(UIPanGestureRecognizer *)ButtonGuestureB1{
    if (!_ButtonGuestureB1) {
        _ButtonGuestureB1 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragRight:)];
        _ButtonGuestureB1.delegate = self;
        _ButtonGuestureB1.maximumNumberOfTouches = 1;
    }return _ButtonGuestureB1;
}
-(UIPanGestureRecognizer *)ButtonGuestureB2{
    if (!_ButtonGuestureB2) {
        _ButtonGuestureB2 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragRight:)];
        _ButtonGuestureB2.delegate = self;
        _ButtonGuestureB2.maximumNumberOfTouches = 1;
    }return _ButtonGuestureB2;
}
-(UIPanGestureRecognizer *)ButtonGuestureB3{
    if (!_ButtonGuestureB3) {
        _ButtonGuestureB3 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragRight:)];
        _ButtonGuestureB3.delegate = self;
        _ButtonGuestureB3.maximumNumberOfTouches = 1;
    }return _ButtonGuestureB3;
}
-(UIPanGestureRecognizer *)ButtonGuestureB4{
    if (!_ButtonGuestureB4) {
        _ButtonGuestureB4 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragRight:)];
        _ButtonGuestureB4.delegate = self;
                _ButtonGuestureB4.maximumNumberOfTouches = 1;
    }return _ButtonGuestureB4;
}
-(UIPanGestureRecognizer *)ButtonGuestureB5{
    if (!_ButtonGuestureB5) {
        _ButtonGuestureB5 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragRight:)];
        _ButtonGuestureB5.delegate = self;
                _ButtonGuestureB5.maximumNumberOfTouches = 1;
    }return _ButtonGuestureB5;
}

-(NSMutableArray *)exchangeArr{
    if (!_exchangeArr) {
        _exchangeArr = [NSMutableArray arrayWithCapacity:2];
    }return _exchangeArr;
}
-(HeroButton *)memberA1{
    if (!_memberA1) {
        _memberA1 = [[HeroButton alloc]initWithFrame:CGRectMake(5,40 , btnSize, btnSize)];
        [_memberA1 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateNormal];
        [_memberA1 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateDisabled];
        [_memberA1 addGestureRecognizer:self.ButtonGuestureA1];
        
    } return _memberA1;
}
-(HeroButton *)memberA2{
    if (!_memberA2) {
        _memberA2 = [[HeroButton alloc]initWithFrame:CGRectMake(5,40+btnSize+20 , btnSize, btnSize)];
        [_memberA2 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateNormal];
        [_memberA2 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateDisabled];
        [_memberA2 addGestureRecognizer:self.ButtonGuestureA2];
    } return _memberA2;
}
-(HeroButton *)memberA3{
    if (!_memberA3) {
        _memberA3 = [[HeroButton alloc]initWithFrame:CGRectMake(5,40+(btnSize+20)*2 , btnSize, btnSize)];
        [_memberA3 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateDisabled];
        [_memberA3 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateNormal];
        [_memberA3 addGestureRecognizer:self.ButtonGuestureA3];
    } return _memberA3;
}
-(HeroButton *)memberA4{
    if (!_memberA4) {
        _memberA4 = [[HeroButton alloc]initWithFrame:CGRectMake(5,40+(btnSize+20)*3 , btnSize, btnSize)];
        [_memberA4 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateNormal];
        [_memberA4 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateDisabled];
        [_memberA4 addGestureRecognizer:self.ButtonGuestureA4];
    } return _memberA4;
}
-(HeroButton *)memberA5{
    if (!_memberA5) {
        _memberA5 = [[HeroButton alloc]initWithFrame:CGRectMake(5,40+(btnSize+20)*4 , btnSize, btnSize)];
        [_memberA5 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateNormal];
        [_memberA5 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateDisabled];
        [_memberA5 addGestureRecognizer:self.ButtonGuestureA5];
    } return _memberA5;
}

-(HeroButton *)memberB1{
    if (!_memberB1) {
        _memberB1 = [[HeroButton alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize,40 , btnSize, btnSize)];
        [_memberB1 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateNormal];
        [_memberB1 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateDisabled];
        [_memberB1 addGestureRecognizer:self.ButtonGuestureB1];
    } return _memberB1;
}
-(HeroButton *)memberB2{
    if (!_memberB2) {
        _memberB2 = [[HeroButton alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize,40+btnSize+20 , btnSize, btnSize)];
        [_memberB2 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateNormal];
        [_memberB2 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateDisabled];
        [_memberB2 addGestureRecognizer:self.ButtonGuestureB2];
    } return _memberB2;
}
-(HeroButton *)memberB3{
    if (!_memberB3) {
        _memberB3 = [[HeroButton alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize,40+(btnSize+20)*2 , btnSize, btnSize)];
        [_memberB3 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateNormal];
        [_memberB3 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateDisabled];
        [_memberB3 addGestureRecognizer:self.ButtonGuestureB3];
    } return _memberB3;
}
-(HeroButton *)memberB4{
    if (!_memberB4) {
        _memberB4 = [[HeroButton alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize,40+(btnSize+20)*3 , btnSize, btnSize)];
        [_memberB4 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateNormal];
        [_memberB4 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateDisabled];
        [_memberB4 addGestureRecognizer:self.ButtonGuestureB4];
    } return _memberB4;
}
-(HeroButton *)memberB5{
    if (!_memberB5) {
        _memberB5 = [[HeroButton alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize,40+(btnSize+20)*4 , btnSize, btnSize)];
        [_memberB5 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateNormal];
        [_memberB5 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateDisabled];
        [_memberB5 addGestureRecognizer:self.ButtonGuestureB5];
    } return _memberB5;
}


#pragma mark 拖拽方法
- (void)dragRight:(UIPanGestureRecognizer *)gesture{
    CGPoint translation = [gesture translationInView:gesture.view];
    gesture.view.transform = CGAffineTransformTranslate(gesture.view.transform,translation.x, translation.y);
    [gesture setTranslation:CGPointZero inView:gesture.view];
        if (gesture.state == UIGestureRecognizerStateEnded) {
        CGFloat moved =  gesture.view.frame.origin.y;
        //-------------------上单
        if (moved<(self.rightTop.frame.origin.y+btnSize)){
            CGFloat tx = screenWidth-5-btnSize - gesture.view.frame.origin.x;
            CGFloat ty = 40 - gesture.view.frame.origin.y;
            [UIView animateWithDuration:0.5 animations:^{
                gesture.view.transform = CGAffineTransformTranslate(gesture.view.transform, tx, ty);
                //判断拖动的是哪个按钮
                //拖动按钮后按钮会从最上层移动到positionview的下面导致无法点击
                if ([gesture.view isEqual:self.rightJun.ButtonForPosition]) {
                    self.rightTop.ButtonForPosition.transform = CGAffineTransformTranslate(self.rightTop.ButtonForPosition.transform, 0,btnSize+20);
                    
                    HeroButton*temp =  self.rightTop.ButtonForPosition;
                    self.rightTop.ButtonForPosition = self.rightJun.ButtonForPosition;
                    self.rightJun.ButtonForPosition = temp;
                    [self.rightTop.ButtonForPosition removeFromSuperview];
                    [self.rightJun.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightTop.ButtonForPosition];
                    [self addSubview:self.rightJun.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionRight::)]) {
                        [self.delegate changePositionRight:self.rightTop.ButtonForPosition.HeroForButton :self.rightTop.PositionKey];
                        [self.delegate changePositionRight:self.rightJun.ButtonForPosition.HeroForButton :self.rightJun.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.rightMid.ButtonForPosition]){
                    self.rightTop.ButtonForPosition.transform = CGAffineTransformTranslate(self.rightTop.ButtonForPosition.transform, 0,(btnSize+20)*2);
                    HeroButton*temp =  self.rightTop.ButtonForPosition;
                    self.rightTop.ButtonForPosition = self.rightMid.ButtonForPosition;
                    self.rightMid.ButtonForPosition = temp;
                    [self.rightTop.ButtonForPosition removeFromSuperview];
                    [self.rightMid.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightTop.ButtonForPosition];
                    [self addSubview:self.rightMid.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionRight::)]) {
                        [self.delegate changePositionRight:self.rightTop.ButtonForPosition.HeroForButton :self.rightTop.PositionKey];
                        [self.delegate changePositionRight:self.rightMid.ButtonForPosition.HeroForButton :self.rightMid.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.rightAd.ButtonForPosition]){
                    self.rightTop.ButtonForPosition.transform = CGAffineTransformTranslate(self.rightTop.ButtonForPosition.transform,0 , (btnSize+20)*3);
                    HeroButton* temp =  self.rightTop.ButtonForPosition;
                    self.rightTop.ButtonForPosition = self.rightAd.ButtonForPosition;
                    self.rightAd.ButtonForPosition = temp;
                    [self.rightTop.ButtonForPosition removeFromSuperview];
                    [self.rightAd.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightTop.ButtonForPosition];
                    [self addSubview:self.rightAd.ButtonForPosition];
                    
                    if ([self.delegate respondsToSelector:@selector(changePositionRight::)]) {
                        [self.delegate changePositionRight:self.rightTop.ButtonForPosition.HeroForButton :self.rightTop.PositionKey];
                        [self.delegate changePositionRight:self.rightAd.ButtonForPosition.HeroForButton :self.rightAd.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.rightSup.ButtonForPosition]){
                    self.rightTop.ButtonForPosition.transform = CGAffineTransformTranslate(self.rightTop.ButtonForPosition.transform, 0, (btnSize+20)*4);
                    HeroButton*temp =  self.rightTop.ButtonForPosition;
                    self.rightTop.ButtonForPosition = self.rightSup.ButtonForPosition;
                    self.rightSup.ButtonForPosition = temp;
                    [self.rightTop.ButtonForPosition removeFromSuperview];
                    [self.rightSup.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightTop.ButtonForPosition];
                    [self addSubview:self.rightSup.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionRight::)]) {
                        [self.delegate changePositionRight:self.rightTop.ButtonForPosition.HeroForButton :self.rightTop.PositionKey];
                        [self.delegate changePositionRight:self.rightSup.ButtonForPosition.HeroForButton :self.rightSup.PositionKey];
                    }
                    
                }else{
                    [self.rightTop.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightTop.ButtonForPosition];
                }
                
                
                
                
                
            }];
        }
        //-------------------打野
        else if((moved>=(self.rightTop.frame.origin.y+btnSize))&&(moved<(self.rightJun.frame.origin.y+btnSize))){
            CGFloat tx = screenWidth-5-btnSize - gesture.view.frame.origin.x;
            CGFloat ty = 60+btnSize - gesture.view.frame.origin.y;
            [UIView animateWithDuration:0.5 animations:^{
                gesture.view.transform = CGAffineTransformTranslate(gesture.view.transform, tx, ty);
                if ([gesture.view isEqual:self.rightTop.ButtonForPosition]) {
                    self.rightJun.ButtonForPosition.transform = CGAffineTransformTranslate(self.rightJun.ButtonForPosition.transform, 0,-(btnSize+20));
                    
                    HeroButton*temp = self.rightJun.ButtonForPosition;
                    self.rightJun.ButtonForPosition = self.rightTop.ButtonForPosition;
                    self.rightTop.ButtonForPosition = temp;
                    [self.rightJun.ButtonForPosition removeFromSuperview];
                    [self.rightTop.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightJun.ButtonForPosition];
                    [self addSubview:self.rightTop.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionRight::)]) {
                        [self.delegate changePositionRight:self.rightTop.ButtonForPosition.HeroForButton :self.rightTop.PositionKey];
                        [self.delegate changePositionRight:self.rightJun.ButtonForPosition.HeroForButton :self.rightJun.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.rightMid.ButtonForPosition]){
                    self.rightJun.ButtonForPosition.transform = CGAffineTransformTranslate(self.rightJun.ButtonForPosition.transform, 0,(btnSize+20));
                    HeroButton*temp =  self.rightJun.ButtonForPosition;
                    self.rightJun.ButtonForPosition = self.rightMid.ButtonForPosition;
                    self.rightMid.ButtonForPosition = temp;
                    [self.rightMid.ButtonForPosition removeFromSuperview];
                    [self.rightJun.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightMid.ButtonForPosition];
                    [self addSubview:self.rightJun.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionRight::)]) {
                        [self.delegate changePositionRight:self.rightJun.ButtonForPosition.HeroForButton :self.rightJun.PositionKey];
                        [self.delegate changePositionRight:self.rightMid.ButtonForPosition.HeroForButton :self.rightMid.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.rightAd.ButtonForPosition]){
                    self.rightJun.ButtonForPosition.transform = CGAffineTransformTranslate(self.rightJun.ButtonForPosition.transform,0 , (btnSize+20)*2);
                    HeroButton* temp =  self.rightJun.ButtonForPosition;
                    self.rightJun.ButtonForPosition = self.rightAd.ButtonForPosition;
                    self.rightAd.ButtonForPosition = temp;
                    [self.rightAd.ButtonForPosition removeFromSuperview];
                    [self.rightJun.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightAd.ButtonForPosition];
                    [self addSubview:self.rightJun.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionRight::)]) {
                        [self.delegate changePositionRight:self.rightJun.ButtonForPosition.HeroForButton :self.rightJun.PositionKey];
                        [self.delegate changePositionRight:self.rightAd.ButtonForPosition.HeroForButton :self.rightAd.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.rightSup.ButtonForPosition]){
                    self.rightJun.ButtonForPosition.transform = CGAffineTransformTranslate(self.rightJun.ButtonForPosition.transform, 0, (btnSize+20)*3);
                    HeroButton*temp =  self.rightJun.ButtonForPosition;
                    self.rightJun.ButtonForPosition = self.rightSup.ButtonForPosition;
                    self.rightSup.ButtonForPosition = temp;
                    [self.rightSup.ButtonForPosition removeFromSuperview];
                    [self.rightJun.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightSup.ButtonForPosition];
                    [self addSubview:self.rightJun.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionRight::)]) {
                        [self.delegate changePositionRight:self.rightJun.ButtonForPosition.HeroForButton :self.rightJun.PositionKey];
                        [self.delegate changePositionRight:self.rightSup.ButtonForPosition.HeroForButton :self.rightSup.PositionKey];
                    }
                    
                }else{      [self.rightJun.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightJun.ButtonForPosition];
                }
                
                
            }];
        }
        //-------------------中单
        else if((moved>=(self.rightJun.frame.origin.y+btnSize))&&(moved<(self.rightMid.frame.origin.y+btnSize))){
            CGFloat tx = screenWidth-5-btnSize - gesture.view.frame.origin.x;
            CGFloat ty = 80+btnSize*2 - gesture.view.frame.origin.y;
            [UIView animateWithDuration:0.5 animations:^{
                gesture.view.transform = CGAffineTransformTranslate(gesture.view.transform, tx, ty);
                if ([gesture.view isEqual:self.rightTop.ButtonForPosition]) {
                    self.rightMid.ButtonForPosition.transform = CGAffineTransformTranslate(self.rightMid.ButtonForPosition.transform, 0,-(btnSize+20)*2);
                    
                    HeroButton*temp =  self.rightMid.ButtonForPosition;
                    self.rightMid.ButtonForPosition = self.rightTop.ButtonForPosition;
                    self.rightTop.ButtonForPosition = temp;
                    [self.rightMid.ButtonForPosition removeFromSuperview];
                    [self.rightTop.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightMid.ButtonForPosition];
                    [self addSubview:self.rightTop.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionRight::)]) {
                        [self.delegate changePositionRight:self.rightTop.ButtonForPosition.HeroForButton :self.rightTop.PositionKey];
                        [self.delegate changePositionRight:self.rightMid.ButtonForPosition.HeroForButton :self.rightMid.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.rightJun.ButtonForPosition]){
                    self.rightMid.ButtonForPosition.transform = CGAffineTransformTranslate(self.rightMid.ButtonForPosition.transform, 0,-(btnSize+20));
                    HeroButton*temp = self.rightMid.ButtonForPosition;
                    self.rightMid.ButtonForPosition = self.rightJun.ButtonForPosition;
                    self.rightJun.ButtonForPosition = temp;
                    [self.rightMid.ButtonForPosition removeFromSuperview];
                    [self.rightJun.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightMid.ButtonForPosition];
                    [self addSubview:self.rightJun.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionRight::)]) {
                        [self.delegate changePositionRight:self.rightJun.ButtonForPosition.HeroForButton :self.rightJun.PositionKey];
                        [self.delegate changePositionRight:self.rightMid.ButtonForPosition.HeroForButton :self.rightMid.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.rightAd.ButtonForPosition]){
                    self.rightMid.ButtonForPosition.transform = CGAffineTransformTranslate(self.rightMid.ButtonForPosition.transform,0 , (btnSize+20));
                    HeroButton* temp = self.rightMid.ButtonForPosition;
                    self.rightMid.ButtonForPosition = self.rightAd.ButtonForPosition;
                    self.rightAd.ButtonForPosition = temp;
                    [self.rightAd.ButtonForPosition removeFromSuperview];
                    [self.rightMid.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightAd.ButtonForPosition];
                    [self addSubview:self.rightMid.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionRight::)]) {
                        [self.delegate changePositionRight:self.rightMid.ButtonForPosition.HeroForButton :self.rightMid.PositionKey];
                        [self.delegate changePositionRight:self.rightAd.ButtonForPosition.HeroForButton :self.rightAd.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.rightSup.ButtonForPosition]){
                    self.rightMid.ButtonForPosition.transform = CGAffineTransformTranslate(self.rightMid.ButtonForPosition.transform, 0, (btnSize+20)*2);
                    HeroButton*temp =  self.rightMid.ButtonForPosition;
                    self.rightMid.ButtonForPosition = self.rightSup.ButtonForPosition;
                    self.rightSup.ButtonForPosition = temp;
                    [self.rightSup.ButtonForPosition removeFromSuperview];
                    [self.rightMid.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightSup.ButtonForPosition];
                    [self addSubview:self.rightMid.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionRight::)]) {
                        [self.delegate changePositionRight:self.rightMid.ButtonForPosition.HeroForButton :self.rightMid.PositionKey];
                        [self.delegate changePositionRight:self.rightSup.ButtonForPosition.HeroForButton :self.rightSup.PositionKey];
                    }
                    
                }else{
                    [self.rightMid.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightMid.ButtonForPosition];
                }
            }];
            
        }
        //-------------------AD
        else if((moved>=(self.rightMid.frame.origin.y+btnSize))&&(moved<(self.rightAd.frame.origin.y+btnSize))){
            CGFloat tx = screenWidth-5-btnSize - gesture.view.frame.origin.x;
            CGFloat ty = 100+btnSize*3 - gesture.view.frame.origin.y;
            [UIView animateWithDuration:0.5 animations:^{
                gesture.view.transform = CGAffineTransformTranslate(gesture.view.transform, tx, ty);
                if ([gesture.view isEqual:self.rightTop.ButtonForPosition]) {
                    self.rightAd.ButtonForPosition.transform = CGAffineTransformTranslate(self.rightAd.ButtonForPosition.transform, 0,-(btnSize+20)*3);
                    HeroButton*temp =  self.rightAd.ButtonForPosition;
                    self.rightAd.ButtonForPosition = self.rightTop.ButtonForPosition;
                    self.rightTop.ButtonForPosition = temp;
                    [self.rightAd.ButtonForPosition removeFromSuperview];
                    [self.rightTop.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightAd.ButtonForPosition];
                    [self addSubview:self.rightTop.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionRight::)]) {
                        [self.delegate changePositionRight:self.rightTop.ButtonForPosition.HeroForButton :self.rightTop.PositionKey];
                        [self.delegate changePositionRight:self.rightAd.ButtonForPosition.HeroForButton :self.rightAd.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.rightJun.ButtonForPosition]){
                    self.rightAd.ButtonForPosition.transform = CGAffineTransformTranslate(self.rightAd.ButtonForPosition.transform, 0,-(btnSize+20)*2);
                    HeroButton*temp = self.rightAd.ButtonForPosition;
                    self.rightAd.ButtonForPosition = self.rightJun.ButtonForPosition;
                    self.rightJun.ButtonForPosition = temp;
                    [self.rightAd.ButtonForPosition removeFromSuperview];
                    [self.rightJun.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightAd.ButtonForPosition];
                    [self addSubview:self.rightJun.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionRight::)]) {
                        [self.delegate changePositionRight:self.rightJun.ButtonForPosition.HeroForButton :self.rightJun.PositionKey];
                        [self.delegate changePositionRight:self.rightAd.ButtonForPosition.HeroForButton :self.rightAd.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.rightMid.ButtonForPosition]){
                    self.rightAd.ButtonForPosition.transform = CGAffineTransformTranslate(self.rightAd.ButtonForPosition.transform,0 , -(btnSize+20));
                    HeroButton* temp = self.rightAd.ButtonForPosition;
                    self.rightAd.ButtonForPosition = self.rightMid.ButtonForPosition;
                    self.rightMid.ButtonForPosition = temp;
                    [self.rightAd.ButtonForPosition removeFromSuperview];
                    [self.rightMid.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightAd.ButtonForPosition];
                    [self addSubview:self.rightMid.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionRight::)]) {
                        [self.delegate changePositionRight:self.rightMid.ButtonForPosition.HeroForButton :self.rightMid.PositionKey];
                        [self.delegate changePositionRight:self.rightAd.ButtonForPosition.HeroForButton :self.rightAd.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.rightSup.ButtonForPosition]){
                    self.rightAd.ButtonForPosition.transform = CGAffineTransformTranslate(self.rightAd.ButtonForPosition.transform, 0, (btnSize+20));
                    HeroButton*temp =  self.rightAd.ButtonForPosition;
                    self.rightAd.ButtonForPosition = self.rightSup.ButtonForPosition;
                    self.rightSup.ButtonForPosition = temp;
                    [self.rightSup.ButtonForPosition removeFromSuperview];
                    [self.rightAd.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightSup.ButtonForPosition];
                    [self addSubview:self.rightAd.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionRight::)]) {
                        [self.delegate changePositionRight:self.rightAd.ButtonForPosition.HeroForButton :self.rightAd.PositionKey];
                        [self.delegate changePositionRight:self.rightSup.ButtonForPosition.HeroForButton :self.rightSup.PositionKey];
                    }
                    
                }else{
                    [self.rightAd.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightAd.ButtonForPosition];}
            }];
        }
        //------------------辅助
        else {
            CGFloat tx = screenWidth-5-btnSize - gesture.view.frame.origin.x;
            CGFloat ty = 120+btnSize*4 - gesture.view.frame.origin.y;
            [UIView animateWithDuration:0.5 animations:^{
                gesture.view.transform = CGAffineTransformTranslate(gesture.view.transform, tx, ty);
                
                if ([gesture.view isEqual:self.rightTop.ButtonForPosition]) {
                    self.rightSup.ButtonForPosition.transform = CGAffineTransformTranslate(self.rightSup.ButtonForPosition.transform, 0,-(btnSize+20)*4);
                    HeroButton*temp = self.rightSup.ButtonForPosition;
                    self.rightSup.ButtonForPosition = self.rightTop.ButtonForPosition;
                    self.rightTop.ButtonForPosition = temp;
                    [self.rightSup.ButtonForPosition removeFromSuperview];
                    [self.rightTop.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightSup.ButtonForPosition];
                    [self addSubview:self.rightTop.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionRight::)]) {
                        [self.delegate changePositionRight:self.rightTop.ButtonForPosition.HeroForButton :self.rightTop.PositionKey];
                        [self.delegate changePositionRight:self.rightSup.ButtonForPosition.HeroForButton :self.rightSup.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.rightJun.ButtonForPosition]){
                    self.rightSup.ButtonForPosition.transform = CGAffineTransformTranslate(self.rightSup.ButtonForPosition.transform, 0,-(btnSize+20)*3);
                    HeroButton*temp = self.rightSup.ButtonForPosition;
                    self.rightSup.ButtonForPosition = self.rightJun.ButtonForPosition;
                    self.rightJun.ButtonForPosition = temp;
                    [self.rightSup.ButtonForPosition removeFromSuperview];
                    [self.rightJun.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightSup.ButtonForPosition];
                    [self addSubview:self.rightJun.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionRight::)]) {
                        [self.delegate changePositionRight:self.rightJun.ButtonForPosition.HeroForButton :self.rightJun.PositionKey];
                        [self.delegate changePositionRight:self.rightSup.ButtonForPosition.HeroForButton :self.rightSup.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.rightMid.ButtonForPosition]){
                    self.rightSup.ButtonForPosition.transform = CGAffineTransformTranslate(self.rightSup.ButtonForPosition.transform,0 , -(btnSize+20)*2);
                    HeroButton* temp = self.rightSup.ButtonForPosition;
                    self.rightSup.ButtonForPosition = self.rightMid.ButtonForPosition;
                    self.rightMid.ButtonForPosition = temp;
                    [self.rightSup.ButtonForPosition removeFromSuperview];
                    [self.rightMid.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightSup.ButtonForPosition];
                    [self addSubview:self.rightMid.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionRight::)]) {
                        [self.delegate changePositionRight:self.rightMid.ButtonForPosition.HeroForButton :self.rightMid.PositionKey];
                        [self.delegate changePositionRight:self.rightSup.ButtonForPosition.HeroForButton :self.rightSup.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.rightAd.ButtonForPosition]){
                    self.rightSup.ButtonForPosition.transform = CGAffineTransformTranslate(self.rightSup.ButtonForPosition.transform, 0, -(btnSize+20));
                    HeroButton*temp =  self.rightSup.ButtonForPosition;
                    self.rightSup.ButtonForPosition = self.rightAd.ButtonForPosition;
                    self.rightAd.ButtonForPosition = temp;
                    [self.rightSup.ButtonForPosition removeFromSuperview];
                    [self.rightAd.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightSup.ButtonForPosition];
                    [self addSubview:self.rightAd.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionRight::)]) {
                        [self.delegate changePositionRight:self.rightAd.ButtonForPosition.HeroForButton :self.rightAd.PositionKey];
                        [self.delegate changePositionRight:self.rightSup.ButtonForPosition.HeroForButton :self.rightSup.PositionKey];
                    }
                    
                }else{
                    [self.rightSup.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.rightSup.ButtonForPosition];}
            }];
            
            
        }
    }
}

- (void)dragLeft:(UIPanGestureRecognizer *)gesture{
    //1.禁用多点触摸(或者不能同时拖拽多个按钮)
   //2.两个按钮交换解决
        CGPoint translation = [gesture translationInView:gesture.view];
            gesture.view.transform = CGAffineTransformTranslate(gesture.view.transform,translation.x, translation.y);
     [gesture setTranslation:CGPointZero inView:gesture.view];
    if (gesture.state == UIGestureRecognizerStateEnded) {
        CGFloat moved =  gesture.view.frame.origin.y;
        //-------------------上单
        if (moved<(self.leftTop.frame.origin.y+btnSize)){
            CGFloat tx = 5 - gesture.view.frame.origin.x;
            CGFloat ty = 40 - gesture.view.frame.origin.y;
            [UIView animateWithDuration:0.5 animations:^{
                gesture.view.transform = CGAffineTransformTranslate(gesture.view.transform, tx, ty);
                //判断拖动的是哪个按钮
                //拖动按钮后按钮会从最上层移动到positionview的下面导致无法点击
                if ([gesture.view isEqual:self.leftJun.ButtonForPosition]) {
                    self.leftTop.ButtonForPosition.transform = CGAffineTransformTranslate(self.leftTop.ButtonForPosition.transform, 0,btnSize+20);
                   
                    HeroButton*temp =  self.leftTop.ButtonForPosition;
                    self.leftTop.ButtonForPosition = self.leftJun.ButtonForPosition;
                    self.leftJun.ButtonForPosition = temp;
                    [self.leftTop.ButtonForPosition removeFromSuperview];
                    [self.leftJun.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftTop.ButtonForPosition];
                    [self addSubview:self.leftJun.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionLeft::)]) {
                        [self.delegate changePositionLeft:self.leftTop.ButtonForPosition.HeroForButton :self.leftTop.PositionKey];
                        [self.delegate changePositionLeft:self.leftJun.ButtonForPosition.HeroForButton :self.leftJun.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.leftMid.ButtonForPosition]){
                    self.leftTop.ButtonForPosition.transform = CGAffineTransformTranslate(self.leftTop.ButtonForPosition.transform, 0,(btnSize+20)*2);
                    HeroButton*temp =  self.leftTop.ButtonForPosition;
                    self.leftTop.ButtonForPosition = self.leftMid.ButtonForPosition;
                    self.leftMid.ButtonForPosition = temp;
                    [self.leftTop.ButtonForPosition removeFromSuperview];
                    [self.leftMid.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftTop.ButtonForPosition];
                    [self addSubview:self.leftMid.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionLeft::)]) {
                        [self.delegate changePositionLeft:self.leftTop.ButtonForPosition.HeroForButton :self.leftTop.PositionKey];
                        [self.delegate changePositionLeft:self.leftMid.ButtonForPosition.HeroForButton :self.leftMid.PositionKey];
                    }

                }else if([gesture.view isEqual:self.leftAd.ButtonForPosition]){
                    self.leftTop.ButtonForPosition.transform = CGAffineTransformTranslate(self.leftTop.ButtonForPosition.transform,0 , (btnSize+20)*3);
                    HeroButton* temp =  self.leftTop.ButtonForPosition;
                    self.leftTop.ButtonForPosition = self.leftAd.ButtonForPosition;
                    self.leftAd.ButtonForPosition = temp;
                    [self.leftTop.ButtonForPosition removeFromSuperview];
                    [self.leftAd.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftTop.ButtonForPosition];
                    [self addSubview:self.leftAd.ButtonForPosition];

                    if ([self.delegate respondsToSelector:@selector(changePositionLeft::)]) {
                        [self.delegate changePositionLeft:self.leftTop.ButtonForPosition.HeroForButton :self.leftTop.PositionKey];
                        [self.delegate changePositionLeft:self.leftAd.ButtonForPosition.HeroForButton :self.leftAd.PositionKey];
                    }

                }else if([gesture.view isEqual:self.leftSup.ButtonForPosition]){
                    self.leftTop.ButtonForPosition.transform = CGAffineTransformTranslate(self.leftTop.ButtonForPosition.transform, 0, (btnSize+20)*4);
                    HeroButton*temp =  self.leftTop.ButtonForPosition;
                    self.leftTop.ButtonForPosition = self.leftSup.ButtonForPosition;
                    self.leftSup.ButtonForPosition = temp;
                    [self.leftTop.ButtonForPosition removeFromSuperview];
                    [self.leftSup.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftTop.ButtonForPosition];
                    [self addSubview:self.leftSup.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionLeft::)]) {
                        [self.delegate changePositionLeft:self.leftTop.ButtonForPosition.HeroForButton :self.leftTop.PositionKey];
                        [self.delegate changePositionLeft:self.leftSup.ButtonForPosition.HeroForButton :self.leftSup.PositionKey];
                    }

                }else{
                    [self.leftTop.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftTop.ButtonForPosition];
                }
                
                
          
                
                
            }];
        }
        //-------------------打野
        else if((moved>=(self.leftTop.frame.origin.y+btnSize))&&(moved<(self.leftJun.frame.origin.y+btnSize))){
            CGFloat tx = 5 - gesture.view.frame.origin.x;
            CGFloat ty = 60+btnSize - gesture.view.frame.origin.y;
            [UIView animateWithDuration:0.5 animations:^{
                gesture.view.transform = CGAffineTransformTranslate(gesture.view.transform, tx, ty);
                if ([gesture.view isEqual:self.leftTop.ButtonForPosition]) {
                    self.leftJun.ButtonForPosition.transform = CGAffineTransformTranslate(self.leftJun.ButtonForPosition.transform, 0,-(btnSize+20));
                    
                    HeroButton*temp = self.leftJun.ButtonForPosition;
                    self.leftJun.ButtonForPosition = self.leftTop.ButtonForPosition;
                    self.leftTop.ButtonForPosition = temp;
                    [self.leftJun.ButtonForPosition removeFromSuperview];
                    [self.leftTop.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftJun.ButtonForPosition];
                    [self addSubview:self.leftTop.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionLeft::)]) {
                        [self.delegate changePositionLeft:self.leftTop.ButtonForPosition.HeroForButton :self.leftTop.PositionKey];
                        [self.delegate changePositionLeft:self.leftJun.ButtonForPosition.HeroForButton :self.leftJun.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.leftMid.ButtonForPosition]){
                    self.leftJun.ButtonForPosition.transform = CGAffineTransformTranslate(self.leftJun.ButtonForPosition.transform, 0,(btnSize+20));
                    HeroButton*temp =  self.leftJun.ButtonForPosition;
                    self.leftJun.ButtonForPosition = self.leftMid.ButtonForPosition;
                    self.leftMid.ButtonForPosition = temp;
                    [self.leftMid.ButtonForPosition removeFromSuperview];
                    [self.leftJun.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftMid.ButtonForPosition];
                    [self addSubview:self.leftJun.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionLeft::)]) {
                        [self.delegate changePositionLeft:self.leftJun.ButtonForPosition.HeroForButton :self.leftJun.PositionKey];
                        [self.delegate changePositionLeft:self.leftMid.ButtonForPosition.HeroForButton :self.leftMid.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.leftAd.ButtonForPosition]){
                    self.leftJun.ButtonForPosition.transform = CGAffineTransformTranslate(self.leftJun.ButtonForPosition.transform,0 , (btnSize+20)*2);
                    HeroButton* temp =  self.leftJun.ButtonForPosition;
                    self.leftJun.ButtonForPosition = self.leftAd.ButtonForPosition;
                    self.leftAd.ButtonForPosition = temp;
                    [self.leftAd.ButtonForPosition removeFromSuperview];
                    [self.leftJun.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftAd.ButtonForPosition];
                    [self addSubview:self.leftJun.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionLeft::)]) {
                        [self.delegate changePositionLeft:self.leftJun.ButtonForPosition.HeroForButton :self.leftJun.PositionKey];
                        [self.delegate changePositionLeft:self.leftAd.ButtonForPosition.HeroForButton :self.leftAd.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.leftSup.ButtonForPosition]){
                    self.leftJun.ButtonForPosition.transform = CGAffineTransformTranslate(self.leftJun.ButtonForPosition.transform, 0, (btnSize+20)*3);
                    HeroButton*temp =  self.leftJun.ButtonForPosition;
                    self.leftJun.ButtonForPosition = self.leftSup.ButtonForPosition;
                    self.leftSup.ButtonForPosition = temp;
                    [self.leftSup.ButtonForPosition removeFromSuperview];
                    [self.leftJun.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftSup.ButtonForPosition];
                    [self addSubview:self.leftJun.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionLeft::)]) {
                        [self.delegate changePositionLeft:self.leftJun.ButtonForPosition.HeroForButton :self.leftJun.PositionKey];
                        [self.delegate changePositionLeft:self.leftSup.ButtonForPosition.HeroForButton :self.leftSup.PositionKey];
                    }
                    
                }else{      [self.leftJun.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftJun.ButtonForPosition];
                }

                
            }];
        }
        //-------------------中单
        else if((moved>=(self.leftJun.frame.origin.y+btnSize))&&(moved<(self.leftMid.frame.origin.y+btnSize))){
            CGFloat tx = 5 - gesture.view.frame.origin.x;
            CGFloat ty = 80+btnSize*2 - gesture.view.frame.origin.y;
            [UIView animateWithDuration:0.5 animations:^{
                gesture.view.transform = CGAffineTransformTranslate(gesture.view.transform, tx, ty);
                if ([gesture.view isEqual:self.leftTop.ButtonForPosition]) {
                    self.leftMid.ButtonForPosition.transform = CGAffineTransformTranslate(self.leftMid.ButtonForPosition.transform, 0,-(btnSize+20)*2);
                    
                    HeroButton*temp =  self.leftMid.ButtonForPosition;
                    self.leftMid.ButtonForPosition = self.leftTop.ButtonForPosition;
                    self.leftTop.ButtonForPosition = temp;
                    [self.leftMid.ButtonForPosition removeFromSuperview];
                    [self.leftTop.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftMid.ButtonForPosition];
                    [self addSubview:self.leftTop.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionLeft::)]) {
                        [self.delegate changePositionLeft:self.leftTop.ButtonForPosition.HeroForButton :self.leftTop.PositionKey];
                        [self.delegate changePositionLeft:self.leftMid.ButtonForPosition.HeroForButton :self.leftMid.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.leftJun.ButtonForPosition]){
                    self.leftMid.ButtonForPosition.transform = CGAffineTransformTranslate(self.leftMid.ButtonForPosition.transform, 0,-(btnSize+20));
                    HeroButton*temp = self.leftMid.ButtonForPosition;
                    self.leftMid.ButtonForPosition = self.leftJun.ButtonForPosition;
                    self.leftJun.ButtonForPosition = temp;
                    [self.leftMid.ButtonForPosition removeFromSuperview];
                    [self.leftJun.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftMid.ButtonForPosition];
                    [self addSubview:self.leftJun.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionLeft::)]) {
                        [self.delegate changePositionLeft:self.leftJun.ButtonForPosition.HeroForButton :self.leftJun.PositionKey];
                        [self.delegate changePositionLeft:self.leftMid.ButtonForPosition.HeroForButton :self.leftMid.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.leftAd.ButtonForPosition]){
                    self.leftMid.ButtonForPosition.transform = CGAffineTransformTranslate(self.leftMid.ButtonForPosition.transform,0 , (btnSize+20));
                    HeroButton* temp = self.leftMid.ButtonForPosition;
                    self.leftMid.ButtonForPosition = self.leftAd.ButtonForPosition;
                    self.leftAd.ButtonForPosition = temp;
                    [self.leftAd.ButtonForPosition removeFromSuperview];
                    [self.leftMid.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftAd.ButtonForPosition];
                    [self addSubview:self.leftMid.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionLeft::)]) {
                        [self.delegate changePositionLeft:self.leftMid.ButtonForPosition.HeroForButton :self.leftMid.PositionKey];
                        [self.delegate changePositionLeft:self.leftAd.ButtonForPosition.HeroForButton :self.leftAd.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.leftSup.ButtonForPosition]){
                    self.leftMid.ButtonForPosition.transform = CGAffineTransformTranslate(self.leftMid.ButtonForPosition.transform, 0, (btnSize+20)*2);
                    HeroButton*temp =  self.leftMid.ButtonForPosition;
                    self.leftMid.ButtonForPosition = self.leftSup.ButtonForPosition;
                    self.leftSup.ButtonForPosition = temp;
                    [self.leftSup.ButtonForPosition removeFromSuperview];
                    [self.leftMid.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftSup.ButtonForPosition];
                    [self addSubview:self.leftMid.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionLeft::)]) {
                        [self.delegate changePositionLeft:self.leftMid.ButtonForPosition.HeroForButton :self.leftMid.PositionKey];
                        [self.delegate changePositionLeft:self.leftSup.ButtonForPosition.HeroForButton :self.leftSup.PositionKey];
                    }
                    
                }else{
                    [self.leftMid.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftMid.ButtonForPosition];
                }
            }];

        }
        //-------------------AD
        else if((moved>=(self.leftMid.frame.origin.y+btnSize))&&(moved<(self.leftAd.frame.origin.y+btnSize))){
            CGFloat tx = 5 - gesture.view.frame.origin.x;
            CGFloat ty = 100+btnSize*3 - gesture.view.frame.origin.y;
            [UIView animateWithDuration:0.5 animations:^{
                gesture.view.transform = CGAffineTransformTranslate(gesture.view.transform, tx, ty);
                if ([gesture.view isEqual:self.leftTop.ButtonForPosition]) {
                    self.leftAd.ButtonForPosition.transform = CGAffineTransformTranslate(self.leftAd.ButtonForPosition.transform, 0,-(btnSize+20)*3);
                    HeroButton*temp =  self.leftAd.ButtonForPosition;
                    self.leftAd.ButtonForPosition = self.leftTop.ButtonForPosition;
                    self.leftTop.ButtonForPosition = temp;
                    [self.leftAd.ButtonForPosition removeFromSuperview];
                    [self.leftTop.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftAd.ButtonForPosition];
                    [self addSubview:self.leftTop.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionLeft::)]) {
                        [self.delegate changePositionLeft:self.leftTop.ButtonForPosition.HeroForButton :self.leftTop.PositionKey];
                        [self.delegate changePositionLeft:self.leftAd.ButtonForPosition.HeroForButton :self.leftAd.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.leftJun.ButtonForPosition]){
                    self.leftAd.ButtonForPosition.transform = CGAffineTransformTranslate(self.leftAd.ButtonForPosition.transform, 0,-(btnSize+20)*2);
                    HeroButton*temp = self.leftAd.ButtonForPosition;
                    self.leftAd.ButtonForPosition = self.leftJun.ButtonForPosition;
                    self.leftJun.ButtonForPosition = temp;
                    [self.leftAd.ButtonForPosition removeFromSuperview];
                    [self.leftJun.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftAd.ButtonForPosition];
                    [self addSubview:self.leftJun.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionLeft::)]) {
                        [self.delegate changePositionLeft:self.leftJun.ButtonForPosition.HeroForButton :self.leftJun.PositionKey];
                        [self.delegate changePositionLeft:self.leftAd.ButtonForPosition.HeroForButton :self.leftAd.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.leftMid.ButtonForPosition]){
                    self.leftAd.ButtonForPosition.transform = CGAffineTransformTranslate(self.leftAd.ButtonForPosition.transform,0 , -(btnSize+20));
                    HeroButton* temp = self.leftAd.ButtonForPosition;
                    self.leftAd.ButtonForPosition = self.leftMid.ButtonForPosition;
                    self.leftMid.ButtonForPosition = temp;
                    [self.leftAd.ButtonForPosition removeFromSuperview];
                    [self.leftMid.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftAd.ButtonForPosition];
                    [self addSubview:self.leftMid.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionLeft::)]) {
                        [self.delegate changePositionLeft:self.leftMid.ButtonForPosition.HeroForButton :self.leftMid.PositionKey];
                        [self.delegate changePositionLeft:self.leftAd.ButtonForPosition.HeroForButton :self.leftAd.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.leftSup.ButtonForPosition]){
                    self.leftAd.ButtonForPosition.transform = CGAffineTransformTranslate(self.leftAd.ButtonForPosition.transform, 0, (btnSize+20));
                    HeroButton*temp =  self.leftAd.ButtonForPosition;
                    self.leftAd.ButtonForPosition = self.leftSup.ButtonForPosition;
                    self.leftSup.ButtonForPosition = temp;
                    [self.leftSup.ButtonForPosition removeFromSuperview];
                    [self.leftAd.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftSup.ButtonForPosition];
                    [self addSubview:self.leftAd.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionLeft::)]) {
                        [self.delegate changePositionLeft:self.leftAd.ButtonForPosition.HeroForButton :self.leftAd.PositionKey];
                        [self.delegate changePositionLeft:self.leftSup.ButtonForPosition.HeroForButton :self.leftSup.PositionKey];
                    }
                    
                }else{
                    [self.leftAd.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftAd.ButtonForPosition];}
            }];
        }
        //------------------辅助
        else {
            CGFloat tx = 5 - gesture.view.frame.origin.x;
            CGFloat ty = 120+btnSize*4 - gesture.view.frame.origin.y;
            [UIView animateWithDuration:0.5 animations:^{
                gesture.view.transform = CGAffineTransformTranslate(gesture.view.transform, tx, ty);
                
                if ([gesture.view isEqual:self.leftTop.ButtonForPosition]) {
                    self.leftSup.ButtonForPosition.transform = CGAffineTransformTranslate(self.leftSup.ButtonForPosition.transform, 0,-(btnSize+20)*4);
                    HeroButton*temp = self.leftSup.ButtonForPosition;
                    self.leftSup.ButtonForPosition = self.leftTop.ButtonForPosition;
                    self.leftTop.ButtonForPosition = temp;
                    [self.leftSup.ButtonForPosition removeFromSuperview];
                    [self.leftTop.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftSup.ButtonForPosition];
                    [self addSubview:self.leftTop.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionLeft::)]) {
                        [self.delegate changePositionLeft:self.leftTop.ButtonForPosition.HeroForButton :self.leftTop.PositionKey];
                        [self.delegate changePositionLeft:self.leftSup.ButtonForPosition.HeroForButton :self.leftSup.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.leftJun.ButtonForPosition]){
                    self.leftSup.ButtonForPosition.transform = CGAffineTransformTranslate(self.leftSup.ButtonForPosition.transform, 0,-(btnSize+20)*3);
                    HeroButton*temp = self.leftSup.ButtonForPosition;
                    self.leftSup.ButtonForPosition = self.leftJun.ButtonForPosition;
                    self.leftJun.ButtonForPosition = temp;
                    [self.leftSup.ButtonForPosition removeFromSuperview];
                    [self.leftJun.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftSup.ButtonForPosition];
                    [self addSubview:self.leftJun.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionLeft::)]) {
                        [self.delegate changePositionLeft:self.leftJun.ButtonForPosition.HeroForButton :self.leftJun.PositionKey];
                        [self.delegate changePositionLeft:self.leftSup.ButtonForPosition.HeroForButton :self.leftSup.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.leftMid.ButtonForPosition]){
                    self.leftSup.ButtonForPosition.transform = CGAffineTransformTranslate(self.leftSup.ButtonForPosition.transform,0 , -(btnSize+20)*2);
                    HeroButton* temp = self.leftSup.ButtonForPosition;
                    self.leftSup.ButtonForPosition = self.leftMid.ButtonForPosition;
                    self.leftMid.ButtonForPosition = temp;
                    [self.leftSup.ButtonForPosition removeFromSuperview];
                    [self.leftMid.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftSup.ButtonForPosition];
                    [self addSubview:self.leftMid.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionLeft::)]) {
                        [self.delegate changePositionLeft:self.leftMid.ButtonForPosition.HeroForButton :self.leftMid.PositionKey];
                        [self.delegate changePositionLeft:self.leftSup.ButtonForPosition.HeroForButton :self.leftSup.PositionKey];
                    }
                    
                }else if([gesture.view isEqual:self.leftAd.ButtonForPosition]){
                    self.leftSup.ButtonForPosition.transform = CGAffineTransformTranslate(self.leftSup.ButtonForPosition.transform, 0, -(btnSize+20));
                    HeroButton*temp =  self.leftSup.ButtonForPosition;
                    self.leftSup.ButtonForPosition = self.leftAd.ButtonForPosition;
                    self.leftAd.ButtonForPosition = temp;
                    [self.leftSup.ButtonForPosition removeFromSuperview];
                    [self.leftAd.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftSup.ButtonForPosition];
                    [self addSubview:self.leftAd.ButtonForPosition];
                    if ([self.delegate respondsToSelector:@selector(changePositionLeft::)]) {
                        [self.delegate changePositionLeft:self.leftAd.ButtonForPosition.HeroForButton :self.leftAd.PositionKey];
                        [self.delegate changePositionLeft:self.leftSup.ButtonForPosition.HeroForButton :self.leftSup.PositionKey];
                    }
                    
                }else{
                    [self.leftSup.ButtonForPosition removeFromSuperview];
                    [self addSubview:self.leftSup.ButtonForPosition];}
            }];

            
        }
    }
}
#pragma mark test方法

-(void)test{
    NSLog(@"%s",__func__);
}


@end
