//
// Created by Denis Morozov on 15/05/15.
// Copyright (c) 2015 FTC. All rights reserved.
//



#import "FTCTextEntryEditingInputFilter.h"
#import "FTCTextEntryNotEditingInputFilter.h"


@interface FTCDigitsValueFilter : NSObject<FTCTextEntryEditingInputFilter, FTCTextEntryNotEditingInputFilter>

@property (nonatomic, readonly) NSUInteger maxLength;

- (instancetype)initWithMaxLength:(NSUInteger)length;//set '0' for infinite length

- (instancetype)init NS_UNAVAILABLE;

@end