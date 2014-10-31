//
//  PlayingCardGameViewController.m
//  lotus
//
//  Created by Ying, Yuqian on 10/21/14.
//  Copyright (c) 2014 ___MSTR___. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController



- (Deck *)createDeck
{
    return [[PlayCardDeck alloc] init];
}



@end
