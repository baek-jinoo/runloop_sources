//
//  Arena.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Robot;
@class FTPSize;
@class Coordinate;
@class FTPCommand;
@protocol Cell;
@protocol GameWinning;

@protocol ArenaContext <NSObject>

- (NSArray *)cells;
- (FTPSize *)size;

@end

@interface Arena : NSObject <ArenaContext>

- (instancetype)initWithArenaSize:(FTPSize *)size NS_DESIGNATED_INITIALIZER;

- (void)insertRobot:(Robot *)robot coordinate:(Coordinate *)coordinate;
- (void)placePrizeCellAtCoordinate:(Coordinate *)coordinate;
- (void)clearArena;
- (void)executeCommand:(FTPCommand *)command;

- (Coordinate *)coordinateWithIndexOfArray:(NSUInteger)index size:(FTPSize *)size;

@property (assign, nonatomic, readonly) BOOL winnerDeclared;
@property (weak, nonatomic) id<GameWinning> gameWinningDelegate;

- (instancetype)init NS_UNAVAILABLE;

@end
