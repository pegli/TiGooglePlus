/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiModule.h"
#import "GooglePlusSignIn.h"

@class GooglePlusSign;
@class GooglePlusSignInButton;

@interface ComObscureGoogleplusModule : TiModule<GooglePlusSignInDelegate> {
    GooglePlusSignIn * signIn;
}
@property (nonatomic, retain) NSString * clientid;
- (void)storeSignIn:(GooglePlusSignIn *)signIn;
@end
