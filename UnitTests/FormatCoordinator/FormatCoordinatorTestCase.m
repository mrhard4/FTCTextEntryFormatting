// Copyright (c) 2017 CFT
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

@import XCTest;
@import FTCTextEntryFormatting;

@interface FormattingCoordinatorTestCase : XCTestCase
@end

@implementation FormattingCoordinatorTestCase
{
	FTCTextEntryFormatCoordinator *coordinator;
}

- (void)setUp
{
	[super setUp];

	coordinator = [[FTCTextEntryFormatCoordinator alloc] init];
}

- (void)tearDown
{
	[super tearDown];
}

- (void)test_set_nil_rawValue
{
	coordinator.rawValue = nil;
	
	XCTAssert( nil == coordinator.rawValue );
}

- (void)test_set_empty_rawValue
{
	[self checkRawValueAfterSetRawValue:@""];
}

- (void)test_set_not_empty_rawValue
{
	[self checkRawValueAfterSetRawValue:@"value"];
}

- (void)test_formattedValue_for_nil_rawValue
{
	[self checkFormattedValue:@"" afterSetRawValue:nil];
}

- (void)test_empty_formattedValue
{
	[self checkFormattedValue:@"" afterSetRawValue:@""];
}

- (void)test_not_empty_formattedValue
{
	[self checkFormattedValue:@"value" afterSetRawValue:@"value"];
}

- (void)test_append_data_to_nil_rawValue
{
	NSString *replacement = @"value";
	NSString *etalonRawValue = @"value";
	
	coordinator.rawValue = nil;
	
	[coordinator beginEditing];
	
	[coordinator userReplacedInFormattedValueSubstringAtRange:NSMakeRange(0, 0) withString:replacement];
	
	[coordinator endEditing];
	
	XCTAssertEqualObjects(etalonRawValue, coordinator.rawValue);
}

- (void)test_insert_to_rawValue
{
	[self checkRawValue:@"1value2"
	  replaceInRawValue:@"12"
	            atRange:NSMakeRange(1, 0)
	    withReplacement:@"value"];
}

- (void)test_replace_in_rawValue
{
	[self checkRawValue:@"1aaaa2"
	  replaceInRawValue:@"1value2"
	            atRange:NSMakeRange(1, 5)
	    withReplacement:@"aaaa"];
}

- (void)test_remove_in_rawValue
{
	[self checkRawValue:@"12"
	  replaceInRawValue:@"1value2"
	            atRange:NSMakeRange(1, 5)
	    withReplacement:@""];
}

- (void)test_insert_to_formattedValue
{
	[self checkFormattedValue:@"1value2"
	        replaceInRawValue:@"12"
	                  atRange:NSMakeRange(1, 0)
	          withReplacement:@"value"];
}

- (void)test_replace_in_formattedValue
{
	[self checkFormattedValue:@"1aaaa2"
	        replaceInRawValue:@"1value2"
	                  atRange:NSMakeRange(1, 5)
	          withReplacement:@"aaaa"];
}

- (void)test_remove_in_formattedValue
{
	[self checkFormattedValue:@"12"
	        replaceInRawValue:@"1value2"
	                  atRange:NSMakeRange(1, 5)
	          withReplacement:@""];
}

- (void)test_selection
{
	NSString *rawValue = @"1value2";
	NSRange range = NSMakeRange(1, 5);
	NSString *replacement = @"aaaa";
	NSRange etalonSelection = NSMakeRange(5, 0);

	[self doReplaceInRawValue:rawValue atRange:range withReplacement:replacement];
	
	XCTAssert( NSEqualRanges(etalonSelection, coordinator.currentSelectionRangeInFormattedValue) );
}

// MARK: Helpers

- (void)checkRawValueAfterSetRawValue:(NSString *)rawValue
{
	coordinator.rawValue = rawValue;
	
	XCTAssertEqualObjects(rawValue, coordinator.rawValue);
}

- (void)checkFormattedValue:(NSString *)etalonFormattedValue afterSetRawValue:(NSString *)rawValue
{
	coordinator.rawValue = rawValue;
	
	XCTAssertEqualObjects(etalonFormattedValue, coordinator.formattedValue);
}

- (void)checkRawValue:(NSString *)etalonRawValue
    replaceInRawValue:(NSString *)rawValue
              atRange:(NSRange)range
      withReplacement:(NSString *)replacement
{
	[self doReplaceInRawValue:rawValue atRange:range withReplacement:replacement];
	
	XCTAssertEqualObjects(etalonRawValue, coordinator.rawValue,
	                      @"\n resultRawValue: '%@'\n etalonRawValue: '%@'\n rawValue: '%@'\n range: '%@'\n replacement: '%@'",
	                      coordinator.rawValue, etalonRawValue, rawValue, NSStringFromRange(range), replacement);
}

- (void)checkFormattedValue:(NSString *)etalonFormattedValue
          replaceInRawValue:(NSString *)rawValue
                    atRange:(NSRange)range
            withReplacement:(NSString *)replacement
{
	[self doReplaceInRawValue:rawValue atRange:range withReplacement:replacement];
	
	XCTAssertEqualObjects(etalonFormattedValue, coordinator.formattedValue,
	                      @"\n formattedValue: '%@'\n etalonFormattedValue: '%@'\n rawValue: '%@'\n range: '%@'\n replacement: '%@'",
	                      coordinator.formattedValue, etalonFormattedValue, rawValue, NSStringFromRange(range), replacement);
}

- (void)doReplaceInRawValue:(NSString *)rawValue atRange:(NSRange)range withReplacement:(NSString *)replacement
{
	coordinator.rawValue = rawValue;
	
	[coordinator beginEditing];
	
	[coordinator userReplacedInFormattedValueSubstringAtRange:range withString:replacement];
	
	[coordinator endEditing];
}

@end
