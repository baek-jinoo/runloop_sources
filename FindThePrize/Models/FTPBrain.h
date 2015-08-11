//
//  FTPBrain.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FTPCommand;
@class GameContext;
@class Robot;

@interface FTPBrain : NSObject

- (instancetype)initWithRobot:(Robot *)robot NS_DESIGNATED_INITIALIZER;

- (FTPCommand *)nextCommandWithGameContext:(GameContext *)gameContext;

- (instancetype)init NS_UNAVAILABLE;

@end
