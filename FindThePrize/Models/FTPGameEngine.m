//
//  FTPGameEngine.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "FTPGameEngine.h"
#import "FTPRobot.h"
#import "FTPPrizeDispatcher.h"
#import "FTPGameEngineRunLoopSource.h"
#import "FTPMultiThreadManager.h"
#import "FTPGameContext.h"
#import "FTPArena.h"
#import "FTPSize.h"
#import "FTPCommand.h"
#import "FTPGameEngineProxy.h"
#import "FTPCoordinate.h"
#import "FTPGameUIInteracting.h"

@interface FTPGameEngine ()

@property (strong, nonatomic) FTPRobot *firstRobot;
@property (strong, nonatomic) FTPRobot *secondRobot;
@property (strong, nonatomic) FTPPrizeDispatcher *prizeDispatcher;
@property (strong, nonatomic) FTPGameEngineRunLoopSource *gameEngineRunLoopSource;
@property (strong, nonatomic) NSArray *robots;
@property (assign, nonatomic) NSUInteger turns;
@property (strong, nonatomic) NSMutableArray *workers;
@property (strong, nonatomic) FTPGameEngineProxy *currentGameEngineProxy;
@property (weak, nonatomic) FTPMultiThreadManager *sharedManager;
@property (strong, nonatomic) NSTimer *currentTimer;

@end

@implementation FTPGameEngine

- (instancetype)initWithArena:(FTPArena *)arena;
{
    self = [super init];
    if (self) {
        _arena = arena;
        _arena.gameWinningDelegate = self;
        _sharedManager = [FTPMultiThreadManager sharedManager];
        _firstRobot = [[FTPRobot alloc] initWithTeamOne:YES];
        _secondRobot = [[FTPRobot alloc] initWithTeamOne:NO];
    }
    return self;
}

- (void)configureNewGame;
{
    [self.arena clearArena];
    _robots = @[_firstRobot, _secondRobot];
    _workers = [NSMutableArray arrayWithCapacity:_robots.count];
    _turns = arc4random() % _robots.count;
    _prizeDispatcher = [[FTPPrizeDispatcher alloc] initWithArena:self.arena];
    [self placeRobots];
    [self placePrize];
}

- (void)placeRobots;
{
    [self.arena insertRobot:self.firstRobot coordinate:[FTPCoordinate withX:0 Y:0]];
    [self.arena insertRobot:self.secondRobot coordinate:[FTPCoordinate withX:6 Y:6]];
}

- (void)placePrize;
{
    [self.prizeDispatcher dispatchPrize];
}

- (void)executeCommand:(FTPCommand *)command;
{
    [self.arena executeCommand:command];
    if (self.arena.winnerDeclared) {
        [self.gameUIInteractionDelegate updateScores];
        [self restartGame];
        return;
    }

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
        NSTimer *timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(giveTurnToNextRobotInLine) userInfo:nil repeats:NO];
        self.currentTimer = timer;
        [[NSRunLoop mainRunLoop] addTimer:self.currentTimer forMode:NSDefaultRunLoopMode];
    }
}

- (void)gameWonBy:(FTPRobot *)robot;
{
    robot.wins = robot.wins + 1;
}

- (void)restartGame;
{
    [self configureNewGame];
    [self startGame];
    [self.gameUIInteractionDelegate updateScreen];
}

- (NSArray *)scores;
{
    NSMutableArray *scores = [NSMutableArray arrayWithCapacity:self.robots.count];
    for (FTPRobot *robot in self.robots) {
        NSString *score = [NSString stringWithFormat:@"%lu", (unsigned long)robot.wins];
        [scores addObject:score];
    }
    return scores;
}

- (void)startGame;
{
    [self.currentTimer invalidate];
    [self.currentGameEngineProxy invalidate];
    [self.gameEngineRunLoopSource invalidate];
    [self.sharedManager removeAllSource];

    [self configureNewGame];

    self.currentGameEngineProxy = [[FTPGameEngineProxy alloc] initWithGameEngine:self];
    self.gameEngineRunLoopSource = [[FTPGameEngineRunLoopSource alloc] initWithGameEngineProxy:self.currentGameEngineProxy];
    [self.gameEngineRunLoopSource addToCurrentRunLoop];

    self.sharedManager.gameEngine = self;
    for (FTPRobot *robot in self.robots) {
        NSThread *worker = [[NSThread alloc] initWithTarget:self.sharedManager
                                                    selector:@selector(workerThreadWithRobot:)
                                                      object:robot];
        [worker start];
        [self.workers addObject:worker];
    }
}

- (void)giveTurnToNextRobotInLine;
{
    FTPGameContext *gameContext = [[FTPGameContext alloc] initWithArenaContext:self.arena
                                                         prizeCoordinate:self.prizeDispatcher.prizeCoordinate
                                                 gameEngineRunLoopSource:self.gameEngineRunLoopSource];
    [self.sharedManager pingSourceAtIndex:self.turns gameContext:gameContext];
}

+ (FTPSize *)arenaSize;
{
    return [[FTPSize alloc] initWithWidth:7 height:7];
}

@end
