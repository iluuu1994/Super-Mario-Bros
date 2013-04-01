//
//  STLevelResultLayer.h
//  Game
//
//  Created by Lukas Seglias on 01.04.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "STLayer.h"

@interface STLevelResultLayer : STLayer {
    
}

#pragma mark -
#pragma mark Initialise

/**
 * Init a game result layer with given level identified by the world and level id. 
 * You specify the time needed for the user to complete the level or die.
 * Furthermore the users score is displayed.
 * A boolean indicates whether the user won or failed.
 * @param worldId - the id of the world containing the played level
 * @param levelID - the id of the played level inside the specified world
 * @param time - the time needed for the user to complete the level or die
 * @param score - the users score made inside this level
 * @param success - true if the user successfully finished this level, false if not
 * @return id - The initialised object
 */
-(id)initWithWorldId:(unsigned int)worldId
             levelId:(unsigned int)levelId
                time:(NSDate *)time
               score:(int)score
             success:(BOOL)success;

/**
 * Returns a game result layer with given level identified by the world and level id.
 * You specify the time needed for the user to complete the level or die.
 * Furthermore the users score is displayed.
 * A boolean indicates whether the user won or failed.
 * @param worldId - the id of the world containing the played level
 * @param levelID - the id of the played level inside the specified world
 * @param time - the time needed for the user to complete the level or die
 * @param score - the users score made inside this level
 * @param success - true if the user successfully finished this level, false if not
 * @return id - The initialised object
 */
+(id)layerWithWorldId:(unsigned int)worldId
             levelId:(unsigned int)levelId
                time:(NSDate *)time
               score:(int)score
             success:(BOOL)success;

/**
 * Is called when the layer is initialised
 */
- (void)setUpWithWorldId:(unsigned int)worldId
                 levelId:(unsigned int)levelId
                    time:(NSDate *)time
                   score:(int)score
                 success:(BOOL)success;

@end
