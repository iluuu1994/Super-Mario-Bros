//
//  SKLayer.m
//  Game
//
//  Created by Ilija Tovilo on 2/3/13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "STLayer.h"


@implementation STLayer

#pragma mark -
#pragma mark Scene
static Class _sceneClass;

+ (STScene *)scene {
    STScene *scene = [[self sceneClass] node];
    
    STLayer *layer = [self node];
    [scene addChild: layer];
    
    return scene;
}
- (STScene *)scene {
    STScene *scene = [[self sceneClass] node];
    [scene addChild:self];
    
    return scene;
}
+ (Class)sceneClass {
    if (!_sceneClass) {
        return [STScene class];
    }
    
    return _sceneClass;
}

#pragma mark -
#pragma mark Initialise
- (id)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    
}

#pragma mark -
#pragma mark Dealloc
- (void)dealloc {
    [self tearDown];
}
- (void)tearDown {
    
}

@end
