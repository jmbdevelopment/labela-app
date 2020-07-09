//
//  Beacon.m
//  LabelA
//
//
//  
//

#import "Item.h"

@implementation Item

- (id)initWithName:(NSString *)name
                        uuid:(NSUUID *)uuid
                       major:(CLBeaconMajorValue)major
                       minor:(CLBeaconMinorValue)minor
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _name = name;
    _uuid = uuid;
    _majorValue = major;
    _minorValue = minor;
    
    return self;
}
- (BOOL)isEqualToItem:(Item *)item {
    if ([item.name isEqualToString:self.name] && [[[item uuid] UUIDString] isEqualToString:[self.uuid UUIDString]] && [@(item.majorValue) isEqual:@(self.majorValue)] && [@(item.minorValue) isEqual:@(self.minorValue)]) {
        return YES;
    } else {
        return NO;
    }
        
}
- (BOOL)isEqualToCLBeacon:(CLBeacon *)beacon {
    if ([[beacon.proximityUUID UUIDString] isEqualToString:[self.uuid UUIDString]] &&
        [beacon.major isEqual: @(self.majorValue)] &&
        [beacon.minor isEqual: @(self.minorValue)])
    {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _name = [aDecoder decodeObjectForKey:kBeaconNameKey];
    _uuid = [aDecoder decodeObjectForKey:kBeaconUUIDKey];
    _majorValue = [[aDecoder decodeObjectForKey:kMajorValueKey] unsignedIntegerValue];
    _minorValue = [[aDecoder decodeObjectForKey:kMinorValueKey] unsignedIntegerValue];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name forKey:kBeaconNameKey];
    [aCoder encodeObject:_uuid forKey:kBeaconUUIDKey];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:_majorValue] forKey:kMajorValueKey];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:_minorValue] forKey:kMinorValueKey];
}


@end

