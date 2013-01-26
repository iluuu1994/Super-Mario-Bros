//
//  HelloWorldLayer.h
//  Game
//
//  Created by Ilija Tovilo on 1/26/13.
//  Copyright Ilija Tovilo 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@property (assign) CCTMXTiledMap *tiledMap;
@property (assign) CCTMXLayer *backgroundLayer;

@end
