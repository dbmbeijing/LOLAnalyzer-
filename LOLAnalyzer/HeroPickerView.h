//
//  HeroPickerView.h
//  LOLAnalyzer
//
//  Created by soppysonny on 15/8/2.
//  Copyright (c) 2015年 soppysonny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeroModel.h"
@interface HeroPickerView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic)HeroModel *hero;
+(instancetype)heroPickerView;
@end
