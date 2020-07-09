//
//  ViewController.h
//  LabelA
//
//  
//  
//

#import <UIKit/UIKit.h>
#import "BeaconViewController.h"
<<<<<<< HEAD
#import "TriangleObject.h"

=======
#import "BeaconController.h"
>>>>>>> 1c8893cce896db61cf3668331eef670cf5941934
@import CoreLocation;

@interface ViewController : UIViewController <CLLocationManagerDelegate>
@property (strong, nonatomic) CLBeaconRegion *myBeaconRegion;
@property (strong, nonatomic) BeaconViewController *beaconViewController;
@property (strong, nonatomic) CLLocationManager *locationManager;
//@property (strong, nonatomic) BeaconController *beaconController;
- (IBAction)launchBeaconVC:(UIBarButtonItem *)sender;

@property (strong, nonatomic) TriangleObject *triangleObject;
@property (strong, nonatomic) UIView *polygonContainer;

@end
