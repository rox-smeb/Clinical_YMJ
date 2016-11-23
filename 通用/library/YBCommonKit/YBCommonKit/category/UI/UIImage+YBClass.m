//
//  UIImage+YBClass.m
//  TestInput
//
//  Created by AnYanbo on 14-6-25.
//  Copyright (c) 2014年 AnYanbo. All rights reserved.
//

#import "UIImage+YBClass.h"

@implementation UIImage (YBClass)

+ (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset
{
    ALAssetRepresentation* assetRep = [asset defaultRepresentation];
    CGImageRef imgRef = [assetRep fullResolutionImage];
    UIImage *img = [UIImage imageWithCGImage:imgRef
                                       scale:assetRep.scale
                                 orientation:(UIImageOrientation)assetRep.orientation];
    return img;
}

+ (UIImage*)imageNamed:(NSString*)name bundleName:(NSString*)bundleName
{
    NSString* bundle = [NSString stringWithFormat:@"%@.bundle", bundleName];
    NSString* bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:bundle];
    NSString* imagePath = [bundlePath stringByAppendingPathComponent:name];
    return [UIImage imageWithContentsOfFile:imagePath];
}

+ (UIImage*)imageWithColor:(UIColor*)color Size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage* colorImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return colorImage;
}

+ (UIImage*)patternImage:(CGRect)frame
{
    /*
     CGCradientCreateWithColorComponents函数需要四个参数：
     
     色彩空间：（Color Space）这是一个色彩范围的容器，类型必须是CGColorSpaceRef.对于这个参数，我们可以传入CGColorSpaceCreateDeviceRGB函数的返回值，它将给我们一个RGB色彩空间。
     
     颜色分量的数组：这个数组必须包含CGFloat类型的红、绿、蓝和alpha值。数组中元素的数量和接下来两个参数密切。从本质来讲，你必须让这个数组包含足够的值，用来指定第四个参数中位置的数量。所以如果你需要两个位置位置（起点和终点），那么你必须为数组提供两种颜色
     
     位置数组，颜色数组中各个颜色的位置：此参数控制该渐变从一种颜色过渡到另一种颜色的速度有多快。
     
     位置的数量：这个参数指明了我们需要多少颜色和位置。
    */
    
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    
    CGFloat colors[] =
    {
        51.0 / 255.0, 160.0 / 255.0, 0.0 / 255.0, 1.00,
        68.0 / 255.0, 198.0 / 255.0, 0.0 / 255.0, 1.00,
    };
    
    CGGradientRef myGradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors) / (sizeof(colors[0]) * 4));
    
    // Allocate bitmap context
    
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, frame.size.width, frame.size.height, 8, 4 * frame.size.width, CGColorSpaceCreateDeviceRGB(), kCGImageAlphaNoneSkipFirst);
    
    // Draw Gradient Here
    /*
     创建好线性渐变后，我们将使用CGContextDrawLinearGradient过程在图形上下文中绘制，此过程需要五个参数：
     
     Graphics context 指定用于绘制线性渐变的图形上下文。
     
     Axial gradient 我们使用CGGradientCreateWithColorComponents函数创建的线性渐变对象的句柄
     
     start point 图形上下文中的一个CGPoint类型的点，表示渐变的起点。
     
     End Point表示渐变的终点。
     
     Gradient drawing options 当你的起点或者终点不在图形上下文的边缘内时，指定该如何处理。你可以使用你的开始或结束颜色来填充渐变以外的空间。此参数为以下值之一：KCGGradientDrawsAfterEndLocation扩展整个渐变到渐变的终点之后的所有点 KCGGradientDrawsBeforeStartLocation扩展整个渐变到渐变的起点之前的所有点。0不扩展该渐变。
    */
    
    CGContextDrawLinearGradient(bitmapContext, myGradient, CGPointMake(160.0f, 0.0f), CGPointMake(160.0f, 480), kCGGradientDrawsBeforeStartLocation);
    
    // Create a CGImage from context
    CGImageRef cgImage = CGBitmapContextCreateImage(bitmapContext);
    // Create a UIImage from CGImage
    UIImage *uiImage = [UIImage imageWithCGImage:cgImage];
    
    // Release the CGImage
    CGImageRelease(cgImage);
    // Release the bitmap context
    CGContextRelease(bitmapContext);
    
    return uiImage;
}

- (UIImage*)getLimitImage:(CGSize) size
{
    if (size.width == 0 || size.height == 0)
        return self;
    CGSize imgSize = self.size;
    float scale    = size.height / size.width;
    float imgScale = imgSize.height / imgSize.width;
    float width    = 0.0f;
    float height   = 0.0f;
    
    if (imgScale < scale && imgSize.width > size.width)
    {
        width  = size.width;
        height = width * imgScale;
    }
    else if (imgScale > scale && imgSize.height > size.height)
    {
        height = size.height;
        width  = height / imgScale;
    }
    else
    {
        width  = size.width;
        height = size.height;
    }
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [self drawInRect:CGRectMake(0, 0, width, height)];
    UIImage* image= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage*)getClickImage:(CGSize) size
{
    if (size.width == 0 || size.height == 0)
        return self;
    CGSize imgSize = self.size;
    UIImageOrientation orientation = self.imageOrientation;
    CGRect rect;
    if (size.height >= imgSize.height && size.width >= imgSize.width)
    {
        return self;
    }
    else if(size.height >= imgSize.height && size.width < imgSize.width)
    {
        rect = CGRectMake((imgSize.width-size.width)/2, 0, size.width, imgSize.height);
    }
    else if(size.height < imgSize.height && size.width >= imgSize.width)
    {
        rect = CGRectMake(0, (imgSize.height - size.height) / 2, imgSize.width, size.height);
    }
    else
    {
        rect = CGRectMake((imgSize.width - size.width) / 2, (imgSize.height - size.height) / 2, size.width, size.height);
    }
    CGImageRef imgRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    return [UIImage imageWithCGImage:imgRef scale:1 orientation:orientation];
}

- (UIImage *)scaleToSize:(CGSize)size
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIColor*)getPixelColorAtLocation:(CGPoint)point
{
    UIColor* color = nil;
    CGImageRef inImage = self.CGImage;
    // Create off screen bitmap context to draw the image into. Format ARGB is 4 bytes for each pixel: Alpa, Red, Green, Blue
    CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage];
    if (cgctx == NULL)
    {
        return nil;
    }
    
    size_t w = CGImageGetWidth(inImage);
    size_t h = CGImageGetHeight(inImage);
    CGRect rect = {{0,0},{w,h}};
    
    // Draw the image to the bitmap context. Once we draw, the memory
    // allocated for the context for rendering will then contain the
    // raw image data in the specified color space.
    CGContextDrawImage(cgctx, rect, inImage);
    
    // Now we can get a pointer to the image data associated with the bitmap
    // context.
    unsigned char* data = CGBitmapContextGetData(cgctx);
    if (data != NULL)
    {
        //offset locates the pixel in the data from x,y.
        //4 for 4 bytes of data per pixel, w is width of one row of data.
        @try
        {
            int offset = 4*((w*round(point.y))+round(point.x));
            NSLog(@"offset: %d", offset);
            int alpha =  data[offset];
            int red = data[offset+1];
            int green = data[offset+2];
            int blue = data[offset+3];
            NSLog(@"offset: %i colors: RGB A %i %i %i  %i",offset,red,green,blue,alpha);
            color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
        }
        @catch (NSException * e)
        {
            NSLog(@"%@", [e reason]);
        }
        @finally
        {
        }
    }
    // When finished, release the context
    CGContextRelease(cgctx);
    // Free image data memory for the context
    if (data)
    {
        free(data);
    }
    
    return color;
}

- (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef) inImage {
    
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    
    // Get image width, height. We'll use the entire image.
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    
    // Declare the number of bytes per row. Each pixel in the bitmap in this
    // example is represented by 4 bytes; 8 bits each of red, green, blue, and
    // alpha.
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    // Use the generic RGB color space.
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if (colorSpace == NULL)
    {
        fprintf(stderr, "Error allocating color spacen");
        return NULL;
    }
    
    // Allocate memory for image data. This is the destination in memory
    // where any drawing to the bitmap context will be rendered.
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL)
    {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    
    // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
    // per component. Regardless of what the source image format is
    // (CMYK, Grayscale, and so on) it will be converted over to the format
    // specified here by CGBitmapContextCreate.
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,      // bits per component
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedFirst);
    if (context == NULL)
    {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    // Make sure and release colorspace before returning
    CGColorSpaceRelease( colorSpace );
    
    return context;
}

+ (UIImage*)qrCodeWithString:(NSString*)str size:(CGFloat)size
{
    @try
    {
        CIImage* image = [UIImage createQRForString:str];
        return [UIImage createNonInterpolatedUIImageFormCIImage:image withSize:size];
    }
    @catch (NSException *exception)
    {
        return nil;
    }
}

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // create a bitmap image that we'll draw into a bitmap context at the desired size;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // Create an image with the contents of our bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    // Cleanup
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

#pragma mark - QRCodeGenerator

+ (CIImage *)createQRForString:(NSString *)qrString
{
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // Send the image back
    return qrFilter.outputImage;
}

#pragma mark - imageToTransparent

void ProviderReleaseData (void *info, const void *data, size_t size)
{
    if (data != NULL)
    {
        free((void*)data);
    }
}

- (UIImage*)imageTransparentWithRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue
{
    const int imageWidth  = self.size.width;
    const int imageHeight = self.size.height;
    size_t    bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), self.CGImage);
    // traverse pixe
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){
            // change color
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }else{
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // context to image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // release
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

@end