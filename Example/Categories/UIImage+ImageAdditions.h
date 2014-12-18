//
//  UIImage+ImageAdditions.h
//  Egmont
//
//  Created by Suraj Sundar on 11/03/14.
//  Copyright (c) 2014 Tarento India. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageAdditions)

/**
 * @brief This method is used to resize an image according to the size of the Image View it is displayed on
 * @param UIImage, CGSize
 * @return UIImage
 */
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

/**
 * @brief This method is used to crop the center of the Image
 * @param
 * @return UIImage
 */
- (UIImage*)croppedImage;

/**
 * @brief Returns a badge image with given number
 * @param Number the number of the badge
 * @return UIImage
 */
- (UIImage *)badgeWithNumber:(NSUInteger)badgeNumber;

@end
