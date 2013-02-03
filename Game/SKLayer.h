//
//  SKLayer.h
//  Game
//
//  Created by Ilija Tovilo on 2/3/13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SKScene.h"

@interface SKLayer : CCLayer <SKSceneChildLayer> {
    
}

+ (SKScene *)scene;

- (void)setUp;
- (void)tearDown;

@end
