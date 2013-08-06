//
//  KOMPagingSwipeViewController.h
//  Kompax
//
//  Created by Bryan on 13-7-25.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KOMPagingSwipeViewController : UIViewController<UIScrollViewDelegate>
{
    BOOL pageControlUsed;
    BOOL accRead;               //记录是否进入过第二页
    int currentPage;            //记录用户当前访问的页
    int lastPage;               //记录上一页
}
@property(retain,nonatomic) IBOutlet UIScrollView *scrollView;
@property(retain,nonatomic) NSMutableArray *viewControllers;


@end
