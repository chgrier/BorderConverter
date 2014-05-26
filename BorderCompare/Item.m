//
//  Item.m
//  BorderCompare
//
//  Created by Charles Grier on 5/19/14.
//  Copyright (c) 2014 com.charlesgrier. All rights reserved.
//

#import "Item.h"

@implementation Item

-(void)toggleUnits
{
    
    if ([self.fromUnit isEqualToString:@"kg"]) {
        self.fromUnit = @"lb";
        self.toUnit = @"kg";
    }
    
    else if ([self.fromUnit isEqualToString:@"lb"]) {
        self.fromUnit = @"kg";
        self.toUnit = @"lb";
    }
    
}

@end
