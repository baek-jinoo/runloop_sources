//
//  FTPRobot.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "FTPRobot.h"

#import "FTPGameContext.h"
#import "FTPCommand.h"
#import "FTPCoordinate.h"
#import "FTPBrain.h"

@interface FTPRobot ()

@property (assign, nonatomic) BOOL teamOne;
@property (strong, nonatomic) FTPBrain *brain;

@end

@implementation FTPRobot

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

- (FTPCommand *)nextCommandWithGameContext:(FTPGameContext *)gameContext;
{
    return [self.brain nextCommandWithGameContext:gameContext];
}

@end
