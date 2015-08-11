//
//  Coordinate.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coordinate : NSObject

- (instancetype)initWithX:(NSUInteger)x Y:(NSUInteger)y NS_DESIGNATED_INITIALIZER;
+ (instancetype)withX:(NSUInteger)x Y:(NSUInteger)y;

@property (assign, nonatomic, readonly) NSUInteger x;
@property (assign, nonatomic, readonly) NSUInteger y;

- (instancetype)init NS_UNAVAILABLE;

@end
