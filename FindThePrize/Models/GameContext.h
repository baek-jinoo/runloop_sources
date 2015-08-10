//
//  GameContext.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ArenaContext;
@class Coordinate;
@class GameEngineRunLoopSource;

@interface GameContext : NSObject

- (instancetype)initWithArenaContext:(id<ArenaContext>)arenaContext
                     prizeCoordinate:(Coordinate *)prizeCoordinate
                  opponentCoordinate:(Coordinate *)opponentCoordinate
             gameEngineRunLoopSource:(GameEngineRunLoopSource *)gameEngineRunLoopSource NS_DESIGNATED_INITIALIZER;

@property (strong, nonatomic, readonly) id<ArenaContext> arenaContext;
@property (strong, nonatomic, readonly) Coordinate *prizeCoordinate;
@property (strong, nonatomic, readonly) Coordinate *opponentCoordinate;
@property (weak, nonatomic, readonly) GameEngineRunLoopSource *gameEngineRunLoopSource;

- (instancetype)init NS_UNAVAILABLE;

@end
