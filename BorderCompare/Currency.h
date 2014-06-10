//
//  Currency.h
//  BorderCompare
//
//  Created by Charles Grier on 5/7/14.
//  Copyright (c) 2014 com.charlesgrier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Currency : NSObject <NSCoding>

@property (nonatomic, copy) NSString *fromFullName;
@property (nonatomic, copy) NSString *fromCodeName;

@property (nonatomic, copy) NSString *toFullName;
@property (nonatomic, copy) NSString *toCodeName;

@property (nonatomic, copy) NSString *imageName;

@property float rate;
@property float inverseRate;
@property float oldRateToUSD;
@property float oldRateFromUSD;

@property (nonatomic, assign) BOOL *checked;

-(void)toggleCurrency;

@end
