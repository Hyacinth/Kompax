//
//  KOMAccountTableViewController.m
//  Kompax
//
//  Created by Bryan on 13-7-28.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMAccountTableViewController.h"

@interface KOMAccountTableViewController ()

@end

@implementation KOMAccountTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置navigationbar上面的返回按钮
    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backBut setTitle:@"back" forState:UIControlStateNormal];
    backBut.frame = CGRectMake(0, 0, 40, 35);
    [backBut addTarget:self action:@selector(backUp:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithCustomView:backBut];
    self.navigationItem.leftBarButtonItem = back;

    //初始化tableview内容
//    NSArray *cashArr = @[@"现金"];
//    NSArray *crediteCardArr = @[@"信用卡"];
    
//    NSArray *cashArr= [NSArray arrayWithObjects:@"现金", nil];
//    NSArray *creditCardArr = [NSArray arrayWithObjects:@"信用卡", nil];
//    _data = [NSMutableArray arrayWithObjects:cashArr,creditCardArr, nil];
    _data = [NSMutableArray arrayWithObjects:@"现金",@"信用卡",@"储蓄",@"网上支付", nil];
}

- (void)backUp:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
       
    }
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [_data objectAtIndex:row];
    
    return cell;
}


// Override to support conditional editing of the table view.
/*- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}*/



// Override to support editing the table view.

/*- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_data removeObjectAtIndex:[indexPath row]];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string = [_data objectAtIndex:indexPath.row];
    [self.delegate changeAccount:string];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}

@end
