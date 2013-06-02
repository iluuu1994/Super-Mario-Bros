//
//  STLevelLayer.m
//  Game
//
//  Created by Ilija Tovilo on 3/12/13.
//  Copyright (c) 2013 by Lukas Seglias & Ilija Tovilo. All rights reserved.
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

#pragma mark -
#pragma mark Constants

#define kDefaultGravity ccp(0, -9.81)
#define kMaxCameraEdge 200



#pragma mark -
#pragma mark Private Interface

@interface STLevelLayer ()
@property (strong) NSMutableArray *gameObjectsToAdd;
@property CGRect endRect;
@end



#pragma mark -
#pragma mark STLevelLayer Implementation

@implementation STLevelLayer
{}


#pragma mark -
#pragma mark Initialise

- (id)initWithWorldID:(unsigned short)worldID levelID:(unsigned short)levelID {
    _worldID = worldID;
    _levelID = levelID;
    _levelInfo = [[STWorldInfoReader sharedInstance] levelWithWorldID:worldID levelID:levelID];
    _gameObjectsToAdd = [NSMutableArray array];
    
    for (id spriteCacheName in [self.levelInfo objectForKey:kLevelSpriteCacheKey]) {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:spriteCacheName];
    }
    
    self = [super initWithTiledMap:
            [NSString stringWithFormat:[[STWorldInfoReader sharedInstance] namingConvention],
             worldID, levelID]];
    if (self) {
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
    [self startPlayingBackgroundMusic];
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
    
    // End End Position
    NSDictionary *endPosition = [self.objectGroup objectNamed:kPlayerEndRectKey];
    self.endRect = CGRectMake([endPosition[kXKey] floatValue], [endPosition[kYKey] floatValue],
                              [endPosition[kWidthKey] floatValue], [endPosition[kHeightKey] floatValue]);
}

- (void)onExit {
    [super onExit];
    
    for (STGameObject *go in self.gameObjects) {
        if ([go respondsToSelector:@selector(delegate)]) {
            [go setValue:nil forKey:@"delegate"];
        }
    }
}

- (void)unloadSpriteCache {
    for (id spriteCacheName in [self.levelInfo objectForKey:kLevelSpriteCacheKey]) {
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:spriteCacheName];
    }
}



#pragma mark -
#pragma mark Methods

- (void)startPlayingBackgroundMusic {
    NSLog(@"%d", self.worldID);
    NSDictionary *level = [[STWorldInfoReader sharedInstance] levelWithWorldID:self.worldID levelID:self.levelID];
    //NSLog(@"%@", [level valueForKey:kLevelBackgroundMusicKey]);
    [[STSoundManager sharedInstance] playBackgroundMusic:[level valueForKey:kLevelBackgroundMusicKey] loop:YES];
}

- (void)stopPlayingBackgroundMusic {
    [[STSoundManager sharedInstance] stopBackgroundMusic];
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
    [self checkIfLevelEnded];
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

- (void)checkIfLevelEnded {
    if (CGRectIntersectsRect(self.player.boundingBox, self.endRect)) {
        [self levelEndedWithSuccess:YES];
    }
}

- (void)updateGravity:(ccTime)delta {
    for (STGameObject *go in self.gameObjects) {
        if (go.bodyType == STGameObjectBodyTypeDynamic) {
            go.velocity = ccpAdd(go.velocity, kDefaultGravity);
        }
        [go move:ccp(go.velocity.x * delta, go.velocity.y * delta)];
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
                CGRect r1 = child.boundingBox;
                CGRect r2 = child2.boundingBox;
                CGPoint v1 = child.velocity;
                CGPoint v2 = child2.velocity;
                r1.origin = ccpSub(r1.origin, ccp(child.velocity.x * delta, child.velocity.y * delta));
                r2.origin = ccpSub(r2.origin, ccp(child2.velocity.x * delta, child2.velocity.y * delta));
                
                // Position objects
                STRectEdge edge1 = [self updateCollisionOfGameObject:child withGameObject:child2 delta:delta];
                STRectEdge edge2 = [self updateCollisionOfGameObject:child2 withGameObject:child delta:delta];
                
                // Send notifications
                if (
                    ((edge1 == STRectEdgeMaxX ||  edge1 == STRectEdgeMinX) && STYIntersect(r1, r2))
                    ||
                    ((edge1 == STRectEdgeMaxY ||  edge1 == STRectEdgeMinY) && STXIntersect(r1, r2))
                    ) {
                    
                    if (
                        (edge1 == STRectEdgeMaxX && (v1.x > 0 || v2.x < 0)) ||
                        (edge1 == STRectEdgeMinX && (v1.x < 0 || v2.x > 0)) ||
                        (edge1 == STRectEdgeMaxY && (v1.y > 0 || v2.y < 0)) ||
                        (edge1 == STRectEdgeMinY && (v1.y < 0 || v2.y > 0))
                        ) {

                            [child collisionWithGameObject:child2 edge:edge1];
                            [child2 collisionWithGameObject:child edge:edge2];
                    }
                }
            }
        }
    }
}

- (STRectEdge)updateCollisionOfGameObject:(STGameObject *)gameObject
                           withGameObject:(STGameObject *)gameObject2
                                    delta:(ccTime)delta {
    
    STRectEdge rectEdge;
    CGRect r1 = gameObject.boundingBox;
    CGRect r2 = gameObject2.boundingBox;
    
    float edgeLeft = (r1.origin.x - r2.origin.x - r2.size.width) * -1;
    float edgeRight = (r1.origin.x + r1.size.width - r2.origin.x);
    float edgeTop = (r1.origin.y + r1.size.height - r2.origin.y);
    float edgeBottom = (r1.origin.y - r2.size.height - r2.origin.y) * -1;

    /*
    float offset = 0.0;
    BOOL wasHit = NO;
    
    // left
    if(gameObject.velocity.x <= gameObject2.velocity.x && (edgeLeft <= offset || !wasHit)) {
        wasHit = YES;
        offset = edgeLeft;
        rectEdge = STRectEdgeMinX;
    }
    // right
    if (gameObject.velocity.x >= gameObject2.velocity.x && (edgeRight <= offset || !wasHit)) {
        wasHit = YES;
        offset = edgeRight;
        rectEdge = STRectEdgeMaxX;
    }
    // top
    if (gameObject.velocity.y >= gameObject2.velocity.y && (edgeTop <= offset || !wasHit)) {
        wasHit = YES;
        offset = edgeTop;
        rectEdge = STRectEdgeMaxY;
    }
    // bottom
    if (gameObject.velocity.y <= gameObject2.velocity.y && (edgeBottom <= offset || !wasHit)) {
        wasHit = YES;
        offset = edgeBottom;
        rectEdge = STRectEdgeMinY;
    }*/
    
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
    [self.player spitFireball];
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
    CGFloat playerX = player.position.x;
    CGFloat mapX = self.map.position.x * -1 / self.map.scale;
    CGFloat mapWidth = self.map.boundingBox.size.width / self.map.scale;
    
    if (playerX - (player.boundingBox.size.width / 2) < mapX) {
        player.position = ccp(mapX + (player.boundingBox.size.width / 2), point.y);
        return NO;
    } else if (playerX + (player.boundingBox.size.width / 2) > mapWidth) {
        player.position = ccp(mapWidth - (player.boundingBox.size.width / 2), point.y);
        return NO;
    }
    
    return YES;
}

- (void)playerDied:(STPlayer *)player {
    [self levelEndedWithSuccess:NO];
}

- (void)playerStopsPlayingInvincibleSong:(STPlayer *)player {
    [self startPlayingBackgroundMusic];
}

- (void)replaceUILayer:(STLayer *)layer {
    [self removeChild:[self uiLayer]];
    [self setUiLayer:layer];
    [self addChild:[self uiLayer]];
}





#pragma mark -
#pragma mark InformationLayer Delegate

- (IBAction)timeElapsed:(id)sender {
    [self levelEndedWithSuccess:NO];
}





#pragma mark -
#pragma mark Game Over & Level Ended
- (void)levelEndedWithSuccess:(BOOL)success {
    [self unscheduleAllSelectors];
    
    if (success) {
        [[STSoundManager sharedInstance] playEffect:kSoundStageClear];
    } else {
        [[STSoundManager sharedInstance] playEffect:kSoundDeath];
    }
    
    [[STSoundManager sharedInstance] stopBackgroundMusic];
    
    NSDictionary *level = [[STWorldInfoReader sharedInstance] levelWithWorldID:_worldID levelID:_levelID];
    int time = [[level valueForKey:kLevelTimeKey] integerValue];
    
    STLayer *layer = [STLevelResultLayer layerWithWorldID:_worldID levelID:_levelID
                                                     time:time - [self.infoLayer time]
                                                    score:[[self player] score]
                                                  success:success];
    [[CCDirector sharedDirector] replaceScene: [layer scene]
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}





#pragma mark -
#pragma mark STItemBlockDelegate

- (void)addGameObjectToMap:(STGameObject *)gameObject toPosition:(CGPoint)position {
    [gameObject setPosition:position];
    [self.gameObjectsToAdd addObject:gameObject];
}





#pragma mark -
#pragma mark STLakituDelegate

- (CGPoint)positionOfPlayer {
    return self.player.position;
}

@end
