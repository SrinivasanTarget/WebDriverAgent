/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <Foundation/Foundation.h>

#import "FBWebServer.h"

extern NSString *const FBSessionDoesNotExistException;
extern NSString *const FBApplicationDeadlockDetectedException;
extern NSString *const FBElementAttributeUnknownException;

@interface FBCoreExceptionHandler : NSObject <FBWebServerExceptionHandler>

@end
