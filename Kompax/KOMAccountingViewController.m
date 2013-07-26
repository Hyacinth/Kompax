//
//  KOMAccountingViewController.m
//  Kompax
//
//  Created by Bryan on 13-7-22.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMAccountingViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SelectionCell.h"
#import "TableViewWithBlock.h"


@interface KOMAccountingViewController ()

@end

@implementation KOMAccountingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.myscrollview.contentSize=CGSizeMake(320,500.0);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.way = [NSArray arrayWithObjects:@"支出",@"收入",@"借记",@"贷记", nil];
    
    isOpened=NO;
    [_tb initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section){
        return 4;
        
    } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath){
        SelectionCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SelectionCell"];
        if (!cell) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"SelectionCell" owner:self options:nil]objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        }
        [cell.lb setText:[NSString stringWithFormat:[NSString stringWithFormat:@"%@",[_way objectAtIndex:indexPath.row]],indexPath.row]];
        return cell;
    } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath){
        SelectionCell *cell=(SelectionCell*)[tableView cellForRowAtIndexPath:indexPath];
        _inputTextField.text=cell.lb.text;
        [_openButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }];
    [_tb setBackgroundColor:[UIColor whiteColor]];
    [_tb setAlpha:0.7];
    _tb.separatorStyle = NO;        //设置tableviewcell之间没有横线
    [_tb.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_tb.layer setBorderWidth:2];
     
}

- (IBAction)changeOpenStatus:(id)sender {
    
    if (isOpened) {
        
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"xiala-red1.png"];
            [_openButton setImage:closeImage forState:UIControlStateNormal];
            
            CGRect frame=_tb.frame;
            
            frame.size.height=0;
            [_tb setFrame:frame];
            
        } completion:^(BOOL finished){
            
            isOpened=NO;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage=[UIImage imageNamed:@"xiala-red1副本.png"];
            [_openButton setImage:openImage forState:UIControlStateNormal];
            CGRect frame=_tb.frame;      
            frame.size.height=125;
            [_tb setFrame:frame];
        } completion:^(BOOL finished){
            
            isOpened=YES;
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
   
    if (isOpened) {
        [self changeOpenStatus:_openButton];
    }
}

@end
