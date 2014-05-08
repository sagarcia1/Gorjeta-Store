//
//  CLSPreferencesViewController.h
//  gorjeta
//
//  Created by Celo on 23/02/14.
//  Copyright (c) 2014 Celo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface CLSPreferencesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,MKMapViewDelegate, UIActionSheetDelegate>
- (IBAction)btVolta:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UISwitch *SwitchCor;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)btreload:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UITableView *tableView1;
@property (strong, nonatomic) IBOutlet UITableViewCell *prototypeCell;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *load;


@end
