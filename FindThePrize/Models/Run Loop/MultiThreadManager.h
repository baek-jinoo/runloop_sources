//
//  MultiThreadManager.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameEngineRunLoopContext.h"

@class RobotRunLoopContext;
@class Robot;
@class GameContext;
@protocol GameEngine;

@interface MultiThreadManager : NSObject

+ (instancetype)sharedManager;

- (void)workerThreadWithRobot:(Robot *)robot;

- (void)registerSource:(RobotRunLoopContext *)robotRunLoopContext;
- (void)removeSource:(RobotRunLoopContext *)robotRunLoopContext;
- (void)removeAllSource;

- (void)removeMainThreadSource:(GameEngineRunLoopContext *)gameEngineRunLoopContext;
- (void)registerMainThreadSource:(GameEngineRunLoopContext *)gameEngineRunLoopContext;

- (void)pingSourceAtIndex:(NSUInteger)index gameContext:(GameContext *)gameContext;
- (void)stopSourceAtIndex:(NSUInteger)index;

@property (weak, nonatomic) id<GameEngine> gameEngine;

@end
