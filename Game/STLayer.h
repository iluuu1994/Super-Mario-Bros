//
//  SKLayer.h
//  Game
//
//  Created by Ilija Tovilo on 2/3/13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "STScene.h"

@interface STLayer : CCLayer <STSceneChildLayer> {
    
}

// Scene
+ (STScene *)scene;
+ (Class)sceneClass;
+ (void)setSceneClass:(Class)sceneClass;

// Init and Destroy
- (void)setUp;
- (void)tearDown;

@end
