//
//  STTiledMapScene.m
//  Game
//
//  Created by Ilija Tovilo on 2/3/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STTiledMapLayer.h"
#import "STGameObject.h"
#import "STTiledMapKeys.h"

@implementation STTiledMapLayer
{}

@synthesize gameObjects = _gameObjects;

#pragma mark -
#pragma mark Initialise
- (id)initWithTiledMap:(NSString *)tiledMap
{
    self = [super init];
    if (self) {
        self.map = [CCTMXTiledMap tiledMapWithTMXFile:tiledMap];
        self.objectGroup = [self.map objectGroupNamed:kEventsLayerKey];
        self.objectLayer = [self.map layerNamed:kObjectLayerKey];

        for (int x = 1; x < self.objectLayer.layerSize.width; x++) {
            for (int y = 1; y < self.objectLayer.layerSize.height; y++) {
                CCSprite *tile = [self.objectLayer tileAt:ccp(x, y)];
                NSDictionary *props = [self.map propertiesForGID:[self.objectLayer tileGIDAt:ccp(x, y)]];
                NSString *type = props[kTypeKey];
                if (type.length) {
                    Class objectClass = NSClassFromString(type);
                    CCNode *node = [objectClass node];
                    [self setProperties:props forNode:node];
                    [node setPosition:ccp(tile.position.x + (self.map.tileSize.width / 2), tile.position.y + (self.map.tileSize.height / 2))];
                    
                    [self addGameObjectToMap:(STGameObject *)node];
                }
            }
        }

        [self.objectLayer setVisible:NO];
        [self.map setScale:([CCDirector sharedDirector].winSize.height / self.map.contentSize.height)];
        
        [self addChild:self.map];
    }
    return self;
}

- (void)setProperties:(NSDictionary *)properties forNode:(CCNode *)node {
    
    // If the node supports key value coding
    if([node respondsToSelector:@selector(setObject:forKey:)]) {
        for(id key in properties) {
            
            // Exclude special keys
            if(![key isEqualToString:kTypeKey]) {
                
                // Set the value at the specified key
                [node performSelector:@selector(setObject:forKey:)
                           withObject:[properties objectForKey:key]
                           withObject:key];
            }
        }
    }
}

- (void)addGameObjectToMap:(STGameObject *)gameObject {
    [self.map addChild:gameObject];
    [self.gameObjects addObject:gameObject];
}

- (NSMutableArray *)gameObjects {
    if (!_gameObjects) _gameObjects = [NSMutableArray array];
    
    return _gameObjects;
}

+ (id)layerWithTiledMap:(NSString *)tiledMap {
    return [[self alloc] initWithTiledMap:tiledMap];
}

@end
