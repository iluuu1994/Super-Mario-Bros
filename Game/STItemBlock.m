//
//  STItemBlock.m
//  Game
//
//  Created by Ilija Tovilo on 5/11/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STItemBlock.h"
#import "STStar.h"
#import "STCoin.h"
#import "STMushroom.h"
#import "STFlower.h"


#pragma mark -
#pragma mark STItemBlock Implementation

@implementation STItemBlock
@synthesize items = _items;



#pragma mark -
#pragma mark Initialization

- (id)init
{
    self = [super initWithPlistFile:@"Block.plist"];
    if (self) {
        self.isDestroyable = NO;
        
        // fills the items array
        [self items];
        [self reloadDisplay];
    }
    return self;
}


#pragma mark -
#pragma mark Properties

- (void)setAppearanceType:(STAppearanceType)appearanceType {
    [super setAppearanceType:appearanceType];
    [self reloadDisplay];
}

- (NSMutableArray *)items {
    if (!_items) {
        _items = [NSMutableArray array];
        
        int from = 0;
        int to = 3;
        int type = (int)from + arc4random() % (to-from+1);
        switch (type) {
            case 0:
            {
                [_items addObject:[[STCoin alloc] init]];
                [_items addObject:[[STCoin alloc] init]];
                [_items addObject:[[STCoin alloc] init]];
                [_items addObject:[[STCoin alloc] init]];
                [_items addObject:[[STCoin alloc] init]];
            }
                break;
            case 1:
            {
                [_items addObject:[[STStar alloc] init]];
            }
                break;
            case 2:
            {
                [_items addObject:[[STMushroom alloc] init]];
            }
                break;
            case 3:
            {
                [_items addObject:[[STFlower alloc] init]];
            }
                break;
        }
    }
    
    return _items;
}





#pragma mark -
#pragma mark Methods

- (void)reloadDisplay {
    if (!self.items.count) {
        [self stopAllActions];
        [self displayFrameWithName:@"bonus-block-empty"];
    } else {
        [self runAnimationWithName:@"blink" endless:YES];
    }
}

- (void)awardPlayer:(STPlayer *)player {
    [super awardPlayer:player];
    
    if (self.items.count) {
        id item = self.items.lastObject;
        [self.items removeObject:item];
        [self reloadDisplay];
        
        [self.delegate addGameObjectToMap:item toPosition:ccpAdd(self.position, ccp(0, (self.boundingBox.size.height)+([item boundingBox].size.height / 2)))];
    }
}

@end
