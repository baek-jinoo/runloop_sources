//
//  Robot.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinate.h"
#import "Cell.h"

@interface Robot : NSObject <Cell>

- (instancetype)initWithX:(NSUInteger)x Y:(NSUInteger)y teamOne:(BOOL)teamOne NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end