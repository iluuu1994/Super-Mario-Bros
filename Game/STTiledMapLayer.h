//
//  STTiledMapScene.h
//  Game
//
//  Created by Ilija Tovilo on 2/3/13.
//  Copyright (c) 2013 by Lukas Seglias & Ilija Tovilo. All rights reserved.
//

#import "STLayer.h"

@class STGameObject;

/**
 * This class is used for displaying tiled maps.
 * The map is scanned and creates the game objects.
 */
@interface STTiledMapLayer : STLayer
{}



#pragma mark -
#pragma mark Initialise

/**
 * Initializes a tiled map.
 * @param tiledMap - The name of the tiled map resource
 * @return the instance of the created tiled map
 */
- (id)initWithTiledMap:(NSString *)tiledMap;

/**
 * Initializes a tiled map.
 * @param tiledMap - The name of the tiled map resource
 * @return the instance of the created tiled map
 */
+ (id)layerWithTiledMap:(NSString *)tiledMap;




#pragma mark -
#pragma mark Properties

/**
 * The tiled map
 */
@property (retain) CCTMXTiledMap *map;

/**
 * The object gropu of the map
 * The object group contains the start-, and end-point of the map
 */
@property (retain) CCTMXObjectGroup *objectGroup;

/**
 * The object layer is the layer of the real game objects that are read and created
 */
@property (retain) CCTMXLayer *objectLayer;

/**
 * The game objects, that are read from the objectLayer
 */
@property (strong, readonly, nonatomic) NSMutableArray *gameObjects;




#pragma mark -
#pragma mark Methods

/**
 * Maps all key/value pairs of a dictionary on a node
 * @param properties - The dictionary that contains the key/value pairs that should be mapped
 * @param node - The node that should be filled
 */
- (void)setProperties:(NSDictionary *)properties forNode:(CCNode *)node;

/**
 * Adds a game object to the map
 * @param gameObject - The game object that should be added to the map
 */
- (void)addGameObjectToMap:(STGameObject *)gameObject;

/**
 * Reads the object layer and creates all the game objects
 */
- (void)readGameObjectsFromMap;

/**
 * Creates the game object at point x ay
 * @param x - The x coordinate
 * @param y - The y coordinate
 */
- (void)createGameObjectAtX:(unsigned int)x y:(unsigned int)y;

@end
