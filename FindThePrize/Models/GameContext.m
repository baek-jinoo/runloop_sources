//
//  GameContext.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "GameContext.h"
#import "GameEngineRunLoopSource.h"

@implementation GameContext

- (instancetype)initWithArenaContext:(id<ArenaContext>)arenaContext
                     prizeCoordinate:(Coordinate *)prizeCoordinate
             gameEngineRunLoopSource:(GameEngineRunLoopSource *)gameEngineRunLoopSource;
{
    self = [super init];
    if (self) {
        _arenaContext = arenaContext;
        _prizeCoordinate = prizeCoordinate;
        _gameEngineRunLoopSource = gameEngineRunLoopSource;
    }
    return self;
}

@end
