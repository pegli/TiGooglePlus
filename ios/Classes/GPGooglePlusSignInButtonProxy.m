/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "GPGooglePlusSignInButtonProxy.h"
#import "TiUtils.h"

@implementation GPGooglePlusSignInButtonProxy

@synthesize _module = module;

-(id)_initWithPageContext:(id<TiEvaluator>)context_ args:(id)args module:(ComObscureGoogleplusModule *)module_ {
	if (self = [super _initWithPageContext:context_ args:args]) {
		module = [module_ retain];
	}
	return self;
}

-(void)dealloc {
	RELEASE_TO_NIL(module);
	[super dealloc];
}

@end
