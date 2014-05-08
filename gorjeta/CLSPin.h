//
//  CLSPin.h
//  gorjeta
//
//  Created by Celo on 01/05/14.
//  Copyright (c) 2014 Celo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CLSPin : NSObject<MKAnnotation>
{
NSString *title;
NSString *subtitle;
CLLocationCoordinate2D coordinate;
UIImage *image;
    
}

@property (nonatomic, copy) NSString * title;
@property (nonatomic, assign)CLLocationCoordinate2D coordinate;
@property (nonatomic,copy)NSString *subtitle;
@property (nonatomic, copy)UIImage *image;

@end


