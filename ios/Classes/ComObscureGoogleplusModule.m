/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "ComObscureGoogleplusModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "GTMOAuth2Authentication.h"
#import "GPGooglePlusSignInButtonProxy.h"

@implementation ComObscureGoogleplusModule

@synthesize clientid;

#pragma mark Internal

-(id)moduleGUID {
	return @"48710a9e-0e7c-4213-8feb-febcfdb31e0d";
}

-(NSString*)moduleId {
	return @"com.obscure.googleplus";
}

#pragma mark Lifecycle

-(void)startup {
	[super startup];

	// copy assets from module to top level of bundle
    // required for sign-in button
    // TODO search for assets dir instead of hardcoding with module version!
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSError * error;
    
    NSString * destdir = [[NSBundle mainBundle] resourcePath];
    NSString * srcdir = [destdir stringByAppendingPathComponent:@"modules/com.obscure.googleplus/0.1/assets"];
    for (NSString * file in [fileManager contentsOfDirectoryAtPath:srcdir error:nil]) {
        NSString * dest = [destdir stringByAppendingPathComponent:file];
        if (![fileManager fileExistsAtPath:dest]) {
            [fileManager copyItemAtPath:[srcdir stringByAppendingPathComponent:file] toPath:dest error:nil];
            
        }
    }

    // notification for application launch; required to finish OAuth
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidFinishLaunchingNotification:) name:UIApplicationDidFinishLaunchingNotification object:nil];
}

-(void)shutdown:(id)sender {
	[super shutdown:sender];
}

- (void)dealloc {
    RELEASE_TO_NIL(signIn);
    [super dealloc];
}

#pragma mark Notifications
- (void)applicationDidFinishLaunchingNotification:(NSNotification *)notification {
    NSString * url = [notification.userInfo objectForKey:UIApplicationLaunchOptionsURLKey];
    NSString * sourceApplication = [notification.userInfo objectForKey:UIApplicationLaunchOptionsSourceApplicationKey];
    NSString * annotation = [notification.userInfo objectForKey:UIApplicationLaunchOptionsAnnotationKey];
    
    if ([signIn handleURL:[NSURL URLWithString:url] sourceApplication:sourceApplication annotation:annotation]) {
        NSLog(@"signIn handled URL: %@", url);
    }
    else {
        NSLog(@"did not handle URL: %@", url);
    }
}

#pragma mark -
#pragma mark GooglePlusSignInDelegate

- (NSDictionary *)authenticationToDictionary:(GTMOAuth2Authentication *)auth {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            auth.accessToken, @"accessToken",
            auth.refreshToken, @"refreshToken",
            auth.expiresIn, @"expiresIn",
            auth.code, @"code",
            auth.errorString, @"errorString",
            nil];
}

- (void)finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error {
    NSMutableDictionary * obj = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 NUMBOOL(error == nil), @"success",
                                 [self authenticationToDictionary:auth], @"data",
                                 nil];
    if (error) {
        [obj setObject:error.description forKey:@"error"];
    }
    
    [self fireEvent:@"login" withObject:obj];
}

- (void)storeSignIn:(GooglePlusSignIn *)value {
    signIn = value;
}

#pragma mark -
#pragma mark Public API

- (id)createLoginButton:(id)args {
    return [[GPGooglePlusSignInButtonProxy alloc] _initWithPageContext:[self executionContext] args:args module:self];
}

- (void)logout:(id)args {
    if (signIn) {
        [signIn signOut];
        [self fireEvent:@"logout"];
    }
    // TODO warn if no signin?
}

@end
