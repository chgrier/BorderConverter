//
//  BaseCurrencyTableViewController.h
//  BorderCompare
//
//  Created by Charles Grier on 6/15/14.
//  Copyright (c) 2014 com.charlesgrier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCurrency.h"

@class BaseCurrencyTableViewController;

@protocol BaseCurrencyTableViewControllerDelegate <NSObject>

- (void)baseCurrencyPicker:(BaseCurrencyTableViewController *)controller didPickBaseCurrency:(BaseCurrency *)baseCurrency;

@end

@interface BaseCurrencyTableViewController : UITableViewController

- (IBAction)cancel:(id)sender;

@property (nonatomic, weak) id <BaseCurrencyTableViewControllerDelegate> delegate;

@end


