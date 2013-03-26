//
//  STChooseWorldLayer.h
//  Game
//
//  Created by Lukas Seglias on 26.03.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "STScene.h"
#import "STLayer.h"
#import "SlidingMenuGrid.h"

#define kWorldsFile @"worlds.plist"
#define kWorldsKey @"worlds"
#define kWorldIDKey @"ID"
#define kWorldNameKey @"Name"
#define kWorldIconKey @"Icon"
#define kWorldIsLockedKey @"isLocked"
#define kWorldSelectionRowNumber 1
#define kWorldSelectionColumnNumber 3

@interface STChooseWorldLayer : STLayer {
    
}

@end
