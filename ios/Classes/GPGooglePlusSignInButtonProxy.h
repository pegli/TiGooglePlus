/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiViewProxy.h"
#import "ComObscureGoogleplusModule.h"

@interface GPGooglePlusSignInButtonProxy : TiViewProxy {
    ComObscureGoogleplusModule * module;
}
@property (nonatomic, readonly) ComObscureGoogleplusModule * _module;
-(id)_initWithPageContext:(id<TiEvaluator>)context_ args:(id)args module:(ComObscureGoogleplusModule*)module_;
@end
