//
//  GameEngine.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "GameEngine.h"
#import "Robot.h"

@implementation GameEngine

- (instancetype)initWithArena:(Arena *)arena;
{
    self = [super init];
    if (self) {
        _arena = arena;
        [self placeRobots];
    }
    return self;
}

- (void)placeRobots;
{
    Robot *firstRobot = [[Robot alloc] initWithX:0 Y:0 teamOne:YES];
    Robot *secondRobot = [[Robot alloc] initWithX:7 Y:7 teamOne:NO];

    [self.arena placeRobot:firstRobot];
    [self.arena placeRobot:secondRobot];
}

+ (FTPSize *)arenaSize;
{
    return [[FTPSize alloc] initWithWidth:7 height:7];
}

@end
