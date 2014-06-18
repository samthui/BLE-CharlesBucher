//
//  Device.h
//  BLE_Master
//
//  Created by samthui7 on 4/25/13.
//  Copyright (c) 2013 samthui7. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

@protocol UpdateInfoDeviceDelegate <NSObject>

-(void) didUpdateRSSI:(int)rssi;
-(void) didUpdateValueForChar2:(NSData*)value;
-(void) didDisconnect;

@end

@interface Device : NSObject <CBPeripheralDelegate>

@property (nonatomic, retain) CBPeripheral* peripheral;
@property (nonatomic, retain) CBService* service;
@property (nonatomic, retain) CBCharacteristic* characteristic1;
@property (nonatomic, retain) CBCharacteristic* characteristic2;

@property (nonatomic, retain) id<UpdateInfoDeviceDelegate> updateInfoDelegate;

@property (nonatomic, assign) float interval;
@property (nonatomic, retain) NSData* data;

@property (nonatomic, assign) int index;

-(id) initWithPeripheral:(CBPeripheral*)peripheral;
-(void) connect;
-(void) disconnect;

-(void) resetTimerWithInterval:(float)newInterval data:(NSData*)newData;

@end
