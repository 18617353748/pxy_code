#import <UIKit/UIKit.h>
#import "IntroView.h"


@protocol IntroControllDelegate <NSObject>

@optional
-(void)clickImage:(IntroView *)model;
-(void)currentIndex:(NSInteger)index;
-(void)currentOffset:(float)offset;

@end

@interface IntroControll : UIView<UIScrollViewDelegate> {
    UIImageView *backgroundImage1;
    UIImageView *backgroundImage2;
    
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    NSArray *pages;
    
    NSTimer *timer;
    
    int currentPhotoNum;
}

@property(assign,nonatomic) id<IntroControllDelegate> delegate;

- (id)initWithFrame:(CGRect)frame pages:(NSArray*)pages;
- (id)initWithFrameNoback:(CGRect)frame pages:(NSArray*)pagesArray;


@end
