//
//  STControlsLayer.h
//  Game
//
//  Created by Lukas Seglias on 30.04.13.
//  Copyright (c) 2013 by Lukas Seglias & Ilija Tovilo. All rights reserved.
//

#import "STLayer.h"
#import "SneakyJoystick.h"

// Configuration of the Joystick
#define kJoystickBaseColor ccc4(128, 128, 128, 128)
#define kJoystickColor ccc4(64, 64, 64, 128)
#define kJoystickBaseRadius 64
#define kJoystickRadius 32
#define kJoystickRect CGRectMake(20, 20, 148, 148)

// Button Images
#define kAButtonImage @"a.png"
#define kBButtonImage @"b.png"
#define kPauseButtonImage @"pause.png"

/**
 * Delegate which will be informed if an input element on this layer was pressed.
 * Defines methods used by STControlsLayer to communicate with the delegate.
 */
@protocol STControlsDelegate <NSObject>

#pragma mark -
#pragma mark Buttons

/**
 * When the user pressed the A-button this message is sent to the delegate.
 * @param sender - the sender of this message. The STControlsLayer
 * @return an IBAction
 */
- (IBAction)a:(id)sender;

/**
 * When the user pressed the B-button this message is sent to the delegate.
 * @param sender - the sender of this message. The STControlsLayer
 * @return an IBAction
 */
- (IBAction)b:(id)sender;

/**
 * When the user wants moves the joystick on the screen this message is sent to the delegate.
 * @param sender - the sender of this message. The STControlsLayer
 * @return an IBAction
 */
- (IBAction)joystick:(id)sender delta:(ccTime)delta;

/**
 * When the user wants to pause the game this message is sent to the delegate.
 * @param sender - the sender of this message. The STControlsLayer.
 * @return an IBAction
 */
- (IBAction)pause:(id)sender;

@end

/**
 * A layer which is displayed on the game screen. Contains input elements for playing the game.
 * Sends messages to a given delegate when a button was pressed. 
 */
@interface STControlsLayer : STLayer
{}

#pragma mark -
#pragma mark Properties

/**
 * The delegate receiving messages wen a button on this layer was pressed. 
 */
@property (unsafe_unretained) id <STControlsDelegate> delegate;

/**
 * The joystick used to move a player. 
 */
@property (strong) SneakyJoystick *joystick;

#pragma mark -
#pragma mark Initialise

/**
 * Init a layer with the input elements needed to play the game.
 * @param delegate the delegate which receives messages when pressing a button on this layer
 * @return id - The initialised object
 */
- (id)initWithDelegate:(id <STControlsDelegate>)delegate;

/**
 * Returns a layer with the input elements needed to play the game.
 * @param delegate the delegate which receives messages when pressing a button on this layer
 * @return id - The initialised object
 */
+ (id)layerWithDelegate:(id <STControlsDelegate>)delegate;

/**
 * Is called when the layer is initialised.
 */
- (void)setUpWithDelegate:(id <STControlsDelegate>)delegate;

#pragma mark -
#pragma mark Update

/**
 * Updates the layer.
 * @param delta - the time elapsed since the last call of update
 */
- (void)update:(ccTime)delta;

@end

