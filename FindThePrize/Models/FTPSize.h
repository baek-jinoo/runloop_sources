//
//  FTPSize.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTPSize : NSObject

- (instancetype)initWithWidth:(NSUInteger)width height:(NSUInteger)height NS_DESIGNATED_INITIALIZER;

@property (assign, nonatomic, readonly) NSUInteger width;
@property (assign, nonatomic, readonly) NSUInteger height;

- (instancetype)init NS_UNAVAILABLE;

@end
