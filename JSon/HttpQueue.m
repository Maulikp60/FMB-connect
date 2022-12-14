//
//  HttpQueue.m
//  helpies
//
//  Created by Rupen Makhecha on 12/10/11.
//  Copyright 2011 cgvak. All rights reserved.
//

#import "HttpQueue.h"
#import "ASIFormDataRequest.h"
//#import "NXJsonParser.h"


@implementation HttpQueue

@synthesize queue = _queue;

+ (HttpQueue*) sharedSingleton
{
	static HttpQueue* theInstance = nil;
	if (theInstance == nil)
	{
		theInstance = [[self alloc] init];
		[theInstance initQueue];
	}
	return theInstance;
}

-(void) setStats 
{
	isShowed = NO;
}

-(void) initQueue
{
	 self.queue = [[[NSOperationQueue alloc] init] autorelease];
	
}

-(void) getItems : (NSString *) requestUrl  : (int) _tag
{
	NSURL *url = [NSURL URLWithString:requestUrl];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	request.tag = _tag;
	[request setDelegate:self];
	[_queue addOperation:request];
}

- (void) queueImages : (NSString *) requestUrl  : (int) _tag : (NSData *)bodyData : (NSString *)imageName
{
	NSURL *url = [NSURL URLWithString:requestUrl];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	request.tag = _tag;
	[request setUseKeychainPersistence:YES];
	[request addPostValue:imageName forKey:@"name"];
	//[request addPostValue:requestUrl forKey:@"name"];
	[request setData:bodyData withFileName:imageName andContentType:@"image/png" forKey:@"datafile"];
	[request setDelegate:self];
	[_queue addOperation:request];
}

- (void) queueImagesWork : (NSString *) requestUrl  : (int) _tag : (NSData *)bodyData : (NSString *)imageName : (NSString *)key
{
	NSURL *url = [NSURL URLWithString:requestUrl];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	request.tag = _tag;
	[request setUseKeychainPersistence:YES];
	[request addPostValue:imageName forKey:@"name"];
	[request setData:bodyData withFileName:imageName andContentType:@"image/png" forKey:key];
	[request setDelegate:self];
	[_queue addOperation:request];
}

//- (void) queueItems : (NSString *) requestUrl  : (NSString *) _tagstr : (NSData *)bodyData
- (void) queueItems : (NSString *) requestUrl  : (int) _tag : (NSData *)bodyData
{
	
	NSURL *url = [NSURL URLWithString:requestUrl];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	request.tag = _tag;
	//request.tagStr = _tagstr;
	//[request setTagStr:_tagstr];
	[request  setRequestMethod:@"POST"];
	//[request addRequestHeader:@"User-Agent" value:@"ASIHTTPRequest"]; 
	[request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
	[request appendPostData:bodyData]; 
	[request setDelegate:self];
	[_queue addOperation:request];
	
}

- (ASIHTTPRequest *) queueItemsCancel : (NSString *) requestUrl  : (int) _tag : (NSData *)bodyData
{
    
    NSURL *url = [NSURL URLWithString:requestUrl];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.tag = _tag;
    //request.tagStr = _tagstr;
    //[request setTagStr:_tagstr];
    [request  setRequestMethod:@"POST"];
    //[request addRequestHeader:@"User-Agent" value:@"ASIHTTPRequest"]; 
    [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [request appendPostData:bodyData]; 
    [request setDelegate:self];
    [_queue addOperation:request];
    return request;
}

- (void)requestFinished:(ASIHTTPRequest *)response {
	NSString *tagStr = [NSString stringWithFormat:@"%d",response.tag];
	
	//NSString *tagStr = response.tagStr;
	NSDictionary* dict = [NSDictionary dictionaryWithObject:
						response
						forKey:@"index"];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:tagStr object:self  userInfo:dict];
}

- (void)requestFailed:(ASIHTTPRequest *)response {
    
	if (isShowed == NO) {
		// Toast show message
		
		isShowed=YES;
	}
	NSError *error = [response error];
    NSLog(@"Error: %@", error);
	
	NSString *tagStr = [NSString stringWithFormat:@"-%d",response.tag];
	NSDictionary* dict = [NSDictionary dictionaryWithObject:
						  response
													 forKey:@"index"];
	[[NSNotificationCenter defaultCenter] postNotificationName:tagStr object:self  userInfo:dict];
	
	
	//[self.view makeToast:@"We are unable to upload data this time. Please connect to Internet." duration:2.0 position:@"center" title:@"Message"];
	
	// When a request in this queue fails or is cancelled, other requests will continue to run
	//[self.queue setShouldCancelAllRequestsOnFailure:YES];
	
	// Cancel all requests in a queue
	[self.queue cancelAllOperations];
	
		
}

- (void) queueAudioFile : (NSString *) requestUrl  : (int) _tag : (NSData *)bodyData : (NSString *)imageName
{
	NSURL *url = [NSURL URLWithString:requestUrl];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	request.tag = _tag;
	[request setUseKeychainPersistence:YES];
	[request addPostValue:imageName forKey:@"name"];
	//[request addPostValue:requestUrl forKey:@"name"];
	[request setData:bodyData withFileName:imageName andContentType:@"audio/caf" forKey:@"audio_file"];
	[request setDelegate:self];
	[_queue addOperation:request];
}

-(void) stopQueue
{
	
}

@end
