//
//  ViewControllerTests.m
//  ViewControllerTrain
//
//  Test cases for ViewController
//
//  Created by Ying, Yuqian on 11/25/14.
//  Copyright (c) 2014 Ying, Yuqian. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "ViewController.h"

@interface ViewControllerTests : SenTestCase

@property (nonatomic, strong) ViewController *myViewController;

@end

@implementation ViewControllerTests

- (void)setUp {
    
    [self setMyViewController:[[ViewController alloc]init]];
    
}

- (void)tearDown {
    
    [self setMyViewController:nil];
    
}

- (void)testInitNotNil {
    
    STAssertNotNil(self.myViewController, @"Test ViewController object not instantiated");
}


@end
