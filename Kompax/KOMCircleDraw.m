//
//  KOMCircleDraw.m
//  Kompax
//
//  Created by Bryan on 13-8-2.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMCircleDraw.h"

@implementation KOMCircleDraw

static double kSmallestRadius = 70/2;
static double kLargestRadius = 230/2;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
    {
    _totalEarn = 3000;
    _totalCost = 1689;
    double larger,smaller,absDif,costRadius,earnRadius;
    double movement = 0;        //差额圆偏移量

    if (_totalEarn >= _totalCost ) {
        _isLargerEarn = YES;
        larger = _totalEarn;
        smaller = _totalCost;
        
        if (larger/3 >= smaller) {
            earnRadius = kLargestRadius;
            costRadius = kSmallestRadius;
        }
        else {
            double smallest = larger/3;  //设立最小边界
            costRadius = kSmallestRadius * smaller / smallest;
            earnRadius = kSmallestRadius * larger / smallest;
        }
        
    }   //收入大于支出
    else {
        _isLargerEarn = NO;
        larger = _totalCost;
        smaller = _totalEarn;
        
        
        if (larger/3 >= smaller) {
            costRadius = kLargestRadius;
            earnRadius = kSmallestRadius;
        }
        else {
            double smallest = larger/3;  //设立最小边界
            earnRadius = kSmallestRadius * smaller / smallest;
            costRadius = kSmallestRadius * larger / smallest;
        }
    }   //支出大于收入

    if (fabs(earnRadius-costRadius)>30)
        absDif = fabs(earnRadius-costRadius);    //差额绝对值
    else
        absDif = 30;

    NSLog(@"earn:%f,cost:%f,abs:%f",earnRadius,costRadius,absDif);

    /*画图*/
    //设置字体
    UIFont *costNumberFont = [UIFont boldSystemFontOfSize:9.5+costRadius/7-4];
    UIFont *earnNumberFont= [UIFont boldSystemFontOfSize:9.5+earnRadius/7-4];
    UIFont *difNumberFont= [UIFont boldSystemFontOfSize:9.5+absDif/7-4];

    CGContextRef context=UIGraphicsGetCurrentContext();

    //画支出半圆并写字
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:248/255.0 green:149/255.0 blue:64/255.0 alpha:1.0].CGColor);//填充颜色
    CGContextFillEllipseInRect(context,CGRectMake(320-costRadius,405/2-costRadius,2*costRadius, 2*costRadius));
    //写字
    NSString *costLabel = [NSString stringWithFormat:@"%.2f",_totalCost];
    CGPoint costDrawPoint = CGPointMake(320-costRadius+costRadius/5-4, 405/2-10);

    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);//填充颜色
    [costLabel drawAtPoint:costDrawPoint forWidth:150 withFont:costNumberFont lineBreakMode:NSLineBreakByCharWrapping];


    //画收入半圆
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:105/255.0 green:167/255.0 blue:203/255.0 alpha:1.0].CGColor);//设置线的颜色
    CGContextFillEllipseInRect(context,CGRectMake(-earnRadius,528/2-earnRadius,2*earnRadius, 2*earnRadius));
    //写字
    NSString *earnLabel = [NSString stringWithFormat:@"%.2f",_totalEarn];
    CGPoint earnDrawPoint = CGPointMake(earnRadius/5-4, 528/2-10);

    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);//填充颜色
    [earnLabel drawAtPoint:earnDrawPoint forWidth:150 withFont:earnNumberFont lineBreakMode:NSLineBreakByCharWrapping];

    if (_isLargerEarn) {
        movement = 0;
    }
    else {
        movement = -100;
    }

    //画差额圆
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:128/255.0 green:135/255.0 blue:147/255.0 alpha:1.0].CGColor);//设置线的颜色
    CGContextFillEllipseInRect(context,CGRectMake(300/2+movement,450/2,2*absDif, 2*absDif));
    //写字
    NSString *difLabel = [NSString stringWithFormat:@"%.2f",fabs(_totalEarn-_totalCost)];
    CGPoint difDrawPoint = CGPointMake(300/2+absDif+movement, 450/2+absDif-10);

    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);//填充颜色
    [difLabel drawAtPoint:difDrawPoint forWidth:150 withFont:difNumberFont lineBreakMode:NSLineBreakByCharWrapping];

    CGContextStrokePath(context);//把线在界面上绘制出来
    }


@end
