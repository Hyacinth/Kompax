//
//  KOMRepaymentViewController.m
//  Kompax
//
//  Created by Bryan on 13-8-6.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMRepaymentViewController.h"
#import "KOMDebitViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface KOMRepaymentViewController ()

@end

@implementation KOMRepaymentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _scrollView.contentSize = CGSizeMake(320, 960);
    _scrollView.scrollEnabled = NO; //无法滚动

    [[NSNotificationCenter defaultCenter]postNotificationName:@"pageSwipeUnable" object:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加点击背景取消第一反应
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgTap)];
    [_scrollView addGestureRecognizer:tap];
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(goBack)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [_scrollView addGestureRecognizer:swipe];
    
    //test
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(60, 80, 150, 40);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"back" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)bgTap {
    [_scrollView endEditing:YES];
    
    if([self.parentViewController respondsToSelector:@selector(bgTap:)]) {
        KOMDebitViewController *father = (KOMDebitViewController *)self.parentViewController;
        [father bgTap:self];
    }
}

//确定并返回主界面
-(void)confirm {
    
    //将还款界面的金额传至外界面
    KOMDebitViewController *father = (KOMDebitViewController *)self.parentViewController;
    father.cash.text = _cashText.text;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pageSwipeAble" object:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}


//返回借记主界面
-(void)goBack {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pageSwipeAble" object:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
