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
#import "KOMCostViewController.h"
#import "KOMIncomeViewController.h"
#import "KOMDebitViewController.h"
#import "KOMCreditViewController.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.way = [NSArray arrayWithObjects:@"支出",@"收入",@"借记",@"贷记", nil];
    
    //初始化下拉菜单
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
    
    //设置开始就选中第一行
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_tb selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    //初始化四个子VC
    KOMCostViewController *costVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Cost"];
    KOMIncomeViewController *imcomeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Imcome"];
    KOMDebitViewController *debitVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Debit"];
    KOMCreditViewController *creditVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Credit"];
    
    _controllers = @[costVC,imcomeVC,debitVC,creditVC];
    currentVC = costVC;
    [self.view sendSubviewToBack:_accView];
    [_accView addSubview:creditVC.view];
    [_accView addSubview:debitVC.view];
    [_accView addSubview:imcomeVC.view];
    [_accView addSubview:costVC.view];
}

- (IBAction)changeOpenStatus:(id)sender {
    
    if (isOpened) {
        
        [UIView animateWithDuration:0.3 animations:^{

            [_openButton.imageView.layer setAffineTransform:CGAffineTransformMakeRotation(0)];

            //设置下拉菜单frame
            CGRect frame=_tb.frame;
            frame.size.height=0;
            [_tb setFrame:frame];
            
            //切换子视图
            UIViewController *vc = [_controllers objectAtIndex:_tb.indexPathForSelectedRow.row];
            [self.accView bringSubviewToFront:vc.view];
            
            //更改输入框的颜色
            if (_tb.indexPathForSelectedRow.row % 2 == 0) {
                self.inputTextField.backgroundColor = [UIColor colorWithRed:239/255.0 green:100/255.0 blue:75/255.0 alpha:1.0];
            }
            else{
                self.inputTextField.backgroundColor = [UIColor colorWithRed:169/255.0 green:203/255.0 blue:107/255.0 alpha:1.0];
            }
            
        } completion:^(BOOL finished){
    
            isOpened=NO;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            
            [_openButton.imageView.layer setAffineTransform:CGAffineTransformMakeRotation(0.5*3.14159)];
            
            //设置下拉菜单frame
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
