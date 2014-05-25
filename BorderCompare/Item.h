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
@property(nonatomic, copy) NSString *unitMetric;
@property(nonatomic, copy) NSString *unitImperial;

//@property (nonatomic) float price;

@property (nonatomic) NSNumber *price;
@end
