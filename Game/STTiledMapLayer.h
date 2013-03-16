//
//  STTiledMapScene.h
//  Game
//
//  Created by Ilija Tovilo on 2/3/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STLayer.h"

#define kEventsLayerKey @"events"
#define kObjectLayerKey @"objects"
#define kTypeKey @"type"
#define kPlayerSpawnPointKey @"playerSpawnPoint"

@interface STTiledMapLayer : STLayer
{}

#pragma mark -
#pragma mark Initialise
- (id)initWithTiledMap:(NSString *)tiledMap;
+ (id)layerWithTiledMap:(NSString *)tiledMap;

#pragma mark -
#pragma mark Properties
@property (retain) CCTMXTiledMap *map;
@property (retain) CCTMXObjectGroup *objectGroup;
@property (retain) CCTMXLayer *objectLayer;

@end
