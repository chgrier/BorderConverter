//
//  CurrencyPickerViewController.h
//  BorderCompare
//
//  Created by Charles Grier on 5/7/14.
//  Copyright (c) 2014 com.charlesgrier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Currency.h"

@class CurrencyPickerViewController;

@protocol CurrencyPickerViewControllerDelegate <NSObject>

- (void)currencyPicker:(CurrencyPickerViewController *)controller didPickCurrency:(Currency *)currencyCode;

@end

@interface CurrencyPickerViewController : UITableViewController

- (IBAction)cancel:(id)sender;

@property (nonatomic, weak) id <CurrencyPickerViewControllerDelegate> delegate;


@end
