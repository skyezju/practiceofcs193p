//
//  DropitBehavior.h
//  Dropit
//
//  Created by Ying, Yuqian on 11/25/14.
//  Copyright (c) 2014 Ying, Yuqian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropitBehavior : UIDynamicBehavior

-(void)addItem:(id<UIDynamicItem>)item;
-(void)removeItem:(id<UIDynamicItem>)item;

@end
