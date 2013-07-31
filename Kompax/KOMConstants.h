//
//  Constants.h
//  Kompax
//
//  Created by Bryan on 13-7-31.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kNotOverspent = 0,
    kOverspent,
    kNotOverearned,
    kOverearned
} OverspendMode;

@interface KOMConstants : NSObject

typedef enum {
    kCostMode = 0,
    kEarnMode
} BarMode;

@end
