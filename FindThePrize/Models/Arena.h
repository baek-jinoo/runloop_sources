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

@protocol ArenaContext <NSObject>

// implement cell at coordinate

- (NSArray *)cells;
- (FTPSize *)size;

@end

@interface Arena : NSObject <ArenaContext>

- (instancetype)initWithArenaSize:(FTPSize *)size NS_DESIGNATED_INITIALIZER;

- (void)placeRobot:(Robot *)robot coordinate:(Coordinate *)coordinate;
- (void)placePrizeCellAtCoordinate:(Coordinate *)coordinate;
- (void)clearArena;
- (void)executeCommand:(FTPCommand *)command;

- (Coordinate *)coordinateWithIndexOfArray:(NSUInteger)index size:(FTPSize *)size;

- (instancetype)init NS_UNAVAILABLE;

@end
