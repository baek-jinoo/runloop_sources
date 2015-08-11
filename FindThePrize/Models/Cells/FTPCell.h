//
//  FTPCell.h
//  FindThePrize
//
//  Created by Jin on 8/10/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cell.h"

@class FTPRobot;

@interface FTPCell : NSObject <Cell>

- (instancetype)initWithCoordinate:(FTPCoordinate *)coordinate NS_DESIGNATED_INITIALIZER;

@property (assign, nonatomic, readwrite) FTPBoardCellType boardCellType;
@property (assign, nonatomic, readwrite) BOOL hasPrize;
@property (assign, nonatomic, readwrite) BOOL isOccupied;
@property (strong, nonatomic, readwrite) FTPRobot *owner;

- (instancetype)init NS_UNAVAILABLE;

@end
