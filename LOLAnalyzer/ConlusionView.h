//
//  ConlusionView.h
//  LOLAnalyzer
//
//  Created by soppysonny on 15/8/8.
//  Copyright (c) 2015年 soppysonny. All rights reserved.
///

#import <UIKit/UIKit.h>
#import "HeroButton.h"
#import "PositionView.h"
#import "heroScore.h"
#import "HeroPickerView.h"
#import "detailView.h"
#import "SideButton.h"
#import <iAd/iAd.h>
@class ConlusionView;
@protocol ChangePositionDelegate <NSObject>

@optional
//调整位置(拖拽方法)
-(void)changePositionLeft:(HeroModel*)hero :(NSString*)key;
-(void)changePositionRight:(HeroModel*)hero :(NSString*)key;
//加载已选英雄
-(void)addAllTeam;
//清除所选
-(void)clearLeft;
-(void)clearRight;
//清除调整位置的view
-(void)destroy;

@end



@interface ConlusionView : UIVisualEffectView<UIGestureRecognizerDelegate,ADBannerViewDelegate,UIWebViewDelegate>
//,detailViewDelegate
@property (weak, nonatomic)id <ChangePositionDelegate> delegate;

@property (strong, nonatomic) ADBannerView* adView;

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

@property (strong, nonatomic)NSArray* allMember;

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

@property (strong, nonatomic)UILabel *tipLable;

@property (strong, nonatomic)UIButton *clearButton;
@property (strong, nonatomic)UIButton *destroyButton;
@property (strong, nonatomic)UIButton *calcButton;
@property (strong, nonatomic)UIButton *reCalc;
#pragma mark 计算结果
@property (strong, nonatomic)NSNumber* laningProportion;
@property (strong, nonatomic)NSNumber* teamFightProportion;
@property (strong, nonatomic)NSNumber* soloPushProportion;
@property (strong, nonatomic)NSNumber* avgRate;
@property (strong, nonatomic)NSNumber* brzRate;
@property (strong, nonatomic)NSNumber* slvRate;
@property (strong, nonatomic)NSNumber* gldRate;
@property (strong, nonatomic)NSNumber* pltRate;
@property (strong, nonatomic)NSNumber* dmdRate;
@property (strong, nonatomic)NSNumber* kngRate;
@property (strong, nonatomic)NSNumber* leftCounted;
@property (strong, nonatomic)NSNumber* leftCoped;
@property (strong, nonatomic)NSNumber* rightCounted;
@property (strong, nonatomic)NSNumber* rightCoped;
@property (assign, nonatomic)CGFloat leftRateALL;
@property (assign, nonatomic)CGFloat BrzRateALL;
@property (assign, nonatomic)CGFloat SlvRateALL;
@property (assign, nonatomic)CGFloat GldRateALL;
@property (assign, nonatomic)CGFloat PltRateALL;
@property (assign, nonatomic)CGFloat DmdRateALL;
@property (assign, nonatomic)CGFloat KngRateALL;


@property (strong, nonatomic)UIImageView *topView;
@property (strong, nonatomic)UILabel *lableText;
@property (strong, nonatomic)UILabel *lableRateLeft;
@property (strong, nonatomic)UILabel *lableRateLeftX;
@property (strong, nonatomic)UILabel *lableRateRight;
@property (strong, nonatomic)UILabel *lableRateRightX;


//@property (strong, nonatomic)detailView *detailsView;

@property (strong, nonatomic)UIView *detailView;
@property (strong, nonatomic)UIView *buttonBar;


@property (strong, nonatomic)UIButton* laningDetailBut;
@property (strong, nonatomic)UIButton* teamFightDetailBut;
@property (strong, nonatomic)UIButton* soloPushDetailBut;

@property(strong, nonatomic)SideButton* leftSwitch;
@property(strong, nonatomic)SideButton* rightSwitch;
@property(strong, nonatomic)UILabel* lableC;

@property(strong, nonatomic)UIButton* brz;
@property(strong, nonatomic)UIButton* slv;
@property(strong, nonatomic)UIButton* gld;
@property(strong, nonatomic)UIButton* plt;
@property(strong, nonatomic)UIButton* dmd;
@property(strong, nonatomic)UIButton* kng;

@property (strong, nonatomic)UIButton* rankSelect;
@property (strong, nonatomic)UIView* rankSelector;

@property (assign, nonatomic)CGFloat widthLeft;

@property (strong, nonatomic)UIView* leftTopScore;

@property (strong, nonatomic)UIView* leftJunScore;
@property (strong, nonatomic)UIView* leftMidScore;
@property (strong, nonatomic)UIView* leftAdScore;
@property (strong, nonatomic)UIView* leftSupScore;

@property (strong, nonatomic)UILabel* a1score;
@property (strong, nonatomic)UILabel* a2score;
@property (strong, nonatomic)UILabel* a3score;
@property (strong, nonatomic)UILabel* a4score;
@property (strong, nonatomic)UILabel* a5score;

@property (strong, nonatomic)UIView* rightTopScore;
@property (strong, nonatomic)UIView* rightJunScore;
@property (strong, nonatomic)UIView* rightMidScore;
@property (strong, nonatomic)UIView* rightAdScore;
@property (strong, nonatomic)UIView* rightSupScore;

@property (strong, nonatomic)UILabel* b1score;
@property (strong, nonatomic)UILabel* b2score;
@property (strong, nonatomic)UILabel* b3score;
@property (strong, nonatomic)UILabel* b4score;
@property (strong, nonatomic)UILabel* b5score;

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

@property (assign, nonatomic)CGFloat leftIsBlue;

@property (strong, nonatomic)UIButton* contactMe;
@property (strong, nonatomic)UIButton* contactMe2;
@property (strong, nonatomic)UIWebView* WeiboWeb;

@property (strong, nonatomic)UIButton* CloseWebBtn;




@end
