//
//  CLSCallTaxi.m
//  gorjeta
//
//  Created by Celo on 28/04/14.
//  Copyright (c) 2014 Celo. All rights reserved.
//

#import "CLSCallTaxi.h"
#import "CLSAppDelegate.h"
#import "CLSSettingsViewController.h"
#import <Security/Security.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "SIAlertView.h"
#import "Reachability.h"
#import "CLSPin.h"




@interface CLSCallTaxi ()<CLLocationManagerDelegate, MKMapViewDelegate>
@property (strong,nonatomic) NSMutableArray *content;
@property (strong,nonatomic)Reachability *hostReachability;
@property (strong,nonatomic)Reachability *internetReachability;
@property (strong,nonatomic)Reachability *wifiReachability;
@property (strong, nonatomic) IBOutlet UITableView *tableView;




@end
@implementation CLSCallTaxi
{
    NSString *latitude;
    NSString *longitude;
    NSArray *getTaxis;
    BOOL isShowingNoInternetScreen;
    CLLocationManager *locationmanager;
    CLLocation *local;
     NSArray *taxi;
    NSArray *telefone;
    NSString *phone;
    NSDictionary *getJson;
    CLSPin *newPin;
}

    

    
    




- (void)viewDidLoad
{
    [super viewDidLoad];
    locationmanager = [[CLLocationManager alloc]init];
    locationmanager.delegate= self;
    locationmanager.distanceFilter = kCLHeadingFilterNone;
    locationmanager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationmanager startUpdatingLocation];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
   
 }

-(void)jsonFoursquare
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSError *error;
        NSString *str = [NSString stringWithFormat: @"https://api.foursquare.com/v2/venues/search?ll=%@,%@&categoryId=4bf58dd8d48988d130951735&oauth_token=KPHLFWJJFYWFB4IVX5W0ODGSL2J44G2ZOIB2WGSNIZ3KAMJX&v=20140428",latitude,longitude] ;
        NSURL *url = [NSURL URLWithString:str];
        NSData *dataJson = [NSData dataWithContentsOfURL:url];
        // id json = [NSJSONSerialization JSONObjectWithData:dataJson options:kNilOptions error:&error];
        getJson =[NSJSONSerialization JSONObjectWithData:dataJson options:kNilOptions error:&error];
        getTaxis = [[getJson objectForKey:@"response"]objectForKey:@"venues"];
        taxi = [getTaxis valueForKey:@"venues"];
        [self.tableView reloadData];
    });
  

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
return taxi.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     static NSString *identifier = @"cell";
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
     cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
     tableView.backgroundColor = [UIColor clearColor];
     phone= [[getTaxis valueForKey:@"contact"]valueForKey:@"phone"][indexPath.row];
        if (phone == (id)[NSNull null])
        {  
            
                NSLog(@"Merdinhas");
                // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
                //[cell  setHidden:YES];
          
            }
        else
            {
                [self.activityTable stopAnimating];
                [self.activityMap stopAnimating];
                cell.backgroundColor = [UIColor clearColor];
                cell.textLabel.text = [getTaxis valueForKey:@"name"][indexPath.row];
                cell.imageView.image = [UIImage imageNamed:@"iconCall"];
                cell.textColor = [UIColor whiteColor];
                CLLocationCoordinate2D point;
                point.latitude = [[[getTaxis valueForKey:@"location"]valueForKey:@"lat"][indexPath.row] floatValue];
                point.longitude = [[[getTaxis valueForKey:@"location"]valueForKey:@"lng"][indexPath.row] floatValue];
                NSString *getAdress = [[getTaxis valueForKey:@"location"]valueForKey:@"address"][indexPath.row];
                newPin = [[CLSPin alloc]init];
                newPin.title = cell.textLabel.text;
                newPin.subtitle = getAdress;
                newPin.coordinate = point;
                UIImage *image = [UIImage imageNamed:@"pino"];
                newPin.image = image;
                [self.mapa addAnnotation:newPin];
                NSArray *annotationsArray = [self.mapa annotations];
                [self.mapa showAnnotations:annotationsArray animated:YES];
                self.mapa.camera.altitude *=1.4;
                NSLog(@"%@Phone",phone);
                NSLog(@"%@ Location",newPin.title);
                MKUserLocation *userLocation = self.mapa.userLocation;
                NSLog(@" UserLocation %@",userLocation);
                MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(newPin.coordinate,34000, 34000);
                [self.mapa setRegion:region animated:YES];
                
            
        }
                return  cell    ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    phone= [[getTaxis valueForKey:@"contact"]valueForKey:@"phone"][indexPath.row];
    if (phone == (id)[NSNull null]) {
        NSLog(@"Merdinhas loucas");
        // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
        return 0;
    }
        else
    {
        return 86;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        phone = [[getTaxis valueForKey:@"contact"]valueForKey:@"phone"][indexPath.row];
        NSString *newPhone = [phone substringWithRange:NSMakeRange(1, 10)];
        NSString *url =[NSString stringWithFormat:@"telprompt://021%@",newPhone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        NSLog(@"Fone %@",phone);
    
    
    
//    CLLocationCoordinate2D point;
//    point.latitude = [[[getTaxis valueForKey:@"location"]valueForKey:@"lat"][indexPath.row] floatValue];
//    point.longitude = [[[getTaxis valueForKey:@"location"]valueForKey:@"lng"][indexPath.row] floatValue];
//    CLSPin *newPin = [[CLSPin alloc]init];
//    newPin.title = @"teste";
//    newPin.coordinate = point;
//    [self.mapa selectAnnotation:newPin animated:YES];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;
    if (currentLocation !=nil)
    {
        [locationmanager stopUpdatingLocation];
    }
    else
    {
     [self.activityTable startAnimating];
        [self.activityMap startAnimating];
    }
    latitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
    longitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
    [self jsonFoursquare];
 
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Erro");
}





- (IBAction)btVoltar:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

