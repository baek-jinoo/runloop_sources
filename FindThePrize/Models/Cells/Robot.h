//
//  Robot.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Cell.h"

@class GameContext;
@class FTPCommand;
@class Coordinate;

@interface Robot : NSObject <Cell>

- (instancetype)initWithX:(NSUInteger)x Y:(NSUInteger)y teamOne:(BOOL)teamOne NS_DESIGNATED_INITIALIZER;

- (FTPCommand *)nextCommandWithGameContext:(GameContext *)gameContext;
- (instancetype)init NS_UNAVAILABLE;

@end
