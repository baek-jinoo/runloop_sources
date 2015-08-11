//
//  FTPGameEngine.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FTPArena;
@class FTPSize;
@class FTPCommand;
@class FTPGameEngineRunLoopSource;
@class FTPRobot;
@protocol FTPGameUIInteracting;

@protocol GameEngine <NSObject>

- (void)executeCommand:(FTPCommand *)command;
- (void)totalRobotWorkerSourceRegistered:(NSUInteger)numberOfWorkers;

@end

@protocol GameWinning <NSObject>

- (void)gameWonBy:(FTPRobot *)robot;

@end

@interface FTPGameEngine : NSObject <GameEngine, GameWinning>

- (instancetype)initWithArena:(FTPArena *)arena NS_DESIGNATED_INITIALIZER;

@property (strong, nonatomic, readonly) FTPArena *arena;
@property (weak, nonatomic) id<FTPGameUIInteracting> gameUIInteractionDelegate;
@property (strong, nonatomic, readonly) FTPGameEngineRunLoopSource *gameEngineRunLoopSource;

- (void)configureNewGame;
- (void)startGame;
- (NSArray *)scores;

+ (FTPSize *)arenaSize;

- (instancetype)init NS_UNAVAILABLE;

@end
