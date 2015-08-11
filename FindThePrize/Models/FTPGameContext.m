//
//  FTPGameContext.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "FTPGameContext.h"
#import "FTPGameEngineRunLoopSource.h"

@implementation FTPGameContext

- (instancetype)initWithArenaContext:(id<ArenaContext>)arenaContext
                     prizeCoordinate:(FTPCoordinate *)prizeCoordinate
             gameEngineRunLoopSource:(FTPGameEngineRunLoopSource *)gameEngineRunLoopSource;
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
