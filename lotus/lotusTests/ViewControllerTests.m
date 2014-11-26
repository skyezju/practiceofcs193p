//
//  ViewControllerTests.m
//  lotus
//
//  Created by Ying, Yuqian on 11/25/14.
//  Copyright (c) 2014 ___MSTR___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ViewController.h"
#import "OCMock.h"
#import <objc/runtime.h>

@interface ViewControllerTests : XCTestCase

@end

@implementation ViewControllerTests
XCTestExpectation *expectation;

- (void)expectationFufill
{
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

- (void)testViewWillAppear_Notification {
    Method orig_method, target_method;
    orig_method = class_getInstanceMethod([ViewController class], @selector(usePreferredFronts));
    target_method = class_getInstanceMethod([ViewControllerTests class], @selector(expectationFufill));
    method_exchangeImplementations(orig_method, target_method);
    ViewController * testView = [[ViewController alloc] init];
    expectation = [self expectationWithDescription:@"Add card in background thread"];
    [[NSNotificationCenter defaultCenter] postNotificationName:UIContentSizeCategoryDidChangeNotification object:nil];
    [testView viewWillAppear:YES];
    [self waitForExpectationsWithTimeout:1
                                 handler:^(NSError *error) {
                                     // handler is called on _either_ success or failure
                                     if (error != nil) {XCTFail(@"timeout error: %@", error);}
                                 }];
     
    method_exchangeImplementations(orig_method, target_method);
}




@end
