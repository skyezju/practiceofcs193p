//
//  DeckTests.m
//  lotus
//
//  Created by Ying, Yuqian on 11/18/14.
//  Copyright (c) 2014 ___MSTR___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Deck.h"
#import "Card.h"
#import "OCMock.h"
#import <objc/runtime.h>


@interface DeckTests : XCTestCase

@end

@implementation DeckTests

XCTestExpectation *expectation;

- (void)hackAddCard:(Card *)card{
    [expectation fulfill];
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAddCard {
    //init the Card and Deck
    Card * testCard = [[Card alloc] init];
    Deck * testDeck = [[Deck alloc] init];
    //init mock object deckMock to observe testDeck
    id deckMock = OCMPartialMock(testDeck);
    //Set the expected code
    [[deckMock expect] addCard:testCard atTop:NO];
    //Run the code
    [testDeck addCard:testCard];
    //verify whether the expected code exeucted or not
    [deckMock verify];
}

- (void)testAddCardAtTop {
    //init the Card and Deck
    Card * testCard = [[Card alloc] init];
    Deck * testDeck = [[Deck alloc] init];
    //init mock object deckMock to observe testDeck
    id cardsMock = OCMClassMock([NSMutableArray class]);
    //Set the expected code
    [[cardsMock expect] insertObject:testCard atIndex:0];
    testDeck.cards = cardsMock;
    //Run the code
    [testDeck addCard:testCard atTop:YES];
    //verify whether the expected code exeucted or not
    [cardsMock verify];
}

- (void)testAddCardAsyn{
    Method orig_method, target_method;
    orig_method = class_getInstanceMethod([Deck class], @selector(addCard:));
    target_method = class_getInstanceMethod([DeckTests class], @selector(hackAddCard:));
    method_exchangeImplementations(orig_method, target_method);
    expectation = [self expectationWithDescription:@"Add card in background thread"];
    Card * testCard = [[Card alloc] init];
    Deck * testDeck = [[Deck alloc] init];
   
    [testDeck addCardAsyn:testCard];
    [self waitForExpectationsWithTimeout:5
                                 handler:^(NSError *error) {
                                     // handler is called on _either_ success or failure
                                     if (error != nil) {
                                         XCTFail(@"timeout error: %@", error);
                                     }
                                 }];
    
    method_exchangeImplementations(orig_method, target_method);
}


@end
