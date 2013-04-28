//
//  STGameObject.h
//  Game
//
//  Created by Ilija Tovilo on 4/23/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STAnimatedSprite.h"

@interface STGameObject : STAnimatedSprite <CCTouchAllAtOnceDelegate>

@property (setter = setCollidable:) BOOL isCollidable;
@property (readonly) BOOL needsTouchNotifications;

@end
