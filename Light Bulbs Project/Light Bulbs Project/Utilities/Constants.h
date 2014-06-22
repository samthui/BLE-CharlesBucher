#ifndef BLE_Master_Constant_h
#define BLE_Master_Constant_h


#define SERVICE_UUID                @"1812"
#define CHARACTERISTIC_1_UUID       @"FFF1"
#define CHARACTERISTIC_2_UUID       @"FFF2"

//#define ON_CMD 1
//#define OFF_CMD 2
//#define STOP_CMD 3


typedef NS_ENUM(NSInteger, COMMAND) {
	ON_CMD = 0x01,
	OFF_CMD = 0x02,
	STOP_CMD = 0x03,
};

typedef NS_ENUM(NSInteger, RESULT) {
	DONE = 0x01,
	ERROR = 0x02,
};

#define kStopScanTimer  2.0

#define kMinInterval    0.5
#define kMaxInterval    2

#define kMax_ADC_value  2047.0

#define RSSI_1m         -68
#define kDegradeFactor  7.0

#define kStoredDeviceList   @"Stored Device List"

#endif
