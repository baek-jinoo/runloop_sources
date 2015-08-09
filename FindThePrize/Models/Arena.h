//
//  Arena.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Robot;
@class FTPSize;

@interface Arena : NSObject

- (instancetype)initWithArenaSize:(FTPSize *)size NS_DESIGNATED_INITIALIZER;

@property (strong, nonatomic, readonly) NSArray *cells;

- (void)placeRobot:(Robot *)robot;

- (instancetype)init NS_UNAVAILABLE;

@end
