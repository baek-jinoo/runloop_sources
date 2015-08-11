//
//  FTPPrizeDispatcher.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Arena;
@class Coordinate;
@protocol Cell;

@interface FTPPrizeDispatcher : NSObject

- initWithArena:(Arena *)arena NS_DESIGNATED_INITIALIZER;

- (void)dispatchPrize;
@property (strong, nonatomic, readonly) Coordinate *prizeCoordinate;

- (instancetype)init NS_UNAVAILABLE;

@end
