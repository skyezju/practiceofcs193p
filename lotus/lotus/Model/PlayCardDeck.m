//
//  PlayCardDeck.m
//  lotus
//
//  Created by Ying, Yuqian on 4/25/14.
//  Copyright (c) 2014 ___MSTR___. All rights reserved.
//

#import "PlayCardDeck.h"
#import "PlayingCard.h"
#import "Deck.h"

@implementation PlayCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        for (NSString *suit in[PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
            }
        }
        
    }
    
    return self;
}



@end
