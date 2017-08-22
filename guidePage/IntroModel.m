#import "IntroModel.h"
#import "UIImage+MultiFormat.h"
//#import "NetWork.h"
@implementation IntroModel

@synthesize titleText;
@synthesize descriptionText;
@synthesize image;
@synthesize goodsId;
@synthesize goodsname;

- (id) initWithTitle:(NSString*)title description:(NSString*)desc image:(NSString*)imageText {
    self = [super init];
    if(self != nil) {
        titleText = title;
        descriptionText = desc;
        image = [UIImage imageNamed:@"default"];
        //-update me
        NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:imageText]];
        if (data && data.length>0) {
            image = [UIImage sd_imageWithData:data];
        }
        //-end update me
    }
    return self;
}

- (id) initWithImage:(NSString*)title description:(NSString*)desc image:(UIImage *)myimage{
    self = [super init];
    if(self != nil) {
        titleText = title;
        descriptionText = desc;
        image = myimage;
    }
    return self;
}

@end
