//
//  Deck.m
//  lotus
//
//  Created by Ying, Yuqian on 4/23/14.
//  Copyright (c) 2014 ___MSTR___. All rights reserved.
//

#import "Deck.h"


@interface Deck ()


@end

@implementation Deck

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    }else {
        [self.cards addObject:card];
    }
}


- (void)addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}

- (void)addCardAsyn:(Card *)card
{
    [self performSelector:@selector(addCard:) withObject:card afterDelay:3];
}

- (Card *)drawRandomCard
{
    Card *randomCard = nil;
    
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndex:index];
        [self.cards removeObjectsAtIndexes:indexes];
    }
    
    
    return randomCard;
};

@end
