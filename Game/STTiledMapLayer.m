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
#import "STItem.h"

#import "STCoin.h"

@interface STTiledMapLayer ()
@property (strong) NSNumberFormatter *numberFormatter;
@end

@implementation STTiledMapLayer
{}

@synthesize gameObjects = _gameObjects;

#pragma mark -
#pragma mark Initialise
- (id)initWithTiledMap:(NSString *)tiledMap
{
    self = [super init];
    if (self) {
        // Init map and layers
        self.map = [CCTMXTiledMap tiledMapWithTMXFile:tiledMap];
        self.objectGroup = [self.map objectGroupNamed:kEventsLayerKey];
        self.objectLayer = [self.map layerNamed:kObjectLayerKey];
        [self.objectLayer setVisible:NO];
        
        // init number formatter
        self.numberFormatter = [[NSNumberFormatter alloc] init];
        [self.numberFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier: @"en_US"]];

        // Scale map to optimal size
        [self.map setScale:([CCDirector sharedDirector].winSize.height / self.map.contentSize.height)];
        [self addChild:self.map];
        
        [self readGameObjectsFromMap];
    }
    return self;
}

- (void)readGameObjectsFromMap {
    for (int x = 1; x < self.objectLayer.layerSize.width; x++) {
        for (int y = 1; y < self.objectLayer.layerSize.height; y++) {
            [self createGameObjectAtX:x y:y];
        }
    }
}

- (void)createGameObjectAtX:(unsigned int)x y:(unsigned int)y {
    CCSprite *tile = [self.objectLayer tileAt:ccp(x, y)];
    
    NSDictionary *props = [self.map propertiesForGID:[self.objectLayer tileGIDAt:ccp(x, y)]];
    NSString *type = props[kTypeKey];
    if (type.length) {
        Class objectClass = NSClassFromString(type);
        CCNode *node = [objectClass node];
        [self setProperties:props forNode:node];
        [node setPosition:ccp(tile.position.x + (self.map.tileSize.width / 2), tile.position.y + (self.map.tileSize.height / 2))];
        
        [self addGameObjectToMap:(STGameObject *)node];
        [self.objectLayer removeTileAt:ccp(x, y)];
    }
}

- (void)setProperties:(NSDictionary *)properties forNode:(CCNode *)node {
    // Loop though the keys and add them to the object
    for(id key in properties) {
        if ([node respondsToSelector:NSSelectorFromString(key)]) {
            id value;
            NSString *stringValue = [properties objectForKey:key];
            
            NSNumber *numberValue = [self.numberFormatter numberFromString:stringValue];
            if (numberValue) {
                value = numberValue;
            } else {
                value = stringValue;
            }
            
            // Set the value at the specified key
            [node setValue:value forKey:key];
        }
        
        if ([node respondsToSelector:@selector(delegate)]) {
            [node setValue:self forKey:@"delegate"];
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
