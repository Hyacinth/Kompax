//
//  KOMPagingSwipeViewController.m
//  Kompax
//
//  Created by Bryan on 13-7-25.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMPagingSwipeViewController.h"
#import "KOMAccountingViewController.h"

static NSUInteger kNumberOfPages = 3;

@interface KOMPagingSwipeViewController ()

@end

@implementation KOMPagingSwipeViewController

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

- (void)awakeFromNib
{
    // view controllers are created lazily
    // in the meantime, load the array with placeholders which will be replaced on demand
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < kNumberOfPages; i++)
    {
		[controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    
    //创建scrollview
    _scrollView = [[UIScrollView  alloc]initWithFrame:CGRectMake(0, 20, 320, 411)];
    [self.view addSubview:_scrollView];
   [_scrollView setUserInteractionEnabled:YES];
    
    // a page is the width of the scroll view
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * kNumberOfPages, _scrollView.frame.size.height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.scrollsToTop = NO;
    _scrollView.delegate = self;
    currentPage = 1;
    
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
    [self loadScrollViewWithPage:2];

    
    // 将开始页设定为当前的currentPage
    CGRect frame = _scrollView.frame;
    frame.origin.x = frame.size.width * currentPage;
    frame.origin.y = 0;
    [_scrollView scrollRectToVisible:frame animated:NO];
}

- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= kNumberOfPages)
        return;
    
    //要load的controller
    UIViewController *vc = nil;
    
    switch (page) {
        case 0:
        {
            vc = [[UIViewController alloc]init];
            UILabel *label= [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 300, 20)];
            label.text = @"asd";
            [vc.view addSubview:label];
            break;
        }
        case 1:
        {
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainPage"];
            break;
        }
        case 2:
        {
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Acc"];
            break;
        }
        default:
            break;
    }
    [_viewControllers replaceObjectAtIndex:page withObject:vc];
    
    
    // add the controller's view to the scroll view
    if (vc.view.superview == nil)
    {
        CGRect frame = _scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        vc.view.frame = frame;
        [_scrollView addSubview:vc.view];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    currentPage = page;
 
    //翻到记账页时，自动弹出键盘
    if (page==2)
    {
        KOMAccountingViewController *acc = [_viewControllers objectAtIndex:2];
        [[acc cash] becomeFirstResponder];
        [[acc cash] selectAll:self];
    }
    else
    {
        KOMAccountingViewController *acc = [_viewControllers objectAtIndex:2];
        [[acc cash] resignFirstResponder];
    }
}



@end