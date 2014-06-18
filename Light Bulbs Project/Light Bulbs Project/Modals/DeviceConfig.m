#import "DeviceConfig.h"

@implementation DeviceConfig

@synthesize UUID = _UUID;
@synthesize name = _name;
@synthesize state = _state;


- (id) initWithCoder: (NSCoder *)coder
{
    self = [[DeviceConfig alloc] init];
    if (self != nil)
    {
        self.UUID = [coder decodeObjectForKey:@"UUID"];
        self.name = [coder decodeObjectForKey:@"name"];
        self.state = [coder decodeIntForKey:@"state"];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_UUID forKey:@"UUID"];
    [aCoder encodeObject:_name forKey:@"name"];    
    [aCoder encodeInt:_state forKey:@"state"];
}

-(void) dealloc
{
    self.UUID = nil;
    
    [super dealloc];
}

@end
