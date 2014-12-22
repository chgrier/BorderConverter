//
//  Currency.m
//  BorderCompare
//
//  Created by Charles Grier on 5/7/14.
//  Copyright (c) 2014 com.charlesgrier. All rights reserved.
//

#import "Currency.h"

@implementation Currency

-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super init])){
        self.fromFullName = [aDecoder decodeObjectForKey:@"Name"];
        self.fromCodeName = [aDecoder decodeObjectForKey:@"Code"];
        self.imageName = [aDecoder decodeObjectForKey:@"ImageName"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.fromFullName forKey:@"Name"];
    [aCoder encodeObject:self.fromCodeName forKey:@"Code"];
    [aCoder encodeObject:self.imageName forKey:@"ImageName"];
}

-(void)toggleCurrency{
    
    if (self.fromCodeName != nil ) {
        NSString *oldFromCode = self.fromCodeName;
        self.fromCodeName = self.toCodeName;
        self.toCodeName = oldFromCode;
    
        }

}

@end



