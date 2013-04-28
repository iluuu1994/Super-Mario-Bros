//
//  STChooseWorldLayer.m
//  Game
//
//  Created by Lukas Seglias on 26.03.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "STChooseWorldLayer.h"
#import "NSBundle+Resources.h"
#import "WorldsConstrants.h"

@implementation STChooseWorldLayer
{}

#pragma mark -
#pragma mark Initialise
- (void)setUp {
    [super setUp];
    
    NSMutableArray *worlds = [[NSMutableArray alloc] init];
    NSArray *root = [NSDictionary dictionaryWithContentsOfFile:[NSBundle pathForResource:kWorldsFile]];
    NSLog(@"%@", root);
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    //NSDictionary *world in [root valueForKey:kWorldsKey]
    
    CCSprite* normalSprite = [CCSprite spriteWithFile:@"twitter.png"];
    CCSprite* selectedSprite = [CCSprite spriteWithFile:@"facebook.png"];
    
    normalSprite.scale = 0.3f;
    selectedSprite.scale = 0.65f;
    
    for(int i = 0; i < 2; i++) {
        CCSprite* normalSprite = [CCSprite spriteWithFile:@"twitter.png"];
        CCSprite* selectedSprite = [CCSprite spriteWithFile:@"facebook.png"];

        normalSprite.scale = 0.3f;
        selectedSprite.scale = 0.65f;

        CCMenuItemSprite* item = [CCMenuItemSprite itemWithNormalSprite:
                                  normalSprite selectedSprite:selectedSprite];
        
        id __block _item = item;
        [item setBlock:^(id sender) {
            [self launchLevel:_item];
        }];
        
        [worlds addObject:item];
    }
    
    NSMutableArray *pages = [[NSMutableArray alloc] init];
    
    int counter = 0;
    
    for(NSDictionary *world in [root valueForKey:kWorldsKey]) {
        CCLayer *page = [[CCLayer alloc] init];
        
        if(counter % kWorldsPerPage == 0) {
            // TODO: something
        }
        
        CCLabelTTF *tlabel = [CCLabelTTF labelWithString:[world valueForKey:kWorldNameKey] fontName:@"Helvetica" fontSize:20];
        CCMenuItemLabel *title = [CCMenuItemLabel itemWithLabel:tlabel target:self selector:@selector(world:)];
        CCMenu *menu = [CCMenu menuWithItems: title, nil];
        menu.position = ccp(winSize.width / 2, winSize.height / 2);
        
        [page addChild:menu];
        [pages addObject:page];
        counter++;
    }
    
    CCScrollLayer *scroller = [[CCScrollLayer alloc] initWithLayers:pages widthOffset:winSize.width / 1.5];
    [self addChild:scroller];
}

#pragma mark -
#pragma mark Methods

-(void)launchLevel:(CCMenuItemSprite *) level {
    NSLog(@"launching level %@", level);
}

#pragma mark -
#pragma mark Select World
- (IBAction)world:(id)sender {
    NSLog(@"selected world");
}

@end
