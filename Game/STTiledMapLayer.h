//
//  STTiledMapScene.h
//  Game
//
//  Created by Ilija Tovilo on 2/3/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STLayer.h"

@interface STTiledMapLayer : STLayer

- (id)initWithTiledMap:(NSString *)tiledMap;
+ (id)layerWithTiledMap:(NSString *)tiledMap;

@property (retain) CCTMXTiledMap *map;
@property (retain) CCTMXObjectGroup *objectGroup;
@property (retain) CCTMXLayer *objectLayer;

@end
