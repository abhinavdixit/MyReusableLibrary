//
//  UIImage+ImageAdditions.m
//  Egmont
//
//  Created by Suraj Sundar on 11/03/14.
//  Copyright (c) 2014 Tarento India. All rights reserved.
//

#import "UIImage+ImageAdditions.h"

@implementation UIImage (ImageAdditions)

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
	
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
	
    CGFloat targetWidth = newSize.width +150;
    CGFloat targetHeight = newSize.height+60;
	
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
	
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	
    if (CGSizeEqualToSize(imageSize, newSize) == NO) {
		
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
		
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
		
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
		
			// center the image
		
        if (widthFactor < heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.15;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.05;
        }
    }
	
	
		// this is actually the interesting part:
	
    UIGraphicsBeginImageContext(newSize);
	
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
	
    [sourceImage drawInRect:thumbnailRect];
	
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    if(newImage == nil) NSLog(@"could not scale image");
	
	
    return newImage ;
}

- (UIImage*)croppedImage
{
    UIImage *ret = nil;
    
    // This calculates the crop area.
    
    float originalWidth  = self.size.width;
    float originalHeight = self.size.height;
    
    float edge = fminf(originalWidth, originalHeight);
    
    float posX = (originalWidth   - edge) / 2.0f;
    float posY = (originalHeight  - edge) / 2.0f;
    
    
    CGRect cropSquare = CGRectMake(posX, posY,
                                   edge, edge);
    
    
    // This performs the image cropping.
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], cropSquare);
    
    ret = [UIImage imageWithCGImage:imageRef
                              scale:self.scale
                        orientation:self.imageOrientation];
    
    CGImageRelease(imageRef);
    
    return ret;
}

- (UIImage*)badgeWithNumber:(NSUInteger)badgeNumber
{
    if (!badgeNumber) {
        //if 0 then return nil
        return nil;
    }
	// begin a graphics context of sufficient size
    float scale=[[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(self.size, /*opaque*/NO, scale);
    
	// draw original image into the context
	[self drawAtPoint:CGPointZero];
    
	// set stroking color and draw circle
	[[UIColor blueColor] setStroke];
    
	// make circle rect 5 px from border
	CGRect circleRect = CGRectMake(0, 0,
                                   self.size.width,
                                   self.size.height);
    
    // draw circle
    NSString *badgeString = [NSString stringWithFormat:@"%lu",(unsigned long)badgeNumber];
    UIFont *font = [UIFont systemFontOfSize:12.0];
    
    [badgeString drawInRect:circleRect withFont:font lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
	
    
	// make image out of bitmap context
	UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    
	// free the context
	UIGraphicsEndImageContext();
    
	return retImage;
}

@end
