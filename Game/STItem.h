//
//  STItem.h
//  Game
//
//  Created by Ilija Tovilo on 5/7/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STGameObject.h"

@class STPlayer;
@interface STItem : STGameObject

- (void)awardPlayer:(STPlayer *)player;

@end
