//
//  Coordinate.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coordinate : NSObject

- (instancetype)initWithX:(NSInteger)x Y:(NSInteger)y NS_DESIGNATED_INITIALIZER;
+ (instancetype)withX:(NSInteger)x Y:(NSInteger)y;

@property (assign, nonatomic, readonly) NSInteger x;
@property (assign, nonatomic, readonly) NSInteger y;

- (instancetype)init NS_UNAVAILABLE;

@end
