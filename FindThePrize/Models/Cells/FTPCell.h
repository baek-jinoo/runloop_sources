//
//  FTPCell.h
//  FindThePrize
//
//  Created by Jin on 8/10/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cell.h"

@class Robot;

@interface FTPCell : NSObject <Cell>

- (instancetype)initWithCoordinate:(Coordinate *)coordinate NS_DESIGNATED_INITIALIZER;

@property (assign, nonatomic, readwrite) BoardCellType boardCellType;
@property (assign, nonatomic, readwrite) BOOL hasPrize;
@property (assign, nonatomic, readwrite) BOOL isOccupied;
@property (strong, nonatomic, readwrite) Robot *owner;

- (instancetype)init NS_UNAVAILABLE;

@end
