//
//  DYCAddressPickerView2.m
//  ailibuli
//
//  Created by 爱理不理 on 16/6/17.
//  Copyright © 2016年 广州爱里不理互联网金融信息服务有限公司. All rights reserved.
//

#import "DYCAddressPickerView2.h"

@implementation DYCAddressPickerView2

-(instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)data{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    if (self) {
        
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        CGFloat btn_height = 40.0f;
        CGFloat btn_width = 80.0f;
        
        //添加其他取消，确定按钮
        UIView *myview = [[UIView alloc] initWithFrame:CGRectMake(0, 0,width, btn_height)];
        myview.backgroundColor =[UIColor colorWithHex:0xeaeaea];
        [self addSubview:myview];
        
        
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btn_width, btn_height)];
        [cancelBtn setTitle:NSLocalizedString(@"取消", @"取消") forState:UIControlStateNormal];
        [cancelBtn setTitle:NSLocalizedString(@"取消", @"取消") forState:UIControlStateHighlighted];
        [cancelBtn setTitleColor:[UIColor colorWithHex:0x242424] forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorWithHex:0x242424] forState:UIControlStateHighlighted];
        cancelBtn.titleLabel.font = K_FONT_14;
        [myview addSubview:cancelBtn];
        [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *okBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - btn_width, 0, btn_width, btn_height)];
        [okBtn setTitle:NSLocalizedString(@"确定", @"确定") forState:UIControlStateNormal];
        [okBtn setTitle:NSLocalizedString(@"确定", @"确定") forState:UIControlStateHighlighted];
        [okBtn setTitleColor:[UIColor colorWithHex:0x242424] forState:UIControlStateNormal];
        [okBtn setTitleColor:[UIColor colorWithHex:0x242424] forState:UIControlStateHighlighted];
        okBtn.titleLabel.font = K_FONT_14;
        [myview addSubview:okBtn];
        [okBtn addTarget:self action:@selector(okClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        _mypickaddress = [[DYCAddressPickerView alloc] initWithFrame:CGRectMake(0,myview.frame.size.height + myview.frame.origin.y , width, height) withAddressArray:data];
        _mypickaddress.DYCDelegate = self;
        [self addSubview:_mypickaddress];
        
        
        
        
    }
    return self;
}



-(instancetype)initWithFullFrame:(CGRect)frame withData:(NSArray *)data with:(UIView *)preView{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    if (self) {
        
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        CGFloat btn_height = 40.0f;
        CGFloat btn_width = 80.0f;
        
        
        ////背景按钮
        UIButton *fullBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, K_WIDTH, K_HEIGHT)];
        fullBtn.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.3];
        [fullBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [preView addSubview:fullBtn];
        _myRemoveBtn = fullBtn;
        
        
        //添加其他取消，确定按钮
        UIView *myview = [[UIView alloc] initWithFrame:CGRectMake(0, 0,width, btn_height)];
        myview.backgroundColor =[UIColor colorWithHex:0xeaeaea];
        [self addSubview:myview];
        
        
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btn_width, btn_height)];
        [cancelBtn setTitle:NSLocalizedString(@"取消", @"取消") forState:UIControlStateNormal];
        [cancelBtn setTitle:NSLocalizedString(@"取消", @"取消") forState:UIControlStateHighlighted];
        [cancelBtn setTitleColor:[UIColor colorWithHex:0x242424] forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorWithHex:0x242424] forState:UIControlStateHighlighted];
        cancelBtn.titleLabel.font = K_FONT_14;
        [myview addSubview:cancelBtn];
        [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *okBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - btn_width, 0, btn_width, btn_height)];
        [okBtn setTitle:NSLocalizedString(@"确定", @"确定") forState:UIControlStateNormal];
        [okBtn setTitle:NSLocalizedString(@"确定", @"确定") forState:UIControlStateHighlighted];
        [okBtn setTitleColor:[UIColor colorWithHex:0x242424] forState:UIControlStateNormal];
        [okBtn setTitleColor:[UIColor colorWithHex:0x242424] forState:UIControlStateHighlighted];
        okBtn.titleLabel.font = K_FONT_14;
        [myview addSubview:okBtn];
        [okBtn addTarget:self action:@selector(okClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        _mypickaddress = [[DYCAddressPickerView alloc] initWithFrame:CGRectMake(0,myview.frame.size.height + myview.frame.origin.y , width, height) withAddressArray:data];
        _mypickaddress.DYCDelegate = self;
        [self addSubview:_mypickaddress];
        
        
        ///添加
        [preView addSubview:self];
        
        
    }
    return self;
}


#pragma mark - 事件点击
-(void)cancelClick{
    
    if (_delegate && [_delegate respondsToSelector:@selector(cancelCitySelect)]) {
        [_delegate cancelCitySelect];
    }
    

   
}
-(void)okClick{
    if (_delegate && [_delegate respondsToSelector:@selector(okCitySelect)]) {
        [_delegate okCitySelect];
    }

}

#pragma mark - dyc delegate
-(void)selectAddressProvince:(Address *)province andCity:(Address *)city andCounty:(Address *)county{
    if (_delegate && [_delegate respondsToSelector:@selector(selectAddressProvince:andCity:andCounty:)]) {
        [_delegate selectAddressProvince:province andCity:city andCounty:county];
    }
}

@end
