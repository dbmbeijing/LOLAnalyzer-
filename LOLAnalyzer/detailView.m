//
//  detailView.m
//  LOLAnalyzer
//
//  Created by soppysonny on 15/8/15.
//  Copyright (c) 2015年 soppysonny. All rights reserved.
//

#import "detailView.h"

@implementation detailView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    CGRect screenRect =  [self.delegate getFrame];
    
      self.frame = CGRectMake(0, screenRect.size.height*0.6, screenRect.size.width, screenRect.size.height*0.4);
    self.backgroundColor = [UIColor blueColor];


    
     return self;
}




-(UIImageView *)leftTopM{
    if (!_leftTopM) {
        CGRect recttemp =[self.delegate getFrame];
        CGFloat h = recttemp.size.height;
        NSString* imgName = [self.delegate getLeftTop].name ;
        UIImage* image = [UIImage imageNamed:imgName];
        _leftTopM = [[UIImageView alloc]initWithImage:image];
        _leftTopM.frame = CGRectMake(0,h*0.7,h*0.06,h*0.06 );
  
    }return _leftTopM;
}
-(UIImageView *)leftJunM{
    if (!_leftJunM) {
        CGRect recttemp =[self.delegate getFrame];
        CGFloat h = recttemp.size.height;
        NSString* imgName = [self.delegate getLeftJun].name ;
        UIImage* image = [UIImage imageNamed:imgName];
        _leftJunM = [[UIImageView alloc]initWithImage:image];
        _leftJunM.frame = CGRectMake(0,h*0.76,h*0.06,h*0.06 );

    }return _leftJunM;
}
-(UIImageView *)leftMidM{
    if (!_leftMidM) {
        CGRect recttemp =[self.delegate getFrame];
        CGFloat h = recttemp.size.height;
        NSString* imgName = [self.delegate getLeftMid].name ;
        UIImage* image = [UIImage imageNamed:imgName];
        _leftMidM = [[UIImageView alloc]initWithImage:image];
        _leftMidM.frame = CGRectMake(0,h*0.82,h*0.06,h*0.06 );
    }return _leftMidM;
}
-(UIImageView *)leftAdM{
    if (!_leftAdM) {
        CGRect recttemp =[self.delegate getFrame];
        CGFloat h = recttemp.size.height;
      
        NSString* imgName = [self.delegate getLeftAd].name ;
        UIImage* image = [UIImage imageNamed:imgName];
        _leftAdM = [[UIImageView alloc]initWithImage:image];
        _leftAdM.frame = CGRectMake(0,h*0.88,h*0.06,h*0.06 );

    }return _leftAdM;
}
-(UIImageView *)leftSupM{
    if (!_leftSupM) {
        CGRect recttemp =[self.delegate getFrame];
        CGFloat h = recttemp.size.height;
        CGFloat w = recttemp.size.width;
        NSString* imgName = [self.delegate getLeftSup].name ;
        UIImage* image = [UIImage imageNamed:imgName];
        _leftSupM = [[UIImageView alloc]initWithImage:image];
        _leftSupM.frame = CGRectMake(w-0.06*h,h*0.94,h*0.06,h*0.06 );
        
    }return _leftSupM;
}
-(UIImageView *)rightTopM{
    if (!_rightTopM) {
        CGRect recttemp =[self.delegate getFrame];
        CGFloat h = recttemp.size.height;
        CGFloat w = recttemp.size.width;
        NSString* imgName = [self.delegate getRightTop].name ;
        UIImage* image = [UIImage imageNamed:imgName];
        _rightTopM = [[UIImageView alloc]initWithImage:image];
        _rightTopM.frame = CGRectMake(w-0.06*h,h*0.7,h*0.06,h*0.06 );
        
    }return _rightTopM;
}
-(UIImageView *)rightJunM{
    if (!_rightJunM) {
        CGRect recttemp =[self.delegate getFrame];
        CGFloat h = recttemp.size.height;
        CGFloat w = recttemp.size.width;
        NSString* imgName = [self.delegate getRightJun].name ;
        UIImage* image = [UIImage imageNamed:imgName];
        _rightJunM = [[UIImageView alloc]initWithImage:image];
        _rightJunM.frame = CGRectMake(w-0.06*h,h*0.76,h*0.06,h*0.06 );
        
    }return _rightJunM;
}
-(UIImageView *)rightMidM{
    if (!_rightMidM) {
        CGRect recttemp =[self.delegate getFrame];
        CGFloat h = recttemp.size.height;
        CGFloat w = recttemp.size.width;
        NSString* imgName = [self.delegate getRightMid].name ;
        UIImage* image = [UIImage imageNamed:imgName];
        _rightMidM = [[UIImageView alloc]initWithImage:image];
        _rightMidM.frame = CGRectMake(w-0.06*h,h*0.82,h*0.06,h*0.06 );
    }return _rightMidM;
}
-(UIImageView *)rightAdM{
    if (!_rightAdM) {
        CGRect recttemp =[self.delegate getFrame];
        CGFloat h = recttemp.size.height;
        CGFloat w = recttemp.size.width;
        NSString* imgName = [self.delegate getRightAd].name ;
        UIImage* image = [UIImage imageNamed:imgName];
        _rightAdM = [[UIImageView alloc]initWithImage:image];
        _rightAdM.frame = CGRectMake(w-0.06*h,h*0.88,h*0.06,h*0.06 );
        
    }return _rightAdM;
}
-(UIImageView *)rightSupM{
    if (!_rightSupM) {
        CGRect recttemp =[self.delegate getFrame];
        CGFloat h = recttemp.size.height;
        CGFloat w = recttemp.size.width;
        NSString* imgName = [self.delegate getRightSup].name ;
        UIImage* image = [UIImage imageNamed:imgName];
        _rightSupM = [[UIImageView alloc]initWithImage:image];
        _rightSupM.frame = CGRectMake(w-0.06*h,h*0.94,h*0.06,h*0.06 );
    }return _rightSupM;
}




@end
