/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "GPGooglePlusSignInButton.h"
#import "ComObscureGoogleplusModule.h"
#import "GPGooglePlusSignInButtonProxy.h"
#import "GooglePlusSignInButton.h"

@implementation GPGooglePlusSignInButton

- (ComObscureGoogleplusModule *)module {
    GPGooglePlusSignInButtonProxy * proxy = (GPGooglePlusSignInButtonProxy *) self.proxy;
    return proxy._module;
}

- (void)dealloc {
    RELEASE_TO_NIL(button);
    [super dealloc];
}

- (GooglePlusSignInButton *)button {
    if (!button) {
        ComObscureGoogleplusModule * module = [self module];
        
        button = [[GooglePlusSignInButton alloc] init];
        [button setStyle:kGooglePlusSignInButtonStyleNormal]; // TODO get from properties
        button.delegate = module;
        button.clientID = module.clientid;
        [module storeSignIn:button.googlePlusSignIn];
        // TODO get scope from module
        /*
        button.scope = [NSArray arrayWithObjects:
                        @"https://www.googleapis.com/auth/plus.moments.write",
                        @"https://www.googleapis.com/auth/plus.me",
                        nil];
        
         */
        [button sizeToFit];
        [self addSubview:button];
        [self sizeToFit];
    }
    return button;
}

- (void)configurationSet {
    [super configurationSet];
    [self addSubview:[self button]];
}

- (void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds {
    if (button) {
        [TiUtils setView:button positionRect:bounds];
        [button sizeToFit];
        [self sizeToFit];
    }
    [super frameSizeChanged:frame bounds:bounds];
}


@end
