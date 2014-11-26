//
//  CardImage.h
//  lotus
//
//  Created by Ying, Yuqian on 11/25/14.
//  Copyright (c) 2014 ___MSTR___. All rights reserved.
//

#import "Card.h"
#import <Foundation/Foundation.h>

@protocol CardImage <nsobject>
- (NSString *)titleForCard:(Card *)card;
- (NSString *)backgroundImageForCard:(Card *)card;

@end