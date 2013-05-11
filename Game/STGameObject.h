//
//  STGameObject.h
//  Game
//
//  Created by Ilija Tovilo on 4/23/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STAnimatedSprite.h"

#ifndef STGameObjectEnums
#define STGameObjectEnums

typedef enum {
    STRectEdgeMinX,
    STRectEdgeMinY,
    STRectEdgeMaxX,
    STRectEdgeMaxY
} STRectEdge;

typedef enum {
    STAppearanceTypeDefault,
    STAppearanceTypeDark,
    STAppearanceTypeCastle
} STAppearanceType;

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
@property (nonatomic) STAppearanceType appearanceType;
@property (setter = setDead:) BOOL isDead;

@property (readonly, nonatomic) BOOL differenciatesAppearance;

- (void)move:(CGPoint)deltaPoint;
- (void)collisionWithGameObject:(STGameObject *)gameObject
                           edge:(STRectEdge)edge;

@end
