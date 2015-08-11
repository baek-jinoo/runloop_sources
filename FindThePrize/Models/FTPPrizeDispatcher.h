//
//  FTPPrizeDispatcher.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FTPArena;
@class FTPCoordinate;
@protocol Cell;

@interface FTPPrizeDispatcher : NSObject

- initWithArena:(FTPArena *)arena NS_DESIGNATED_INITIALIZER;

- (void)dispatchPrize;
@property (strong, nonatomic, readonly) FTPCoordinate *prizeCoordinate;

- (instancetype)init NS_UNAVAILABLE;

@end
