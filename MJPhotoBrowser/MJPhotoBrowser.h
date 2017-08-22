//
//  MJPhotoBrowser.h
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.

#import <UIKit/UIKit.h>

@protocol MJPhotoBrowserDelegate;
@interface MJPhotoBrowser : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak) id<MJPhotoBrowserDelegate> delegate;// 代理

@property (nonatomic, strong) NSArray *photos;// 所有的图片对象

@property (nonatomic, assign) NSUInteger currentPhotoIndex;// 当前展示的图片索引

// 显示
- (void)show;

@end

@protocol MJPhotoBrowserDelegate <NSObject>
@optional
// 切换到某一页图片
- (void)photoBrowser:(MJPhotoBrowser *)photoBrowser didChangedToPageAtIndex:(NSUInteger)index;

@end