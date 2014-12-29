//
//  CardMatchingGame.h
//  lotus
//
//  Created by Ying, Yuqian on 10/15/14.
//  Copyright (c) 2014 ___MSTR___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"
#import "PlayingCard.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (PlayingCard *)cardAtIndex:(NSUInteger)index;


@property (nonatomic, readonly)NSInteger score;

@end
