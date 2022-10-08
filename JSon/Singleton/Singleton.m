//
//  Singleton.m
//  PocketRealty
//
//  Created by TISMobile on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Singleton.h"


@implementation Singleton

+ (Singleton*) sharedSingleton  {
	static Singleton* theInstance = nil;
	if (theInstance == nil) {
		theInstance = [[self alloc] init];
	}
	return theInstance;
}


- (NSString *) getBaseURL
{
    return @"http://services.saksolution.com/FMBservice_new1.asmx/";
}
@end

