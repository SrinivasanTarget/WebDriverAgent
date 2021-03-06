/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <XCTest/XCTest.h>

#import <WebDriverAgentLib/FBLogger.h>
#import <WebDriverAgentLib/FBWebDriverAgent.h>
#import <WebDriverAgentLib/XCTestCase.h>

#import "FBDebugLogDelegateDecorator.h"
#import "FBXCTestCaseImplementationFailureHoldingProxy.h"

// This magic method removes duplicated hidden cell views. (Possibly used for cell reuse)
BOOL _AXSAutomationSetFauxCollectionViewCellsEnabled(BOOL);

@interface UITestingUITests : XCTestCase
@property (nonatomic, strong) FBWebDriverAgent *agent;
@end

@implementation UITestingUITests

+ (void)setUp
{
  [FBDebugLogDelegateDecorator decorateXCTestLogger];
  [super setUp];
}

- (void)setUp
{
  [super setUp];
  self.continueAfterFailure = YES;
  _AXSAutomationSetFauxCollectionViewCellsEnabled(YES);
  self.agent = [FBWebDriverAgent new];
}

/**
 Never ending test used to start WebDriverAgent
 */
- (void)testRunner
{
  self.internalImplementation = (_XCTestCaseImplementation *)[FBXCTestCaseImplementationFailureHoldingProxy proxyWithXCTestCaseImplementation:self.internalImplementation];
  [self.agent start];
}

/**
 Private XCTestCase method used to block and tunnel failure messages
 */
- (void)_enqueueFailureWithDescription:(NSString *)description inFile:(NSString *)filePath atLine:(NSUInteger)lineNumber expected:(BOOL)expected
{
  [FBLogger logFmt:@"Enqueue Failure: %@ %@ %lu %d", description, filePath, (unsigned long)lineNumber, expected];
  [self.agent handleTestFailureWithDescription:description];
}

@end
