//
//  STGameObject.h
//  Game
//
//  Created by Ilija Tovilo on 4/23/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STAnimatedSprite.h"

#ifndef STGameObjectBodyTypeEnum
#define STGameObjectBodyTypeEnum

typedef enum {
    STGameObjectBodyTypeNonColliding,
    STGameObjectBodyTypeStatic,
    STGameObjectBodyTypeDynamic,
    STGameObjectBodyTypeSemiDynamic
} STGameObjectBodyType;

#endif

@interface STGameObject : STAnimatedSprite <CCTouchAllAtOnceDelegate>

@property (setter = setCollidable:) BOOL isCollidable;
@property (readonly) BOOL needsTouchNotifications;
@property (readonly, nonatomic) float weight;
@property CGPoint velocity;
@property STGameObjectBodyType bodyType;

- (void)move:(CGPoint)deltaPoint;
- (void)collisionWithGameObject:(STGameObject *)gameObject;

@end
