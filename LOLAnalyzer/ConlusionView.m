//
//  ConlusionView.m
//  LOLAnalyzer
//
//  Created by soppysonny on 15/8/8.
//  Copyright (c) 2015年 soppysonny. All rights reserved.
//

#import "ConlusionView.h"
#define btnSize [UIScreen mainScreen].bounds.size.height*0.09
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define txtpicGap 160
@implementation ConlusionView



-(instancetype)initWithFrame:(CGRect)frame{
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
    return self;
}

-(void)clearView{
    [UIVisualEffectView animateWithDuration:1.0 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, screenHeight);
    }];
//    [self removeFromSuperview];
   // [self.delegate addAllTeam];
}

-(UIButton *)clearButton{
    if (!_clearButton) {
        _clearButton = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth*0.5-0.5*btnSize, screenHeight*0.5-0.5*btnSize, btnSize, btnSize)];
        [_clearButton setBackgroundImage:[UIImage imageNamed:@"done"] forState:UIControlStateNormal];
        [_clearButton addTarget:self action:@selector(clearView) forControlEvents:UIControlEventTouchUpInside];
    }return _clearButton;
}

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

@end
