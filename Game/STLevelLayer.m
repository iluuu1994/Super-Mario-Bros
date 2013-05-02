//
//  STLevelLayer.m
//  Game
//
//  Created by Ilija Tovilo on 3/12/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STLevelLayer.h"
#import "STWorldsConstants.h"
#import "NSBundle+Resources.h"
#import "STCollisionDetectionHelper.h"
#import "STGameObject.h"

#define kDefaultGravity ccp(0, -9.81)

typedef enum {
    STRectEdgeMinX,
    STRectEdgeMinY,
    STRectEdgeMaxX,
    STRectEdgeMaxY
} STRectEdge;

@implementation STLevelLayer
{}

#pragma mark -
#pragma mark Initialise
- (id)initWithWorldID:(unsigned short)worldID levelID:(unsigned short)levelID {
    NSDictionary *worldsInfo = [NSDictionary dictionaryWithContentsOfFile:[NSBundle pathForResource:kWorldsFile]];
    _levelInfo = worldsInfo[kWorldsKey][worldID][kLevelsKey][levelID];
    for (id spriteCacheName in [self.levelInfo objectForKey:kLevelSpriteCacheKey]) {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:spriteCacheName];
    }
    
    if (self = [super initWithTiledMap:[NSString stringWithFormat:worldsInfo[kWorldsNamingConvention], worldID, levelID]]) {
        _worldID = worldID;
        _levelID = levelID;
    }
    
    return self;
}

+ (id)layerWithWorldID:(unsigned short)worldID levelID:(unsigned short)levelID {
    return [[self alloc] initWithWorldID:worldID levelID:levelID];
}

+ (id)sceneWithWorldID:(unsigned short)worldID levelID:(unsigned short)levelID {
    STLevelLayer *layer = [STLevelLayer layerWithWorldID:worldID
                                                 levelID:levelID];
    STScene *scene = [STScene node];
    [scene addChild:layer];
    return scene;
}

- (void)tearDown {
    [super tearDown];
    
    for (id spriteCacheName in [self.levelInfo objectForKey:kLevelSpriteCacheKey]) {
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:spriteCacheName];
    }
}

#pragma mark -
#pragma mark Update

- (BOOL)needsUpdate {
    return YES;
}

- (void)update:(ccTime)delta {
    [self updateGravity:delta];
    [self updateCollisions:delta];
}

- (void)updateGravity:(ccTime)delta {
    for (STGameObject *go in self.gameObjects) {
        if (go.bodyType == STGameObjectBodyTypeDynamic) {
            go.velocity = ccpAdd(go.velocity, kDefaultGravity);
            go.position = ccpAdd(go.position, ccp(go.velocity.x * delta, go.velocity.y * delta));
        }
    }
}

- (void)updateCollisions:(ccTime)delta {
    for (STGameObject *child in self.gameObjects) {
        for (STGameObject *child2 in self.gameObjects) {
            // Don't check same object
            if (child == child2) {
                break;
            }
            
            if (STRectIntersect(child.boundingBox, child2.boundingBox)) {
                // Position objects
                [self updateCollisionOfGameObject:child withGameObject:child2 delta:delta];
                [self updateCollisionOfGameObject:child2 withGameObject:child delta:delta];
                
                // Send notifications
                [child collisionWithGameObject:child2];
                [child2 collisionWithGameObject:child];
            }
        }
    }
}

- (void)updateCollisionOfGameObject:(STGameObject *)gameObject
                     withGameObject:(STGameObject *)gameObject2
                              delta:(ccTime)delta {
    
    if (gameObject.bodyType != STGameObjectBodyTypeStatic) {
        float edgeLeft = (gameObject.boundingBox.origin.x - gameObject2.boundingBox.origin.x - gameObject.boundingBox.size.width) * -1;
        float edgeRight = (gameObject.boundingBox.origin.x + gameObject2.boundingBox.size.width - gameObject2.boundingBox.origin.x);
        float edgeTop = (gameObject.boundingBox.origin.y + gameObject.boundingBox.size.height - gameObject2.boundingBox.origin.y);
        float edgeBottom = (gameObject.boundingBox.origin.y - gameObject2.boundingBox.size.height - gameObject2.boundingBox.origin.y) * -1;

        float offset = 0.0;
        STRectEdge rectEdge;
        if (edgeLeft < edgeRight) {
            rectEdge = STRectEdgeMinX;
            offset = edgeLeft;
        } else {
            rectEdge = STRectEdgeMaxX;
            offset = edgeRight;
        }
        
        if (edgeTop < edgeBottom) {
            float cached = edgeTop;
            if (cached < offset) {
                rectEdge = STRectEdgeMaxY;
                offset = cached;
            }
        } else {
            float cached = edgeBottom;
            if (cached < offset) {
                rectEdge = STRectEdgeMinY;
                offset = cached;
            }
        }
        
        if (gameObject2.bodyType != STGameObjectBodyTypeStatic) {
            offset /= 2.0;
        }
        
        switch (rectEdge) {
            case STRectEdgeMinX:
            {
                [gameObject move:ccp(offset, 0)];
            }
                break;
            case STRectEdgeMaxX:
            {
                [gameObject move:ccp(-offset, 0)];
            }
                break;
            case STRectEdgeMinY:
            {
                [gameObject move:ccp(0, offset)];
            }
                break;
            case STRectEdgeMaxY:
            {
                [gameObject move:ccp(0, -offset)];
            }
                break;
        }
        
        if (rectEdge == STRectEdgeMinY && gameObject.velocity.y < 0) {
            gameObject.velocity = ccp(gameObject.velocity.x, 0);
        }
        if (rectEdge == STRectEdgeMaxY && gameObject.velocity.y > 0) {
            gameObject.velocity = ccp(gameObject.velocity.x, 0);
        }
    }
}

@end
