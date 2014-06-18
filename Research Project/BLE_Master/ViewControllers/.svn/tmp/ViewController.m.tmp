//
//  ViewController.m
//  BLE_Master
//
//  Created by samthui7 on 4/25/13.
//  Copyright (c) 2013 samthui7. All rights reserved.
//

#import "ViewController.h"

#import "BLEDiscoveryHelper.h"

#import "Device.h"

#import "Utilities.h"

#import "DeviceViewController.h"

@interface ViewController ()

@property (nonatomic, retain) IBOutlet UITableView* devicesTable;

@end

@implementation ViewController

@synthesize devicesTable = _devicesTable;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    BLEDiscoveryHelper* centralBLEHelper = [BLEDiscoveryHelper sharedInstance];
    UIBarButtonItem* reScanBtn = [[UIBarButtonItem alloc] initWithTitle:@"Scan" style:UIBarButtonItemStyleBordered target:centralBLEHelper action:@selector(reScan)];
    [self.navigationItem setRightBarButtonItem:reScanBtn];
    [reScanBtn release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate
{
    return NO;
}

#pragma mark - UITableView
-(int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numb = 0;
    
    BLEDiscoveryHelper* centralBLEHelper = [BLEDiscoveryHelper sharedInstance];
    numb = centralBLEHelper.discoveredDeviceList.count;
    
    return numb;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellID = @"deviceCellID";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
    }
    
    BLEDiscoveryHelper* centralBLEHelper = [BLEDiscoveryHelper sharedInstance];
    Device* device = (Device*)[centralBLEHelper.discoveredDeviceList objectAtIndex:indexPath.row];
    
    NSString* deviceUUID = [Utilities UUIDofPeripheral:device.peripheral];
    [cell.textLabel setText:deviceUUID];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BLEDiscoveryHelper* centralBLEHelper = [BLEDiscoveryHelper sharedInstance];
    Device* device = (Device*)[centralBLEHelper.discoveredDeviceList objectAtIndex:indexPath.row];
    
    [device connect];
    
    //push view
    DeviceViewController* deviceVC = [[DeviceViewController alloc] initWithNibName:@"DeviceViewController" bundle:nil ownerIndex:indexPath.row];    
    [self.navigationController pushViewController:deviceVC animated:YES];
}

#pragma mark - public methods
-(void)reloadList
{
    [self.devicesTable reloadData];
}

@end
