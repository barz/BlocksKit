//
//  UITextField+BlocksKit.m
//  BlocksKit
//
//  Created by Samuel E. Giddins on 7/24/13.
//  Copyright (c) 2013 Pandamonia LLC. All rights reserved.
//

#import "UITextField+BlocksKit.h"

#pragma mark Delegate

@interface A2DynamicUITextFieldDelegate : A2DynamicDelegate

@end

@implementation A2DynamicUITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	BOOL ret = YES;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
		ret = [realDelegate textFieldShouldBeginEditing:textField];
	BOOL (^block)(UITextField *) = [self blockImplementationForMethod:_cmd];
	if (block)
		ret &= block(textField);
	return ret;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
		[realDelegate textFieldDidBeginEditing:textField];
	void (^block)(UITextField *) = [self blockImplementationForMethod:_cmd];
	if (block)
		block(textField);
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
	BOOL ret = YES;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
		ret = [realDelegate textFieldShouldEndEditing:textField];
	BOOL (^block)(UITextField *) = [self blockImplementationForMethod:_cmd];
	if (block)
		ret &= block(textField);
	return ret;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(textFieldDidEndEditing:)])
		[realDelegate textFieldDidEndEditing:textField];
	void (^block)(UITextField *) = [self blockImplementationForMethod:_cmd];
	if (block)
		block(textField);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	BOOL ret = YES;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
		ret = [realDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
	BOOL (^block)(UITextField *, NSRange, NSString *) = [self blockImplementationForMethod:_cmd];
	if (block)
		ret &= block(textField, range, string);
	return ret;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
	BOOL ret = YES;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(textFieldShouldClear:)])
		ret = [realDelegate textFieldShouldClear:textField];
	BOOL (^block)(UITextField *) = [self blockImplementationForMethod:_cmd];
	if (block)
		ret &= block(textField);
	return ret;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	BOOL ret = YES;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(textFieldShouldReturn:)])
		ret = [realDelegate textFieldShouldReturn:textField];
	BOOL (^block)(UITextField *) = [self blockImplementationForMethod:_cmd];
	if (block)
		ret &= block(textField);
	return ret;
}

@end

#pragma mark - Category

@implementation UITextField (BlocksKit)

@dynamic shouldBeginEditingBlock, didBeginEditingBlock, shouldEndEditingBlock, didEndEditingBlock, shouldChangeCharactersInRangeWithReplacementStringBlock, shouldClearBlock, shouldReturnBlock;

+ (void)load {
	@autoreleasepool {
		[self registerDynamicDelegate];
		[self linkDelegateMethods: @{
		 @"shouldBeginEditingBlock": @"textFieldShouldBeginEditing:",
		 @"didBeginEditingBlock": @"textFieldDidBeginEditing:",
		 @"shouldEndEditingBlock": @"textFieldShouldEndEditing:",
		 @"didEndEditingBlock" : @"textFieldDidEndEditing:",
		 @"shouldChangeCharactersInRangeWithReplacementStringBlock" : @"textField:shouldChangeCharactersInRange:replacementString:",
		 @"shouldClearBlock" : @"textFieldShouldClear:",
		 @"shouldReturnBlock" : @"textFieldShouldReturn:",
		 }];
	}
}

@end
