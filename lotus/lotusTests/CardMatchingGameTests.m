//
//  CardMatchingGameTests.m
//  lotus
//
//  Created by Ying, Yuqian on 11/21/14.
//  Copyright (c) 2014 ___MSTR___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CardMatchingGame.h"
#import "Deck.h"
#import "OCMock.h"
#import <objc/runtime.h>

@interface Deck (CardMatchingGameTests)
- (Card *)hackDrawRandomCard;
@end

@implementation Deck (CardMatchingGameTests)
- (Card *)hackDrawRandomCard{
    return nil;
}

@end

@interface CardMatchingGameTests : XCTestCase

@end

@implementation CardMatchingGameTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
/*
- (void)testinitWithCardCountNilCard {
    //creat mock object to stub
    id mockDeck = OCMClassMock([Deck class]);
    //set stub, if [mockDeck drawRandomCard] is called
    //the return will be nil
    OCMStub([mockDeck drawRandomCard]).andReturn(nil);
    //Run the code need test
    CardMatchingGame * testGame = [[CardMatchingGame alloc] initWithCardCount:2 usingDeck:mockDeck];
    //verify the result
    XCTAssertNil(testGame, @"The deck draw a nil card, the game should be nil");
}
*/

- (void)testinitWithCardCountNilCard_protocol {
    //creat mock object to stub
    id mockDeck = OCMProtocolMock(@protocol(Card));
    //set stub, if [mockDeck drawRandomCard] is called
    //the return will be nil
    OCMStub([mockDeck drawRandomCard]).andReturn(nil);
    //Run the code need test
    CardMatchingGame * testGame = [[CardMatchingGame alloc] initWithCardCount:2 usingDeck:mockDeck];
    //verify the result
    XCTAssertNil(testGame, @"The deck draw a nil card, the game should be nil");
}


- (void)testinitWithCardCountNilCardSwizzle {
    Method orig_method, target_method;
    orig_method = class_getInstanceMethod([Deck class], @selector(drawRandomCard));
    target_method = class_getInstanceMethod([Deck class], @selector(hackDrawRandomCard));
    method_exchangeImplementations(orig_method, target_method);
    Deck *testDeck = [[Deck alloc] init];
    CardMatchingGame * testGame = [[CardMatchingGame alloc] initWithCardCount:2 usingDeck:testDeck];
    XCTAssertNil(testGame, @"The deck draw a nil card, the game should be nil");
    method_exchangeImplementations(orig_method, target_method);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
