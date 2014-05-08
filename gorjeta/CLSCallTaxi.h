//
//  CLSCallTaxi.h
//  gorjeta
//
//  Created by Celo on 28/04/14.
//  Copyright (c) 2014 Celo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface CLSCallTaxi : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityTable;
@property (weak, nonatomic) IBOutlet MKMapView *mapa;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityMap;

- (IBAction)btVoltar:(UIButton *)sender;

@end
