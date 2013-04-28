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
#import "CCScrollLayer.h"

#define kWorldsPerPage 3
#define kWorldIdKey @"ID"
#define kWorldNameKey @"Name"
#define kWorldIconKey @"Icon Name"
#define kWorldIsLockedKey @"Is Locked"

@interface STChooseWorldLayer : STLayer {
    
}

@end
