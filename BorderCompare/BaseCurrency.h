//
//  BaseCurrency.h
//  BorderCompare
//
//  Created by Charles Grier on 6/15/14.
//  Copyright (c) 2014 com.charlesgrier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseCurrency : NSObject

@property (nonatomic, copy) NSString *fromFullName;
@property (nonatomic, copy) NSString *fromCodeName;

@property (nonatomic, copy) NSString *toFullName;
@property (nonatomic, copy) NSString *toCodeName;

@property (nonatomic, copy) NSString *imageName;

@property float rate;
@property float inverseRate;
@property (nonatomic, copy) NSString *oldRateToUSD;
@property float oldRateFromUSD;

@property (nonatomic, assign) BOOL *checked;

-(void)toggleCurrency;

@end
