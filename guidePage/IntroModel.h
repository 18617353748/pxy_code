#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IntroModel : NSObject

@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSString *descriptionText;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic,assign) NSInteger goodsId;
@property (nonatomic,copy) NSString *goodsname;

- (id) initWithTitle:(NSString*)title description:(NSString*)desc image:(NSString*)imageText;
- (id) initWithImage:(NSString*)title description:(NSString*)desc image:(UIImage *)myimage;

@end
