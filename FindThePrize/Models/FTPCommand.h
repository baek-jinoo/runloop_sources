//
//  FTPCommand.h
//  FindThePrize
//
//  Created by Jin on 8/10/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Robot;

typedef NS_ENUM(NSInteger, FTPCommandMovementDirection){
    FTPCommandMovementDirectionUp = 1,
    FTPCommandMovementDirectionDown,
    FTPCommandMovementDirectionLeft,
    FTPCommandMovementDirectionRight,
};

@interface FTPCommand : NSObject

- (instancetype)initWithMovementDirection:(FTPCommandMovementDirection)movementDirection robot:(Robot *)robot NS_DESIGNATED_INITIALIZER;

@property (assign, nonatomic) FTPCommandMovementDirection movementDirection;
@property (weak, nonatomic) Robot *robot;

- (instancetype)init NS_UNAVAILABLE;

@end
