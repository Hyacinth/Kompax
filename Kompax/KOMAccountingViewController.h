//
//  KOMAccountingViewController.h
//  Kompax
//
//  Created by Bryan on 13-7-22.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+DataSourceBlocks.h"

@class TableViewWithBlock;
@interface KOMAccountingViewController : UIViewController{
    
    UIViewController *currentVC;
    BOOL isOpened;
}

@property (strong, nonatomic) IBOutlet UIView *accView;

@property (retain, nonatomic) IBOutlet UIButton *openButton;
@property (retain, nonatomic) IBOutlet UILabel *inputTextField;
@property (retain, nonatomic) IBOutlet TableViewWithBlock *tb;
- (IBAction)changeOpenStatus:(id)sender;

@property (strong,nonatomic)   NSArray *way;
@property (strong,nonatomic) NSArray *controllers;


- (IBAction)backgroundTap:(id)sender;

@end
