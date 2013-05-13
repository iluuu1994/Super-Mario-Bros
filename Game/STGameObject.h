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

@class STGameObject;
@protocol STGameObjectDelegate <NSObject>
- (void)addGameObjectToMap:(STGameObject *)gameObject toPosition:(CGPoint)position;
@end

@interface STGameObject : STAnimatedSprite <CCTouchAllAtOnceDelegate>

@property (setter = setCollidable:) BOOL isCollidable;
@property (readonly) BOOL needsTouchNotifications;
@property (readonly, nonatomic) float weight;
@property CGPoint velocity;
@property STGameObjectBodyType bodyType;
@property (nonatomic) STAppearanceType appearanceType;
@property (setter = setDead:) BOOL isDead;

@property (readonly, nonatomic) BOOL differenciatesAppearance;
@property (unsafe_unretained) id<STGameObjectDelegate> delegate;

- (void)move:(CGPoint)deltaPoint;
- (void)collisionWithGameObject:(STGameObject *)gameObject
                           edge:(STRectEdge)edge;
- (NSString *)appearanceNameForString:(NSString *)name;

@end
