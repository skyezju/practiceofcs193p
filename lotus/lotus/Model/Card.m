//
//  Card.m
//  lotus
//
//  Created by Ying, Yuqian on 4/23/14.
//  Copyright (c) 2014 ___MSTR___. All rights reserved.
//

#import "Card.h"

@interface Card() 

@end

@implementation Card

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    for (Card * card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;    }
    
    }
    
    return score;
}

@end
