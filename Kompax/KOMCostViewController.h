//
//  KOMCostViewController.h
//  Kompax
//
//  Created by Bryan on 13-7-27.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KOMAccountTableViewController.h"
#import "KOMTimePickerViewController.h"
#import "KOMMemberTableViewController.h"

static NSString *GLOBAL_TIMEFORMAT = @"yyyy-MM-dd HH:mm:ss";

@interface KOMCostViewController : UIViewController<KOMAccountTableViewDelegate,KOMTimePickerDelegate,KOMMemberTableViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *cash;
@property (strong, nonatomic) IBOutlet UILabel *accountLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong,nonatomic) IBOutlet UILabel *memberLabel;

@end
