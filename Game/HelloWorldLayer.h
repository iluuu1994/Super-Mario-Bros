//
//  HelloWorldLayer.h
//  Game
//
//  Created by Ilija Tovilo on 1/26/13.
//  Copyright Ilija Tovilo 2013. All rights reserved.
//

// When you import this file, you import all the cocos2d classes
#import "STLayer.h"

// HelloWorldLayer
@interface HelloWorldLayer : STLayer
{}

#pragma mark -
#pragma mark Properties
@property (strong) CCTMXTiledMap *tiledMap;
@property (strong) CCTMXLayer *backgroundLayer;

@end
