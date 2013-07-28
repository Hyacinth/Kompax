//
//  KOMAccountNavViewController.m
//  Kompax
//
//  Created by Bryan on 13-7-28.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMAccountNavViewController.h"

@interface KOMAccountNavViewController ()

@end

@implementation KOMAccountNavViewController

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
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStyleBordered target:self action:@selector(backToTabbar:)];
    
    self.navigationItem.leftBarButtonItem = back;
    
    
	// Do any additional setup after loading the view.
}

-(IBAction)backToTabbar:(id)sender {
    NSLog(@"222");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
