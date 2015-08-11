//
//  FTPMultiThreadManager.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTPGameEngineRunLoopContext.h"

@class FTPRobotRunLoopContext;
@class FTPRobot;
@class FTPGameContext;
@protocol GameEngine;

@interface FTPMultiThreadManager : NSObject

+ (instancetype)sharedManager;

- (void)workerThreadWithRobot:(FTPRobot *)robot;

- (void)registerSource:(FTPRobotRunLoopContext *)robotRunLoopContext;
- (void)removeSource:(FTPRobotRunLoopContext *)robotRunLoopContext;
- (void)removeAllSource;

- (void)removeMainThreadSource:(FTPGameEngineRunLoopContext *)gameEngineRunLoopContext;
- (void)registerMainThreadSource:(FTPGameEngineRunLoopContext *)gameEngineRunLoopContext;

- (void)pingSourceAtIndex:(NSUInteger)index gameContext:(FTPGameContext *)gameContext;
- (void)stopSourceAtIndex:(NSUInteger)index;

@property (weak, nonatomic) id<GameEngine> gameEngine;

@end
