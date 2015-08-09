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
@protocol Cell;

@interface Arena : NSObject

- (instancetype)initWithArenaSize:(FTPSize *)size NS_DESIGNATED_INITIALIZER;

@property (strong, nonatomic, readonly) NSArray *cells;

- (FTPSize *)size;

- (void)placeRobot:(Robot *)robot;
- (void)placePrizeCell:(id<Cell>)prizeCell;
- (void)clearArena;

- (Coordinate *)coordinateWithIndexOfArray:(NSUInteger)index size:(FTPSize *)size;

- (instancetype)init NS_UNAVAILABLE;

@end
