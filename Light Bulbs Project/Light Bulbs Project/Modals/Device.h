#import <CoreBluetooth/CoreBluetooth.h>
#import "Constants.h"
//
//@protocol UpdateInfoDeviceDelegate <NSObject>
//
//-(void) didUpdateRSSI:(int)rssi;
//-(void) didUpdateValueForChar2:(NSData*)value;
//-(void) didDisconnect;
//
//@end
//
@interface Device : NSObject <CBPeripheralDelegate>
{
    COMMAND _command;
}

@property (nonatomic, retain) CBPeripheral* peripheral;
@property (nonatomic, retain) CBService* service;
@property (nonatomic, retain) CBCharacteristic* characteristic1;
@property (nonatomic, retain) CBCharacteristic* characteristic2;

//@property (nonatomic, retain) id<UpdateInfoDeviceDelegate> updateInfoDelegate;
//
//@property (nonatomic, assign) float interval;
//@property (nonatomic, retain) NSData* data;
//
//@property (nonatomic, assign) int index;

-(id) initWithPeripheral:(CBPeripheral*)peripheral;
-(void) connect;
-(void) disconnect;

//-(void) resetTimerWithInterval:(float)newInterval data:(NSData*)newData;

-(void)connectToSendOnCommand;
-(void)connectToSendOffCommand;
-(void)connectToSendStopCommand;
-(void)sendOnCommand;
-(void)sendOffCommand;
-(void)sendStopCommand;

@end
