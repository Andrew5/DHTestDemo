//
//  CIFilterDemoViewController.m
//  testSingature
//
//  Created by jabraknight on 2021/11/6.
//  Copyright © 2021 zk. All rights reserved.
//

#import "CIFilterDemoViewController.h"
#import <Accelerate/Accelerate.h>

typedef enum
{
    ///旧色调
    SepiaTone =0,
    
    ///模糊设置
    GaussianBlur,
    
}Stype;

@interface CIFilterDemoViewController ()
@property(nonatomic,retain)UISlider * slider;
@property(nonatomic,retain)UISegmentedControl * segmentControl;
@property(nonatomic,assign)Stype type;
@property(nonatomic,retain)UIImageView * imgView;
@property(nonatomic,retain)UIImage * image;
@property(nonatomic,retain)UIImageView * imageView;

@end

@implementation CIFilterDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view.
    [self setupui];
}
- (void)setupui{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20,30,280, 20)];
    label.backgroundColor = [UIColor cyanColor];
    label.text =@"先选中按钮，再拖动滑块即可达到想要的效果";
    label.numberOfLines =0;
    label.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:label];
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(50,50,200, 40)];
    _slider.maximumValue =1.0;
    _slider.minimumValue =0;
    _slider.continuous =YES;
    [_slider addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
    
    _segmentControl = [[UISegmentedControl alloc]initWithFrame:CGRectMake(100,80,120, 40)];
    //    _segmentControl.segmentedControlStyle = UISegmentedControlStyleBar;
    [_segmentControl insertSegmentWithTitle:@"旧色调"atIndex:0 animated:YES];
    [_segmentControl insertSegmentWithTitle:@"模糊设置"atIndex:1 animated:YES];
    [_segmentControl addTarget:self action:@selector(ButtonAction)forControlEvents:UIControlEventValueChanged];
    _segmentControl.selectedSegmentIndex = 0;
    [self.view addSubview:_segmentControl];
    _image = [UIImage imageNamed:@"123123123"];
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20,150,_image.size.width,_image.size.height)];
    _imageView.layer.borderColor  = UIColor.redColor.CGColor;
    _imageView.layer.borderWidth  = 0.5;
    [_imageView setImage:_image];
    [self.view addSubview:_imageView];
    
}
- (void)valueChange{
    switch (self.type) {
        case SepiaTone:
        {
            //旧色调
            [self filterSepiaTone];
        }
            break;
            
        default:
        {
            //模糊设置
            [self filterGaussianBlur];
        }
            break;
    }
    
}
- (void)ButtonAction{
    switch (_segmentControl.selectedSegmentIndex) {
        case 0:
        {
            self.type = SepiaTone;//旧色调
        }
            break;
            
        default:
        {
            self.type = GaussianBlur;//模糊设置
        }
            break;
    }
}
//旧色调处理
-(void)filterSepiaTone
{
    //创建CIContext对象(默认值，传入nil)
    CIContext * context = [CIContext contextWithOptions:nil];
    //获取图片
    CIImage * cimage = [CIImage imageWithCGImage:[_imageView.image CGImage]];
    //创建CIFilter
    CIFilter * sepiaTone = [CIFilter filterWithName:@"CISepiaTone"];
    //设置滤镜输入参数
    [sepiaTone setValue:cimage forKey:@"inputImage"];
    
    //获取滑块的Value，设置色调强度
    [sepiaTone setValue:[NSNumber numberWithFloat:[_slider value]]forKey:@"inputIntensity"];
    //创建处理后的图片
    CIImage * resultImage = [sepiaTone valueForKey:@"outputImage"];
    CGImageRef imageRef = [context createCGImage:resultImage fromRect:CGRectMake(0,0,self.image.size.width,self.image.size.height)];
    UIImage * image = [[UIImage alloc]initWithCGImage:imageRef];
    [_imageView setImage:image];
    CFRelease(imageRef);
}
//模糊设置处理
-(void)filterGaussianBlur
{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{

//    //创建CIContext对象
//    CIContext * context = [CIContext contextWithOptions:nil];
//    //获取图片
//    CIImage * image = [CIImage imageWithCGImage:[_imageView.image CGImage]];
//    //创建CIFilter
//    CIFilter * gaussianBlur = [CIFilter filterWithName:@"CIGaussianBlur"];
//    //设置滤镜输入参数
//    [gaussianBlur setValue:image forKey:@"inputImage"];
//    //设置模糊参数
//    [gaussianBlur setValue:[NSNumber numberWithFloat:_slider.value*10]forKey:@"inputRadius"];
//
//    //得到处理后的图片
//    CIImage* resultImage = [gaussianBlur valueForKey:@"outputImage"];
//    //方法二
//    CGRect frame = [image extent];
//    NSLog(@"%f,%f,%f,%f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
//    CGImageRef imageRef = [context createCGImage: resultImage fromRect:image.extent];
//    UIImage * blurImage = [UIImage imageWithCGImage:imageRef];
//    [_imageView setImage:blurImage];
//    //    CGImageRef imageRef = [context createCGImage:resultImage fromRect:CGRectMake(0,0,self.image.size.width,self.image.size.height)];
//    //    UIImage * imge = [[UIImage alloc]initWithCGImage:imageRef];
//    //    [_imageView setImage:imge];
//    CFRelease(imageRef);
    //方法二
    
    //方法三
    [_imageView setImage:[CIFilterDemoViewController boxblurImage:_image withBlurNumber:_slider.value]];
    //方法三
    
    //方法四
//    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    UIVisualEffectView *view = [[UIVisualEffectView alloc]initWithEffect:beffect];
//    view.frame = _imageView.frame;
//    [self.view addSubview:view];
    //方法四
    
    //方法五
//    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0,0,_image.size.width,_image.size.height)];
//    toolBar.barStyle = UIBarStyleDefault;
//    [_imageView addSubview:toolBar];
    //方法五

    //SKEffectNode
//    });
    
//    CGFloat cornerRadius = 20.0;// 使用角半径的屏幕比例尺来尊重内容比例尺
//    CGFloat screenScale = UIScreen.mainScreen.scale;
//    _photoImageNode.willDisplayNodeContentWithRenderingContext = ^(CGContextRef context, id drawParameters) {
//        CGRect bounds = CGContextGetClipBoundingBox(context);
//        CGFloat半径=角Radius *屏幕缩放;
//        //特征收集
//        UIImage *overlay = [UIImage as_resizableRoundedImageWithCornerRadius:radius:[UIColor clearColor]fillColor:[UIColor clearColor]:self.primitiveTraitCollection];
////        叠加抽签
//        [InRect:bounds]；
//        [[UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:radius] addClip];
//    };
//    CGFloat cornerRadius = 20.0;
//    _photoImageNode.imageModificationBlock = ASImageNodeRoundBorderModificationBlock(5.0, [UIColor orangeColor]);

    


}
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;

    CGImageRef img = image.CGImage;

    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;

    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);

    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);

    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));

    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");

    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);

    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);

    if (error) {
        NSLog(@"error from convolution %ld", error);
    }

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];

    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);

    free(pixelBuffer);
    CFRelease(inBitmapData);

    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);

    return returnImage;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
