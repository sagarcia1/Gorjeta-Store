//
//  CLSingleton.h
//  gorjeta
//
//  Created by Celo on 24/03/14.
//  Copyright (c) 2014 Celo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>
#import<CoreLocation/CoreLocation.h>

@interface CLSingleton : UITableViewController



@property(nonatomic,strong) NSString *ids;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *referralId;
@property(nonatomic,strong) NSString *url;
//@property(nonatomic,strong) CLLocation *location;


-(id)initWithName:(NSString *)name
            andID:(NSString *)ids
      andReferral:(NSString *)referralId;
    //  andLocation:(CLLocation *)location;


@end
