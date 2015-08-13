//
//  ConlusionView.h
//  LOLAnalyzer
//
//  Created by soppysonny on 15/8/8.
//  Copyright (c) 2015年 soppysonny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeroButton.h"
#import "PositionView.h"
@class ConlusionView;
@protocol ChangePositionDelegate <NSObject>

@optional
-(void)changePositionLeft:(HeroModel*)hero :(NSString*)key;
-(void)changePositionRight:(HeroModel*)hero :(NSString*)key;
-(void)addAllTeam;
@end



@interface ConlusionView : UIVisualEffectView<UIGestureRecognizerDelegate>

@property (weak, nonatomic)id <ChangePositionDelegate> delegate;

@property (strong, nonatomic)PositionView* leftTop;
@property (strong, nonatomic)PositionView* leftJun;
@property (strong, nonatomic)PositionView* leftMid;
@property (strong, nonatomic)PositionView* leftAd;
@property (strong, nonatomic)PositionView* leftSup;

@property (strong, nonatomic)PositionView* rightTop;
@property (strong, nonatomic)PositionView* rightJun;
@property (strong, nonatomic)PositionView* rightMid;
@property (strong, nonatomic)PositionView* rightAd;
@property (strong, nonatomic)PositionView* rightSup;

@property (strong, nonatomic)HeroButton* memberA1;
@property (strong, nonatomic)HeroButton* memberA2;
@property (strong, nonatomic)HeroButton* memberA3;
@property (strong, nonatomic)HeroButton* memberA4;
@property (strong, nonatomic)HeroButton* memberA5;

@property (strong, nonatomic)HeroButton* memberB1;
@property (strong, nonatomic)HeroButton* memberB2;
@property (strong, nonatomic)HeroButton* memberB3;
@property (strong, nonatomic)HeroButton* memberB4;
@property (strong, nonatomic)HeroButton* memberB5;


@property (strong, nonatomic)NSMutableArray *exchangeArr;

@property (strong, nonatomic)UIPanGestureRecognizer *ButtonGuestureA1;
@property (strong, nonatomic)UIPanGestureRecognizer *ButtonGuestureA2;
@property (strong, nonatomic)UIPanGestureRecognizer *ButtonGuestureA3;
@property (strong, nonatomic)UIPanGestureRecognizer *ButtonGuestureA4;
@property (strong, nonatomic)UIPanGestureRecognizer *ButtonGuestureA5;

@property (strong, nonatomic)UIPanGestureRecognizer *ButtonGuestureB1;
@property (strong, nonatomic)UIPanGestureRecognizer *ButtonGuestureB2;
@property (strong, nonatomic)UIPanGestureRecognizer *ButtonGuestureB3;
@property (strong, nonatomic)UIPanGestureRecognizer *ButtonGuestureB4;
@property (strong, nonatomic)UIPanGestureRecognizer *ButtonGuestureB5;

@property (strong, nonatomic)UILabel *l1;
@property (strong, nonatomic)UILabel *l2;
@property (strong, nonatomic)UILabel *l3;
@property (strong, nonatomic)UILabel *l4;
@property (strong, nonatomic)UILabel *l5;

@property (strong, nonatomic)UILabel *l6;
@property (strong, nonatomic)UILabel *l7;
@property (strong, nonatomic)UILabel *l8;
@property (strong, nonatomic)UILabel *l9;
@property (strong, nonatomic)UILabel *l10;

@property (strong, nonatomic)UIButton *clearButton;

@end
