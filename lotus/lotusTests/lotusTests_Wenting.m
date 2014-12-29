//
//  lotusTests.m
//  lotusTests
//
//  Created by Ying, Yuqian on 4/23/14.
//  Copyright (c) 2014 ___MSTR___. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CardMatchingGame.h"
#import "ViewController.h"
#import "OCMock.h"
#import <objc/runtime.h>
#import "PlayCardDeck.h"

@interface lotusTests : XCTestCase{
    PlayCardDeck *playCardDeck;
    PlayingCard *baseCard;
}

@end

XCTestExpectation *expectation;

@implementation lotusTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    playCardDeck = [[PlayCardDeck alloc]init];
    
    baseCard = [[PlayingCard alloc]init];
    baseCard.rank = 11;
    baseCard.suit = @"♣️";
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)hacked_changeLastScore{
    [expectation fulfill];
}


- (void)test_Deck_drawRandomCard{
    
    Deck *deck = [[Deck alloc]init];
    Card *randomCard = [playCardDeck drawRandomCard];
    Card *nilCard = [deck drawRandomCard];
    
    XCTAssertTrue(randomCard, @"Fail! randomCard returns nil!");
    XCTAssertNil(nilCard, @"Fail! nilCard should be nil!");
    
}

- (void)test_Deck_addCard{
    Deck *deck = [[Deck alloc]init];
    
    id testMock = OCMPartialMock(deck);
    [[testMock expect]addCard:baseCard atTop:NO];
    
    [deck addCard:baseCard];
    [testMock verify];
}

- (void)test_Deck_addCardAtTop{
    Deck *deck = [[Deck alloc]init];
    [deck.cards addObject:baseCard];
    
    Card *addCard = [[Card alloc]init];
    
    
    [deck addCard:addCard atTop:YES];
    Card *checkCard = [deck.cards objectAtIndex:0];
    XCTAssertNil(checkCard.contents, @"Fail");
    
    [deck addCard:addCard atTop:NO];
    Card *checkCard1 = [deck.cards lastObject];
    XCTAssertNil(checkCard1.contents, @"Fail");
    
    
}

- (void)test_PlayingCard_cardStyleChange{
    PlayingCard *playingCard =[[PlayingCard alloc]init];
    
    id observeMock = OCMObserverMock();
    [[NSNotificationCenter defaultCenter]addMockObserver:observeMock name:@"CardStyleChanged" object:nil];
    [[observeMock expect]notificationWithName: @"CardStyleChanged" object: nil];
    
    [playingCard cardStyleChange];
    
    [observeMock verify];
    [[NSNotificationCenter defaultCenter]removeObserver:observeMock];
    
}

- (void)test_PlayingCard_maxRank{
    XCTAssertEqual([PlayingCard maxRank], 13, @"The maxRank should be 13.");
}

- (void)test_PlayingCard_match{


    NSArray *baseArray = @[baseCard];
    PlayingCard *playingCard = [[PlayingCard alloc]init];
    
    playingCard.suit = @"♣️";
    playingCard.rank = 9;
    
    int score = [playingCard match:playCardDeck.cards];
    XCTAssertEqual(score, 0, @"Fail");
    
    int score1 = [playingCard match:baseArray];
    XCTAssertEqual(score1, 1, @"Fail");
    
    playingCard.rank = 11;
    int score2 = [playingCard match:baseArray];
    XCTAssertEqual(score2, 4, @"Fail");
    
    
    
}

- (void)test_CardMatchingGame_chooseCardAtIndex{
    
    id protocolMock = OCMProtocolMock(@protocol(Card));
    OCMStub([protocolMock drawRandomCard]).andReturn(baseCard);
    
    CardMatchingGame *game = [[CardMatchingGame alloc]initWithCardCount:12 usingDeck:protocolMock];
    id testMock = OCMClassMock([PlayingCard class]);
    [game.cards addObject:testMock];
    
    [[testMock expect]match:[OCMArg any]];
    unsigned random = arc4random() % 12;
    Card *otherCard = [game cardAtIndex:random];
    otherCard.matched = NO;
    otherCard.chosen = YES;
    game.score = 0;
    [game chooseCardAtIndex:12];
    [testMock verify];
    XCTAssertEqual(game.score, -3, @"Calculate Error");
    
    OCMStub([testMock match:[OCMArg any]]).andReturn(1);
    otherCard.matched = NO;
    otherCard.chosen = YES;
    game.score = 0;
    [game chooseCardAtIndex:12];
    XCTAssertEqual(game.score, 3, @"Calculate Error");
    
}

- (void)test_veiwcontroller_setFlipCount{
    
    Method orig_method, target_method;
    orig_method = class_getInstanceMethod([ViewController class], @selector(changeLastScore));
    target_method = class_getInstanceMethod([lotusTests class], @selector(hacked_changeLastScore));
    method_exchangeImplementations(orig_method, target_method);
    
    ViewController *controller = [[ViewController alloc]init];

    expectation = [self expectationWithDescription:@"change last score"];
    [controller setFlipCount:10];
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error){
        if (error) {
            XCTFail(@"Timeout error: %@", error);
        }
    }];
    
    method_exchangeImplementations(target_method, orig_method);
}

- (void)test_veiwcontroller_setFlipCount2{

    
    ViewController *controller = [[ViewController alloc]init];
    lotusTests *test = [[lotusTests alloc]init];
    id testMock = OCMPartialMock(controller);
    OCMStub([testMock changeLastScore]).andCall(test, @selector(hacked_changeLastScore));
    
    
    expectation = [self expectationWithDescription:@"change last score"];
    [controller setFlipCount:10];
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error){
        if (error) {
            XCTFail(@"Timeout error: %@", error);
        }
    }];

}


- (void)test_viewController_viewWillAppear{
    id observerMock = OCMObserverMock();
    ViewController *controller = [[ViewController alloc]init];
    
    [[NSNotificationCenter defaultCenter]addMockObserver:observerMock name:UIContentSizeCategoryDidChangeNotification object:nil];
    [[observerMock expect] notificationWithName:UIContentSizeCategoryDidChangeNotification object: nil];
    
    [controller viewWillAppear:YES];
    
    [observerMock verify];
    
    [[NSNotificationCenter defaultCenter]removeObserver:observerMock];
    
}

- (void)test_viewController_preferredFrontsChanges{
    ViewController *controller = [[ViewController alloc]init];
    id testMock = OCMPartialMock(controller);
    [[testMock expect]usePreferredFronts];
    NSNotification *notification;
    [controller preferredFrontsChanges:notification];
    
    [testMock verify];

}




@end
