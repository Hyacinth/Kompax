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
    
    //初始化账户
    _accountLabel.text = @"现金";
    //初始化成员
    _memberLabel.text = @"自己";
    
}

- (void)viewDidAppear:(BOOL)animated
{
    //设置标签可点击
    [self.accountLabel setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapForAcc = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentAcc)];
    UITapGestureRecognizer *tapForTime = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentTimePicker)];
    UITapGestureRecognizer *tapForMember = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentMember)];
    
    [self.accountLabel addGestureRecognizer:tapForAcc];
    [self.timeLabel addGestureRecognizer:tapForTime];
    [self.memberLabel addGestureRecognizer:tapForMember];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击子视图空白处能够隐藏键盘
- (IBAction)bgTap:(id)sender {
    
     [self.view endEditing:YES];
  
    if ([self.parentViewController respondsToSelector:@selector(backgroundTap:)])
    {
        KOMAccountingViewController *acc = 
        (KOMAccountingViewController *)self.parentViewController ;
        [acc backgroundTap:self];
    }
}

//显示账户选项
-(void)presentAcc {
    KOMNavViewController * nav = [self.storyboard instantiateViewControllerWithIdentifier:@"AccNav"];
    
    KOMAccountTableViewController *tableVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AccTable"];
    [nav pushViewController:tableVC animated:NO];
    
    //设置代理
    tableVC.delegate = self;
    
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:nav animated:YES completion:nil];
}

//显示time picker
-(void)presentTimePicker {
    KOMNavViewController * nav = [self.storyboard instantiateViewControllerWithIdentifier:@"AccNav"];
    KOMTimePickerViewController *timeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TimePicker"];
    [nav pushViewController:timeVC animated:NO];
    
    timeVC.delegate = self;
    
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)presentMember {
    KOMNavViewController * nav = [self.storyboard instantiateViewControllerWithIdentifier:@"AccNav"];
    KOMTimePickerViewController *memberVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MemberTable"];
    [nav pushViewController:memberVC animated:NO];
    
    memberVC.delegate = self;
    
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


@end
