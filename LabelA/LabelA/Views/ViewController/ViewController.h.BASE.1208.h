//
//  ViewController.h
//  LabelA
//
//  
//  
//

#import <UIKit/UIKit.h>
#import "BeaconViewController.h"
@import CoreLocation;

@interface ViewController : UIViewController <CLLocationManagerDelegate>
@property (strong, nonatomic) CLBeaconRegion *myBeaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) BeaconViewController *beaconViewController;
- (IBAction)launchBeaconVC:(UIBarButtonItem *)sender;

@end
