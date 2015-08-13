//
//  ViewController.m
//  LOLAnalyzer
//
//  Created by soppysonny on 15/8/2.
//  Copyright (c) 2015年 soppysonny. All rights reserved.
//what's next : 钟情

//豪华版功能:图像搜索
//目的:套路大全/胜率计算/阵容分析

//待优化:多线程,复数按钮的相似方法可使用统一方法,分别使用block,通知,代理
//第二页:多个按键同时移动(真机测试)
//字体,边框(圆角),按钮纹理
/*
目标效果:一个方法提供多个按钮使用,方法能够识别是哪个按钮(无法实现)
 尝试1:自定义按钮,为按钮添加对应属性.未能想出单个方法提供多个按钮使用的做法
 尝试2:代理: 自定义按钮文件中添加协议,单个方法对应单个按钮(姑且尝试)未能实现
 尝试3:通知:实现

 目标效果:储存理想队形直接读取(套路大全)
 涉及知识:偏好设置储存
 
 胜率计算结果界面:collectionView(网易新闻)
 */

//BanPick界面
//套路队伍:输入数组
//键盘弹出时有向下拖拽收起键盘手势(停止编辑,收起所有picker) UISwipeGestureRecognizerDirectionDown
//picker添加自定义bar,确定键点击时将所选英雄传入按键
//第二个界面:
//判断拖拽的按钮时使用大量if判断,应写个枚举,使用switch

//位置分配界面
//让用户确定阵容位置,拖拽可互换(nscache/nsdictionaryvalue:heromodel key@"mid")

/*
 1.按钮添加
 2.队伍位置猜测,nscache ab队, 对比index更新:cache在内存吃紧时会被释放,此处使用NSDictionary保证稳定,返回banpick页面时清空dict
*/
//3.用NSCache传递/block已选队伍分析胜率
/*
1, switch选择 蓝色紫色方
2,各个英雄的位置适应度排名确定位置分配,按钮确定并计算分析阵容胜率
3,各个按钮可拖拽交换操作,拖拽之后更新对应位置
4,
 */
//BUGS:键盘操作 通知: self.view maketransform
//modal时,自定义的viewcontroller继承自原viewcontroller
//导致所有原来按钮都包含其中 完全一样,修改父类后(uiviewcontroller)
//guesspicker消失,一旦点击searchLaunch,CPU使用率飙升达100%
//点击一次不显示,点击第二次时报错:数组越界,猜测原因,点击时减少guessHeroes数组内容
//原因:-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{方法中加入了pickerview reload ------死循环


#import "ViewController.h"
#import "HeroModel.h"
#import "HeroPickerView.h"
//#import "UIButton_UIButton_HeroModel.h"//有问题
#import "HeroButton.h"
#import "ConclusionViewController.h"
#import "SideButton.h"

#define btnSize [UIScreen mainScreen].bounds.size.height*0.09
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define txtpicGap 160
#define textSize btnSize*2.5
#define pickerWidth self.HeroPicker.frame.size.width*0.8
@interface ViewController ()<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate,UIAlertViewDelegate>

@property (strong, nonatomic)UIPickerView *HeroPicker;
@property (strong, nonatomic)UIPickerView *GuessPicker;

@property (strong, nonatomic)NSMutableArray *heroes;
@property (strong, nonatomic)NSMutableArray *currentHeroes;

@property (strong, nonatomic)HeroButton* memberA1;
@property (strong, nonatomic)HeroButton* memberA2;
@property (strong, nonatomic)HeroButton* memberA3;
@property (strong, nonatomic)HeroButton* memberA4;
@property (strong, nonatomic)HeroButton* memberA5;

@property (strong, nonatomic)HeroButton* memberB1;
@property (strong, nonatomic)HeroButton* memberB2;
@property (strong, nonatomic)HeroButton* memberB3;
@property (strong, nonatomic)HeroButton* memberB4;
@property (strong, nonatomic)HeroButton* memberB5;

@property (strong, nonatomic)HeroButton* Banned1;
@property (strong, nonatomic)HeroButton* Banned2;
@property (strong, nonatomic)HeroButton* Banned3;
@property (strong, nonatomic)HeroButton* Banned4;
@property (strong, nonatomic)HeroButton* Banned5;
@property (strong, nonatomic)HeroButton* Banned6;

@property (strong, nonatomic)UITextField* shortCut;
@property (strong, nonatomic)UIButton* searchLaunch;
@property (strong, nonatomic)UIButton* lockButton;
@property (strong, nonatomic)HeroModel* tempHero;
@property (strong, nonatomic)UIPickerView* currentPicker;

@property (copy, nonatomic)  NSString* keyWord;
@property (strong, nonatomic)NSDictionary* searcherDict;
@property (strong, nonatomic)NSMutableArray* guessHeroes;

@property (strong, nonatomic)NSMutableArray* clickedBtn;
@property (strong, nonatomic)NSMutableArray* selectedHero;//被Ban被选英雄都加到这个数组,容量16

@property (strong, nonatomic)NSArray* allTeam;
@property (strong, nonatomic)NSArray* teamLeft;
@property (strong, nonatomic)NSArray* teamRight;

@property (strong, nonatomic)NSArray* banLeft;
@property (strong, nonatomic)NSArray* banRight;

@property (strong, nonatomic)UIButton* modalButton;

@property (copy, nonatomic)NSMutableDictionary* teamcacheA;
@property (copy, nonatomic)NSMutableDictionary* teamcacheB;

@property (strong, nonatomic)ConlusionView* coverView;
//点击左列按钮右侧count按钮(if 对应herobutton.heromodel存在)全部add,
//点击count按钮,heroview移除,添加guessview,读取count按钮同一行的herobutton.heroforbutton.countedBy
//以此数组读取复数的英雄,遍历监测是否已经被选,剔除后添加到guessheroes数组,详情参照searcherlaunched方法
@property (strong, nonatomic)SideButton *countB1;
@property (strong, nonatomic)SideButton *countB2;
@property (strong, nonatomic)SideButton *countB3;
@property (strong, nonatomic)SideButton *countB4;
@property (strong, nonatomic)SideButton *countB5;

@property (strong, nonatomic)SideButton *countA1;
@property (strong, nonatomic)SideButton *countA2;
@property (strong, nonatomic)SideButton *countA3;
@property (strong, nonatomic)SideButton *countA4;
@property (strong, nonatomic)SideButton *countA5;

@property (strong, nonatomic)SideButton *ptnB1;
@property (strong, nonatomic)SideButton *ptnB2;
@property (strong, nonatomic)SideButton *ptnB3;
@property (strong, nonatomic)SideButton *ptnB4;
@property (strong, nonatomic)SideButton *ptnB5;

@property (strong, nonatomic)SideButton *ptnA1;
@property (strong, nonatomic)SideButton *ptnA2;
@property (strong, nonatomic)SideButton *ptnA3;
@property (strong, nonatomic)SideButton *ptnA4;
@property (strong, nonatomic)SideButton *ptnA5;

@property (strong, nonatomic)UIButton *clearAButton;
@property (strong, nonatomic)UIButton *clearBButton;

@end

@implementation ViewController
#pragma mark 代理传值
-(void)changePositionRight:(HeroModel *)hero :(NSString *)key{
    [self.teamcacheB setObject:hero forKey:key];
    
}
-(void)changePositionLeft:(HeroModel *)hero :(NSString *)key{
    [self.teamcacheA setObject:hero forKey:key];

}


#pragma mark 方法
-(void)addAllTeam{
    self.memberA1.HeroForButton = [self.teamcacheA objectForKey:@"leftTop"];
    self.memberA2.HeroForButton = [self.teamcacheA objectForKey:@"leftJun"];
    self.memberA3.HeroForButton = [self.teamcacheA objectForKey:@"leftMid"];
    self.memberA4.HeroForButton = [self.teamcacheA objectForKey:@"leftAd"];
    self.memberA5.HeroForButton = [self.teamcacheA objectForKey:@"leftSup"];

    self.memberB1.HeroForButton = [self.teamcacheB objectForKey:@"rightTop"];
    self.memberB2.HeroForButton = [self.teamcacheB objectForKey:@"rightJun"];
    self.memberB3.HeroForButton = [self.teamcacheB objectForKey:@"rightMid"];
    self.memberB4.HeroForButton = [self.teamcacheB objectForKey:@"rightAd"];
    self.memberB5.HeroForButton = [self.teamcacheB objectForKey:@"rightSup"];
//    
    for (HeroButton*button in self.allTeam) {
        [self.view addSubview:button];
        
    }
}

#pragma mark 按钮懒加载
-(UIButton *)clearAButton{
    if (!_clearAButton) {
        _clearAButton = [[UIButton alloc]initWithFrame:CGRectMake(self.Banned1.frame.origin.x+1.1*btnSize, screenHeight-btnSize, btnSize*1.6, btnSize*0.75)];
        [_clearAButton setBackgroundImage:[UIImage imageNamed:@"ptnNormal"] forState:UIControlStateNormal];
        [_clearAButton setBackgroundImage:[UIImage imageNamed:@"ptn"] forState:UIControlStateHighlighted];
        [_clearAButton setTitle:@"清空左侧队伍" forState:UIControlStateNormal];
        [_clearAButton setTitle:@"清空左侧队伍" forState:UIControlStateHighlighted];
        _clearAButton.titleLabel.numberOfLines = 0;
        _clearAButton.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
        _clearAButton.layer.cornerRadius = btnSize*0.2;
        _clearAButton.layer.masksToBounds = YES;
        [_clearAButton addTarget:self action:@selector(clearLeft) forControlEvents:UIControlEventTouchUpInside];
    }return _clearAButton;
}
-(UIButton *)clearBButton{
    if (!_clearBButton) {
        _clearBButton = [[UIButton alloc]initWithFrame:CGRectMake(self.Banned4.frame.origin.x-1.8*btnSize, screenHeight-btnSize, btnSize*1.6, btnSize*0.75)];
        [_clearBButton setBackgroundImage:[UIImage imageNamed:@"ptnNormal"] forState:UIControlStateNormal];
        [_clearBButton setBackgroundImage:[UIImage imageNamed:@"ptn"] forState:UIControlStateHighlighted];
        [_clearBButton setTitle:@"清空右侧队伍" forState:UIControlStateNormal];
        [_clearBButton setTitle:@"清空右侧队伍" forState:UIControlStateHighlighted];
        _clearBButton.titleLabel.numberOfLines = 0;
        _clearBButton.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
        _clearBButton.layer.cornerRadius = btnSize*0.2;
        _clearBButton.layer.masksToBounds = YES;
        [_clearBButton addTarget:self action:@selector(clearRight) forControlEvents:UIControlEventTouchUpInside];
    }return _clearBButton;
}
-(UIButton *)modalButton{
    if (!_modalButton) {
        _modalButton = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth*0.5-btnSize, 40+20, btnSize*2, btnSize)];
        [_modalButton addTarget:self action:@selector(modalButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        //此button仍需修改样式
        [_modalButton setBackgroundImage:[UIImage imageNamed:@"boost_normal"] forState:UIControlStateNormal];
                [_modalButton setBackgroundImage:[UIImage imageNamed:@"boost_normal"] forState:UIControlStateHighlighted];
    }return _modalButton;
}
-(SideButton *)countA1{
    if (!_countA1) {
        _countA1 = [[SideButton alloc]initWithFrame:CGRectMake(5+btnSize, 40, btnSize*0.3, btnSize)];
        [_countA1 setBackgroundImage:[UIImage imageNamed:@"countA"] forState:UIControlStateHighlighted];
        [_countA1 setBackgroundImage:[UIImage imageNamed:@"countA2"] forState:UIControlStateNormal];
        [_countA1 setTitle:@"压制" forState:UIControlStateNormal];
        [_countA1 setTitle:@"压制" forState:UIControlStateHighlighted];
        _countA1.titleLabel.numberOfLines = 0;
        _countA1.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
        _countA1.button = self.memberA1;
        _countA1.name = @"A1";
    }return _countA1;
}
-(SideButton *)countA2{
    if (!_countA2) {
        _countA2 = [[SideButton alloc]initWithFrame:CGRectMake(5+btnSize, 40+(btnSize+20), btnSize*0.3, btnSize)];
        [_countA2 setBackgroundImage:[UIImage imageNamed:@"countA"] forState:UIControlStateHighlighted];
        [_countA2 setBackgroundImage:[UIImage imageNamed:@"countA2"] forState:UIControlStateNormal];
        [_countA2 setTitle:@"压制" forState:UIControlStateNormal];
        [_countA2 setTitle:@"压制" forState:UIControlStateHighlighted];
        _countA2.titleLabel.numberOfLines = 0;
        _countA2.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
                _countA2.name = @"A2";
                _countA2.button = self.memberA2;
    }return _countA2;
}
-(SideButton *)countA3{
    if (!_countA3) {
        _countA3 = [[SideButton alloc]initWithFrame:CGRectMake(5+btnSize, 40+(btnSize+20)*2, btnSize*0.3, btnSize)];
        [_countA3 setBackgroundImage:[UIImage imageNamed:@"countA"] forState:UIControlStateHighlighted];
        [_countA3 setBackgroundImage:[UIImage imageNamed:@"countA2"] forState:UIControlStateNormal];
        [_countA3 setTitle:@"压制" forState:UIControlStateNormal];
        [_countA3 setTitle:@"压制" forState:UIControlStateHighlighted];
        _countA3.titleLabel.numberOfLines = 0;
        _countA3.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
               _countA3.button = self.memberA3;
                _countA3.name = @"A3";
    }return _countA3;
}
-(SideButton *)countA4{
    if (!_countA4) {
        _countA4 = [[SideButton alloc]initWithFrame:CGRectMake(5+btnSize, 40+(btnSize+20)*3, btnSize*0.3, btnSize)];
        [_countA4 setBackgroundImage:[UIImage imageNamed:@"countA"] forState:UIControlStateHighlighted];
        [_countA4 setBackgroundImage:[UIImage imageNamed:@"countA2"] forState:UIControlStateNormal];
        [_countA4 setTitle:@"压制" forState:UIControlStateNormal];
        [_countA4 setTitle:@"压制" forState:UIControlStateHighlighted];
        _countA4.titleLabel.numberOfLines = 0;
        _countA4.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
                _countA4.name = @"A4";
                _countA4.button = self.memberA4;
    }return _countA4;
}
-(SideButton *)countA5{
    if (!_countA5) {
        _countA5 = [[SideButton alloc]initWithFrame:CGRectMake(5+btnSize, 40+(btnSize+20)*4, btnSize*0.3, btnSize)];
        [_countA5 setBackgroundImage:[UIImage imageNamed:@"countA"] forState:UIControlStateHighlighted];
        [_countA5 setBackgroundImage:[UIImage imageNamed:@"countA2"] forState:UIControlStateNormal];
        [_countA5 setTitle:@"压制" forState:UIControlStateNormal];
        [_countA5 setTitle:@"压制" forState:UIControlStateHighlighted];
        _countA5.titleLabel.numberOfLines = 0;
        _countA5.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
               _countA5.button = self.memberA5;
                _countA5.name = @"A5";
    }return _countA5;
}
-(SideButton *)countB1{
    if (!_countB1) {
        _countB1 = [[SideButton alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize-0.3*btnSize, 40, btnSize*0.3, btnSize)];
        [_countB1 setBackgroundImage:[UIImage imageNamed:@"countA"] forState:UIControlStateHighlighted];
        [_countB1 setBackgroundImage:[UIImage imageNamed:@"countA2"] forState:UIControlStateNormal];
        [_countB1 setTitle:@"压制" forState:UIControlStateNormal];
        [_countB1 setTitle:@"压制" forState:UIControlStateHighlighted];
        _countB1.titleLabel.numberOfLines = 0;
        _countB1.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
                _countB1.button = self.memberB1;
    }return _countB1;
}
-(SideButton *)countB2{
    if (!_countB2) {
        _countB2 = [[SideButton alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize-0.3*btnSize, 40+(btnSize+20), btnSize*0.3, btnSize)];
        [_countB2 setBackgroundImage:[UIImage imageNamed:@"countA"] forState:UIControlStateHighlighted];
        [_countB2 setBackgroundImage:[UIImage imageNamed:@"countA2"] forState:UIControlStateNormal];
        [_countB2 setTitle:@"压制" forState:UIControlStateNormal];
        [_countB2 setTitle:@"压制" forState:UIControlStateHighlighted];
        _countB2.titleLabel.numberOfLines = 0;
        _countB2.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
        _countB2.button = self.memberB2;
    }return _countB2;
}
-(SideButton *)countB3{
    if (!_countB3) {
        _countB3 = [[SideButton alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize-0.3*btnSize, 40+(btnSize+20)*2, btnSize*0.3, btnSize)];
        [_countB3 setBackgroundImage:[UIImage imageNamed:@"countA"] forState:UIControlStateHighlighted];
        [_countB3 setBackgroundImage:[UIImage imageNamed:@"countA2"] forState:UIControlStateNormal];
        [_countB3 setTitle:@"压制" forState:UIControlStateNormal];
        [_countB3 setTitle:@"压制" forState:UIControlStateHighlighted];
        _countB3.titleLabel.numberOfLines = 0;
        _countB3.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
                _countB3.button = self.memberB3;
    }return _countB3;
}
-(SideButton *)countB4{
    if (!_countB4) {
        _countB4 = [[SideButton alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize-0.3*btnSize, 40+(btnSize+20)*3, btnSize*0.3, btnSize)];
        [_countB4 setBackgroundImage:[UIImage imageNamed:@"countA"] forState:UIControlStateHighlighted];
        [_countB4 setBackgroundImage:[UIImage imageNamed:@"countA2"] forState:UIControlStateNormal];
        [_countB4 setTitle:@"压制" forState:UIControlStateNormal];
        [_countB4 setTitle:@"压制" forState:UIControlStateHighlighted];
        _countB4.titleLabel.numberOfLines = 0;
        _countB4.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
                        _countB4.button = self.memberB4;
    }return _countB4;
}
-(SideButton *)countB5{
    if (!_countB5) {
        _countB5 = [[SideButton alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize-0.3*btnSize, 40+(btnSize+20)*4, btnSize*0.3, btnSize)];
        [_countB5 setBackgroundImage:[UIImage imageNamed:@"countA"] forState:UIControlStateHighlighted];
        [_countB5 setBackgroundImage:[UIImage imageNamed:@"countA2"] forState:UIControlStateNormal];
        [_countB5 setTitle:@"压制" forState:UIControlStateNormal];
        [_countB5 setTitle:@"压制" forState:UIControlStateHighlighted];
        _countB5.titleLabel.numberOfLines = 0;
        _countB5.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
                        _countB5.button = self.memberB5;

    }return _countB5;
}
-(SideButton *)ptnA1{
    if (!_ptnA1) {
        _ptnA1 = [[SideButton alloc]initWithFrame:CGRectMake(5, self.memberA1.frame.origin.y+btnSize+1, btnSize, 18)];
        [_ptnA1 setBackgroundImage:[UIImage imageNamed:@"ptnNormal"] forState:UIControlStateNormal];
        [_ptnA1 setBackgroundImage:[UIImage imageNamed:@"ptn"] forState:UIControlStateHighlighted];
        [_ptnA1 setTitle:@"配合" forState:UIControlStateNormal];
        [_ptnA1 setTitle:@"配合" forState:UIControlStateHighlighted];
        _ptnA1.titleLabel.numberOfLines = 1;
        _ptnA1.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
        _ptnA1.button = self.memberA1;
        _ptnA1.name = @"C1";
    }return _ptnA1;
}
-(SideButton *)ptnA2{
    if (!_ptnA2) {
        _ptnA2 = [[SideButton alloc]initWithFrame:CGRectMake(5, self.memberA2.frame.origin.y+btnSize+1, btnSize, 18)];
        [_ptnA2 setBackgroundImage:[UIImage imageNamed:@"ptnNormal"] forState:UIControlStateNormal];
        [_ptnA2 setBackgroundImage:[UIImage imageNamed:@"ptn"] forState:UIControlStateHighlighted];
        [_ptnA2 setTitle:@"配合" forState:UIControlStateNormal];
        [_ptnA2 setTitle:@"配合" forState:UIControlStateHighlighted];
        _ptnA2.titleLabel.numberOfLines = 1;
        _ptnA2.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
        _ptnA2.button = self.memberA2;
        _ptnA2.name = @"C2";
    }return _ptnA2;
}
-(SideButton *)ptnA3{
    if (!_ptnA3) {
        _ptnA3 = [[SideButton alloc]initWithFrame:CGRectMake(5, self.memberA3.frame.origin.y+btnSize+1, btnSize, 18)];
        [_ptnA3 setBackgroundImage:[UIImage imageNamed:@"ptnNormal"] forState:UIControlStateNormal];
        [_ptnA3 setBackgroundImage:[UIImage imageNamed:@"ptn"] forState:UIControlStateHighlighted];
        [_ptnA3 setTitle:@"配合" forState:UIControlStateNormal];
        [_ptnA3 setTitle:@"配合" forState:UIControlStateHighlighted];
        _ptnA3.titleLabel.numberOfLines = 1;
        _ptnA3.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
        _ptnA3.button = self.memberA3;
        _ptnA3.name = @"C3";
    }return _ptnA3;
}
-(SideButton *)ptnA4{
    if (!_ptnA4) {
        _ptnA4 = [[SideButton alloc]initWithFrame:CGRectMake(5, self.memberA4.frame.origin.y+btnSize+1, btnSize, 18)];
        [_ptnA4 setBackgroundImage:[UIImage imageNamed:@"ptnNormal"] forState:UIControlStateNormal];
        [_ptnA4 setBackgroundImage:[UIImage imageNamed:@"ptn"] forState:UIControlStateHighlighted];
        [_ptnA4 setTitle:@"配合" forState:UIControlStateNormal];
        [_ptnA4 setTitle:@"配合" forState:UIControlStateHighlighted];
        _ptnA4.titleLabel.numberOfLines = 1;
        _ptnA4.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
        _ptnA4.button = self.memberA4;
        _ptnA4.name = @"C4";
    }return _ptnA4;
}
-(SideButton *)ptnA5{
    if (!_ptnA5) {
        _ptnA5 = [[SideButton alloc]initWithFrame:CGRectMake(5, self.memberA5.frame.origin.y+btnSize+1, btnSize, 18)];
        [_ptnA5 setBackgroundImage:[UIImage imageNamed:@"ptnNormal"] forState:UIControlStateNormal];
        [_ptnA5 setBackgroundImage:[UIImage imageNamed:@"ptn"] forState:UIControlStateHighlighted];
        [_ptnA5 setTitle:@"配合" forState:UIControlStateNormal];
        [_ptnA5 setTitle:@"配合" forState:UIControlStateHighlighted];
        _ptnA5.titleLabel.numberOfLines = 1;
        _ptnA5.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
        _ptnA5.button = self.memberA5;
        _ptnA5.name = @"C5";
    }return _ptnA5;
}
-(SideButton *)ptnB1{
    if (!_ptnB1) {
        _ptnB1 = [[SideButton alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize, self.memberB1.frame.origin.y+btnSize+1, btnSize, 18)];
        [_ptnB1 setBackgroundImage:[UIImage imageNamed:@"ptnNormal"] forState:UIControlStateNormal];
        [_ptnB1 setBackgroundImage:[UIImage imageNamed:@"ptn"] forState:UIControlStateHighlighted];
        [_ptnB1 setTitle:@"配合" forState:UIControlStateNormal];
        [_ptnB1 setTitle:@"配合" forState:UIControlStateHighlighted];
        _ptnB1.titleLabel.numberOfLines = 1;
        _ptnB1.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
        _ptnB1.button = self.memberB1;
        _ptnB1.name = @"D1";
    }return _ptnB1;
}
-(SideButton *)ptnB2{
    if (!_ptnB2) {
        _ptnB2 = [[SideButton alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize, self.memberB2.frame.origin.y+btnSize+1, btnSize, 18)];
        [_ptnB2 setBackgroundImage:[UIImage imageNamed:@"ptnNormal"] forState:UIControlStateNormal];
        [_ptnB2 setBackgroundImage:[UIImage imageNamed:@"ptn"] forState:UIControlStateHighlighted];
        [_ptnB2 setTitle:@"配合" forState:UIControlStateNormal];
        [_ptnB2 setTitle:@"配合" forState:UIControlStateHighlighted];
        _ptnB2.titleLabel.numberOfLines = 1;
        _ptnB2.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
        _ptnB2.button = self.memberB2;
        _ptnB2.name = @"D2";
    }return _ptnB2;
}
-(SideButton *)ptnB3{
    if (!_ptnB3) {
        _ptnB3 = [[SideButton alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize, self.memberB3.frame.origin.y+btnSize+1, btnSize, 18)];
        [_ptnB3 setBackgroundImage:[UIImage imageNamed:@"ptnNormal"] forState:UIControlStateNormal];
        [_ptnB3 setBackgroundImage:[UIImage imageNamed:@"ptn"] forState:UIControlStateHighlighted];
        [_ptnB3 setTitle:@"配合" forState:UIControlStateNormal];
        [_ptnB3 setTitle:@"配合" forState:UIControlStateHighlighted];
        _ptnB3.titleLabel.numberOfLines = 1;
        _ptnB3.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
        _ptnB3.button = self.memberB3;
        _ptnB3.name = @"D3";
    }return _ptnB3;
}
-(SideButton *)ptnB4{
    if (!_ptnB4) {
        _ptnB4 = [[SideButton alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize, self.memberB4.frame.origin.y+btnSize+1, btnSize, 18)];
        [_ptnB4 setBackgroundImage:[UIImage imageNamed:@"ptnNormal"] forState:UIControlStateNormal];
        [_ptnB4 setBackgroundImage:[UIImage imageNamed:@"ptn"] forState:UIControlStateHighlighted];
        [_ptnB4 setTitle:@"配合" forState:UIControlStateNormal];
        [_ptnB4 setTitle:@"配合" forState:UIControlStateHighlighted];
        _ptnB4.titleLabel.numberOfLines = 1;
        _ptnB4.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
        _ptnB4.button = self.memberB4;
        _ptnB4.name = @"D4";
    }return _ptnB4;
}
-(SideButton *)ptnB5{
    if (!_ptnB5) {
        _ptnB5 = [[SideButton alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize, self.memberB5.frame.origin.y+btnSize+1, btnSize, 18)];
        [_ptnB5 setBackgroundImage:[UIImage imageNamed:@"ptnNormal"] forState:UIControlStateNormal];
        [_ptnB5 setBackgroundImage:[UIImage imageNamed:@"ptn"] forState:UIControlStateHighlighted];
        [_ptnB5 setTitle:@"配合" forState:UIControlStateNormal];
        [_ptnB5 setTitle:@"配合" forState:UIControlStateHighlighted];
        _ptnB5.titleLabel.numberOfLines = 1;
        _ptnB5.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
        _ptnB5.button = self.memberB5;
        _ptnB5.name = @"D5";
    }return _ptnB5;
}

#pragma mark 点击方法

-(void)clearAll{
    for (HeroButton*button in self.allTeam) {
        if (button.HeroForButton) {
            [self.currentHeroes addObject:button.HeroForButton];
        }
        button.HeroForButton = nil;
        [button setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateDisabled];
        [button setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateHighlighted];
    }
}//清除全部队伍方法
-(void)clearLeft{
    for (HeroButton*button in self.teamLeft) {
        //检测是否存在model,并加入可选数组currentheroes中
        if (button.HeroForButton) {
            [self.currentHeroes addObject:button.HeroForButton];
        }
        //.HeroForButton方法中添加了检测model是否存在的判断,否则会报invalid
         button.HeroForButton = nil;
        [button setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateDisabled];
        [button setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateHighlighted];
    }
    UIAlertView* alt = [[UIAlertView alloc]initWithTitle:nil message:@"已清空左侧队伍" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alt show];
    };
-(void)clearRight{
    //同clearLeft
    for (HeroButton*button in self.teamRight) {
        if (button.HeroForButton) {
            [self.currentHeroes addObject:button.HeroForButton];
        }
        button.HeroForButton = nil;
        [button setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateDisabled];
        [button setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateHighlighted];
    }
    UIAlertView* alt = [[UIAlertView alloc]initWithTitle:nil message:@"已清空右侧队伍" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alt show];
};
- (void)searcherLaunched{
    
    //点击搜索关键字
    [self.guessHeroes removeAllObjects];
    for (HeroButton *but in self.allTeam) {
        [but setEnabled:NO];
    }
    
    self.keyWord = self.shortCut.text;
    if(self.searcherDict[self.keyWord]){
        NSArray*arr = self.searcherDict[self.keyWord];
        [self.HeroPicker removeFromSuperview];
        for (NSNumber *number in arr) {
            HeroModel*model =  self.heroes[number.longValue];
            NSString* nameString = model.name;
            BOOL isContained = 0;
            for (HeroModel*model in self.currentHeroes) {
              
                if ([model.name isEqualToString:nameString]) {
                    isContained = YES;
                    break;
                }else{

                    continue;
                }
            }
            if (isContained) {
                [self.guessHeroes addObject:self.heroes[number.intValue]];
                          }
            
        }
        //搜索没有内容的适合报警告
        if (self.guessHeroes.count==0) {
            
            UIAlertView* alt = [[UIAlertView alloc]initWithTitle:nil message:@"已被选定" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            for (UIButton*but in self.allTeam) {
                but.enabled = YES;
            }
            [alt show];
            [self.GuessPicker removeFromSuperview];
        }else{
            
            [self.GuessPicker reloadAllComponents];
            [self.GuessPicker selectRow:(self.guessHeroes.count-1) inComponent:0 animated:NO];
            [self.view addSubview:self.GuessPicker];
            
        }
        
    }else {
        UIAlertView* alt = [[UIAlertView alloc]initWithTitle:nil message:@"无符合关键字英雄" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        for (UIButton*but in self.allTeam) {
            but.enabled = YES;
        }
        [alt show];
        [self.GuessPicker removeFromSuperview];
    }
    
}
-(void)modalButtonClicked{
    HeroModel* leftTop = [[HeroModel alloc]init];
    HeroModel* leftJun = [[HeroModel alloc]init];
    HeroModel* leftMid = [[HeroModel alloc]init];
    HeroModel* leftAd = [[HeroModel alloc]init];
    HeroModel* leftSup = [[HeroModel alloc]init];
    
    HeroModel* rightTop = [[HeroModel alloc]init];
    HeroModel* rightJun = [[HeroModel alloc]init];
    HeroModel* rightMid = [[HeroModel alloc]init];
    HeroModel* rightAd = [[HeroModel alloc]init];
    HeroModel* rightSup = [[HeroModel alloc]init];
    
    NSMutableArray *compareA =[NSMutableArray arrayWithObjects:self.memberA1,self.memberA2,self.memberA3,self.memberA4,self.memberA5, nil];
    
    int iMid = 0;
    for (HeroButton* but in compareA) {
        HeroModel*model = but.HeroForButton;
        if (iMid < model.midIndex.intValue) {
            iMid = model.midIndex.intValue;
            leftMid = model;
        }
    }
    for (HeroButton*but in compareA) {
        NSString* nameCom = but.HeroForButton.name;
        if ([nameCom isEqualToString:leftMid.name]) {
            [compareA removeObject:but];
            break;
        }
    }
    //-------------
    
    int iTop = 0;
    for (HeroButton* but in compareA) {
        HeroModel*model = but.HeroForButton;
        if (iTop < model.topIndex.intValue) {
            iTop = model.topIndex.intValue;
            leftTop = model;
        }
    }
    for (HeroButton*but in compareA) {
        NSString* nameCom = but.HeroForButton.name;
        if ([nameCom isEqualToString:leftTop.name]) {
            [compareA removeObject:but];
            break;
        }
    }
    //-------------
    int iJun = 0;
    for (HeroButton* but in compareA) {
        HeroModel*model = but.HeroForButton;
        if (iJun < model.jungleIndex.intValue) {
            iJun = model.jungleIndex.intValue;
            leftJun = model;
        }
    }
    for (HeroButton*but in compareA) {
        NSString* nameCom = but.HeroForButton.name;
        if ([nameCom isEqualToString:leftJun.name]) {
            [compareA removeObject:but];
            break;
        }
    }
    //-------------
    
    int iAd = 0;
    for (HeroButton* but in compareA) {
        HeroModel*model = but.HeroForButton;
        if (iAd < model.adIndex.intValue) {
            iAd = model.adIndex.intValue;
            leftAd = model;
        }
    }
    for (HeroButton*but in compareA) {
        NSString* nameCom = but.HeroForButton.name;
        if ([nameCom isEqualToString:leftAd.name]) {
            [compareA removeObject:but];
            break;
        }
    }
    //-------------
    leftSup = [compareA.lastObject HeroForButton];
    
    
    
    [self.teamcacheA setObject:leftTop forKey:@"leftTop"];
    [self.teamcacheA setObject:leftJun forKey:@"leftJun"];
    [self.teamcacheA setObject:leftMid forKey:@"leftMid"];
    [self.teamcacheA setObject:leftAd forKey:@"leftAd"];
    [self.teamcacheA setObject:leftSup forKey:@"leftSup"];
    
    NSMutableArray *compareB =[NSMutableArray arrayWithObjects:self.memberB1,self.memberB2,self.memberB3,self.memberB4,self.memberB5, nil];
    
    int Mid = 0;
    for (HeroButton* but in compareB) {
        HeroModel*model = but.HeroForButton;
        if (Mid < model.midIndex.intValue) {
            Mid = model.midIndex.intValue;
            rightMid = model;
        }
    }
    for (HeroButton*but in compareB) {
        NSString* nameCom = but.HeroForButton.name;
        if ([nameCom isEqualToString:rightMid.name]) {
            [compareB removeObject:but];
            break;
        }
    }
    //-------------
    
    int Top = 0;
    for (HeroButton* but in compareB) {
        HeroModel*model = but.HeroForButton;
        if (Top < model.topIndex.intValue) {
            Top = model.topIndex.intValue;
            rightTop = model;
        }
    }
    for (HeroButton*but in compareB) {
        NSString* nameCom = but.HeroForButton.name;
        if ([nameCom isEqualToString:rightTop.name]) {
            [compareB removeObject:but];
            break;
        }
    }
    //-------------
    int Jun = 0;
    for (HeroButton* but in compareB) {
        HeroModel*model = but.HeroForButton;
        if (Jun < model.jungleIndex.intValue) {
            Jun = model.jungleIndex.intValue;
            rightJun = model;
        }
    }
    for (HeroButton*but in compareB) {
        NSString* nameCom = but.HeroForButton.name;
        if ([nameCom isEqualToString:rightJun.name]) {
            [compareB removeObject:but];
            break;
        }
    }
    //-------------
    
    int Ad = 0;
    for (HeroButton* but in compareB) {
        HeroModel*model = but.HeroForButton;
        if (Ad < model.adIndex.intValue) {
            Ad = model.adIndex.intValue;
            rightAd = model;
        }
    }
    for (HeroButton*but in compareB) {
        NSString* nameCom = but.HeroForButton.name;
        if ([nameCom isEqualToString:rightAd.name]) {
            [compareB removeObject:but];
            break;
        }
    }
    //-------------
    rightSup = [compareB.lastObject HeroForButton];
    [self.teamcacheB setObject:rightTop forKey:@"rightTop"];
    [self.teamcacheB setObject:rightJun forKey:@"rightJun"];
    [self.teamcacheB setObject:rightMid forKey:@"rightMid"];
    [self.teamcacheB setObject:rightAd forKey:@"rightAd"];
    [self.teamcacheB setObject:rightSup forKey:@"rightSup"];
    
    self.coverView.memberA1.HeroForButton = [self.teamcacheA objectForKey:@"leftTop"];
    self.coverView.memberA2.HeroForButton = [self.teamcacheA objectForKey:@"leftJun"];
    self.coverView.memberA3.HeroForButton = [self.teamcacheA objectForKey:@"leftMid"];
    self.coverView.memberA4.HeroForButton = [self.teamcacheA objectForKey:@"leftAd"];
    self.coverView.memberA5.HeroForButton = [self.teamcacheA objectForKey:@"leftSup"];
    
    self.coverView.memberB1.HeroForButton = [self.teamcacheB objectForKey:@"rightTop"];
    self.coverView.memberB2.HeroForButton = [self.teamcacheB objectForKey:@"rightJun"];
    self.coverView.memberB3.HeroForButton = [self.teamcacheB objectForKey:@"rightMid"];
    self.coverView.memberB4.HeroForButton = [self.teamcacheB objectForKey:@"rightAd"];
    self.coverView.memberB5.HeroForButton = [self.teamcacheB objectForKey:@"rightSup"];
    
    [self.view addSubview:self.coverView];
    [UIVisualEffectView animateWithDuration:1.0 animations:^{
        self.coverView.transform = CGAffineTransformMakeTranslation(0, -screenHeight);
    }];
//    for (HeroButton* button in self.allTeam) {
//        [button removeFromSuperview];
//        //        button.HeroForButton  = nil;
//        
//    }
}
-(void)addCountB{
    if ([self.teamRight[0] HeroForButton]) {
        [self.view addSubview:self.countB1];
    }
    if ([self.teamRight[1] HeroForButton]) {
        [self.view addSubview:self.countB2];
    }
    if ([self.teamRight[2] HeroForButton]) {
        [self.view addSubview:self.countB3];
    }
    if ([self.teamRight[3] HeroForButton]) {
        [self.view addSubview:self.countB4];
    }
    if ([self.teamRight[4] HeroForButton]) {
        [self.view addSubview:self.countB5];
    }
}
-(void)removeCountB{
    if ([self.teamRight[0] HeroForButton]) {
        [self.countB1 removeFromSuperview];
    }
    if ([self.teamRight[1] HeroForButton]) {
        [self.countB2 removeFromSuperview];
    }
    if ([self.teamRight[2] HeroForButton]) {
        [self.countB3 removeFromSuperview];
    }
    if ([self.teamRight[3] HeroForButton]) {
        [self.countB4 removeFromSuperview];
    }
    if ([self.teamRight[4] HeroForButton]) {
        [self.countB5 removeFromSuperview];
    }
}
-(void)addCountA{
    if ([self.teamLeft[0] HeroForButton]) {
        [self.view addSubview:self.countA1];
    }
    if ([self.teamLeft[1] HeroForButton]) {
        [self.view addSubview:self.countA2];
    }
    if ([self.teamLeft[2] HeroForButton]) {
        [self.view addSubview:self.countA3];
    }
    if ([self.teamLeft[3] HeroForButton]) {
        [self.view addSubview:self.countA4];
    }
    if ([self.teamLeft[4] HeroForButton]) {
        [self.view addSubview:self.countA5];
    }
}
-(void)removeCountA{
    if ([self.teamLeft[0] HeroForButton]) {
        [self.countA1 removeFromSuperview];
    }
    if ([self.teamLeft[1] HeroForButton]) {
        [self.countA2 removeFromSuperview];
    }
    if ([self.teamLeft[2] HeroForButton]) {
        [self.countA3 removeFromSuperview];
    }
    if ([self.teamLeft[3] HeroForButton]) {
        [self.countA4 removeFromSuperview];
    }
    if ([self.teamLeft[4] HeroForButton]) {
        [self.countA5 removeFromSuperview];
    }
}
-(void)addPtnA{
    if (self.ptnA1.button.HeroForButton) {
        [self.view addSubview:self.ptnA1];
    }
    if (self.ptnA2.button.HeroForButton) {
        [self.view addSubview:self.ptnA2];
    }
    if (self.ptnA3.button.HeroForButton) {
        [self.view addSubview:self.ptnA3];
    }
    if (self.ptnA4.button.HeroForButton) {
        [self.view addSubview:self.ptnA4];
    }
    if (self.ptnA5.button.HeroForButton) {
        [self.view addSubview:self.ptnA5];
    }

}
-(void)removePtnA{
    if (self.ptnA1.button.HeroForButton) {
        [self.ptnA1 removeFromSuperview];
    }
    if (self.ptnA2.button.HeroForButton) {
        [self.ptnA2 removeFromSuperview];
    }
    if (self.ptnA3.button.HeroForButton) {
        [self.ptnA3 removeFromSuperview];
    }
    if (self.ptnA4.button.HeroForButton) {
        [self.ptnA4 removeFromSuperview];
    }
    if (self.ptnA5.button.HeroForButton) {
        [self.ptnA5 removeFromSuperview];
    }
}
-(void)addPtnB{
    if (self.ptnB1.button.HeroForButton) {
        [self.view addSubview:self.ptnB1];
    }
    if (self.ptnB2.button.HeroForButton) {
        [self.view addSubview:self.ptnB2];
    }
    if (self.ptnB3.button.HeroForButton) {
        [self.view addSubview:self.ptnB3];
    }
    if (self.ptnB4.button.HeroForButton) {
        [self.view addSubview:self.ptnB4];
    }
    if (self.ptnB5.button.HeroForButton) {
        [self.view addSubview:self.ptnB5];
    }
    
}
-(void)removePtnB{
    if (self.ptnB1.button.HeroForButton) {
        [self.ptnB1 removeFromSuperview];
    }
    if (self.ptnB2.button.HeroForButton) {
        [self.ptnB2 removeFromSuperview];
    }
    if (self.ptnB3.button.HeroForButton) {
        [self.ptnB3 removeFromSuperview];
    }
    if (self.ptnB4.button.HeroForButton) {
        [self.ptnB4 removeFromSuperview];
    }
    if (self.ptnB5.button.HeroForButton) {
        [self.ptnB5 removeFromSuperview];
    }
}
-(void)a1clicked{
    [self.modalButton removeFromSuperview];
    [self addCountB];
    [self removeCountA];
    [self addPtnA];
    [self.ptnA1 removeFromSuperview];
    [self removePtnB];
    [self.clearAButton removeFromSuperview];
    [self.clearBButton removeFromSuperview];
    if(self.memberA1.HeroForButton)
    {
        NSString *nameString = self.memberA1.HeroForButton.name;
        BOOL isContained = 0;
        for (HeroModel*model in self.currentHeroes) {
            if ([model.name isEqualToString:nameString]) {
                isContained = YES;
                break;
            }else{
                continue;
            }
        }
        if (!isContained) {
            [self.currentHeroes addObject:self.memberA1.HeroForButton];}

    }
    
    for (HeroButton *but in self.allTeam) {
        [but setEnabled:NO];
    }
            self.shortCut.placeholder = @"输入英雄关键字查找";
    self.shortCut.frame = CGRectMake(10+btnSize, 50-btnSize+txtpicGap, textSize, btnSize);
    self.searchLaunch.frame = CGRectMake(13+btnSize*3.5, 50-btnSize+txtpicGap, btnSize*0.6, btnSize);

        [self.HeroPicker reloadAllComponents];
        [self.GuessPicker reloadAllComponents];

    [self.view addSubview:self.searchLaunch];
    [self.view addSubview:self.shortCut];
     self.GuessPicker.frame =CGRectMake(btnSize, 50-btnSize, 202, 162);
    self.HeroPicker.frame = CGRectMake(btnSize, 50-btnSize, 202, 162);
    [self.view addSubview: self.HeroPicker];
    [self.clickedBtn addObject:self.memberA1];
      [self.HeroPicker selectRow:(self.currentHeroes.count-1) inComponent:0 animated:NO];
  
}
-(void)a2clicked{
        [self.modalButton removeFromSuperview];
    [self addCountB];
    [self removeCountA];
    [self addPtnA];
    [self.ptnA2 removeFromSuperview];
    [self removePtnB];
    [self.clearAButton removeFromSuperview];
    [self.clearBButton removeFromSuperview];
    if(self.memberA2.HeroForButton)
    {
        NSString *nameString = self.memberA2.HeroForButton.name;
        BOOL isContained = 0;
        for (HeroModel*model in self.currentHeroes) {
            if ([model.name isEqualToString:nameString]) {
                isContained = YES;
                break;
            }else{
                continue;
            }
        }
        if (!isContained) {
            [self.currentHeroes addObject:self.memberA2.HeroForButton];}

    }
    for (HeroButton *but in self.allTeam) {
        [but setEnabled:NO];
    }
                self.shortCut.placeholder = @"输入英雄关键字查找";
    self.shortCut.frame = CGRectMake(10+btnSize, 50+20+txtpicGap, textSize, btnSize);
    self.searchLaunch.frame = CGRectMake(13+btnSize*3.5, 50+20+txtpicGap, btnSize*0.6, btnSize);

    [self.HeroPicker reloadAllComponents];
    [self.GuessPicker reloadAllComponents];
    [self.view addSubview:self.searchLaunch];
    [self.view addSubview:self.shortCut];
     self.GuessPicker.frame =CGRectMake(btnSize, 50+20, 202, 162);
    self.HeroPicker.frame = CGRectMake(btnSize, 50+20, 202, 162);
    [self.view addSubview: self.HeroPicker];
     [self.clickedBtn addObject:self.memberA2];
    [self.HeroPicker selectRow:(self.currentHeroes.count-1) inComponent:0 animated:NO];
}
-(void)a3clicked{
    [self.modalButton removeFromSuperview];
    [self addCountB];
    [self removeCountA];
    [self addPtnA];
    [self.ptnA3 removeFromSuperview];
    [self removePtnB];
    [self.clearAButton removeFromSuperview];
    [self.clearBButton removeFromSuperview];
    if(self.memberA3.HeroForButton)
    {
        NSString *nameString = self.memberA3.HeroForButton.name;
        BOOL isContained = 0;
        for (HeroModel*model in self.currentHeroes) {
            if ([model.name isEqualToString:nameString]) {
                isContained = YES;
                break;
            }else{
                continue;
            }
        }
        if (!isContained) {
            [self.currentHeroes addObject:self.memberA3.HeroForButton];}

    }
    for (HeroButton *but in self.allTeam) {
        [but setEnabled:NO];
    }
    self.shortCut.placeholder = @"输入英雄关键字查找";
    self.shortCut.frame = CGRectMake(10+btnSize, 70+btnSize+20+txtpicGap, textSize, btnSize);
    self.searchLaunch.frame = CGRectMake(13+btnSize*3.5, 70+btnSize+20+txtpicGap, btnSize*0.6, btnSize);

    [self.HeroPicker reloadAllComponents];
    [self.GuessPicker reloadAllComponents];
    [self.view addSubview:self.searchLaunch];
    [self.view addSubview:self.shortCut];
    self.GuessPicker.frame =CGRectMake(btnSize, 70+btnSize+20, 202, 162);
    self.HeroPicker.frame = CGRectMake(btnSize, 70+btnSize+20, 202, 162);
    [self.view addSubview: self.HeroPicker];
    [self.clickedBtn addObject:self.memberA3];
    [self.HeroPicker selectRow:(self.currentHeroes.count-1) inComponent:0 animated:NO];
}
-(void)a4clicked{
    [self.modalButton removeFromSuperview];
    [self addCountB];
    [self removeCountA];
    [self addPtnA];
    [self.ptnA4 removeFromSuperview];
    [self removePtnB];
    [self.clearAButton removeFromSuperview];
    [self.clearBButton removeFromSuperview];
    if(self.memberA4.HeroForButton)
    {
        NSString *nameString = self.memberA4.HeroForButton.name;
        BOOL isContained = 0;
        for (HeroModel*model in self.currentHeroes) {
            if ([model.name isEqualToString:nameString]) {
                isContained = YES;
                break;
            }else{
                continue;
            }
        }
        if (!isContained) {
            [self.currentHeroes addObject:self.memberA4.HeroForButton];}
        
    }
    for (HeroButton *but in self.allTeam) {
        [but setEnabled:NO];
    }
                self.shortCut.placeholder = @"输入英雄关键字查找";
    self.shortCut.frame = CGRectMake(10+btnSize,70+(btnSize+20)*2+txtpicGap ,textSize, btnSize);
    self.searchLaunch.frame = CGRectMake(13+btnSize*3.5, 70+(btnSize+20)*2+txtpicGap,btnSize*0.6, btnSize);
  //  self.lockButton.frame = CGRectMake(18+btnSize*4.6, self.searchLaunch.frame.origin.y, btnSize, btnSize);
   // [self.view addSubview:self.lockButton];

    [self.HeroPicker reloadAllComponents];
    [self.GuessPicker reloadAllComponents];
    [self.view addSubview:self.searchLaunch];
    [self.view addSubview:self.shortCut];
    self.GuessPicker.frame =CGRectMake(btnSize, 70+(btnSize+20)*2, 202, 162);
    self.HeroPicker.frame = CGRectMake(btnSize, 70+(btnSize+20)*2, 202, 162);
    [self.view addSubview: self.HeroPicker];
    [self.clickedBtn addObject:self.memberA4];
   
    [self.HeroPicker selectRow:(self.currentHeroes.count-1) inComponent:0 animated:NO];
}
-(void)a5clicked{
    [self.modalButton removeFromSuperview];
    [self addCountB];
    [self removeCountA];
    [self addPtnA];
    [self.ptnA5 removeFromSuperview];
    [self removePtnB];
    [self.clearAButton removeFromSuperview];
    [self.clearBButton removeFromSuperview];
    if(self.memberA5.HeroForButton)
    {
        NSString *nameString = self.memberA5.HeroForButton.name;
        BOOL isContained = 0;
        for (HeroModel*model in self.currentHeroes) {
            if ([model.name isEqualToString:nameString]) {
                isContained = YES;
                break;
            }else{
                continue;
            }
        }
        if (!isContained) {
            [self.currentHeroes addObject:self.memberA5.HeroForButton];}
        
    }
    for (HeroButton *but in self.allTeam) {
        [but setEnabled:NO];
    }
                self.shortCut.placeholder = @"输入英雄关键字查找";
    self.shortCut.frame = CGRectMake(10+btnSize*1.5,(btnSize+20)*6+10 , textSize, btnSize);
    self.searchLaunch.frame = CGRectMake(13+btnSize*4, (btnSize+20)*6+10 ,btnSize*0.6, btnSize);
    
    [self.HeroPicker reloadAllComponents];
    [self.GuessPicker reloadAllComponents];
    [self.view addSubview:self.searchLaunch];
    [self.view addSubview:self.shortCut];
    self.GuessPicker.frame =CGRectMake(btnSize, 70+(btnSize+20)*3, 202, 162);
    self.HeroPicker.frame = CGRectMake(btnSize, 70+(btnSize+20)*3, 202, 162);
    [self.view addSubview: self.HeroPicker];
    [self.clickedBtn addObject:self.memberA5];
    
    [self.HeroPicker selectRow:(self.currentHeroes.count-1) inComponent:0 animated:NO];
   
    
}
-(void)b1clicked{
    [self.modalButton removeFromSuperview];
    [self addCountA];
    [self removeCountB];
    [self addPtnB];
    [self.ptnB1 removeFromSuperview];
    [self removePtnA];
    [self.clearAButton removeFromSuperview];
    [self.clearBButton removeFromSuperview];
    if(self.memberB1.HeroForButton)
    {
        NSString *nameString = self.memberB1.HeroForButton.name;
        BOOL isContained = 0;
        for (HeroModel*model in self.currentHeroes) {
            if ([model.name isEqualToString:nameString]) {
                isContained = YES;
                break;
            }else{
                continue;
            }
        }
        if (!isContained) {
            [self.currentHeroes addObject:self.memberB1.HeroForButton];}
        
    }
    
    for (HeroButton *but in self.allTeam) {
        [but setEnabled:NO];
    }
                self.shortCut.placeholder = @"输入英雄关键字查找";
    self.shortCut.frame = CGRectMake(10+btnSize*1.5, 50-btnSize+txtpicGap, textSize, btnSize);
    self.searchLaunch.frame = CGRectMake(13+btnSize*4, 50-btnSize+txtpicGap, btnSize*0.6, btnSize);
    
    [self.HeroPicker reloadAllComponents];
    [self.GuessPicker reloadAllComponents];
    [self.view addSubview:self.searchLaunch];
    [self.view addSubview:self.shortCut];
    self.GuessPicker.frame =CGRectMake(screenWidth-5-btnSize-190, 50-btnSize, 202, 162);
    self.HeroPicker.frame = CGRectMake(screenWidth-5-btnSize-190, 50-btnSize, 202, 162);
    [self.view addSubview: self.HeroPicker];
    [self.clickedBtn addObject:self.memberB1];
    [self.HeroPicker selectRow:(self.currentHeroes.count-1) inComponent:0 animated:NO];
    
}
-(void)b2clicked{
        [self.modalButton removeFromSuperview];
    [self addCountA];
    [self removeCountB];
    [self addPtnB];
    [self.ptnB2 removeFromSuperview];
    [self removePtnA];
    [self.clearAButton removeFromSuperview];
    [self.clearBButton removeFromSuperview];
    if(self.memberB2.HeroForButton)
        {
            NSString *nameString = self.memberB2.HeroForButton.name;
            BOOL isContained = 0;
            for (HeroModel*model in self.currentHeroes) {
                if ([model.name isEqualToString:nameString]) {
                    isContained = YES;
                    break;
                }else{
                    continue;
                }
            }
            if (!isContained) {
                [self.currentHeroes addObject:self.memberB2.HeroForButton];}
            
        }
    for (HeroButton *but in self.allTeam) {
        [but setEnabled:NO];
    }
                self.shortCut.placeholder = @"输入英雄关键字查找";
    self.shortCut.frame = CGRectMake(10+btnSize*1.5, 50+20+txtpicGap, textSize, btnSize);
    self.searchLaunch.frame = CGRectMake(13+btnSize*4, 50+20+txtpicGap, btnSize*0.6, btnSize);

    [self.HeroPicker reloadAllComponents];
    [self.GuessPicker reloadAllComponents];
    [self.view addSubview:self.searchLaunch];
    [self.view addSubview:self.shortCut];
    self.GuessPicker.frame =CGRectMake(screenWidth-5-btnSize-190, 50+20, 202, 162);
    self.HeroPicker.frame = CGRectMake(screenWidth-5-btnSize-190, 50+20, 202, 162);
    [self.view addSubview: self.HeroPicker];
    [self.clickedBtn addObject:self.memberB2];
    [self.HeroPicker selectRow:(self.currentHeroes.count-1) inComponent:0 animated:NO];
}
-(void)b3clicked{
    [self.modalButton removeFromSuperview];
    [self addCountA];
    [self removeCountB];
    [self addPtnB];
    [self.ptnB3 removeFromSuperview];
    [self removePtnA];
    [self.clearAButton removeFromSuperview];
    [self.clearBButton removeFromSuperview];
    if(self.memberB3.HeroForButton)
    {
        NSString *nameString = self.memberB3.HeroForButton.name;
        BOOL isContained = 0;
        for (HeroModel*model in self.currentHeroes) {
            if ([model.name isEqualToString:nameString]) {
                isContained = YES;
                break;
            }else{
                continue;
            }
        }
        if (!isContained) {
            [self.currentHeroes addObject:self.memberB3.HeroForButton];}
        
    }
    for (HeroButton *but in self.allTeam) {
        [but setEnabled:NO];
    }
                self.shortCut.placeholder = @"输入英雄关键字查找";
    self.shortCut.frame = CGRectMake(10+btnSize*1.5, 70+btnSize+20+txtpicGap, textSize, btnSize);
    self.searchLaunch.frame = CGRectMake(13+btnSize*4, 70+btnSize+20+txtpicGap, btnSize*0.6, btnSize);

    [self.HeroPicker reloadAllComponents];
    [self.GuessPicker reloadAllComponents];
    [self.view addSubview:self.searchLaunch];
    [self.view addSubview:self.shortCut];
    self.GuessPicker.frame =CGRectMake(screenWidth-5-btnSize-190, 70+btnSize+20, 202, 162);
    self.HeroPicker.frame = CGRectMake(screenWidth-5-btnSize-190, 70+btnSize+20, 202, 162);
    [self.view addSubview: self.HeroPicker];
    [self.clickedBtn addObject:self.memberB3];
    [self.HeroPicker selectRow:(self.currentHeroes.count-1) inComponent:0 animated:NO];
}
-(void)b4clicked{
    [self.modalButton removeFromSuperview];
    [self addCountA];
    [self removeCountB];
    [self addPtnB];
    [self.ptnB4 removeFromSuperview];
    [self removePtnA];
    [self.clearAButton removeFromSuperview];
    [self.clearBButton removeFromSuperview];
    if(self.memberB4.HeroForButton)
    {
        NSString *nameString = self.memberB4.HeroForButton.name;
        BOOL isContained = 0;
        for (HeroModel*model in self.currentHeroes) {
            if ([model.name isEqualToString:nameString]) {
                isContained = YES;
                break;
            }else{
                continue;
            }
        }
        if (!isContained) {
            [self.currentHeroes addObject:self.memberB4.HeroForButton];}
        
    }

    for (HeroButton *but in self.allTeam) {
        [but setEnabled:NO];
    }
                self.shortCut.placeholder = @"输入英雄关键字查找";
    self.shortCut.frame = CGRectMake(10+btnSize*1.5,70+(btnSize+20)*2+txtpicGap , textSize, btnSize);
    self.searchLaunch.frame = CGRectMake(13+btnSize*4, 70+(btnSize+20)*2+txtpicGap,btnSize*0.6, btnSize);

    [self.HeroPicker reloadAllComponents];
    [self.GuessPicker reloadAllComponents];
    [self.view addSubview:self.searchLaunch];
    [self.view addSubview:self.shortCut];
    self.GuessPicker.frame =CGRectMake(screenWidth-5-btnSize-190, 70+(btnSize+20)*2, 202, 162);
    self.HeroPicker.frame = CGRectMake(screenWidth-5-btnSize-190, 70+(btnSize+20)*2, 202, 162);
    [self.view addSubview: self.HeroPicker];
    [self.clickedBtn addObject:self.memberB4];
    [self.HeroPicker selectRow:(self.currentHeroes.count-1) inComponent:0 animated:NO];
}
-(void)b5clicked{
    [self.modalButton removeFromSuperview];
    [self addCountA];
    [self removeCountB];
    [self addPtnB];
    [self.ptnB5 removeFromSuperview];
    [self removePtnA];
    
    [self.clearAButton removeFromSuperview];
    [self.clearBButton removeFromSuperview];
    if(self.memberB5.HeroForButton)
    {
        NSString *nameString = self.memberB5.HeroForButton.name;
        BOOL isContained = 0;
        for (HeroModel*model in self.currentHeroes) {
            if ([model.name isEqualToString:nameString]) {
                isContained = YES;
                break;
            }else{
                continue;
            }
        }
        if (!isContained) {
            [self.currentHeroes addObject:self.memberB5.HeroForButton];}
        
    }
    for (HeroButton *but in self.allTeam) {
        [but setEnabled:NO];
    }
                self.shortCut.placeholder = @"输入英雄关键字查找";
    self.shortCut.frame = CGRectMake(10+btnSize*1.5,(btnSize+20)*6+10, textSize, btnSize);
    self.searchLaunch.frame = CGRectMake(13+btnSize*4, (btnSize+20)*6+10,btnSize*0.6, btnSize);

    [self.HeroPicker reloadAllComponents];
    [self.GuessPicker reloadAllComponents];
    [self.view addSubview:self.searchLaunch];
    [self.view addSubview:self.shortCut];
    self.GuessPicker.frame =CGRectMake(screenWidth-5-btnSize-190, 70+(btnSize+20)*3, 202, 162);
    self.HeroPicker.frame = CGRectMake(screenWidth-5-btnSize-190, 70+(btnSize+20)*3, 202, 162);
    [self.view addSubview: self.HeroPicker];
    [self.clickedBtn addObject:self.memberB5];
    [self.HeroPicker selectRow:(self.currentHeroes.count-1) inComponent:0 animated:NO];
    
}
-(void)ban1Clicked{
    [self.modalButton removeFromSuperview];
    [self.clearAButton removeFromSuperview];
    [self.clearBButton removeFromSuperview];
    if(self.Banned1.HeroForButton)
    {
        NSString *nameString = self.Banned1.HeroForButton.name;
        BOOL isContained = 0;
        for (HeroModel*model in self.currentHeroes) {
            if ([model.name isEqualToString:nameString]) {
                isContained = YES;
                break;
            }else{
                continue;
            }
        }
        if (!isContained) {
            [self.currentHeroes addObject:self.Banned1.HeroForButton];}
        
    }
    for (HeroButton *but in self.allTeam) {
        [but setEnabled:NO];
    }
    
    self.shortCut.placeholder = @"禁用英雄";
    self.shortCut.frame = CGRectMake(10+btnSize,(btnSize+20)*6+10, btnSize*3, btnSize);
    self.searchLaunch.frame = CGRectMake(13+btnSize*4, (btnSize+20)*6+10,btnSize*0.6, btnSize);
    //self.lockButton.frame = CGRectMake(18+btnSize*4.6, self.searchLaunch.frame.origin.y, btnSize, btnSize);
    //[self.view addSubview:self.lockButton];

    [self.HeroPicker reloadAllComponents];
    [self.GuessPicker reloadAllComponents];
    [self.view addSubview:self.searchLaunch];
    [self.view addSubview:self.shortCut];
    self.GuessPicker.frame =CGRectMake(5+btnSize, 40+(btnSize+20)*3, 202, 162);
    self.HeroPicker.frame = CGRectMake(5+btnSize, 40+(btnSize+20)*3, 202, 162);
    
    [self.view addSubview: self.HeroPicker];
    [self.clickedBtn addObject:self.Banned1];
    [self.HeroPicker selectRow:(self.currentHeroes.count-1) inComponent:0 animated:NO];
    
}
-(void)ban2Clicked{
    [self.clearAButton removeFromSuperview];
    [self.clearBButton removeFromSuperview];
    [self.modalButton removeFromSuperview];
    if(self.Banned2.HeroForButton)
    {
        NSString *nameString = self.Banned2.HeroForButton.name;
        BOOL isContained = 0;
        for (HeroModel*model in self.currentHeroes) {
            if ([model.name isEqualToString:nameString]) {
                isContained = YES;
                break;
            }else{
                continue;
            }
        }
        if (!isContained) {
            [self.currentHeroes addObject:self.Banned2.HeroForButton];}
        
    }
    for (HeroButton *but in self.allTeam) {
        [but setEnabled:NO];
    }
   
    self.shortCut.placeholder = @"禁用英雄";
    self.shortCut.frame = CGRectMake(10+btnSize,(btnSize+20)*6+10, btnSize*3, btnSize);
    self.searchLaunch.frame = CGRectMake(13+btnSize*4, (btnSize+20)*6+10,btnSize*0.6, btnSize);
    //self.lockButton.frame = CGRectMake(18+btnSize*4.6, self.searchLaunch.frame.origin.y, btnSize, btnSize);
    //[self.view addSubview:self.lockButton];

    [self.HeroPicker reloadAllComponents];
    [self.GuessPicker reloadAllComponents];
    [self.view addSubview:self.searchLaunch];
    [self.view addSubview:self.shortCut];
    self.GuessPicker.frame =CGRectMake(5+btnSize, 40+(btnSize+20)*3, 202, 162);
    self.HeroPicker.frame = CGRectMake(5+btnSize, 40+(btnSize+20)*3, 202, 162);
    
    [self.view addSubview: self.HeroPicker];
    [self.clickedBtn addObject:self.Banned2];
    [self.HeroPicker selectRow:(self.currentHeroes.count-1) inComponent:0 animated:NO];
    
}
-(void)ban3Clicked{
    [self.clearAButton removeFromSuperview];
    [self.clearBButton removeFromSuperview];
    [self.modalButton removeFromSuperview];
    if(self.Banned3.HeroForButton)
    {
        NSString *nameString = self.Banned3.HeroForButton.name;
        BOOL isContained = 0;
        for (HeroModel*model in self.currentHeroes) {
            if ([model.name isEqualToString:nameString]) {
                isContained = YES;
                break;
            }else{
                continue;
            }
        }
        if (!isContained) {
            [self.currentHeroes addObject:self.Banned3.HeroForButton];}
        
    }

    for (HeroButton *but in self.allTeam) {
        [but setEnabled:NO];
    }
    
    self.shortCut.placeholder = @"禁用英雄";
    self.shortCut.frame = CGRectMake(10+btnSize,(btnSize+20)*6+10, btnSize*3, btnSize);
    self.searchLaunch.frame = CGRectMake(13+btnSize*4, (btnSize+20)*6+10,btnSize*0.6, btnSize);
    //self.lockButton.frame = CGRectMake(18+btnSize*4.6, self.searchLaunch.frame.origin.y, btnSize, btnSize);
    //[self.view addSubview:self.lockButton];

    [self.HeroPicker reloadAllComponents];
    [self.GuessPicker reloadAllComponents];
    [self.view addSubview:self.searchLaunch];
    [self.view addSubview:self.shortCut];
    self.GuessPicker.frame =CGRectMake(5+btnSize, 40+(btnSize+20)*3, 202, 162);
    self.HeroPicker.frame = CGRectMake(5+btnSize, 40+(btnSize+20)*3, 202, 162);
    
    [self.view addSubview: self.HeroPicker];
    [self.clickedBtn addObject:self.Banned3];
    [self.HeroPicker selectRow:(self.currentHeroes.count-1) inComponent:0 animated:NO];
    
}
-(void)ban4Clicked{
    [self.clearAButton removeFromSuperview];
    [self.clearBButton removeFromSuperview];
    [self.modalButton removeFromSuperview];
    if(self.Banned4.HeroForButton)
    {
        NSString *nameString = self.Banned4.HeroForButton.name;
        BOOL isContained = 0;
        for (HeroModel*model in self.currentHeroes) {
            if ([model.name isEqualToString:nameString]) {
                isContained = YES;
                break;
            }else{
                continue;
            }
        }
        if (!isContained) {
            [self.currentHeroes addObject:self.Banned4.HeroForButton];}
        
    }

    for (HeroButton *but in self.allTeam) {
        [but setEnabled:NO];
    }
    
    self.shortCut.placeholder = @"禁用英雄";
    self.shortCut.frame = CGRectMake(10+btnSize,(btnSize+20)*6+10, btnSize*3, btnSize);
    self.searchLaunch.frame = CGRectMake(13+btnSize*4, (btnSize+20)*6+10,btnSize*0.6, btnSize);
  //  self.lockButton.frame = CGRectMake(18+btnSize*4.6, self.searchLaunch.frame.origin.y, btnSize, btnSize);
    //[self.view addSubview:self.lockButton];

    [self.HeroPicker reloadAllComponents];
    [self.GuessPicker reloadAllComponents];
    [self.view addSubview:self.searchLaunch];
    [self.view addSubview:self.shortCut];
    self.GuessPicker.frame =CGRectMake(5+btnSize, 40+(btnSize+20)*3, 202, 162);
    self.HeroPicker.frame = CGRectMake(5+btnSize, 40+(btnSize+20)*3, 202, 162);

    
    [self.view addSubview: self.HeroPicker];
    [self.clickedBtn addObject:self.Banned4];
    [self.HeroPicker selectRow:(self.currentHeroes.count-1) inComponent:0 animated:NO];
    
}
-(void)ban5Clicked{
    [self.clearAButton removeFromSuperview];
    [self.clearBButton removeFromSuperview];
    [self.modalButton removeFromSuperview];
    if(self.Banned5.HeroForButton)
    {
        NSString *nameString = self.Banned5.HeroForButton.name;
        BOOL isContained = 0;
        for (HeroModel*model in self.currentHeroes) {
            if ([model.name isEqualToString:nameString]) {
                isContained = YES;
                break;
            }else{
                continue;
            }
        }
        if (!isContained) {
            [self.currentHeroes addObject:self.Banned5.HeroForButton];}
        
    }
    for (HeroButton *but in self.allTeam) {
        [but setEnabled:NO];
    }
    
    self.shortCut.placeholder = @"禁用英雄";
    self.shortCut.frame = CGRectMake(10+btnSize,(btnSize+20)*6+10, btnSize*3, btnSize);
    self.searchLaunch.frame = CGRectMake(13+btnSize*4, (btnSize+20)*6+10,btnSize*0.6, btnSize);
   // self.lockButton.frame = CGRectMake(18+btnSize*4.6, self.searchLaunch.frame.origin.y, btnSize, btnSize);
    //[self.view addSubview:self.lockButton];

    [self.HeroPicker reloadAllComponents];
    [self.GuessPicker reloadAllComponents];
    [self.view addSubview:self.searchLaunch];
    [self.view addSubview:self.shortCut];
    self.GuessPicker.frame =CGRectMake(5+btnSize, 40+(btnSize+20)*3, 202, 162);
    self.HeroPicker.frame = CGRectMake(5+btnSize, 40+(btnSize+20)*3, 202, 162);
    
    [self.view addSubview: self.HeroPicker];
    [self.clickedBtn addObject:self.Banned5];
    [self.HeroPicker selectRow:(self.currentHeroes.count-1) inComponent:0 animated:NO];
    
}
-(void)ban6Clicked{
    [self.clearAButton removeFromSuperview];
    [self.clearBButton removeFromSuperview];
    [self.modalButton removeFromSuperview];
    if(self.Banned6.HeroForButton)
    {
        NSString *nameString = self.Banned6.HeroForButton.name;
        BOOL isContained = 0;
        for (HeroModel*model in self.currentHeroes) {
            if ([model.name isEqualToString:nameString]) {
                isContained = YES;
                break;
            }else{
                continue;
            }
        }
        if (!isContained) {
            [self.currentHeroes addObject:self.Banned6.HeroForButton];}
        
    }

    for (HeroButton *but in self.allTeam) {
        [but setEnabled:NO];
    }
    
    self.shortCut.placeholder = @"禁用英雄";
    self.shortCut.frame = CGRectMake(10+btnSize,(btnSize+20)*6+10, btnSize*3, btnSize);
    self.searchLaunch.frame = CGRectMake(13+btnSize*4, (btnSize+20)*6+10,btnSize*0.6, btnSize);
   // self.lockButton.frame = CGRectMake(18+btnSize*4.6, self.searchLaunch.frame.origin.y, btnSize, btnSize);
    //[self.view addSubview:self.lockButton];

    [self.HeroPicker reloadAllComponents];
    [self.GuessPicker reloadAllComponents];
    [self.view addSubview:self.searchLaunch];
    [self.view addSubview:self.shortCut];
    self.GuessPicker.frame =CGRectMake(5+btnSize, 40+(btnSize+20)*3, 202, 162);
    self.HeroPicker.frame = CGRectMake(5+btnSize, 40+(btnSize+20)*3, 202, 162);
    
    [self.view addSubview: self.HeroPicker];
    [self.clickedBtn addObject:self.Banned6];
    [self.HeroPicker selectRow:(self.currentHeroes.count-1) inComponent:0 animated:NO];
    
}

#pragma mark pickerView方法
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    for (HeroButton *but in self.allTeam) {
        [but setEnabled:YES];
    }
    if(pickerView == self.HeroPicker ){
        HeroModel*temp = self.currentHeroes[row];

        
        HeroButton*tempBtn  = self.clickedBtn.lastObject;

        [self.HeroPicker removeFromSuperview];
        [self.shortCut removeFromSuperview];
        [self.searchLaunch removeFromSuperview];
        tempBtn.HeroForButton  = temp;
        
    }else{
        HeroModel* tempModel = self.guessHeroes[row];
        [self.currentHeroes removeObject:tempModel];
        HeroButton*tempBtn2 = self.clickedBtn.lastObject;
        tempBtn2.HeroForButton = tempModel;

        [self.GuessPicker removeFromSuperview];
        [self.shortCut removeFromSuperview];
        [self.searchLaunch removeFromSuperview];
        
    }
    [self.view addSubview:self.clearAButton];
    [self.view addSubview:self.clearBButton];
    [self removeCountA];
    [self removeCountB];
    [self removePtnA];
    [self removePtnB];
    for (HeroButton*button in self.allTeam) {
        if (button.HeroForButton) {
            NSString*tempStr = button.HeroForButton.name;
            NSMutableArray *arr = [NSMutableArray array];
            for (int i = 0; i<self.currentHeroes.count; i++) {
                [arr addObject:self.currentHeroes[i]];
            }
            
            for (HeroModel*model in arr) {
                if ([model.name isEqualToString:tempStr]) {
                    [self.currentHeroes removeObject:model];

                }
            }
        }
    }
    BOOL allPicked = YES;
    for (HeroButton* but in self.teamLeft) {
        if (!but.HeroForButton) {
            allPicked = NO;
            break;
        }
    }
    for (HeroButton* but in self.teamRight) {
        if (!but.HeroForButton) {
            allPicked = NO;
            break;
        }
    }
    
    if (allPicked) {
        [self.view addSubview:self.modalButton];
    }
}
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if(pickerView == self.HeroPicker)
    {
        HeroPickerView *pickerviewtemp = [HeroPickerView heroPickerView];
        pickerviewtemp.hero = self.currentHeroes[row];
        pickerviewtemp.label.font = [UIFont systemFontOfSize:11];
        return pickerviewtemp;
    }else{
        HeroPickerView* guessPickerview = [HeroPickerView heroPickerView];
        guessPickerview.hero = self.guessHeroes[row];
        guessPickerview.label.font = [UIFont systemFontOfSize:11];
        return guessPickerview;
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
   if(pickerView==self.HeroPicker)
   { return 60;}
   else{
       return 60;
   }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if(pickerView==self.HeroPicker)
    { return 1;}
    else{
        return 1;
    }

}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView==self.HeroPicker) {
        return self.currentHeroes.count;
    }else{
    return self.guessHeroes.count;
    }
}

#pragma mark 懒加载
-(UIPickerView*)currentPicker{
    _currentPicker = [UIPickerView new];
    return _currentPicker;
}
-(HeroModel *)tempHero{
    
    _tempHero = [[HeroModel alloc]init];
    return _tempHero;
}
-(NSMutableDictionary *)teamcacheA{
    if (!_teamcacheA) {
        _teamcacheA = [[NSMutableDictionary alloc]initWithCapacity:5];
        
    }return _teamcacheA;
}
-(NSMutableDictionary *)teamcacheB{
    if (!_teamcacheB) {
        _teamcacheB = [[NSMutableDictionary alloc]initWithCapacity:5];
    }return _teamcacheB;
}
-(ConlusionView *)coverView{
    if (!_coverView) {
        
        CGRect rect = CGRectMake(0, screenHeight, screenWidth, screenHeight);
        _coverView = [[ConlusionView alloc]initWithFrame:rect];
//        [_coverView setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
        _coverView.delegate = self;
        
    }return _coverView;
}
-(HeroButton *)memberA1{
    if (!_memberA1) {
        _memberA1 = [[HeroButton alloc]initWithFrame:CGRectMake(5,40 , btnSize, btnSize)];
        [_memberA1 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateNormal];
        [_memberA1 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateDisabled];
    } return _memberA1;
}
-(HeroButton *)memberA2{
    if (!_memberA2) {
        _memberA2 = [[HeroButton alloc]initWithFrame:CGRectMake(5,40+btnSize+20 , btnSize, btnSize)];
        [_memberA2 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateNormal];
        [_memberA2 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateDisabled];
    } return _memberA2;
}
-(HeroButton *)memberA3{
    if (!_memberA3) {
        _memberA3 = [[HeroButton alloc]initWithFrame:CGRectMake(5,40+(btnSize+20)*2 , btnSize, btnSize)];
        [_memberA3 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateDisabled];
        [_memberA3 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateNormal];
    } return _memberA3;
}
-(HeroButton *)memberA4{
    if (!_memberA4) {
        _memberA4 = [[HeroButton alloc]initWithFrame:CGRectMake(5,40+(btnSize+20)*3 , btnSize, btnSize)];
        [_memberA4 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateNormal];
        [_memberA4 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateDisabled];
    } return _memberA4;
}
-(HeroButton *)memberA5{
    if (!_memberA5) {
        _memberA5 = [[HeroButton alloc]initWithFrame:CGRectMake(5,40+(btnSize+20)*4 , btnSize, btnSize)];
        [_memberA5 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateNormal];
        [_memberA5 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateDisabled];
    } return _memberA5;
}
-(HeroButton *)memberB1{
    if (!_memberB1) {
        _memberB1 = [[HeroButton alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize,40 , btnSize, btnSize)];
        [_memberB1 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateNormal];
        [_memberB1 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateDisabled];
    } return _memberB1;
}
-(HeroButton *)memberB2{
    if (!_memberB2) {
        _memberB2 = [[HeroButton alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize,40+btnSize+20 , btnSize, btnSize)];
        [_memberB2 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateNormal];
        [_memberB2 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateDisabled];
    } return _memberB2;
}
-(HeroButton *)memberB3{
    if (!_memberB3) {
        _memberB3 = [[HeroButton alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize,40+(btnSize+20)*2 , btnSize, btnSize)];
        [_memberB3 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateNormal];
        [_memberB3 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateDisabled];
    } return _memberB3;
}
-(HeroButton *)memberB4{
    if (!_memberB4) {
        _memberB4 = [[HeroButton alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize,40+(btnSize+20)*3 , btnSize, btnSize)];
        [_memberB4 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateNormal];
        [_memberB4 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateDisabled];
    } return _memberB4;
}
-(HeroButton *)memberB5{
    if (!_memberB5) {
        _memberB5 = [[HeroButton alloc]initWithFrame:CGRectMake(screenWidth-5-btnSize,40+(btnSize+20)*4 , btnSize, btnSize)];
        [_memberB5 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateNormal];
        [_memberB5 setBackgroundImage:[UIImage imageNamed:@"placeholder.jpg"] forState:UIControlStateDisabled];
    } return _memberB5;
}

-(HeroButton *)Banned1{
    if (!_Banned1) {
        UILabel* banTitleA = [[UILabel alloc]initWithFrame:CGRectMake(5, 40+(btnSize+20)*5, btnSize-10, 22)];
        banTitleA.text = @"禁用";
        
        banTitleA.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
        banTitleA.textAlignment = NSTextAlignmentCenter;
        banTitleA.textColor = [UIColor orangeColor];
        banTitleA.backgroundColor = [UIColor clearColor];
        [self.view addSubview:banTitleA];
        _Banned1 = [[HeroButton alloc]initWithFrame:CGRectMake(5,60+(btnSize+20)*5  , btnSize-10, btnSize-10)];
        [_Banned1 setBackgroundImage:[UIImage imageNamed:@"forbiddenMark"] forState:UIControlStateNormal];
        [_Banned1 setBackgroundImage:[UIImage imageNamed:@"forbiddenMark"] forState:UIControlStateDisabled];
    } return _Banned1;
}
-(HeroButton *)Banned2{
    if (!_Banned2) {
        _Banned2 = [[HeroButton alloc]initWithFrame:CGRectMake(5,50+(btnSize+20)*5+btnSize  , btnSize-10, btnSize-10)];
        [_Banned2 setBackgroundImage:[UIImage imageNamed:@"forbiddenMark"] forState:UIControlStateNormal];
        [_Banned2 setBackgroundImage:[UIImage imageNamed:@"forbiddenMark"] forState:UIControlStateDisabled];
    } return _Banned2;
}
-(HeroButton *)Banned3{
    if (!_Banned3) {
        _Banned3 = [[HeroButton alloc]initWithFrame:CGRectMake(5,40+(btnSize+20)*5+btnSize*2  , btnSize-10, btnSize-10)];
        [_Banned3 setBackgroundImage:[UIImage imageNamed:@"forbiddenMark"] forState:UIControlStateNormal];
        [_Banned3 setBackgroundImage:[UIImage imageNamed:@"forbiddenMark"] forState:UIControlStateDisabled];
    } return _Banned3;
}
-(HeroButton *)Banned4{
    if (!_Banned4) {
        UILabel* banTitleB = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth-btnSize,40+(btnSize+20)*5 , btnSize-10, 22)];
        banTitleB.text = @"禁用";
        
        banTitleB.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
        banTitleB.textAlignment = NSTextAlignmentCenter;
        banTitleB.textColor = [UIColor orangeColor];
        banTitleB.backgroundColor = [UIColor clearColor];
        [self.view addSubview:banTitleB];
        _Banned4 = [[HeroButton alloc]initWithFrame:CGRectMake(screenWidth-btnSize+3, 60+(btnSize+20)*5   , btnSize-10, btnSize-10)];
        [_Banned4 setBackgroundImage:[UIImage imageNamed:@"forbiddenMark"] forState:UIControlStateNormal];
        [_Banned4 setBackgroundImage:[UIImage imageNamed:@"forbiddenMark"] forState:UIControlStateDisabled];
    } return _Banned4;
}
-(HeroButton *)Banned5{
    if (!_Banned5) {
        _Banned5 = [[HeroButton alloc]initWithFrame:CGRectMake(screenWidth-btnSize+3, 50+(btnSize+20)*5+btnSize , btnSize-10, btnSize-10)];
        [_Banned5 setBackgroundImage:[UIImage imageNamed:@"forbiddenMark"] forState:UIControlStateNormal];
        [_Banned5 setBackgroundImage:[UIImage imageNamed:@"forbiddenMark"] forState:UIControlStateDisabled];
    } return _Banned5;
}
-(HeroButton *)Banned6{
    if (!_Banned6) {
        _Banned6 = [[HeroButton alloc]initWithFrame:CGRectMake(screenWidth-btnSize+3, 40+(btnSize+20)*5+btnSize*2 , btnSize-10, btnSize-10)];
        [_Banned6 setBackgroundImage:[UIImage imageNamed:@"forbiddenMark"] forState:UIControlStateNormal];
        [_Banned6 setBackgroundImage:[UIImage imageNamed:@"forbiddenMark"] forState:UIControlStateDisabled];
    } return _Banned6;
}

-(NSDictionary *)searcherDict{
    if(!_searcherDict) {
        NSString* path = [[NSBundle mainBundle]pathForResource:@"Searcher.plist" ofType:nil];
        NSDictionary* dict = [[NSDictionary alloc]initWithContentsOfFile:path];
        _searcherDict = dict;
    }return _searcherDict;
}
-(UIButton *)searchLaunch{
    if (!_searchLaunch) {
        _searchLaunch = [[UIButton alloc]init];
        [_searchLaunch setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchLaunch setTitle:@"GO!" forState:UIControlStateHighlighted];
        _searchLaunch.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
        _searchLaunch.backgroundColor = [UIColor colorWithRed:190/255.0 green:120/255.0 blue:150/255.0 alpha:0.9];
    }return _searchLaunch;
}

-(NSArray *)allTeam{
    if (!_allTeam) {
        _allTeam = [NSArray arrayWithObjects:self.memberA1,self.memberA2,self.memberA3,self.memberA4,self.memberA5,self.memberB1,self.memberB2,self.memberB3,self.memberB4,self.memberB5,self.Banned1,self.Banned2,self.Banned3,self.Banned4,self.Banned5,self.Banned6, nil];
    }return _allTeam;
}
-(NSArray *)teamLeft{
    if (!_teamLeft) {
        _teamLeft = [NSArray arrayWithObjects:self.memberA1,self.memberA2,self.memberA3,self.memberA4,self.memberA5, nil];
    }return _teamLeft;
}
-(NSArray *)teamRight{
    if (!_teamRight) {
        _teamRight = [NSArray arrayWithObjects:self.memberB1,self.memberB2,self.memberB3,self.memberB4,self.memberB5, nil];
    }return _teamRight;
}
-(NSMutableArray*)currentHeroes{
    if (!_currentHeroes) {
        _currentHeroes = [NSMutableArray array];
        for (int i = 0; i<self.heroes.count; i++) {
            [_currentHeroes addObject:self.heroes[i]];
        }
        }
    return _currentHeroes;
}
-(NSMutableArray *)selectedHero{
    _selectedHero = [NSMutableArray arrayWithArray:@[]];
    for (HeroButton*button in self.allTeam) {
        if (button.HeroForButton) {
            [_selectedHero addObject:button.HeroForButton];
        }
    }
        return _selectedHero;
}
-(NSMutableArray *)clickedBtn{
    if (!_clickedBtn) {
        _clickedBtn = [NSMutableArray array];
    }return _clickedBtn;
}
-(NSMutableArray *)heroes{
    
        _heroes = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"heros.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        
        for (NSDictionary*dict in arr) {
            HeroModel*temp = [HeroModel heroModelWithDict:dict];
            [_heroes addObject:temp];
        }
    
    return _heroes;
}
-(UIPickerView *)HeroPicker{
    if (!_HeroPicker) {
        _HeroPicker = [[UIPickerView alloc]init];
        
    }return _HeroPicker;
}
-(NSString *) keyWord{
    if (!_keyWord) {
        _keyWord = [NSString string];
    }return _keyWord;
}
-(UITextField *)shortCut{
    if (!_shortCut) {
        _shortCut = [[UITextField alloc]init];
        _shortCut.backgroundColor = [UIColor whiteColor];
        
        _shortCut.adjustsFontSizeToFitWidth = YES;
        
    }return _shortCut;
}
-(NSMutableArray *)guessHeroes{
    if (!_guessHeroes) {
        _guessHeroes = [[NSMutableArray alloc]initWithCapacity:self.heroes.count];
    }return _guessHeroes;
}
-(UIPickerView *)GuessPicker{
    if (!_GuessPicker) {
        _GuessPicker = [[UIPickerView alloc]init];
    }return _GuessPicker;
}

#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = [UIScreen mainScreen].bounds;
    UIImageView*imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background2"]];
    imgView.backgroundColor = [UIColor purpleColor];
    imgView.frame = CGRectMake(0, 20, rect.size.width, rect.size.height-20);
    [self.view addSubview:imgView];
    
    self.HeroPicker.delegate = self;
    self.HeroPicker.dataSource = self;
    self.GuessPicker.delegate = self;
    self.GuessPicker.dataSource = self;
    self.shortCut.delegate =self;
    self.view.backgroundColor = [UIColor colorWithRed:100/255.0 green:120/255.0 blue:150/255.0 alpha:0.9];

    [self.view addSubview:self.memberA1];
    [self.view addSubview:self.memberA2];
    [self.view addSubview:self.memberA3];
    [self.view addSubview:self.memberA4];
    [self.view addSubview:self.memberA5];
    [self.view addSubview:self.memberB1];
    [self.view addSubview:self.memberB2];
    [self.view addSubview:self.memberB3];
    [self.view addSubview:self.memberB4];
    [self.view addSubview:self.memberB5];
    [self.view addSubview:self.Banned1];
    [self.view addSubview:self.Banned2];
    [self.view addSubview:self.Banned3];
    [self.view addSubview:self.Banned4];
    [self.view addSubview:self.Banned5];
    [self.view addSubview:self.Banned6];
    
    
    [self.memberA1 addTarget:self action:@selector(a1clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.memberA2 addTarget:self action:@selector(a2clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.memberA3 addTarget:self action:@selector(a3clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.memberA4 addTarget:self action:@selector(a4clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.memberA5 addTarget:self action:@selector(a5clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.memberB5 addTarget:self action:@selector(b5clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.memberB4 addTarget:self action:@selector(b4clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.memberB3 addTarget:self action:@selector(b3clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.memberB2 addTarget:self action:@selector(b2clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.memberB1 addTarget:self action:@selector(b1clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.Banned1 addTarget:self action:@selector(ban1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.Banned2 addTarget:self action:@selector(ban2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.Banned3 addTarget:self action:@selector(ban3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.Banned4 addTarget:self action:@selector(ban4Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.Banned5 addTarget:self action:@selector(ban5Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.Banned6 addTarget:self action:@selector(ban6Clicked) forControlEvents:UIControlEventTouchUpInside];
   [self.searchLaunch addTarget:self action:@selector(searcherLaunched) forControlEvents:UIControlEventTouchUpInside];



    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDisappera:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardAppear:) name:UIKeyboardDidShowNotification object:nil];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotcification:) name:@"A1" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotcification:) name:@"A2" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotcification:) name:@"A3" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotcification:) name:@"A4" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotcification:) name:@"A5" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotcification:) name:@"B1" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotcification:) name:@"B2" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotcification:) name:@"B3" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotcification:) name:@"B4" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotcification:) name:@"B5" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotcification:) name:@"C1" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotcification:) name:@"C2" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotcification:) name:@"C3" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotcification:) name:@"C4" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotcification:) name:@"C5" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotcification:) name:@"D1" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotcification:) name:@"D2" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotcification:) name:@"D3" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotcification:) name:@"D4" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotcification:) name:@"D5" object:nil];

    [self.countA1 addTarget:self action:@selector(sideButtonA1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.countA2 addTarget:self action:@selector(sideButtonA2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.countA3 addTarget:self action:@selector(sideButtonA3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.countA4 addTarget:self action:@selector(sideButtonA4Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.countA5 addTarget:self action:@selector(sideButtonA5Clicked) forControlEvents:UIControlEventTouchUpInside];
  
    [self.countB1 addTarget:self action:@selector(sideButtonB1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.countB2 addTarget:self action:@selector(sideButtonB2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.countB3 addTarget:self action:@selector(sideButtonB3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.countB4 addTarget:self action:@selector(sideButtonB4Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.countB5 addTarget:self action:@selector(sideButtonB5Clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.ptnA1 addTarget:self action:@selector(ptnA1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.ptnA2 addTarget:self action:@selector(ptnA2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.ptnA3 addTarget:self action:@selector(ptnA3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.ptnA4 addTarget:self action:@selector(ptnA4Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.ptnA5 addTarget:self action:@selector(ptnA5Clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.ptnB1 addTarget:self action:@selector(ptnB1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.ptnB2 addTarget:self action:@selector(ptnB2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.ptnB3 addTarget:self action:@selector(ptnB3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.ptnB4 addTarget:self action:@selector(ptnB4Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.ptnB5 addTarget:self action:@selector(ptnB5Clicked) forControlEvents:UIControlEventTouchUpInside];

    
}
#pragma mark count点击post通知方法
-(void)sideButtonA1Clicked{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"A1" object:self.countA1 userInfo:@{@"button":self.memberA1  }];
}
-(void)sideButtonA2Clicked{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"A2" object:self.countA2 userInfo:@{@"button":self.memberA2  }];
}
-(void)sideButtonA3Clicked{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"A3" object:self.countA3 userInfo:@{@"button":self.memberA3  }];
}
-(void)sideButtonA4Clicked{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"A4" object:self.countA4 userInfo:@{@"button":self.memberA4  }];
}
-(void)sideButtonA5Clicked{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"A5" object:self.countA5 userInfo:@{@"button":self.memberA5  }];
}
-(void)sideButtonB1Clicked{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"B1" object:self.countB1 userInfo:@{@"button":self.memberB1  }];
}
-(void)sideButtonB2Clicked{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"B2" object:self.countB2 userInfo:@{@"button":self.memberB2  }];
}
-(void)sideButtonB3Clicked{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"B3" object:self.countB3 userInfo:@{@"button":self.memberB3  }];
}
-(void)sideButtonB4Clicked{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"B4" object:self.countB4 userInfo:@{@"button":self.memberB4  }];
}
-(void)sideButtonB5Clicked{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"B5" object:self.countB5 userInfo:@{@"button":self.memberB5  }];
}
-(void)ptnA1Clicked{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"C1" object:self.ptnA1];
}
-(void)ptnA2Clicked{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"C2" object:self.ptnA2];
}
-(void)ptnA3Clicked{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"C3" object:self.ptnA3];
}
-(void)ptnA4Clicked{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"C4" object:self.ptnA4];
}
-(void)ptnA5Clicked{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"C5" object:self.ptnA5];
}
-(void)ptnB1Clicked{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"D1" object:self.ptnB1];
}
-(void)ptnB2Clicked{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"D2" object:self.ptnB2];
}
-(void)ptnB3Clicked{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"D3" object:self.ptnB3];
}
-(void)ptnB4Clicked{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"D4" object:self.ptnB4];
}
-(void)ptnB5Clicked{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"D5" object:self.ptnB5];
}


-(void)receiveNotcification:(NSNotification*)info{
    [self.guessHeroes removeAllObjects];
    SideButton* but = info.object;
    HeroModel* model = but.button.HeroForButton;
     NSArray* countArr = model.countedBy;
     [self.HeroPicker removeFromSuperview];
    for (NSNumber *number in countArr) {
     HeroModel*model =  self.heroes[number.longValue];
     NSString* nameString = model.name;
     BOOL isContained = 0;
     for (HeroModel*model in self.currentHeroes) {
     if ([model.name isEqualToString:nameString]) {
     isContained = YES;
     break;
     }else{
     continue;
     }
     }
     if (isContained) {
     [self.guessHeroes addObject:self.heroes[number.intValue]];
     }
     }
     //搜索没有内容的适合报警告
     if (self.guessHeroes.count==0) {
     UIAlertView* alt = [[UIAlertView alloc]initWithTitle:nil message:@"已被选定" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
         [self.shortCut removeFromSuperview];
         [self.searchLaunch removeFromSuperview];
     for (UIButton*but in self.allTeam) {
     but.enabled = YES;
     }
     [alt show];
     [self.GuessPicker removeFromSuperview];
     }else{
     [self.GuessPicker reloadAllComponents];
     [self.GuessPicker selectRow:(self.guessHeroes.count-1) inComponent:0 animated:NO];

     [self.view addSubview:self.GuessPicker];
     }

}


#pragma mark test
-(void)setDragBtnTop:(HeroButton*)btn{
    [self.teamcacheA setObject:btn.HeroForButton forKey:@"leftTop"];
    NSLog(@"%@",[[self.teamcacheA objectForKey:@"leftTop"] name]);
}
-(UIButton *)lockButton{
    if (!_lockButton) {
        _lockButton = [[UIButton alloc]init];
        [_lockButton setTitle:@"点击选定" forState:UIControlStateNormal];
        [_lockButton setTitle:@"点击选定" forState:UIControlStateNormal];
        _lockButton.titleLabel.font = [UIFont systemFontOfSize:12*(screenWidth/360)];
        _lockButton.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    }return _lockButton;
}
-(void)lockButtonClicked{
    HeroButton*tempBtn = self.clickedBtn.lastObject;
    if (self.currentPicker == self.HeroPicker) {
        [self.HeroPicker removeFromSuperview];
        [self.shortCut removeFromSuperview];
        [self.searchLaunch removeFromSuperview];
        [self.lockButton removeFromSuperview];
        tempBtn.HeroForButton  = self.tempHero;
    }else{
        [self.GuessPicker removeFromSuperview];
        [self.shortCut removeFromSuperview];
        [self.searchLaunch removeFromSuperview];
        [self.lockButton removeFromSuperview];
        tempBtn.HeroForButton = self.tempHero;
        [self.currentHeroes removeObject:self.tempHero];
    }
    for (HeroButton*button in self.allTeam) {
        if (button.HeroForButton) {
            NSString*tempStr = button.HeroForButton.name;
            NSMutableArray *arr = [NSMutableArray array];
            for (int i = 0; i<self.currentHeroes.count; i++) {
                [arr addObject:self.currentHeroes[i]];
            }
            
            for (HeroModel*model in arr) {
                if ([model.name isEqualToString:tempStr]) {
                    [self.currentHeroes removeObject:model];
                    //[self.HeroPicker reloadAllComponents];
                }
            }
        }
    }
    BOOL allPicked = YES;
    for (HeroButton* but in self.teamLeft) {
        if (!but.HeroForButton) {
            allPicked = NO;
            break;
        }
    }
    for (HeroButton* but in self.teamRight) {
        if (!but.HeroForButton) {
            allPicked = NO;
            break;
        }
    }
    
    if (allPicked) {
        [self.view addSubview:self.modalButton];
    }
    
}
//test第二个界面启用该方法省去输入过程
-(void)logheroes{
    for (int i = 0; i<self.heroes.count; i++) {
        NSLog(@"HeroNumber--%d--%@",i,[self.heroes[i] name]);
    }
}
-(void)test2{
    self.guessHeroes  = self.heroes;
    NSLog(@"%ld",(unsigned long)self.guessHeroes.count);
      self.GuessPicker.frame =CGRectMake(btnSize, 50-btnSize, 202, 162);
    [self.view addSubview:self.GuessPicker];
    

}

#pragma mark 键盘收缩通知
- (void)keyboardFrameChange:(NSNotification *)info{
    
    NSDictionary *keyBoardDict =   info.userInfo;
    CGRect keyBoardFrame = [keyBoardDict[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat duration = [keyBoardDict    [UIKeyboardAnimationDurationUserInfoKey]doubleValue];
 
    
    CGFloat y = self.shortCut.frame.origin.y;
    CGFloat h = self.shortCut.frame.size.height;
    CGFloat distance = y + h;
    if(distance>keyBoardFrame.origin.y){
       [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, keyBoardFrame.origin.y-distance);
       }];}
 
}
-(void)keyboardDisappera:(NSNotification *)info{
    NSDictionary *keyboarDict = info.userInfo;
  CGRect originFrame = [keyboarDict[UIKeyboardFrameBeginUserInfoKey]CGRectValue];
    CGFloat y = originFrame.origin.y -self.shortCut.frame.size.height - self.shortCut.frame.origin.y;
    CGFloat duration = [keyboarDict [UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    if(y<0){
        [UIView animateWithDuration:duration animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, 0);}];
    }
    
    
}
-(void)keyboardAppear:(NSNotification*)info{
    NSDictionary *keyBoardDict =   info.userInfo;
    CGRect keyBoardFrame = [keyBoardDict[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat duration = [keyBoardDict [UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    CGFloat distance = self.shortCut.frame.origin.y +self.shortCut.frame.size.height;
    if (distance>keyBoardFrame.origin.y) {
        [UIView animateWithDuration:duration animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, keyBoardFrame.origin.y-distance);
        }];}

    }
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma system
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
