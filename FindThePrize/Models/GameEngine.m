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

@interface GameEngine ()

@property (strong, nonatomic) Robot *firstRobot;
@property (strong, nonatomic) Robot *secondRobot;
@property (strong, nonatomic) FTPPrizeDispatcher *prizeDispatcher;

@end

@implementation GameEngine

- (instancetype)initWithArena:(Arena *)arena;
{
    self = [super init];
    if (self) {
        [self initializeNewGameWithArena:arena];
    }
    return self;
}

- (void)initializeNewGameWithArena:(Arena *)arena;
{
    _arena = arena;
    _firstRobot = [[Robot alloc] initWithX:0 Y:0 teamOne:YES];
    _secondRobot = [[Robot alloc] initWithX:6 Y:6 teamOne:NO];
    _prizeDispatcher = [[FTPPrizeDispatcher alloc] initWithArena:_arena];
    [self placeRobots];
    [self placePrize];
}

- (void)placeRobots;
{
    [self.arena placeRobot:self.firstRobot];
    [self.arena placeRobot:self.secondRobot];
}

- (void)placePrize;
{
    [self.prizeDispatcher dispatchPrize];
}

+ (FTPSize *)arenaSize;
{
    return [[FTPSize alloc] initWithWidth:7 height:7];
}

@end
