//
//  Item.h
//  BorderCompare
//
//  Created by Charles Grier on 5/19/14.
//  Copyright (c) 2014 com.charlesgrier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *fromUnit;
@property(nonatomic, copy) NSString *toUnit;

@property(nonatomic, copy) Item *item;

-(void)toggleUnits;

@property (nonatomic) NSNumber *price;
@end
