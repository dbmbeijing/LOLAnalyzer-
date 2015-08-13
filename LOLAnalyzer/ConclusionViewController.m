//
//  ConclusionViewController.m
//  LOLAnalyzer
//
//  Created by soppysonny on 15/8/7.
//  Copyright (c) 2015年 soppysonny. All rights reserved.
//

#import "ConclusionViewController.h"
#import <iAd/iAd.h>
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define adBarHeight 50
@interface ConclusionViewController ()<ADBannerViewDelegate>
@property (strong, nonatomic) ADBannerView* adView;
@end

@implementation ConclusionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //广告
//        [self.view addSubview:a];
        self.adView.delegate = self;
    self.view.frame = [UIScreen mainScreen].bounds;
    
    UIButton* a = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    a.backgroundColor = [UIColor blueColor];
    

    [self.view addSubview:self.adView];

    
    [a addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
  
}

-(ADBannerView *)adView{
    if (!_adView) {
        _adView = [[ADBannerView alloc]init];
        _adView.frame = CGRectMake(0,screenHeight-50, screenWidth, screenHeight);
        [_adView setBackgroundColor:[UIColor clearColor]];

    }return _adView;
}

-(void)bannerView:(ADBannerView *)banner
didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"Error loading");
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad loaded");
}
-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad will load");
}
-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    NSLog(@"Ad did finish");}

-(void)dismissView{
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
