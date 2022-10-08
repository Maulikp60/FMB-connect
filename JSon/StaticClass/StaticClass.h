//
//  StaticClass.h
//  PocketRealty
//
//  Created by TISMobile on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface StaticClass : NSObject {

}

+ (NSString *) returnMD5Hash:(NSString *)concat;
+ (void)saveToUserDefaults:(NSString*)myString : (NSString *) pref;
+ (NSString*)retrieveFromUserDefaults: (NSString *) pref;
+ (NSString * ) urlEncoding : (NSString *) raw;
+ (NSString * ) urlDecode : (NSString *) raw;
+ (NSString *)encodeBase64WithData:(NSData *)objData;

@end
