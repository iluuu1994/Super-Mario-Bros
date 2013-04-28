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
#import "STStartLayer.h"
#import "STChooseLevelLayer.h"
#import "CCScrollLayer.h"

#define kWorldIdKey @"ID"
#define kWorldNameKey @"Name"
#define kWorldIconKey @"Icon Name"
#define kWorldIsLockedKey @"Is Locked"
#define kLockIcon @"lock.png"

#define kScreenPadding 10

@interface STChooseWorldLayer : STLayer {
    
}

@end
