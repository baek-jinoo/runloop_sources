//
//  FTPRobot.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Cell.h"

@class FTPGameContext;
@class FTPCommand;
@class FTPCoordinate;
@protocol Cell;

@interface FTPRobot : NSObject

- (instancetype)initWithTeamOne:(BOOL)teamOne NS_DESIGNATED_INITIALIZER;

- (FTPCommand *)nextCommandWithGameContext:(FTPGameContext *)gameContext;

@property (assign, nonatomic, readonly) BOOL teamOne;
@property (weak, nonatomic) id<Cell> occupyingCell;
@property (assign, nonatomic) NSUInteger wins;

- (instancetype)init NS_UNAVAILABLE;

@end
