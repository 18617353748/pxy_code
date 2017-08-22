#import <UIKit/UIKit.h>
#import "IntroModel.h"

@interface IntroView : UIButton
@property(nonatomic,strong) IntroModel *model;
- (id)initWithFrame:(CGRect)frame model:(IntroModel*)model;
@end
