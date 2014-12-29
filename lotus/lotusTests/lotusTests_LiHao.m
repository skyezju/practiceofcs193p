//
//  lotusTests.m
//  lotusTests
//
//  Created by Ying, Yuqian on 4/23/14.
//  Copyright (c) 2014 ___MSTR___. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
#import "CardMatchingGame.h"
#import "PlayCardDeck.h"
#import "PlayingCard.h"
#import "OCMock.h"
#import <objc/runtime.h>


@interface CardMatchingGameTests:NSObject
-(NSInteger) countSwizzle;
@property (nonatomic, strong) NSMutableArray *cards;
@end

@implementation CardMatchingGameTests
-(NSInteger) countSwizzle
{
//        return [self.cards count]-4;
    return 1;
}
@end

@interface lotusTests : XCTestCase
@end

@implementation lotusTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTAssertEqual(0, 0);
}

- (void)testWhat
{
    XCTAssert(YES);
}

- (void)test_addCard_Partial
{
    Deck *deck = [[Deck alloc] init];
    Card *card = [[Card alloc] init];
    id testMock = OCMPartialMock(deck);
    [[testMock expect]addCard:card atTop:NO];
    [deck addCard:card];
    [testMock verify];
}


-(void)test_addCard_atTop
{
    Deck *deck = [[Deck alloc] init];
    Card *card = [[Card alloc] init];
    id testMock = OCMClassMock([NSMutableArray class]);
    [[testMock expect]insertObject:card atIndex:0];
    deck.cards = testMock;
    [deck addCard:card atTop:YES];
    [testMock verify];
}

-(void)test_drawRandomCard
{   Card *card = [[Card alloc] init];
    card = nil;
    id mockTest = OCMProtocolMock(@protocol(CardDelegate));
    [OCMStub([mockTest drawRandomCard]) andReturn:card];
    XCTAssertNil([[CardMatchingGame alloc] initWithCardCount:5 usingDeck:mockTest],@"nil");
}

-(void)test_observer
{
    NSString *notificationName = @"CardStyleChanged";
    id observerMock = OCMObserverMock();
    PlayingCard *sender = [[PlayingCard alloc] init];
    [[NSNotificationCenter defaultCenter] addMockObserver:observerMock name:notificationName object:nil];
    [[observerMock expect] notificationWithName:notificationName object:nil];
    [sender cardStyleChange];
    [observerMock verify];
    [[NSNotificationCenter defaultCenter]removeObserver:observerMock];
    
}



-(void)test_maxRank
{
    id mockTest = OCMClassMock([NSMutableArray class]);
    OCMStub([mockTest count]).andReturn(5);
    PlayingCard *card = [[PlayingCard alloc] init];
    card.cards = mockTest;
    XCTAssertEqual([card cardsCount],5,@"should be equal to 5");
}

/*
- (void)test_cardAtIndex
{
    id mockTest = OCMClassMock([NSMutableArray class]);
    OCMStub([mockTest count]).andReturn(5);
    Deck *deck = [[PlayCardDeck alloc] init];
  	deck.cards = mockTest;
    CardMatchingGame *game = [[CardMatchingGame alloc] initWithCardCount:5 usingDeck:deck];
    XCTAssertNil([game cardAtIndex:4],@"Nil");
}
 */

- (void)test_cardAtIndex_Swizzle
{
    Method count, countSwizzle;
    count = class_getInstanceMethod([CardMatchingGame class], @selector(count));
    countSwizzle = class_getInstanceMethod([CardMatchingGameTests class], @selector(countSwizzle));
    method_exchangeImplementations(count, countSwizzle);
    Deck *deck = [[PlayCardDeck alloc] init];
    CardMatchingGame *card = [[CardMatchingGame alloc] initWithCardCount:5 usingDeck:deck];
    XCTAssertNotNil([card cardAtIndex:0],@"NotNil");
    method_exchangeImplementations(count, countSwizzle);
}

-(void)test_cardAtIndex_Stub_class
{
    Deck *deck = [[PlayCardDeck alloc] init];
    CardMatchingGameTests *deck2 = [[CardMatchingGameTests alloc] init];
    CardMatchingGame *card = [[CardMatchingGame alloc] initWithCardCount:5 usingDeck:deck];
    id mockTest = OCMPartialMock(card);
    OCMStub([mockTest count]).andCall(deck2,@selector(countSwizzle));
    XCTAssertNotNil([card cardAtIndex:0],@"NotNil");
}


XCTestExpectation *expectation;
-(void)changeLastScoretest
{
    [expectation fulfill];
}

-(void)test_setFlipCount
{
    Method changeLastScore, changeLastScoreTest;
    changeLastScore = class_getInstanceMethod([ViewController class], @selector(changeLastScore));
    changeLastScoreTest = class_getInstanceMethod([lotusTests class], @selector(changeLastScoretest));
    method_exchangeImplementations(changeLastScore, changeLastScoreTest);
    ViewController *view = [[ViewController alloc] init];
    expectation = [self expectationWithDescription:@"Count:8"];
    [view setFlipCount:8];
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        if(error!=nil){XCTFail(@"Error:%@",error);}
    }];
    method_exchangeImplementations(changeLastScore, changeLastScoreTest);
}

@end

