//
// Created by Sechko Artem Sergeevich on 29/07/15.
// Copyright (c) 2015 FTC. All rights reserved.
//


#import "FTCTextEntryEditingInputFilter.h"


@class MoneyType;


@interface CaneIntegralMoneyAmountEntryEditingInputFilter : NSObject<FTCTextEntryEditingInputFilter>

@property (nonatomic, strong) MoneyType *maxMoneyAmount;

- (instancetype)init;

@end