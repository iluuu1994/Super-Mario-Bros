//
//  STItemBlock.h
//  Game
//
//  Created by Ilija Tovilo on 5/11/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STBlock.h"

@class STItem;
@protocol STItemBlockDelegate <NSObject>
- (void)addItemToMap:(STItem *)item toPosition:(CGPoint)position;
@end

@interface STItemBlock : STBlock

@property (readonly, nonatomic) NSMutableArray *items;
@property (unsafe_unretained) id<STItemBlockDelegate> delegate;

@end
