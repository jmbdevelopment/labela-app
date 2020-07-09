//
//  ViewController.h
//  LabelA
//
//  
//  
//

#import <UIKit/UIKit.h>
#import "BeaconViewController.h"
#import "BeaconController.h"
@import CoreLocation;

@interface ViewController : UIViewController <CLLocationManagerDelegate>
@property (strong, nonatomic) CLBeaconRegion *myBeaconRegion;
@property (strong, nonatomic) BeaconViewController *beaconViewController;
@property (strong, nonatomic) CLLocationManager *locationManager;
//@property (strong, nonatomic) BeaconController *beaconController;
- (IBAction)launchBeaconVC:(UIBarButtonItem *)sender;

@end
