//
//  FTPArena.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FTPRobot;
@class FTPSize;
@class FTPCoordinate;
@class FTPCommand;
@protocol Cell;
@protocol GameWinning;

@protocol ArenaContext <NSObject>

- (NSArray *)cells;
- (FTPSize *)size;

@property (strong, nonatomic, readonly) NSMutableArray *robots;

@end

@interface FTPArena : NSObject <ArenaContext>

- (instancetype)initWithArenaSize:(FTPSize *)size NS_DESIGNATED_INITIALIZER;

- (void)insertRobot:(FTPRobot *)robot coordinate:(FTPCoordinate *)coordinate;
- (void)placePrizeCellAtCoordinate:(FTPCoordinate *)coordinate;
- (void)clearArena;
- (void)executeCommand:(FTPCommand *)command;

- (FTPCoordinate *)coordinateWithIndexOfArray:(NSUInteger)index size:(FTPSize *)size;

@property (assign, nonatomic, readonly) BOOL winnerDeclared;
@property (weak, nonatomic) id<GameWinning> gameWinningDelegate;

- (instancetype)init NS_UNAVAILABLE;

@end
