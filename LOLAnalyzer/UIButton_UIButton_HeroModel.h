//
//  UIButton_UIButton_HeroModel.h
//  LOLAnalyzer
//
//  Created by soppysonny on 15/8/3.
//  Copyright (c) 2015年 soppysonny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeroModel.h"

@interface UIButton (ext)
@property (strong, nonatomic)HeroModel *HeroForButton;
-(void)setHeroForButton:(HeroModel *)HeroForButton;
-(HeroModel *)HeroForButton;

@end

@implementation UIButton(ext)

-(void)setHeroForButton:(HeroModel *)HeroForButton{
    
}

-(HeroModel *)HeroForButton{
    return [[HeroModel alloc]init];
}

@end
