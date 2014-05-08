//
//  AFAppDotNetAPIClient.h
//  Notas
//
//  Created by Peterson Mauricio on 19/10/13.
//  Copyright (c) 2013 Peterson Mauricio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface AFAppDotNetAPIClient : AFHTTPClient

+ (AFAppDotNetAPIClient *)sharedClient;

@end
