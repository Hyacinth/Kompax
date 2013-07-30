//
//  KOMDraw.m
//  Kompax
//
//  Created by Bryan on 13-7-30.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMDraw.h"

@implementation KOMDraw

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
    NSLog(@"出现！");
    CGRect myRect = CGRectMake(80, 80, 150, 30);

    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置矩形填充颜色：红色
    CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
    //填充矩形
    CGContextFillRect(context, myRect);
    //执行绘画
    CGContextStrokePath(context);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches begin！");
    [self setNeedsDisplay];
}

@end
