//
//  Arena.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "Arena.h"
#import "BoardCellType.h"
#import "FTPBackgroundCell.h"
#import "Coordinate.h"
#import "FTPSize.h"
#import "Robot.h"

@interface Arena ()

@property (strong, nonatomic) NSMutableArray *internalCells;

@end

@implementation Arena

- (instancetype)initWithArenaSize:(FTPSize *)size;
{
    self = [super init];
    if (self) {
        _internalCells = [NSMutableArray array];
        [self setArenaSize:size];
    }
    return self;
}

- (void)placeRobot:(Robot *)robot;
{
//    self.internalCells

}

- (NSArray *)cells;
{
    return [self.internalCells copy];
}

#pragma mark - Private

- (void)setArenaSize:(FTPSize *)size;
{
    for (int i = 0; i < size.width * size.height; i++) {
        Coordinate *coordinate = [self coordinateWithIndexOfArray:i size:size];
        id<Cell> backgroundCell = [[FTPBackgroundCell alloc] initWithX:coordinate.x Y:coordinate.y];
        [self.internalCells addObject:backgroundCell];
    }
}

- (Coordinate *)coordinateWithIndexOfArray:(NSUInteger)index size:(FTPSize *)size;
{
    NSUInteger row = index / size.width;
    NSUInteger column = index % size.width;
    return [[Coordinate alloc] initWithX:column Y:row];
}

@end
