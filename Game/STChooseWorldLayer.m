//
//  STChooseWorldLayer.m
//  Game
//
//  Created by Lukas Seglias on 26.03.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "STChooseWorldLayer.h"


@implementation STChooseWorldLayer
{}

#pragma mark -
#pragma mark Initialise
- (void)setUp {
    [super setUp];
    
    NSMutableArray *worlds = [[NSMutableArray alloc] init];
    
    NSArray *root = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:kWorldsFile ofType:@""]];
    
    CGSize windowSize = [[CCDirector sharedDirector] winSize];
    CGPoint middle = ccp(windowSize.width/2, windowSize.height/2);
    
    //NSDictionary *world in [root valueForKey:kWorldsKey]
    
    CCSprite* normalSprite = [CCSprite spriteWithFile:@"twitter.png"];
    CCSprite* selectedSprite = [CCSprite spriteWithFile:@"facebook.png"];
    
    normalSprite.scale = 0.3f;
    selectedSprite.scale = 0.65f;
    
    for(int i = 0; i < 20; i++) {
        CCSprite* normalSprite = [CCSprite spriteWithFile:@"twitter.png"];
        CCSprite* selectedSprite = [CCSprite spriteWithFile:@"facebook.png"];

        normalSprite.scale = 0.3f;
        selectedSprite.scale = 0.65f;

        CCMenuItemSprite* item = [CCMenuItemSprite itemWithNormalSprite:
                                  normalSprite selectedSprite:selectedSprite];
        
        [worlds addObject:item];
    }
    
    NSLog(@"%f", windowSize.width);
    NSLog(@"%f", windowSize.height);

    
    SlidingMenuGrid *worldGrid = [SlidingMenuGrid
                                 menuWithArray:worlds
                                 cols:kWorldSelectionColumnNumber
                                 rows:kWorldSelectionRowNumber
                                 position:CGPointMake(250.f, 250.f)
                                 padding:CGPointMake(normalSprite.boundingBox.size.width + 20, normalSprite.boundingBox.size.height + 20)
                                 verticalPaging:false];
        
    [self addChild:worldGrid];
}

-(void)launchLevel:(CCMenuItemSprite *) level {
    NSLog(@"launching level %@", level);
}

@end
