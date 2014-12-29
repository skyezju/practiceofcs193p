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
#import "OCMock.h"

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

- (void)testMaxRank {
    XCTAssertEqual([PlayingCard maxRank], 13, @"The max rank of card should be 13");
}


@end
