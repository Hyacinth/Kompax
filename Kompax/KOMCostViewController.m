//
//  KOMCostViewController.m
//  Kompax
//
//  Created by Bryan on 13-7-27.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMCostViewController.h"
#import "KOMAccountingViewController.h"

@interface KOMCostViewController ()

@end

@implementation KOMCostViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bgTap:(id)sender {
    
     [self.view endEditing:YES];
    //3层nextResponder才到KOMAccountingViewController
    if ([self.nextResponder.nextResponder.nextResponder respondsToSelector:@selector(backgroundTap:)])
    {
        KOMAccountingViewController *acc = 
        (KOMAccountingViewController *)self.nextResponder.nextResponder.nextResponder ;
        [acc backgroundTap:self];
    }
}



@end
