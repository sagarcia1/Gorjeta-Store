//
//  CLSingleton.m
//  gorjeta
//
//  Created by Celo on 24/03/14.
//  Copyright (c) 2014 Celo. All rights reserved.
//

#import "CLSingleton.h"
#import <CoreLocation/CoreLocation.h>

@interface CLSingleton ()

@end

@implementation CLSingleton
-(id)initWithName:(NSString *)name
            andID:(NSString *)ids
      andReferral:(NSString *)referralId;
     // andLocation:(CLLocation *)location;

{
    if(self = [super init])
    {
        self.name = name;
        self.ids = ids;
        self.referralId = referralId;
      //  self.location = location;
        
    }
    return self;
}



@end
