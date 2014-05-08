//
//  CLSPreferencesViewController.m
//  gorjeta
//
//  Created by Celo on 23/02/14.
//  Copyright (c) 2014 Celo. All rights reserved.
//

#import "CLSPreferencesViewController.h"
#import "CLSViewController.h"
#import "CLSAppDelegate.h"
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FSVenue.h"
#import "Foursquare2.h"
#import "FSConverter.h"
#import <MapKit/MapKit.h>



@interface CLSPreferencesViewController ()<CLLocationManagerDelegate>
@property (strong,nonatomic) CLLocationManager *locationManager;
@property (strong,nonatomic ) NSMutableArray *allBars;
@property (strong,nonatomic)NSString *userlocation;
@property (strong,nonatomic)FSVenue *setting;
@property (strong,nonatomic)NSArray *nearbyPlaces;
@property (strong,nonatomic)NSString *local;

@end

@implementation CLSPreferencesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation ];
 
 
}


- (void)getVenuesForLocation:(CLLocation *)location {
    
    [Foursquare2 venueSearchNearByLatitude:@(location.coordinate.latitude)
                                 longitude:@(location.coordinate.longitude)
                                     query:nil
                                     limit:nil
                                    intent:intentCheckin
                                    radius:@(500)
                                categoryId:nil
                                  callback:^(BOOL success, id result){
                                      if (success) {
                                          NSDictionary *dic = result;
                                          NSArray *venues = [dic valueForKeyPath:@"response.venues"];
                                       
                                          self.nearbyPlaces = [venues valueForKey:@"name"];
                                      [self.tableView1 reloadData];
                                          [self.load stopAnimating];
                                          NSLog(@"bombou %@",self.nearbyPlaces);
                                      }else
                                          [self.load startAnimating];
                                  }];
}




- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    [self.locationManager stopUpdatingLocation];
    [self getVenuesForLocation:newLocation];

}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    [self.locationManager stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btVolta:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark venues



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nearbyPlaces.count;

    
 
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      static NSString *identifier = @"cell";
    
    
    
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    
    cell.textLabel.text = self.nearbyPlaces[indexPath.row];
    return cell;
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.local = self.nearbyPlaces[indexPath.row] ;
    [self actionFace];
}

#pragma mark face
-(void)actionFace
{
    //snippet retirado da documentação do site do sdk do facebook for developers
    
    NSString *stringLocal = [NSString stringWithFormat:@"Estou dividindo a conta com os meus amigos no %@ usando o iGorjeta",self.local];
    
    // Check if the Facebook app is installed and we can present the share dialog
    FBShareDialogParams *params = [[FBShareDialogParams alloc] init];
    params.link = [NSURL URLWithString:@"https://www.facebook.com/groups/297250497044821/"];
    params.name = @"iGorjeta";
    params.caption = stringLocal;
    params.picture = [NSURL URLWithString:@"http://i.imgur.com/PZEPHWC.png"];
    params.description = stringLocal;
    
    
    // If the Facebook app is installed and we can present the share dialog
    if ([FBDialogs canPresentShareDialogWithParams:params]) {
        
        // Present share dialog
        [FBDialogs presentShareDialogWithLink:params.link
                                         name:params.name
                                      caption:params.caption
                                  description:params.description
                                      picture:params.picture
                                  clientState:nil
                                      handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                          if(error) {
                                              // An error occurred, we need to handle the error
                                              // See: https://developers.facebook.com/docs/ios/errors
                                              NSLog(@"Error publishing story: %@", error.description);
                                          } else {
                                              // Success
                                              NSLog(@"result %@", results);
                                          }
                                      }];
        
        
    } else {
    
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"iGorjeta", @"name",
                                       stringLocal, @"caption",
                                       stringLocal, @"description",
                                       @"www.google.com", @"link",
                                       @"http://i.imgur.com/PZEPHWC.png", @"picture",
                                       nil];
        
        // Show the feed dialog
        [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                               parameters:params
                                                  handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                      if (error) {
                                                          // An error occurred, we need to handle the error
                                                          // See: https://developers.facebook.com/docs/ios/errors
                                                          NSLog(@"Error publishing story: %@", error.description);
                                                      } else {
                                                          if (result == FBWebDialogResultDialogNotCompleted) {
                                                              // User canceled.
                                                              NSLog(@"User cancelled.");
                                                          } else {
                                                              // Handle the publish feed callback
                                                              NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                              
                                                              if (![urlParams valueForKey:@"post_id"]) {
                                                                  // User canceled.
                                                                  NSLog(@"User cancelled.");
                                                                  
                                                              } else {
                                                                  // User clicked the Share button
                                                                  NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                                  NSLog(@"result %@", result);
                                                              }
                                                          }
                                                      }
                                                  }];
    }
}

- (IBAction)btreload:(UIButton *)sender {
    [self actionFace];
  
    }




- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}



@end
