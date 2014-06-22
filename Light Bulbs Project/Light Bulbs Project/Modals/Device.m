#import "Device.h"
#import "DeviceConfig.h"

#import "Constants.h"
#import "Utilities.h"

#import "BLEDiscoveryHelper.h"

@interface Device ()

//-(void) send;
//-(void) read;
-(void) sendCommand:(COMMAND)command;
@end

@implementation Device

@synthesize peripheral = _peripheral;
@synthesize service = _service;
@synthesize characteristic1 = _characteristic1;
@synthesize characteristic2 = _characteristic2;

//@synthesize updateInfoDelegate = _updateInfoDelegate;

//@synthesize data = _data;
//
//@synthesize interval = _interval;
//
//@synthesize index = _index;

-(id) initWithPeripheral:(CBPeripheral*)peripheral
{
    self = [super init];
    
    if (self) {
        self.peripheral = peripheral;
        self.peripheral.delegate = self;
        
        self.service = nil;
        self.characteristic1 = nil;
        self.characteristic2 = nil;
        
//        self.updateInfoDelegate = nil;
        
        //config
//        CheckTableItem checkItem = [Utilities findDeviceConfig:[Utilities UUIDofPeripheral:_peripheral]];
//        if (checkItem.found) {
//            NSMutableArray* savedDeviceList = [Utilities arrayFromUserDefaultWithKey:(NSString*)kStoredDeviceList];
//            DeviceConfig* deviceConfig = (DeviceConfig*)[savedDeviceList objectAtIndex:checkItem.index];
//            NSInteger data = deviceConfig.state;
//            self.data = [NSData dataWithBytes:&data length:1];
//            
//            _interval = deviceConfig.interval;
//        }
//        else
//        {            
//            NSInteger initDataToSend = 0;
//            self.data = [NSMutableData dataWithBytes:&initDataToSend length:1];
//            
//            _interval = kMinInterval;
//        }
    }
    
    return self;
}

-(void)dealloc
{
    self.peripheral.delegate = nil;
    self.peripheral = nil;
    
    self.service = nil;
    self.characteristic1 = nil;
    self.characteristic2 = nil;
    
//    self.data = nil;
    
    [super dealloc];
}

#pragma mark - CBPeripheralDelegate
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    NSLog(@"++ didDiscoverServices");
    if (error) {
        NSLog(@"didDiscoverServices Error:%@", [error description]);
        return;
    }
    NSArray *services = peripheral.services;
    if ([services count] > 0) {
        for (CBService *service in services) {
            //           NSLog(@"serviceUUID:%@", [service.UUID description]);
            //            NSLog(@"serviceUUID: %@", (NSString*) service.UUID);
            if ([service.UUID isEqual:[CBUUID UUIDWithString:SERVICE_UUID]]) {
                //                NSLog(@"had LockService");
                
                self.service = service;
                
                NSArray* characteristicsUUIDsArray = [NSArray arrayWithObjects:[CBUUID UUIDWithString:CHARACTERISTIC_1_UUID], [CBUUID UUIDWithString:CHARACTERISTIC_2_UUID], nil];
//                [peripheral discoverCharacteristics:characteristicsUUIDsArray forService:service];
                [peripheral discoverCharacteristics:nil forService:service];
                break;
            }
        }
        
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    NSLog(@"++ didDiscoverCharacteristicsForService");
    
    if (error) {
        NSLog(@"didDiscoverCharacteristics Error:%@", [error description]);
        return;
    }
    
    NSArray *characteristics = service.characteristics;
    if ([characteristics count] > 0) {
        for (CBCharacteristic *characteristic in characteristics) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:CHARACTERISTIC_1_UUID]])
            {
                self.characteristic1 = characteristic;
                
                [self sendCommand:_command];
            } else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:CHARACTERISTIC_2_UUID]]) {
                self.characteristic2 = characteristic;
                [self.peripheral setNotifyValue:YES forCharacteristic:self.characteristic2];
            }
        }
    }
    
//    if (self.characteristic1 && self.characteristic2) {
//        [self startMonitoringTimer];
//    }
//    else
//    {
//        NSLog(@"missing characteristic");
//    }
}
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
//    NSLog(@"++ didUpdateValueForCharacteristic");
    if (error) {
        NSLog(@"Error:%@", [error description]);
        return;
    }    
    
//    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:CHARACTERISTIC_2_UUID]]) {
//        if (self.updateInfoDelegate) {
//            [_updateInfoDelegate didUpdateValueForChar2:characteristic.value];
//        }
//    }
    
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:CHARACTERISTIC_1_UUID]])
    {
        DBLog(@"Update successful");
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
//    NSLog(@"++ didWriteValueForCharacteristic");
    if (error) {
        NSLog(@"Error:%@", [error description]);
        return;
    }
    
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:CHARACTERISTIC_1_UUID]]) {
        
//        unsigned char byte[1];
//        [characteristic.value getBytes:&byte length:1];
//        
//        NSLog(@".. %i", byte[0]);
    }
}
//
//
//-(void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error
//{
////    NSLog(@"++ peripheralDidUpdateRSSI: %i", [peripheral.RSSI intValue]);
//    if (error) {
////        NSLog(@"Error:%@", [error description]);
////        return;
//    }else {
//        if (self.updateInfoDelegate) {
//            [_updateInfoDelegate didUpdateRSSI:[peripheral.RSSI intValue]];
//        }
//    }
//}
//

-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:CHARACTERISTIC_2_UUID]])
    {
        DBLog(@"register done.");
    }
}
#pragma mark - public methods
-(void) connect
{
    BLEDiscoveryHelper* centralBLEHelper = [BLEDiscoveryHelper sharedInstance];
    [centralBLEHelper connectPeripheral:_peripheral];
}

-(void) disconnect
{
    BLEDiscoveryHelper* centralBLEHelper = [BLEDiscoveryHelper sharedInstance];
    [centralBLEHelper disconnectPeripheral:_peripheral];
}

-(void)connectToSendOnCommand
{
    _command = ON_CMD;
    [self connect];
}

-(void)connectToSendOffCommand
{
    _command = OFF_CMD;
    [self connect];
}

-(void)connectToSendStopCommand
{
    _command = STOP_CMD;
    [self connect];
}

-(void)sendOnCommand
{
    _command = ON_CMD;
    [self sendCommand:ON_CMD];
}

-(void)sendOffCommand
{
    _command = OFF_CMD;
    [self sendCommand:OFF_CMD];
}

-(void)sendStopCommand
{}
//
//-(void)resetTimerWithInterval:(float)newInterval data:(NSData *)newData
//{
//    [self stopMonitoringTimer];
//    
//    self.interval = newInterval;
//    self.data = newData;
//    
//    [self startMonitoringTimer];
//}
//
//#pragma mark - private methods
//-(void)startMonitoringTimer
//{
//    if (self.monitoringTimer) {
//        if ([_monitoringTimer isValid]) {
//            [_monitoringTimer invalidate];
//        }
//    }
//    
//    self.monitoringTimer = [NSTimer scheduledTimerWithTimeInterval:_interval target:self selector:@selector(monitor) userInfo:nil repeats:YES];
//    
//    [self send];
//}
//
//-(void) stopMonitoringTimer
//{
//    if (self.monitoringTimer) {
//        if ([_monitoringTimer isValid]) {
//            [_monitoringTimer invalidate];
//        }
//    }
//    self.monitoringTimer = nil;
//}
//
//-(void)monitor
//{
////    [self send];
//    [self read];
//    [self.peripheral readRSSI];
//}
//
//-(void)send
//{
//    if (!_data) {
//        return;
//    }
//    
//    unsigned char byte[1];
//    [_data getBytes:&byte length:1];
//    
//    NSLog(@"send .. %i", byte[0]);
//    [self.peripheral writeValue:_data forCharacteristic:_characteristic1 type:CBCharacteristicWriteWithResponse];
//}
//
//-(void)read
//{
//    [_peripheral readValueForCharacteristic:_characteristic2];
//}
//
-(void)sendCommand:(COMMAND)command
{
    NSData* data = [NSData dataWithBytes:&command length:1];
    [self.peripheral writeValue:data forCharacteristic:self.characteristic1 type:CBCharacteristicWriteWithoutResponse];
}
@end
