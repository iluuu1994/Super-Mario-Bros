//
//  SKAnimationConfiguration.h
//  Game
//
//  Created by Ilija Tovilo on 2/3/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface STAnimationConfiguration : NSObject

@property (unsafe_unretained) NSString *name;
@property (unsafe_unretained) NSString *frameNamePattern;
@property NSTimeInterval delay;

- (id)initWithName:(NSString *)name
  frameNamePattern:(NSString *)frameNamePattern
             delay:(NSTimeInterval)delay;

+ (id)configurationWithName:(NSString *)name
  frameNamePattern:(NSString *)frameNamePattern
             delay:(NSTimeInterval)delay;

- (CCAnimation *)animation;

@end
