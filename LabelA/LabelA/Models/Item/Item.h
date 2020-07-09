//
//  Beacon.h
//  LabelA
//
//
//  
//

static NSString * const kBeaconNameKey = @"name";
static NSString * const kBeaconUUIDKey = @"uuid";
static NSString * const kMajorValueKey = @"major";
static NSString * const kMinorValueKey = @"minor";

#import <Foundation/Foundation.h>
@import CoreLocation;

@interface Item : NSObject
@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSUUID *uuid;
@property (nonatomic, readonly) CLBeaconMajorValue majorValue;
@property (nonatomic, readonly) CLBeaconMinorValue minorValue;
@property (strong, nonatomic) CLBeacon *lastSeenBeacon;

- (id)initWithName:(NSString *)name
                        uuid:(NSUUID *)uuid
                       major:(CLBeaconMajorValue)major
                       minor:(CLBeaconMinorValue)minor;

- (BOOL)isEqualToCLBeacon:(CLBeacon *)beacon;
- (BOOL)isEqualToItem:(Item *)item;

@end

