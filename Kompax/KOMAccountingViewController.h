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
    BOOL isOpened;
}

@property (nonatomic,strong) IBOutlet UIScrollView *myscrollview;
@property (nonatomic,strong) IBOutlet UITextField *cash;

@property (retain, nonatomic) IBOutlet UIButton *openButton;
@property (retain, nonatomic) IBOutlet UITextField *inputTextField;
@property (retain, nonatomic) IBOutlet TableViewWithBlock *tb;
- (IBAction)changeOpenStatus:(id)sender;

@property (strong,nonatomic)   NSArray *way;

@end
