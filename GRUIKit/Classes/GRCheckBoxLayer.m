//
//  GRCheckBoxLayer.m
//  GRUIKit
//
//  Created by Grant Robinson on 5/22/15.
//  Copyright (c) 2015 Grant Robinson. All rights reserved.
//

#import "GRCheckBoxLayer.h"

@interface GRCheckBoxLayer ()
{
	CAShapeLayer *checkbox;
	CAShapeLayer *circle;
}

@end

@implementation GRCheckBoxLayer

@synthesize checked = _checked, highlighted;

+ (BOOL)needsDisplayForKey:(NSString *)key {
	static dispatch_once_t onceToken;
	static NSSet<NSString *> *lookup;
	dispatch_once(&onceToken, ^{
		lookup = [NSSet setWithArray:@[
			@"tintColor",
			@"checked",
			@"strokeFactor",
			@"insetFactor",
			@"markInsetFactor",
			@"fillColor",
			@"checkmarkColor",
			@"circleColor",
			@"circleLineWidth"
		]];
	});
	if ([lookup containsObject:key]) {
		return YES;
	}
	return [super needsDisplayForKey:key];
}

- (instancetype)init {
	
	self = [super init];
	
	if (self) {
		_checked = NO;
		
		_strokeFactor = 0.07;
		_insetFactor = 0.17;
		_markInsetFactor = 0.34;
		_circleLineWidth = 1.0;
		_circleCornerRadius = 0.0;
		_circleColor = [UIColor lightGrayColor];
		_fillColor = [UIColor lightGrayColor];
		circle = [CAShapeLayer layer];
		checkbox = [CAShapeLayer layer];
		[self addSublayer:circle];
		[self addSublayer:checkbox];
	}
	
	return self;
}

- (void) setBounds:(CGRect)bounds {
	[super setBounds:bounds];
	[self setupLayers];
}

- (void) layoutSublayers {
	[super layoutSublayers];
	[self setupLayers];
}

- (void) setupLayers {
	const CGFloat size = MIN(self.bounds.size.width, self.bounds.size.height);
	
	
	CGRect circleRect = CGRectMake(0, 0, self.bounds.size.width - (_circleLineWidth * 2), self.bounds.size.height - (_circleLineWidth * 2));
	UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:circleRect cornerRadius:_circleCornerRadius > 0 ? _circleCornerRadius : circleRect.size.width/2.0];
	circle.bounds = [circlePath bounds];
	circle.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
	circle.strokeColor = self.circleColor.CGColor;
	circle.path = circlePath.CGPath;
	circle.lineWidth = _circleLineWidth;
	
	const CGFloat strokeWidth = self.strokeFactor * size;
	
	CGRect checkmarkRect = CGRectZero;
	
	if (CGSizeEqualToSize(_checkmarkSize, CGSizeZero) == true) {
		_checkmarkSize = self.bounds.size;
		checkmarkRect = CGRectMake(0, 0, _checkmarkSize.width, _checkmarkSize.height);
	}
	else {
		checkmarkRect = CGRectMake(CGRectGetMidX(self.bounds) - (_checkmarkSize.width/2.0), CGRectGetMidY(self.bounds) - (_checkmarkSize.height/2.0), _checkmarkSize.width, _checkmarkSize.height);
	}
	checkbox.frame = checkmarkRect;
	
	checkmarkRect = checkbox.bounds;
	
	UIBezierPath *path = [UIBezierPath bezierPath];
	[path moveToPoint:CGPointMake(CGRectGetMinX(checkmarkRect), checkmarkRect.origin.y + (checkmarkRect.size.height/2.0))];
	[path addLineToPoint:CGPointMake(checkmarkRect.origin.x + (checkmarkRect.size.width/3.0), CGRectGetMaxY(checkmarkRect))];
	[path addLineToPoint:CGPointMake(CGRectGetMaxX(checkmarkRect), CGRectGetMinY(checkmarkRect))];
	
	checkbox.path = path.CGPath;
	checkbox.lineWidth = strokeWidth;
	checkbox.strokeColor = self.checkmarkColor.CGColor;
	checkbox.fillColor = [UIColor clearColor].CGColor;

	if (self.isChecked) {
		checkbox.hidden = NO;
		circle.fillColor = self.fillColor.CGColor;
		
	}
	else {
		circle.fillColor = nil;
		checkbox.hidden = YES;
	}
}

- (void) setChecked:(BOOL)checked animated:(BOOL)animated {
	self.checked = checked;
	if (animated) {
		CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
		pathAnimation.duration = 0.25;
		pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
		pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
		[checkbox addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
	}
}

- (void)setChecked:(BOOL)checked {
	if (_checked != checked) {
		_checked = checked;
		if (_checked) {
			checkbox.hidden = NO;
			circle.fillColor = self.highlighted ? _highlightColor.CGColor : self.fillColor.CGColor;
		}
		else {
			circle.fillColor = self.highlighted ? _highlightColor.CGColor : nil;
			checkbox.hidden = YES;
		}
		[self setNeedsDisplay];
	}
}

- (BOOL)isChecked {
	return _checked;
}

- (void) setCheckmarkSize:(CGSize)checkmarkSize {
	[self willChangeValueForKey:@"checkmarkSize"];
	_checkmarkSize = checkmarkSize;
	[self didChangeValueForKey:@"checkmarkSize"];
	[self setupLayers];
	[self setNeedsDisplay];
}

- (void) setCircleLineWidth:(CGFloat)circleLineWidth {
	[self willChangeValueForKey:@"circleLineWidth"];
	_circleLineWidth = circleLineWidth;
	[self didChangeValueForKey:@"circleLineWidth"];
	circle.lineWidth = _circleLineWidth;
}

- (void) setCircleColor:(UIColor *)circleColor {
	[self willChangeValueForKey:@"circleColor"];
	_circleColor = circleColor;
	[self didChangeValueForKey:@"circleColor"];
	circle.strokeColor = _circleColor.CGColor;
}

- (void) setStrokeFactor:(CGFloat)strokeFactor {
	[self willChangeValueForKey:@"strokeFactor"];
	_strokeFactor = strokeFactor;
	[self didChangeValueForKey:@"strokeFactor"];
	checkbox.lineWidth = _strokeFactor * (MIN(self.bounds.size.width, self.bounds.size.height));
}

- (void) setCheckmarkColor:(UIColor *)checkmarkColor {
	_checkmarkColor = checkmarkColor;
	checkbox.strokeColor = _checkmarkColor.CGColor;
}

- (void) setFillColor:(UIColor *)fillColor {
	_fillColor = fillColor;
	if (_checked) {
		circle.fillColor = _fillColor.CGColor;
	}
}

- (void) setHighlightColor:(UIColor *)highlightColor {
	_highlightColor = highlightColor;
	if (self.highlighted) {
		circle.fillColor = _highlightColor.CGColor;
	}
}

- (void) setHighlighted:(BOOL)_highlighted {
	if (highlighted != _highlighted) {
		highlighted = _highlighted;
		if (highlighted) {
			circle.fillColor = _highlightColor.CGColor;
		}
		else {
			circle.fillColor = _checked ? self.fillColor.CGColor : nil;
		}
	}
}


@end
