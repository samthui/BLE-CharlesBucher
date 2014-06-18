//
//  DeviceViewController.h
//  BLE_Master
//
//  Created by samthui7 on 4/26/13.
//  Copyright (c) 2013 samthui7. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Device.h"

@interface DeviceViewController : UIViewController <UpdateInfoDeviceDelegate>

@property (nonatomic, retain) IBOutlet UISwitch* c1_bit0_switch;
@property (nonatomic, retain) IBOutlet UISwitch* c1_bit1_switch;
@property (nonatomic, retain) IBOutlet UISwitch* c1_bit2_switch;
@property (nonatomic, retain) IBOutlet UISwitch* c1_bit3_switch;

@property (nonatomic, retain) IBOutlet UISwitch* c2_bit0_switch;
@property (nonatomic, retain) IBOutlet UISwitch* c2_bit1_switch;
@property (nonatomic, retain) IBOutlet UISwitch* c2_bit2_switch;
@property (nonatomic, retain) IBOutlet UISwitch* c2_bit3_switch;

@property (nonatomic, retain) IBOutlet UISlider* adc1_slider;
@property (nonatomic, retain) IBOutlet UISlider* adc2_slider;
@property (nonatomic, retain) IBOutlet UILabel* adc1_label;
@property (nonatomic, retain) IBOutlet UILabel* adc2_label;

@property (nonatomic, retain) IBOutlet UILabel* rssi_label;
@property (nonatomic, retain) IBOutlet UILabel* distance_label;

@property (nonatomic, retain) IBOutlet UIButton* interval_3s_btn;
@property (nonatomic, retain) IBOutlet UIButton* interval_4s_btn;
@property (nonatomic, retain) IBOutlet UIButton* interval_5s_btn;

-(IBAction)selectInterval:(id)sender;
-(IBAction)done:(id)sender;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil ownerIndex:(int) ownerIndex;

@end
