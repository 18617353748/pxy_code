//
//  DYCAddressPickerView2.h
//  ailibuli
//
//  Created by 爱理不理 on 16/6/17.
//  Copyright © 2016年 广州爱里不理互联网金融信息服务有限公司. All rights reserved.
//
#import "DYCAddressPickerView.h"
#import <UIKit/UIKit.h>

@protocol DYCAddressPickerView2Delegate <NSObject>

@optional
-(void)selectAddressProvince:(Address *)province andCity:(Address *)city andCounty:(Address *)county;
-(void)cancelCitySelect;
-(void)okCitySelect;

@end

@interface DYCAddressPickerView2 : UIView<DYCAddressPickerViewDelegate>

@property(nonatomic,strong) DYCAddressPickerView *mypickaddress;
@property(nonatomic,assign) id<DYCAddressPickerView2Delegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)data;
//需要全屏
@property(nonatomic,strong) UIButton *myRemoveBtn;
-(instancetype)initWithFullFrame:(CGRect)frame withData:(NSArray *)data with:(UIView *)preView;


@end
