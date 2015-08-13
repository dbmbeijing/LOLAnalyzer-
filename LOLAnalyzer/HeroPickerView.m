//
//  HeroPickerView.m
//  LOLAnalyzer
//
//  Created by soppysonny on 15/8/2.
//  Copyright (c) 2015年 soppysonny. All rights reserved.
//

#import "HeroPickerView.h"

@implementation HeroPickerView

+(instancetype)heroPickerView{
    return [[NSBundle mainBundle]loadNibNamed:@"HeroPickerXib" owner:nil options:nil][0];
}

- (void)setHero:(HeroModel *)hero{
    _hero = hero;
    self.imageView.image = [UIImage imageNamed:[hero icon]];
    self.label.text = hero.name;
}

@end
