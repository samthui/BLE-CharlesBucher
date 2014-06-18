#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#import "Defines.h"


/****************************************************************************/
/*							UI protocols									*/
/****************************************************************************/
@protocol BLEDiscoveryHelperDelegate <NSObject>
- (void) discoveryDidRefresh;
- (void) discoveryStatePoweredOff;

@optional
- (void) updateStickedObjectAtIndex:(int)index;
- (void) didDisconnectUnregisteredObject:(NSString *)UUID;

@end

@interface BLEDiscoveryHelper : NSObject

@property (nonatomic, assign) id <BLEDiscoveryHelperDelegate> BLEDiscoveryHelperDelegate;

extern NSString *kLockingServiceEnteredBackgroundNotification;
extern NSString *kLockingServiceEnteredForegroundNotification;

+ (id) sharedInstance;



/****************************************************************************/
/*								Actions										*/
/****************************************************************************/
//- (void) startScanningForUUIDString:(NSString *)uuidString;
- (void) startScanning;
- (void) stopScanning;
- (void) reScan;

- (void) connectPeripheral:(CBPeripheral *)peripheral;
- (void) disconnectPeripheral:(CBPeripheral *)peripheral;

/****************************************************************************/
/*							Access to the devices							*/
/****************************************************************************/
//new
@property (nonatomic, retain) NSMutableArray* discoveredDeviceList;

@end
