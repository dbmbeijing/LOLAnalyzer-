//
//  SideButton.h
//  LOLAnalyzer
//
//  Created by soppysonny on 15/8/11.
//  Copyright (c) 2015年 soppysonny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeroButton.h"

@interface SideButton : UIButton
@property (strong, nonatomic)HeroButton* button;
@property (copy, nonatomic)NSString* name;
@property (getter=isBlue,nonatomic)BOOL isBlue;


@end
