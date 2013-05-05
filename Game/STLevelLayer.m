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
#import "STSoundManager.h"
#import "STTiledMapKeys.h"
#import "STMario.h"

#define kDefaultGravity ccp(0, -9.81)
#define kMaxCameraEdge 300

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
        [self setUiLayer:[STControlsLayer layerWithDelegate:self]];
        [self addChild:[self uiLayer]];
    }
    
    return self;
}

+ (id)layerWithWorldID:(unsigned short)worldID levelID:(unsigned short)levelID {
    return [[self alloc] initWithWorldID:worldID levelID:levelID];
}

// TODO: remove?
+ (id)sceneWithWorldID:(unsigned short)worldID levelID:(unsigned short)levelID {
    STLevelLayer *layer = [STLevelLayer layerWithWorldID:worldID
                                                 levelID:levelID];
    STScene *scene = [STScene node];
    [scene addChild:layer];
    return scene;
}

- (void)setUp {
    [super setUp];
    
    // TODO: static name of music file
    [[STSoundManager sharedInstance] playBackgroundMusic:@"theme.mp3"];
}

- (void)tearDown {
    [super tearDown];
    
    for (id spriteCacheName in [self.levelInfo objectForKey:kLevelSpriteCacheKey]) {
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:spriteCacheName];
    }
    
    [[STSoundManager sharedInstance] stopBackgroundMusic];
}

- (void)onEnter {
    [super onEnter];
    
    // Init Player
    self.player = [[STMario alloc] init];
    self.player.delegate = self;
    
    NSDictionary *position = [self.objectGroup objectNamed:kPlayerSpawnPointKey];
    self.player.position = ccp([position[kXKey] floatValue], [position[kYKey] floatValue]);
    
    [self addGameObjectToMap:self.player];
}

#pragma mark -
#pragma mark Update

- (BOOL)needsUpdate {
    return YES;
}

- (void)update:(ccTime)delta {
    self.player.velocity = ccp(15, self.player.velocity.y); // TODO: remove this, only for debugging
    [self updateGravity:delta];
    [self updateCollisions:delta];
}

- (void)updateGravity:(ccTime)delta {
    for (STGameObject *go in self.gameObjects) {
        if (go.bodyType == STGameObjectBodyTypeDynamic) {
            go.velocity = ccpAdd(go.velocity, kDefaultGravity);
            [go move:ccp(go.velocity.x * delta, go.velocity.y * delta)];
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

#pragma mark -
#pragma mark ControlsLayer Delegate
- (IBAction)a:(id)sender {
    [self.player jump];
}

- (IBAction)b:(id)sender {
    NSLog(@"b pressed.");
}

#define kJoystickTolerance 0.0
- (IBAction)joystick:(id)sender delta:(ccTime)delta {
    CGPoint velocity = [(SneakyJoystick *)sender velocity];
    [self.player setVelocity:ccp(velocity.x * delta * 5000, self.player.velocity.y)];
}

- (IBAction)pause:(id)sender {
    [self replaceUILayer:[STPauseLayer layerWithDelegate:self worldID:[self worldID] levelID:[self levelID]]];
    [[STGameFlowManager sharedInstance] pause];
}

#pragma mark -
#pragma mark PauseLayer Delegate
- (IBAction)play:(id)sender {
    [self replaceUILayer:[STControlsLayer layerWithDelegate:self]];
    [[STGameFlowManager sharedInstance] resume];
}

#pragma mark -
#pragma mark Player Delegate
- (void)player:(STPlayer *)player didMoveToPoint:(CGPoint)point {
    CGFloat cameraWidth = [[CCDirector sharedDirector] winSize].width;
    CGFloat playerX = player.position.x;
    CGFloat mapX = self.map.position.x * -1;
    CGFloat deltaX = (playerX - mapX) - (cameraWidth - kMaxCameraEdge);
    
    // Prevent the player from going to the left (The screen can only move to the right).
    if (deltaX > 0) {
        self.map.position = ccpAdd(self.map.position, ccp(-deltaX, 0));
    }
}

- (BOOL)player:(STPlayer *)player shouldMoveToPoint:(CGPoint)point {
    
    /*
    CGFloat playerX = point.x;
    CGFloat mapX = self.map.position.x * -1;
        
    if (playerX - mapX < 0) return NO;*/
    
    return YES;
}

- (void)replaceUILayer:(STLayer *)layer {
    [self removeChild:[self uiLayer]];
    [self setUiLayer:layer];
    [self addChild:[self uiLayer]];
}

@end
