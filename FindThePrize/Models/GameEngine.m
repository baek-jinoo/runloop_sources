//
//  GameEngine.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "GameEngine.h"
#import "Robot.h"
#import "FTPPrizeDispatcher.h"
#import "GameEngineRunLoopSource.h"
#import "MultiThreadManager.h"
#import "GameContext.h"
#import "Arena.h"
#import "FTPSize.h"
#import "FTPCommand.h"
#import "GameEngineProxy.h"
#import "Coordinate.h"
#import "GameUIInteracting.h"

@interface GameEngine ()

@property (strong, nonatomic) Robot *firstRobot;
@property (strong, nonatomic) Robot *secondRobot;
@property (strong, nonatomic) FTPPrizeDispatcher *prizeDispatcher;
@property (strong, nonatomic) GameEngineRunLoopSource *gameEngineRunLoopSource;
@property (strong, nonatomic) NSArray *robots;
@property (assign, nonatomic) NSUInteger turns;
@property (strong, nonatomic) NSMutableArray *workers;
@property (strong, nonatomic) GameEngineProxy *currentGameEngineProxy;
@property (weak, nonatomic) MultiThreadManager *sharedManager;
@property (strong, nonatomic) NSTimer *currentTimer;

@end

@implementation GameEngine

- (instancetype)initWithArena:(Arena *)arena;
{
    self = [super init];
    if (self) {
        _arena = arena;
        _sharedManager = [MultiThreadManager sharedManager];
    }
    return self;
}

- (void)configureNewGame;
{
    [self.arena clearArena];
    _firstRobot = [[Robot alloc] initWithTeamOne:YES];
    _secondRobot = [[Robot alloc] initWithTeamOne:NO];
    _robots = @[_firstRobot, _secondRobot];
    _workers = [NSMutableArray arrayWithCapacity:_robots.count];
    _turns = 0;
    _prizeDispatcher = [[FTPPrizeDispatcher alloc] initWithArena:self.arena];
    [self placeRobots];
    [self placePrize];
}

- (void)placeRobots;
{
    [self.arena placeRobot:self.firstRobot coordinate:[Coordinate withX:0 Y:0]];
    [self.arena placeRobot:self.secondRobot coordinate:[Coordinate withX:6 Y:6]];
}

- (void)placePrize;
{
    [self.prizeDispatcher dispatchPrize];
}

- (void)executeCommand:(FTPCommand *)command;
{
    [self.arena executeCommand:command];

    [self.gameUIInteractionDelegate updateScreen];

    [self changeTurnToNextRobot];

    NSTimer *timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(giveTurnToNextRobotInLine) userInfo:nil repeats:NO];
    self.currentTimer = timer;
    [[NSRunLoop mainRunLoop] addTimer:self.currentTimer forMode:NSDefaultRunLoopMode];
}

- (void)changeTurnToNextRobot;
{
    self.turns = self.turns + 1;
    if (self.turns >= self.robots.count) {
        self.turns = 0;
    }
}

- (void)totalRobotWorkerSourceRegistered:(NSUInteger)numberOfWorkers;
{
    if (numberOfWorkers == self.robots.count) {
        [self giveTurnToNextRobotInLine];
    }
}

- (void)startGame;
{
    [self.currentTimer invalidate];
    [self.currentGameEngineProxy invalidate];

    [self configureNewGame];

    self.currentGameEngineProxy = [[GameEngineProxy alloc] initWithGameEngine:self];
    self.gameEngineRunLoopSource = [[GameEngineRunLoopSource alloc] initWithGameEngineProxy:self.currentGameEngineProxy];
    [self.gameEngineRunLoopSource addToCurrentRunLoop];

    self.sharedManager.gameEngine = self;
    for (Robot *robot in self.robots) {
        NSThread *worker = [[NSThread alloc] initWithTarget:self.sharedManager
                                                    selector:@selector(workerThreadWithRobot:)
                                                      object:robot];
        [worker start];
        [self.workers addObject:worker];
    }
}

- (void)giveTurnToNextRobotInLine;
{
    GameContext *gameContext = [[GameContext alloc] initWithArenaContext:nil // TODONOW this needs to be real
                                                         prizeCoordinate:self.prizeDispatcher.prizeCoordinate
                                                      opponentCoordinate:self.secondRobot.occupyingCell.coordinate
                                                 gameEngineRunLoopSource:self.gameEngineRunLoopSource];
    [self.sharedManager pingSourceAtIndex:self.turns gameContext:gameContext];
}

+ (FTPSize *)arenaSize;
{
    return [[FTPSize alloc] initWithWidth:7 height:7];
}

@end
