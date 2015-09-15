//
//  HeroPickerView.m
//  LOLAnalyzer
//
//  Created by soppysonny on 15/8/2.
//  Copyright (c) 2015年 soppysonny. All rights reserved.
//

#import "HeroPickerView.h"
#define screenWidth [UIScreen mainScreen].bounds.size.width
@implementation HeroPickerView

+(instancetype)heroPickerView{
    if (screenWidth>400) {
        
        return [[NSBundle mainBundle]loadNibNamed:@"HeroPickerXib_6plus" owner:nil options:nil][0];
    }else{
    return [[NSBundle mainBundle]loadNibNamed:@"HeroPickerXib" owner:nil options:nil][0];
    }
}

- (void)setHero:(HeroModel *)hero{
    _hero = hero;
    self.imageView.image = [UIImage imageNamed:[hero icon]];
    self.label.text = hero.name;
  
}

@end
