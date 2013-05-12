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

@implementation STItemBlock
@synthesize items = _items;

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

- (void)setAppearanceType:(STAppearanceType)appearanceType {
    [super setAppearanceType:appearanceType];
    [self reloadDisplay];
}

- (void)reloadDisplay {
    if (!self.items.count) {
        [self stopAllActions];
        [self displayFrameWithName:@"bonus-block-empty"];
    } else {
        [self runAnimationWithName:@"blink" endless:YES];
    }
}

- (NSMutableArray *)items {
    if (!_items) {
        _items = [NSMutableArray array];
        
        [_items addObject:[[STMushroom alloc] init]];
        /*
        int r = arc4random() % 2;
        switch (r) {
            case 0:
            {
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
        }*/
    }
    
    return _items;
}

- (void)awardPlayer:(STPlayer *)player {
    [super awardPlayer:player];
    
    if (self.items.count) {
        id item = self.items.lastObject;
        [self.items removeObject:item];
        [self reloadDisplay];
        
        [self.delegate addItemToMap:item
                         toPosition:ccpAdd(self.position, ccp(0, (self.boundingBox.size.height)+([item boundingBox].size.height / 2)))];
    }
}

@end
