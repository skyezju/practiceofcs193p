//
//  ViewController.h
//  lotus
//
//  Created by Ying, Yuqian on 4/23/14.
//  Copyright (c) 2014 ___MSTR___. All rights reserved.
//
// Absctract class

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface ViewController : UIViewController
//protected
//for subclasses
- (Deck *)createDeck;

@end
