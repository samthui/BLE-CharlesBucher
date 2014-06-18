//
//  DeviceConfig.h
//  BLE_Master
//
//  Created by samthui7 on 5/3/13.
//  Copyright (c) 2013 samthui7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceConfig : NSObject<NSCoding>

@property (nonatomic, retain) NSString* UUID;
@property (nonatomic, assign) int state;
@property (nonatomic, assign) float interval;

@end
