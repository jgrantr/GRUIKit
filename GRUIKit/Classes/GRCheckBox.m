//
//  GRCheckBox.m
//  GRUIKit
//
//  Created by Grant Robinson on 5/22/15.
//  Copyright (c) 2015 Grant Robinson. All rights reserved.
//

#import "GRCheckBox.h"
#import "GRCheckBoxLayer.h"

@interface GRCheckBox ()

@property (readonly) GRCheckBoxLayer *checkBoxLayer;

@end

@implementation GRCheckBox

#pragma mark - Overrides

+ (Class)layerClass {
	return [GRCheckBoxLayer class];
}

- (void)tintColorDidChange {
	[super tintColorDidChange];
	
	self.checkBoxLayer.tintColor = self.tintColor.CGColor;
}

#pragma mark - Property Overrides

- (void) awakeFromNib {
	[super awakeFromNib];
	[self addTarget:self action:@selector(checkboxTapped:) forControlEvents:UIControlEventTouchUpInside];
	[self.layer setNeedsDisplay];
}

- (void)didMoveToWindow {
	if (self.window != nil) {
		self.contentScaleFactor = self.window.screen.scale;
		[self.layer setNeedsDisplay];
	}
}

- (void)setChecked:(BOOL)checked {
	[self willChangeValueForKey:@"checked"];
	self.checkBoxLayer.checked = checked;
	[self didChangeValueForKey:@"checked"];
}

- (BOOL)isChecked {
	return self.checkBoxLayer.isChecked;
}

- (void)setStrokeFactor:(CGFloat)strokeFactor {
	self.checkBoxLayer.strokeFactor = strokeFactor;
}

- (CGFloat)strokeFactor {
	return self.checkBoxLayer.strokeFactor;
}

- (void)setInsetFactor:(CGFloat)insetFactor {
	self.checkBoxLayer.insetFactor = insetFactor;
}

- (CGFloat)insetFactor {
	return self.insetFactor;
}

- (void)setMarkInsetFactor:(CGFloat)markInsetFactor {
	self.checkBoxLayer.markInsetFactor = markInsetFactor;
}

- (CGFloat)markInsetFactor {
	return self.checkBoxLayer.markInsetFactor;
}

- (void) setCheckmarkSize:(CGSize)checkmarkSize {
	self.checkBoxLayer.checkmarkSize = checkmarkSize;
}

- (CGSize) checkmarkSize {
	return self.checkBoxLayer.checkmarkSize;
}

- (void) setFillColor:(UIColor *)fillColor {
	self.checkBoxLayer.fillColor = fillColor;
}

- (UIColor *) fillColor {
	return self.checkBoxLayer.fillColor;
}

- (void) setCheckmarkColor:(UIColor *)checkmarkColor {
	self.checkBoxLayer.checkmarkColor = checkmarkColor;
}

- (UIColor *) checkmarkColor {
	return self.checkBoxLayer.checkmarkColor;
}

- (void) setCircleColor:(UIColor *)circleColor {
	self.checkBoxLayer.circleColor = circleColor;
}

- (UIColor *) circleColor {
	return self.checkBoxLayer.circleColor;
}

- (void) setCircleLineWidth:(CGFloat)circleLineWidth {
	self.checkBoxLayer.circleLineWidth = circleLineWidth;
}

- (CGFloat) circleLineWidth {
	return self.checkBoxLayer.circleLineWidth;
}

- (void) setCornerRadius:(CGFloat)cornerRadius {
	self.checkBoxLayer.cornerRadius = cornerRadius;
}

- (CGFloat) cornerRadius {
	return self.checkBoxLayer.cornerRadius;
}

- (void) setBorderColor:(UIColor *)borderColor {
	self.checkBoxLayer.borderColor = borderColor.CGColor;
}

- (UIColor *) borderColor {
	return [UIColor colorWithCGColor:self.checkBoxLayer.borderColor];
}

- (void) setBorderWidth:(CGFloat)borderWidth {
	self.checkBoxLayer.borderWidth = borderWidth;
}

- (CGFloat) borderWidth {
	return self.checkBoxLayer.borderWidth;
}

- (void) setHighlightColor:(UIColor *)highlightColor {
	self.checkBoxLayer.highlightColor = highlightColor;
}

- (UIColor *) highlightColor {
	return self.checkBoxLayer.highlightColor;
}

- (void) setChecked:(BOOL)checked animated:(BOOL)animated {
	[self.checkBoxLayer setChecked:checked animated:animated];
}

- (void) setCircleCornerRadius:(CGFloat)circleCornerRadius {
	self.checkBoxLayer.circleCornerRadius = circleCornerRadius;
}

- (CGFloat) circleCornerRadius {
	return self.checkBoxLayer.circleCornerRadius;
}

#pragma mark - Convenience

- (GRCheckBoxLayer *)checkBoxLayer {
	return (GRCheckBoxLayer *)self.layer;
}

#pragma mark - UIControl overrides

- (void) setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
}

- (BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
	[super beginTrackingWithTouch:touch withEvent:event];
	if (self.highlightOnTouch) {
		self.checkBoxLayer.highlighted = YES;
	}
	return YES;
}

- (void) endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
	[super endTrackingWithTouch:touch withEvent:event];
	if (self.highlightOnTouch) {
		self.checkBoxLayer.highlighted = NO;
	}
}

#pragma mark - Action

- (IBAction)checkboxTapped:(id)sender {
	self.checked = !self.checked;
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
