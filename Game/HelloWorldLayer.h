//
//  HelloWorldLayer.h
//  Game
//
//  Created by Ilija Tovilo on 1/26/13.
//  Copyright Ilija Tovilo 2013. All rights reserved.
//

// When you import this file, you import all the cocos2d classes
#import "SKLayer.h"

// HelloWorldLayer
@interface HelloWorldLayer : SKLayer
{
}

@property (unsafe_unretained) CCTMXTiledMap *tiledMap;
@property (unsafe_unretained) CCTMXLayer *backgroundLayer;

@end
