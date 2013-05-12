//
//  STLevelLayer.m
//  Game
//
//  Created by Ilija Tovilo on 3/12/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STLevelLayer.h"
#import "STWorldsConstants.h"
#import "CCDirector+Transitions.h"
#import "NSBundle+Resources.h"
#import "STCollisionDetectionHelper.h"
#import "STLevelResultLayer.h"
#import "STGameFlowManager.h"
#import "STWorldInfoReader.h"
#import "STWorldsConstants.h"
#import "STGameObject.h"
#import "STSoundManager.h"
#import "STTiledMapKeys.h"
#import "STMario.h"
#import "STItem.h"

#define kDefaultGravity ccp(0, -9.81)
#define kMaxCameraEdge 200

@interface STLevelLayer ()
@property (strong) NSMutableArray *gameObjectsToAdd;
@end

@implementation STLevelLayer
{}

#pragma mark -
#pragma mark Initialise
- (id)initWithWorldID:(unsigned short)worldID levelID:(unsigned short)levelID {
    _levelInfo = [[STWorldInfoReader sharedInstance] levelWithWorldID:worldID levelID:levelID];
    _gameObjectsToAdd = [NSMutableArray array];
    
    for (id spriteCacheName in [self.levelInfo objectForKey:kLevelSpriteCacheKey]) {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:spriteCacheName];
    }
    
    self = [super initWithTiledMap:
            [NSString stringWithFormat:[[STWorldInfoReader sharedInstance] namingConvention],
             worldID, levelID]];
    if (self) {
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

- (void)setUp {
    [super setUp];
    //[[STSoundManager sharedInstance] playBackgroundMusic:kSoundTheme loop:YES];
}

- (void)tearDown {
    [super tearDown];
}

- (void)onEnter {
    [super onEnter];
    
    // Init Player
    self.player = [[STMario alloc] init];
    self.player.delegate = self;
    
    NSDictionary *position = [self.objectGroup objectNamed:kPlayerSpawnPointKey];
    self.player.position = ccp([position[kXKey] floatValue], [position[kYKey] floatValue]);
    
    [self addGameObjectToMap:self.player];
    
    NSDictionary *level = [[STWorldInfoReader sharedInstance] levelWithWorldID:_worldID levelID:_levelID];
    unsigned short time = [[level valueForKey:kLevelTimeKey] shortValue];
    [self setInfoLayer:[STInformationLayer layerWithDelegate:self player:self.player time:time]];
    [self addChild:self.infoLayer];
}

- (void)unloadSpriteCache {
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
    [self cleanup];
    [self updateGravity:delta];
    [self updateCollisions:delta];
    [self updateGameObjects];
    [self trashLostGameObjects];
}

- (void)cleanup {
    // Add new objects
    for (STGameObject *newGo in self.gameObjectsToAdd) {
        [self addGameObjectToMap:newGo];
    }
    self.gameObjectsToAdd = [NSMutableArray array];
    
    // Remove dead objects
    NSMutableArray *deadObjects = [NSMutableArray array];
    for (STGameObject *go in self.gameObjects) {
        if (go.isDead) {
            [deadObjects addObject:go];
        }
    }
    for (STGameObject *deadGo in deadObjects) {
        [deadGo removeFromParent];
        [self.gameObjects removeObject:deadGo];
    }
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
                STRectEdge edge1 = [self updateCollisionOfGameObject:child withGameObject:child2 delta:delta];
                STRectEdge edge2 = [self updateCollisionOfGameObject:child2 withGameObject:child delta:delta];
                
                // Send notifications
                [child collisionWithGameObject:child2 edge:edge1];
                [child2 collisionWithGameObject:child edge:edge2];
            }
        }
    }
}

- (STRectEdge)updateCollisionOfGameObject:(STGameObject *)gameObject
                           withGameObject:(STGameObject *)gameObject2
                                    delta:(ccTime)delta {
    
    STRectEdge rectEdge;
    float edgeLeft = (gameObject.boundingBox.origin.x - gameObject2.boundingBox.origin.x - gameObject.boundingBox.size.width) * -1;
    float edgeRight = (gameObject.boundingBox.origin.x + gameObject2.boundingBox.size.width - gameObject2.boundingBox.origin.x);
    float edgeTop = (gameObject.boundingBox.origin.y + gameObject.boundingBox.size.height - gameObject2.boundingBox.origin.y);
    float edgeBottom = (gameObject.boundingBox.origin.y - gameObject2.boundingBox.size.height - gameObject2.boundingBox.origin.y) * -1;
    
    float offset = 0.0;
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
    
    if (gameObject.bodyType != STGameObjectBodyTypeStatic) {
        if (gameObject2.bodyType != STGameObjectBodyTypeStatic) {
            offset /= 2.0;
        }
        
        if ([gameObject bodyType] != STGameObjectBodyTypeNonColliding && [gameObject2 bodyType] != STGameObjectBodyTypeNonColliding) {
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
    
    return rectEdge;
}

#pragma mark -
#pragma mark Game Objects

- (void)updateGameObjects {
    [self readGameObjectsFromMap];
}

#define kMapLoadingDelta 10.0
- (void)readGameObjectsFromMap {
    int mapHeight = self.objectLayer.layerSize.height;
    CGFloat cameraWidth = [[CCDirector sharedDirector] winSize].width;
    CGFloat mapX = self.map.position.x * -1 / self.map.scale;
    
    int tileWidth = (cameraWidth + (2 * kMapLoadingDelta)) / self.map.tileSize.width;
    int firstTile = ((mapX - kMapLoadingDelta) / self.map.tileSize.width) + 1;
    if (firstTile < 0) firstTile = 0;
    
    int lastTile = firstTile + tileWidth;
    if (lastTile > self.objectLayer.layerSize.width) lastTile = self.objectLayer.layerSize.width;
    
    for (int x = firstTile; x < lastTile; x++) {
        for (int y = 0; y < mapHeight; y++) {
            [self createGameObjectAtX:x y:y];
        }
    }
}

#define kRemovingDelta 30.0
- (void)trashLostGameObjects {
    CGFloat cameraWidth = [[CCDirector sharedDirector] winSize].width;
    CGFloat mapX = self.map.position.x * -1 / self.map.scale;
    
    for (STGameObject *gameObject in self.gameObjects) {
        if (
            // if objects fell of the ground
            gameObject.boundingBox.origin.y + gameObject.boundingBox.size.height + kRemovingDelta < 0
            ||
            // too much on left side
            gameObject.boundingBox.origin.x + gameObject.boundingBox.size.width + kRemovingDelta < mapX
            ||
            // too much on right side
            gameObject.boundingBox.origin.x - kRemovingDelta > mapX + cameraWidth
            ) {
            [gameObject setDead:YES];
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
    [self.player setVelocity:ccp(velocity.x * delta * 7000, self.player.velocity.y)];
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

- (IBAction)retryLevel:(id)sender {
    [self unloadSpriteCache];
    [[STGameFlowManager sharedInstance] resume];
    STScene *scene = [[STLevelLayer layerWithWorldID:self.worldID levelID:self.levelID] scene];
    [[CCDirector sharedDirector] replaceScene: scene
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

#pragma mark -
#pragma mark Player Delegate
- (void)player:(STPlayer *)player didMoveToPoint:(CGPoint)point {
    CGFloat cameraWidth = [[CCDirector sharedDirector] winSize].width;
    CGFloat playerX = player.position.x;
    CGFloat mapX = self.map.position.x * -1 / self.map.scale;
    
    // Moves the camera with the player
    if (mapX - playerX + kMaxCameraEdge < 0) {
        float newMapX = (-playerX + kMaxCameraEdge) * self.map.scale;
        if (newMapX > 0) {
            newMapX = 0;
        } else if (self.map.boundingBox.size.width + newMapX - cameraWidth < 0) {
            newMapX = -self.map.boundingBox.size.width + cameraWidth;
        }
        
        self.map.position = ccp(newMapX, self.map.position.y);;
    }
}

- (BOOL)player:(STPlayer *)player shouldMoveToPoint:(CGPoint)point {
    
    /*
    CGFloat playerX = point.x;
    CGFloat mapX = self.map.position.x * -1;
        
    if (playerX - mapX < 0) return NO;*/
    
    return YES;
}

- (void)playerDied:(STPlayer *)player {
    [self gameOver];
}

- (void)replaceUILayer:(STLayer *)layer {
    [self removeChild:[self uiLayer]];
    [self setUiLayer:layer];
    [self addChild:[self uiLayer]];
}

#pragma mark -
#pragma mark InformationLayer Delegate

- (IBAction)timeElapsed:(id)sender {
    [self gameOver];
}

#pragma mark -
#pragma mark Game Over
- (void)gameOver {
    [[STSoundManager sharedInstance] playEffect:kSoundDeath];
    [[STSoundManager sharedInstance] stopBackgroundMusic];
    
    NSDictionary *level = [[STWorldInfoReader sharedInstance] levelWithWorldID:_worldID levelID:_levelID];
    int time = [[level valueForKey:kLevelTimeKey] integerValue];
    
    STLayer *layer = [STLevelResultLayer layerWithWorldID:_worldID levelID:_levelID
                                                     time:time - [self.infoLayer time]
                                                    score:[[self player] score]
                                                  success:NO];
    [[CCDirector sharedDirector] replaceScene: [layer scene]
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

#pragma mark -
#pragma mark STItemBlockDelegate

- (void)addItemToMap:(STItem *)item toPosition:(CGPoint)position {
    [item setPosition:position];
    [self.gameObjectsToAdd addObject:item];
}

@end
