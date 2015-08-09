//
//  FTPPrizeDispatcher.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Arena;
@protocol Cell;

@interface FTPPrizeDispatcher : NSObject

- initWithArena:(Arena *)arena NS_DESIGNATED_INITIALIZER;

- (void)dispatchPrize;
- (id<Cell>)prizeCell;

- (instancetype)init NS_UNAVAILABLE;

@end
