//
//  HttpQueue.h
//  helpies
//
//  Created by Rupen Makhecha on 12/10/11.
//  Copyright 2011 cgvak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface HttpQueue : NSObject {

	 NSOperationQueue *_queue;
	BOOL isShowed;
}

-(void) initQueue;
//- (void) queueItems : (NSString *) requestUrl  : (NSString *) _tagstr : (NSData *)bodyData;
- (void) queueItems : (NSString *) requestUrl  : (int) _tag : (NSData *)bodyData;
+ (HttpQueue*) sharedSingleton;
- (void) queueImages : (NSString *) requestUrl  : (int) _tag : (NSData *)bodyData : (NSString *)imageName;
- (void) queueImagesWork : (NSString *) requestUrl  : (int) _tag : (NSData *)bodyData : (NSString *)imageName : (NSString *)key;
-(void) getItems : (NSString *) requestUrl  : (int) _tag;
- (ASIHTTPRequest *) queueItemsCancel : (NSString *) requestUrl  : (int) _tag : (NSData *)bodyData;
- (void) queueAudioFile : (NSString *) requestUrl  : (int) _tag : (NSData *)bodyData : (NSString *)imageName;

@property (retain) NSOperationQueue *queue;
@end
