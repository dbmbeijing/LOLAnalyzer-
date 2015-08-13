//
//  PositionView.h
//  LOLAnalyzer
//
//  Created by soppysonny on 15/8/10.
//  Copyright (c) 2015年 soppysonny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeroButton.h"

@interface PositionView : UIView

@property (copy, nonatomic)NSString *PositionKey;
@property (strong, nonatomic)HeroButton *ButtonForPosition;

@end
