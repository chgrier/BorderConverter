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
        self.fullName = [aDecoder decodeObjectForKey:@"Name"];
        self.codeName = [aDecoder decodeObjectForKey:@"Code"];
        self.imageName = [aDecoder decodeObjectForKey:@"ImageName"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.fullName forKey:@"Name"];
    [aCoder encodeObject:self.codeName forKey:@"Code"];
    [aCoder encodeObject:self.imageName forKey:@"ImageName"];
}


@end



