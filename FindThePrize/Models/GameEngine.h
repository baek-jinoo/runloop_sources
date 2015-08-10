//
//  GameEngine.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Arena;
@class FTPSize;
@class FTPCommand;
@class GameEngineRunLoopSource;
@protocol GameUIInteracting;

@protocol GameEngine <NSObject>

- (void)executeCommand:(FTPCommand *)command;
- (void)totalRobotWorkerSourceRegistered:(NSUInteger)numberOfWorkers;

@end

@interface GameEngine : NSObject <GameEngine>

- (instancetype)initWithArena:(Arena *)arena NS_DESIGNATED_INITIALIZER;

@property (strong, nonatomic, readonly) Arena *arena;
@property (weak, nonatomic) id<GameUIInteracting> gameUIInteractionDelegate;
@property (strong, nonatomic, readonly) GameEngineRunLoopSource *gameEngineRunLoopSource;

- (void)configureNewGame;
- (void)startGame;

+ (FTPSize *)arenaSize;

- (instancetype)init NS_UNAVAILABLE;

@end
