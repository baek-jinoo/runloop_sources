//
//  GameEngineProxy.m
//  FindThePrize
//
//  Created by Jin on 8/10/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "GameEngineProxy.h"
#import "GameEngine.h"

@interface GameEngineProxy ()

@property (assign, nonatomic) BOOL valid;
@property (weak, nonatomic) id<GameEngine> gameEngine;

@end

@implementation GameEngineProxy

- (instancetype)initWithGameEngine:(id<GameEngine>)gameEngine;
{
    self = [super init];
    if (self) {
        _valid = YES;
        _gameEngine = gameEngine;
    }
    return self;
}

- (void)invalidate;
{
    self.valid = NO;
}

- (void)executeCommand:(FTPCommand *)command;
{
    if (self.valid) {
        [self.gameEngine executeCommand:command];
    }
}

@end
