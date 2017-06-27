//
// Created by Denis Morozov on 29/04/15.
// Copyright (c) 2015 FTC. All rights reserved.
//

#import "FTCTextEntryFormatter.h"

@class FTCMobilePhoneFormatterConfig;

NS_ASSUME_NONNULL_BEGIN

@interface FTCMobilePhoneFormatter : NSObject<FTCTextEntryFormatter>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithConfig:(FTCMobilePhoneFormatterConfig *)aConfig;

@end

NS_ASSUME_NONNULL_END