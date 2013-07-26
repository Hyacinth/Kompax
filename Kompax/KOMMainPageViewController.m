//
//  KOMMainPageViewController.m
//  Kompax
//
//  Created by Bryan on 13-7-23.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMMainPageViewController.h"
#import "KOMAccountingViewController.h";

@interface KOMMainPageViewController ()

@end

@implementation KOMMainPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(changeView)];
//    [swipeRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
//    [self.view addGestureRecognizer:swipeRecognizer];//关键语句，给self.view添加一个手势监测；
//    swipeRecognizer.delegate = self;
}

//-(void)changeView {
//    KOMAccountingViewController *accVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Acc"];
//    [self presentModalViewController:accVC animated:YES];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
