//
//  Deck.h
//  lotus
//
//  Created by Ying, Yuqian on 4/23/14.
//  Copyright (c) 2014 ___MSTR___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
@property (strong, nonatomic) NSMutableArray *cards;

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
