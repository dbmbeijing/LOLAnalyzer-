//
//  HeroButton.m
//  LOLAnalyzer
//
//  Created by soppysonny on 15/8/3.
//  Copyright (c) 2015年 soppysonny. All rights reserved.
//

#import "HeroButton.h"

@implementation HeroButton

-(void)setHeroForButton:(HeroModel *)HeroForButton{
    _HeroForButton = HeroForButton;
    if (HeroForButton) {
        [self setBackgroundImage:[UIImage imageNamed:HeroForButton.icon] forState:UIControlStateHighlighted];
        [self setBackgroundImage:[UIImage imageNamed:HeroForButton.icon] forState:UIControlStateDisabled];
        [self setBackgroundImage:[UIImage imageNamed:HeroForButton.icon] forState:UIControlStateNormal];
    }
   }

@end
