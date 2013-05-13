//
//  STLakitu.h
//  Game
//
//  Created by Ilija Tovilo on 5/9/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STNPC.h"

@protocol STLakituDelegate <STGameObjectDelegate>
- (CGPoint)positionOfPlayer;
@end

@interface STLakitu : STNPC

@property (unsafe_unretained) id<STLakituDelegate> delegate;

@end
