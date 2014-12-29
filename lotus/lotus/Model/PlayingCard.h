//
//  PlayingCard.h
//  lotus
//
//  Created by Ying, Yuqian on 4/24/14.
//  Copyright (c) 2014 ___MSTR___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic)NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
