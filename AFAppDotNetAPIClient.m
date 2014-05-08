//
//  AFAppDotNetAPIClient.m
//  Notas
//
//  Created by Peterson Mauricio on 19/10/13.
//  Copyright (c) 2013 Peterson Mauricio. All rights reserved.
//
#import "AFAppDotNetAPIClient.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "AFJSONRequestOperation.h"

static NSString * const kAFAppDotNetAPIBaseURLString = @"https://api.foursquare.com/v2/";

@implementation AFAppDotNetAPIClient

+ (AFAppDotNetAPIClient *)sharedClient {
    static AFAppDotNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppDotNetAPIBaseURLString]];
    });
		// NSLog(@"instance: %@",_sharedClient);
    return _sharedClient;
}

-(id)initWithBaseURL:(NSURL *)url{
		
		if(self = [super initWithBaseURL:url]){
			
			[self registerHTTPOperationClass:[AFJSONRequestOperation class]];
			
			[self setDefaultHeader:@"Accept" value:@"application/json"];
            
			self.parameterEncoding = AFJSONParameterEncoding;
			[AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
		}
		return self;
	}


@end
