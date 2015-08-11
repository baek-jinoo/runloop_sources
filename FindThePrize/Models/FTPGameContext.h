//
//  FTPGameContext.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ArenaContext;
@class FTPCoordinate;
@class FTPGameEngineRunLoopSource;

@interface FTPGameContext : NSObject

- (instancetype)initWithArenaContext:(id<ArenaContext>)arenaContext
                     prizeCoordinate:(FTPCoordinate *)prizeCoordinate
             gameEngineRunLoopSource:(FTPGameEngineRunLoopSource *)gameEngineRunLoopSource NS_DESIGNATED_INITIALIZER;

@property (strong, nonatomic, readonly) id<ArenaContext> arenaContext;
@property (strong, nonatomic, readonly) FTPCoordinate *prizeCoordinate;
@property (weak, nonatomic, readonly) FTPGameEngineRunLoopSource *gameEngineRunLoopSource;

- (instancetype)init NS_UNAVAILABLE;

@end
