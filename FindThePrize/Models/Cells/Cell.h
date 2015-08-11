//
//  Cell.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoardCellType.h"
@class Coordinate;
@class Robot;

@protocol Cell <NSObject>

- (Coordinate *)coordinate;
- (void)clearCell;

@property (assign, nonatomic, readonly) BoardCellType boardCellType;
@property (assign, nonatomic, readonly) BOOL hasPrize;

@end
