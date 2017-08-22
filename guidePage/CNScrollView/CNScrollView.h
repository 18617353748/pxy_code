//
//  CNScrollView.h
//  CNScrollView-Demo
//
//  Created by mac on 15-3-19.
//  Copyright (c) 2015年 Baby_V5. All rights reserved.
//

#import <UIKit/UIKit.h>




#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

#define kScrollW   _scrollView.frame.size.width
#define kScrollH   _scrollView.frame.size.height


@class ItemsView;
@class CNViewController;


@protocol CNScrollDelegate <NSObject>

@optional
-(void)clickItemView;

@end


@protocol ItemDelegate <NSObject>

@optional
-(void)clickItemView;

@end


@interface CNScrollView : UIView<UIScrollViewDelegate,ItemDelegate>

{

    UIPageControl*pageControl;
    
}

@property(nonatomic,strong)UIScrollView*scrollView;//底层的ScrollView 承载item和做动画用

@property(nonatomic,assign)NSInteger itemsCount;//itemView的个数

@property(nonatomic,strong)NSArray*dataList;//数据

@property(nonatomic,assign) id<CNScrollDelegate> delegate;

-(id)initWithFrame:(CGRect)frame itemCount:(NSInteger)itemCount;



@end



@interface ItemsView : UIView

@property(nonatomic,assign)NSInteger index;//记录当前第几个item

@property(nonatomic,strong)UIImageView*bgImageView;

@property(nonatomic,strong)UIButton*btn;

@property(nonatomic,strong)CNViewController*cnViewController;

@property(nonatomic,assign) id<ItemDelegate> delegate;


@end

@interface CNViewController : UIViewController

{
    ItemsView*item;
}

@property(nonatomic,strong)NSArray*dataList;//

@end


