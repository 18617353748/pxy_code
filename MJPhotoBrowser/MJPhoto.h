//
//  MJPhoto1.h
//  11
//
//  Created by Apple on 15/9/21.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJPhoto : UIView

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) UIImage *image; // 完整的图片

@property (nonatomic, strong) UIImageView *srcImageView; // 来源view
@property (nonatomic, strong, readonly) UIImage *placeholder;
@property (nonatomic, strong, readonly) UIImage *capture;

@property (nonatomic, assign) BOOL firstShow;

// 是否已经保存到相册
@property (nonatomic, assign) BOOL save;
@property (nonatomic, assign) int index; // 索引

@end
