//
//  PlayingCardTests.m
//  lotus
//
//  Created by Ying, Yuqian on 11/18/14.
//  Copyright (c) 2014 ___MSTR___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PlayingCard.h"

@interface PlayingCardTests : XCTestCase

@end

@implementation PlayingCardTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testmaxRank {
    XCTAssertEqual([PlayingCard maxRank], 13, @"The max rank of card should be 13");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
