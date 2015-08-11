//
//  Robot.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "Robot.h"

#import "GameContext.h"
#import "FTPCommand.h"
#import "Coordinate.h"
#import "FTPBrain.h"

@interface Robot ()

@property (assign, nonatomic) BOOL teamOne;
@property (strong, nonatomic) FTPBrain *brain;

@end

@implementation Robot

- (instancetype)initWithTeamOne:(BOOL)teamOne;
{
    self = [super init];
    if (self) {
        _teamOne = teamOne;
        _wins = 0;
        _brain = [[FTPBrain alloc] initWithRobot:self];
    }
    return self;
}

- (FTPCommand *)nextCommandWithGameContext:(GameContext *)gameContext;
{
    return [self.brain nextCommandWithGameContext:gameContext];
}

@end
