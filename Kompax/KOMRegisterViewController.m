//
//  KOMRegisterViewController.m
//  Kompax
//
//  Created by Bryan on 13-7-19.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMRegisterViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AFNetworking.h"

@implementation KOMRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *col = [UIColor colorWithRed:88.0/256 green:150.0/256 blue:192.0/256 alpha:1];
    	
    self.mailText.layer.borderColor = col.CGColor;
    self.mailText.layer.borderWidth = 1.5;
    self.passwordText.layer.borderColor = col.CGColor;
    self.passwordText.layer.borderWidth = 1.5;
    self.againText.layer.borderColor = col.CGColor;
    self.againText.layer.borderWidth = 1.5;
    
    NSString *email = _mailText.text;
    NSString *password = _passwordText.text;
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:email,@"email",password,@"password", nil];
    
    /*NSURL *url = [NSURL URLWithString:@"http://3.compax.sinaapp.com/index.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPClient *client = [[AFHTTPClient alloc]initWithBaseURL:url];
    [client setParameterEncoding:AFJSONParameterEncoding];
    
    
    NSURLConnection *connet = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    AFURLConnectionOperation *operation = [[AFURLConnectionOperation alloc]initWithRequest:request];
    operation.completionBlock = ^{
        NSLog(@"%@",operation.responseString);
    };
    
    [connet start];*/
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}


- (IBAction)textFieldDoneEditing:(id)sender {
    [self.view endEditing:YES];
}
@end
