//
//  Currency.h
//  BorderCompare
//
//  Created by Charles Grier on 5/7/14.
//  Copyright (c) 2014 com.charlesgrier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Currency : NSObject <NSCoding>

@property (nonatomic, copy) NSString *fullName;
@property (nonatomic, copy) NSString *codeName;

@property (nonatomic, copy) NSString *imageName;

@property float rate;
@property (nonatomic, assign) BOOL *checked;

@end
