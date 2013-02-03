//
//  SKScene.h
//  Game
//
//  Created by Ilija Tovilo on 2/3/13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class STScene;
@protocol STSceneChildLayer <NSObject>

@optional
- (void)sceneWasAdded:(STScene *)scene;
- (void)sceneWasRemoved:(STScene *)scene;

@end

@interface STScene : CCScene {
    
}

@end
