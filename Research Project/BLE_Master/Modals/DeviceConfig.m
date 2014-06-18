//
//  DeviceConfig.m
//  BLE_Master
//
//  Created by samthui7 on 5/3/13.
//  Copyright (c) 2013 samthui7. All rights reserved.
//

#import "DeviceConfig.h"

@implementation DeviceConfig

@synthesize UUID = _UUID;
@synthesize state = _state;
@synthesize interval = _interval;


- (id) initWithCoder: (NSCoder *)coder
{
    self = [[DeviceConfig alloc] init];
    if (self != nil)
    {
        self.UUID = [coder decodeObjectForKey:@"UUID"];
        
        self.state = [coder decodeIntForKey:@"state"];
        self.interval = [coder decodeFloatForKey:@"interval"];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_UUID forKey:@"UUID"];
    
    [aCoder encodeInt:_state forKey:@"state"];
    [aCoder encodeFloat:_interval forKey:@"interval"];
}

-(void) dealloc
{
    self.UUID = nil;
    
    [super dealloc];
}

@end
