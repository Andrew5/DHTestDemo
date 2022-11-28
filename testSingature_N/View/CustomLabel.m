//
//  CustomLabel.m
//  TextAnimate
//
//  Created by 郭毅 on 2021/2/4.
//

#import "CustomLabel.h"

#import <CoreText/CoreText.h>


@implementation CustomLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _textTransform = CGAffineTransformIdentity;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _textTransform = CGAffineTransformIdentity;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1, -1);

    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)self.font.fontName, self.font.pointSize, NULL);
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                             (__bridge id)fontRef, kCTFontAttributeName,
                             nil];
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:self.text attributes:attrs];
        
    CTLineRef lines = CTLineCreateWithAttributedString((CFAttributedStringRef)attrStr);
    CFArrayRef runArray = CTLineGetGlyphRuns(lines);
    
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++) {
        
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        CGFloat fontSize = CTFontGetSize(runFont);
        
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++) {
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            
            CGContextSetTextMatrix(context, self.textTransform);
            CGContextSetTextPosition(context,
                                     position.x + fontSize,
                                     position.y + fontSize);
            CGPoint zeroPoint = CGPointMake(-fontSize/2, -fontSize/2);
            CTFontDrawGlyphs(runFont, &glyph, &zeroPoint, 1, context);
            
        }
    }

    CFRelease(fontRef);
    CFRelease(lines);
}

#pragma mark - Set

- (void)setTextTransform:(CGAffineTransform)textTransform {
    _textTransform = textTransform;
    [self setNeedsDisplay];
}

- (void)setAngle:(CGFloat)angle {
    _angle = angle;
    [self setNeedsDisplay];
}

#pragma mark - Get

- (UIFont *)font {
    if (!_font) {
        _font = [UIFont systemFontOfSize:10];
    }
    return _font;
}

@end
