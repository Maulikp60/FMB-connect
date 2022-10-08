//
//  StaticClass.m
//  PocketRealty
//
//  Created by TISMobile on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StaticClass.h"
#import "QSStrings.h"

static const char _base64EncodingTable[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
static const short _base64DecodingTable[256] = {
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2, -1, -1, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62, -2, -2, -2, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2, -2, -2, -2, -2,
    -2,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2, -2, -2, -2, -2,
    -2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2
};


@implementation StaticClass

+ (NSString *)encodeBase64WithString:(NSString *)strData {
    return [QSStrings encodeBase64WithData:[strData dataUsingEncoding:NSUTF8StringEncoding]];
}

+ (NSString *)encodeBase64WithData:(NSData *)objData {
    const unsigned char * objRawData = [objData bytes];
    char * objPointer;
    char * strResult;
    
    // Get the Raw Data length and ensure we actually have data
    int intLength = [objData length];
    if (intLength == 0) return nil;
    
    // Setup the String-based Result placeholder and pointer within that placeholder
    strResult = (char *)calloc((((intLength + 2) / 3) * 4) + 1, sizeof(char));
    objPointer = strResult;
    
    // Iterate through everything
    while (intLength > 2) { // keep going until we have less than 24 bits
        *objPointer++ = _base64EncodingTable[objRawData[0] >> 2];
        *objPointer++ = _base64EncodingTable[((objRawData[0] & 0x03) << 4) + (objRawData[1] >> 4)];
        *objPointer++ = _base64EncodingTable[((objRawData[1] & 0x0f) << 2) + (objRawData[2] >> 6)];
        *objPointer++ = _base64EncodingTable[objRawData[2] & 0x3f];
        
        // we just handled 3 octets (24 bits) of data
        objRawData += 3;
        intLength -= 3; 
    }
    
    // now deal with the tail end of things
    if (intLength != 0) {
        *objPointer++ = _base64EncodingTable[objRawData[0] >> 2];
        if (intLength > 1) {
            *objPointer++ = _base64EncodingTable[((objRawData[0] & 0x03) << 4) + (objRawData[1] >> 4)];
            *objPointer++ = _base64EncodingTable[(objRawData[1] & 0x0f) << 2];
            *objPointer++ = '=';
        } else {
            *objPointer++ = _base64EncodingTable[(objRawData[0] & 0x03) << 4];
            *objPointer++ = '=';
            *objPointer++ = '=';
        }
    }
    
    // Terminate the string-based result
    *objPointer = '\0';
    
    // Return the results as an NSString object
    return [NSString stringWithCString:strResult encoding:NSASCIIStringEncoding];
}


// MD5 generating
+ (NSString *) returnMD5Hash:(NSString *)concat
{
	const char *concat_str = [concat UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(concat_str, strlen(concat_str), result);
	NSMutableString *hash = [NSMutableString string];
	for (int i = 0; i < 16; i++)
		[hash appendFormat:@"%02X", result[i]];
	return [hash lowercaseString];
}

+ (void)saveToUserDefaults:(NSString*)myString : (NSString *) pref
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	if (standardUserDefaults) {
		[standardUserDefaults setObject:myString forKey:pref];
		[standardUserDefaults synchronize];
	}
}

+ (NSString*)retrieveFromUserDefaults: (NSString *) pref
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSString *val = nil;
	
	if (standardUserDefaults) 
		val = [standardUserDefaults objectForKey: pref];
	
	return val;
}

// String Encoding
+(NSString * ) urlEncoding : (NSString *) raw 
{
//	NSString *preparedString = [raw stringByReplacingOccurrencesOfString: @" " withString: @"%20"];
//	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"&" withString: @"%26"];
//	return preparedString ;
    NSString *preparedString = [raw stringByReplacingOccurrencesOfString: @" " withString: @"%20"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"&" withString: @"%26"];
    preparedString = [preparedString stringByReplacingOccurrencesOfString: @"+" withString: @"%2B"];
    
	return preparedString ;
}

// String Decoding 
+(NSString * ) urlDecode : (NSString *) raw 
{
	NSString *preparedString = [raw stringByReplacingOccurrencesOfString: @"%20" withString: @" "];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%7B" withString: @"{"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%2F" withString: @"/"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%3A" withString: @":"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%2C" withString: @","];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%7D" withString: @"}"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%22" withString: @""];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%0A" withString: @"\n"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"+" withString: @" "];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%5C" withString: @""];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%27" withString: @"'"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%24" withString: @"$"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%3F" withString: @"?"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%3A" withString: @":"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%2F" withString: @"/"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%3F" withString: @"?"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%3D" withString: @"="];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%26" withString: @"&"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%3B" withString: @";"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"&amp;" withString: @"&"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%28" withString: @"("];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%29" withString: @")"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%2A" withString: @"*"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%2B" withString: @"+"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%2E" withString: @"."];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%2D" withString: @"-"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%40" withString: @"@"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%3C" withString: @"<"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%C3" withString: @""];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%83" withString: @""];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%C2" withString: @""];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%A9" withString: @""];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%21" withString: @"!"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%0D" withString: @" "];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%09" withString: @" "];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%3E" withString: @">"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%7E" withString: @"~"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%5C" withString: @"\\"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%5B" withString: @"["];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%5D" withString: @"]"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%F4" withString: @"U"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%7C" withString: @"|"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%23" withString: @"#"];
	
	//preparedString = [preparedString stringByReplacingOccurrencesOfString: @"\n" withString: @""];
	return preparedString;
}


@end
