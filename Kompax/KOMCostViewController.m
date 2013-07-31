//
//  KOMCostViewController.m
//  Kompax
//
//  Created by Bryan on 13-7-27.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMCostViewController.h"
#import "KOMAccountingViewController.h"
#import "KOMNavViewController.h"
#import "KOMTimePickerViewController.h"
#import "KOMCategoryTableViewController.h"
#import "KOMBarDraw.h"
#import "KOMConstants.h"

static NSString *GLOBAL_TIMEFORMAT = @"yyyy-MM-dd HH:mm:ss";

@interface KOMCostViewController ()

@end

@implementation KOMCostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化时间
    NSTimeZone* localzone = [NSTimeZone localTimeZone];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:GLOBAL_TIMEFORMAT];
    [formatter setTimeZone:localzone];
    _timeLabel.text = [formatter stringFromDate:[NSDate date]];
    
    _categoryLabel.text = @"餐饮 > 早餐";
    _cash.text = @"0.00";        //初始化现金
    _accountLabel.text = @"现金"; //初始化账户
    _memberLabel.text = @"自己";  //初始化成员
    
    planedCost = 700.0f;
    didCost = 200.0f;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
        //设置标签可点击
    [self.accountLabel setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapForAcc = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentAcc)];
    UITapGestureRecognizer *tapForTime = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentTimePicker)];
    UITapGestureRecognizer *tapForMember = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentMember)];
    UITapGestureRecognizer *tapForCategory = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentCategory)];
    
    [self.accountLabel addGestureRecognizer:tapForAcc];
    [self.timeLabel addGestureRecognizer:tapForTime];
    [self.memberLabel addGestureRecognizer:tapForMember];
    [self.categoryLabel addGestureRecognizer:tapForCategory];
    
    [self calculateAndDraw];
}

//计算当前支出与计划支出大小关系并且画图
-(void)calculateAndDraw {

    KOMBarDraw *draw = (KOMBarDraw *)self.view;
    
    double current = [_cash.text doubleValue];
    
    
    if (didCost + current <= planedCost) {
        
        draw.drawingMode = kNotOverspend;
        draw.larger = planedCost;
        draw.smaller = didCost + current;
        
    }   //未超支
    else {
        draw.drawingMode = kOverspend;
        draw.smaller = planedCost;
        draw.larger = didCost + current;
    }   //已超支
    
    //画图
    [draw setNeedsDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击子视图空白处能够隐藏键盘
- (IBAction)bgTap:(id)sender {
    
    NSLog(@"test");
    [self calculateAndDraw];
    
    if ([self.parentViewController respondsToSelector:@selector(backgroundTap:)])
    {
        KOMAccountingViewController *acc = 
        (KOMAccountingViewController *)self.parentViewController ;
        [acc backgroundTap:self];
    }
}

//显示账户选项
-(void)presentAcc {
    
    //切换页面时先去掉cash输入框的第一反应资格
    [self.cash resignFirstResponder];
    
    KOMNavViewController * nav = [self.storyboard instantiateViewControllerWithIdentifier:@"AccNav"];
    
    KOMAccountTableViewController *tableVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AccTable"];
    [nav pushViewController:tableVC animated:NO];
    
    //设置代理
    tableVC.delegate = self;
    
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:nav animated:YES completion:nil];
}

//画cashbar函数
-(void)loadCashBar {
    double inputCash = [_cash.text doubleValue];
    
    //计入本笔支出后尚未超出预算
    if (didCost + inputCash <= planedCost) {
        CGRect rect = CGRectMake(80, 80, 150, 30);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //设置矩形填充颜色：红色
        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
        //填充矩形
        CGContextFillRect(context, rect);
        //执行绘画
        CGContextStrokePath(context);
    }
}

//显示time picker
-(void)presentTimePicker {
    
    //切换页面时先去掉cash输入框的第一反应资格
    [self.cash resignFirstResponder];
    
    KOMNavViewController * nav = [self.storyboard instantiateViewControllerWithIdentifier:@"AccNav"];
    KOMTimePickerViewController *timeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TimePicker"];
    [nav pushViewController:timeVC animated:NO];
    
    timeVC.delegate = self;
    
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)presentMember {
    
    //切换页面时先去掉cash输入框的第一反应资格
    [self.cash resignFirstResponder];
    
    KOMNavViewController * nav = [self.storyboard instantiateViewControllerWithIdentifier:@"AccNav"];
    KOMTimePickerViewController *memberVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MemberTable"];
    [nav pushViewController:memberVC animated:NO];
    
    memberVC.delegate = self;
    
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)presentCategory {
    
    //切换页面时先去掉cash输入框的第一反应资格
    [self.cash resignFirstResponder];
    
    KOMNavViewController * nav = [self.storyboard instantiateViewControllerWithIdentifier:@"AccNav"];
    KOMCategoryTableViewController *categoryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Category"];
    [nav pushViewController:categoryVC animated:NO];
    
    categoryVC.delegate = self;
    
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:nav animated:YES completion:nil];
}


#pragma mark - KOMAccountTableViewController delegate
-(void)changeAccount:(NSString *)text {
    self.accountLabel.text = text;
}

#pragma  mark - KOMTimePickerViewController delegate
-(void)changeTimeText:(NSString *)text {
    self.timeLabel.text = text;
}

#pragma  mark - KOMMemberTableViewController delegate
-(void)changeMember:(NSString *)text {
    self.memberLabel.text = text;
}

#pragma mark - KOMCategoryTableViewController delegate
-(void)changeCategory:(NSString *)text {
    self.categoryLabel.text = text;
}


@end
