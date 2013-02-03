//
//  SKScene.h
//  Game
//
//  Created by Ilija Tovilo on 2/3/13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class SKScene;
@protocol SKSceneChildLayer <NSObject>
@optional
- (void)sceneWasAdded:(SKScene *)scene;
- (void)sceneWasRemoved:(SKScene *)scene;
@end

@interface SKScene : CCScene {
    
}

@end
