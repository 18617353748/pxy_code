//
//  DYCAddressPickerView.m
//  DYCPickView
//
//  Created by DYC on 15/9/10.
//  Copyright (c) 2015年 DYC. All rights reserved.
//
#import "Address.h"
#import "DYCAddressPickerView.h"
@interface DYCAddressPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong,nonatomic) NSMutableArray *provinceArray;
@property (strong,nonatomic) NSMutableArray *cityArray;
@property (strong,nonatomic) NSMutableArray *countyArray;
@property (strong,nonatomic) Address *province;
@property (strong,nonatomic) Address *city;
@property (strong,nonatomic) Address *county;
//@property (strong,nonatomic) NSArray *addressArray;
@end

@implementation DYCAddressPickerView
-(instancetype)initWithFrame:(CGRect)frame withAddressArray:(NSArray *)addressArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor whiteColor];
        if (addressArray.count) {
            _provinceArray = [NSMutableArray arrayWithArray:addressArray];
            _province = _provinceArray[0];
            if (_province.sonAddress.count) {
                _cityArray = [NSMutableArray arrayWithArray:_province.sonAddress];
                _city =_cityArray[0];
                if (_city.sonAddress.count) {
                    _countyArray = [NSMutableArray arrayWithArray:_city.sonAddress];
                    _county = _countyArray[0];
                }
                else
                {
                    NSLog(@"init DYCPickerView with unavliable addressArray;please check out and make sure addressArray is valid.sonAddress in sonAddress is unvalid.");
                }
            }
            else
            {
                NSLog(@"init DYCPickerView with unavliable addressArray;please check out and make sure addressArray is valid.sonAddress is unvalid.");
            }
        }
        else
        {
            NSLog(@"init DYCPickerView with unavliable addressArray;please check out and make sure addressArray is valid.");
        }
        
        
        
    }
    return self;
}

-(void)setData:(NSArray *)addressArray andStart:(NSInteger)index1 and:(NSInteger)index2 and:(NSInteger)index3{
    
    if (addressArray.count) {
        _provinceArray = [NSMutableArray arrayWithArray:addressArray];
        _province = _provinceArray[index1];
        if (_province.sonAddress.count) {
            _cityArray = [NSMutableArray arrayWithArray:_province.sonAddress];
            _city =_cityArray[index2];
            if (_city.sonAddress.count) {
                _countyArray = [NSMutableArray arrayWithArray:_city.sonAddress];
                _county = _countyArray[index3];
            }
            else
            {
                NSLog(@"init DYCPickerView with unavliable addressArray;please check out and make sure addressArray is valid.sonAddress in sonAddress is unvalid.");
            }
        }
        else
        {
            NSLog(@"init DYCPickerView with unavliable addressArray;please check out and make sure addressArray is valid.sonAddress is unvalid.");
        }
    }
    else
    {
        NSLog(@"init DYCPickerView with unavliable addressArray;please check out and make sure addressArray is valid.");
    }
    if (_DYCDelegate && [_DYCDelegate respondsToSelector:@selector(selectAddressProvince:andCity:andCounty:)]) {
        [_DYCDelegate selectAddressProvince:_province andCity:_city andCounty:_county];
    }
    
    [self reloadAllComponents];//先load 再选择
    [self selectRow:index1 inComponent:0 animated:YES];
    //[self reloadComponent:0];
    [self selectRow:index2 inComponent:1 animated:YES];
    //[self reloadComponent:1];
    [self selectRow:index3 inComponent:2 animated:YES];
    //[self reloadComponent:2];
    
    
    
}

-(void)setData:(NSArray *)addressArray province:(NSString *)province andCity:(NSString *)city andCounty:(NSString *)county{
    
    
    //设置默认值
    NSInteger p_index = 0,c_index=0,count_index=0;
    for (int i=0; i<addressArray.count; i++) {//这是查找省
        Address *areaAddress  = (Address *)addressArray[i];
        NSString *addessStr = areaAddress.name;
        if ([addessStr isEqualToString:province]) {
            p_index = i;
            NSArray *temp =areaAddress.sonAddress;
            for (int j = 0; j<temp.count; j++) {//查找市
                Address *cityAddress  = (Address *)temp[j];
                NSString *cityStr = cityAddress.name;
                if ([cityStr isEqualToString:city]) {
                    c_index = j;
                    NSArray *temp = cityAddress.sonAddress;
                    for ( int k = 0; k<temp.count; k++) {//查找区
                        Address *countAddress  = (Address *)temp[k];
                        NSString *countStr = countAddress.name;
                        if ([countStr isEqualToString:county]) {
                            count_index = k;
                            break;
                        }
                    }
                    break;
                }
                
            }
            break;
        }
    }
    
    if (addressArray.count) {
        _provinceArray = [NSMutableArray arrayWithArray:addressArray];
        _province = _provinceArray[p_index];
        if (_province.sonAddress.count) {
            _cityArray = [NSMutableArray arrayWithArray:_province.sonAddress];
            _city =_cityArray[c_index];
            if (_city.sonAddress.count) {
                _countyArray = [NSMutableArray arrayWithArray:_city.sonAddress];
                _county = _countyArray[count_index];
            }
            else
            {
                NSLog(@"init DYCPickerView with unavliable addressArray;please check out and make sure addressArray is valid.sonAddress in sonAddress is unvalid.");
            }
        }
        else
        {
            NSLog(@"init DYCPickerView with unavliable addressArray;please check out and make sure addressArray is valid.sonAddress is unvalid.");
        }
    }
    else
    {
        NSLog(@"init DYCPickerView with unavliable addressArray;please check out and make sure addressArray is valid.");
    }
    if (_DYCDelegate && [_DYCDelegate respondsToSelector:@selector(selectAddressProvince:andCity:andCounty:)]) {
        [_DYCDelegate selectAddressProvince:_province andCity:_city andCounty:_county];
    }
    
    [self reloadAllComponents];//先load 再选择
    [self selectRow:p_index inComponent:0 animated:YES];
    //[self reloadComponent:0];
    [self selectRow:c_index inComponent:1 animated:YES];
    //[self reloadComponent:1];
    [self selectRow:count_index inComponent:2 animated:YES];
    //[self reloadComponent:2];
    
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger count = 0;
    switch (component) {
        case 0:
            count = _provinceArray.count;
            break;
        case 1:
            count = _cityArray.count;
            break;
        case 2:
            count = _countyArray.count;
            break;
        default:
            break;
    }
    return count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *str = @"";
    Address *address;
    switch (component) {
        case 0:
        {
            address = _provinceArray[row];
            str = address.name;
        }
            break;
        case 1:
        {
            address = _cityArray[row];
            str = address.name;
        }
            break;
        case 2:
        {
            address = _countyArray[row];
            str = address.name;
        }
            break;
        default:
            break;
    }
    return str;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
        {
            _province = _provinceArray[row];
            if (_province.sonAddress.count) {
                _cityArray = [NSMutableArray arrayWithArray:_province.sonAddress];
                _city = _cityArray[0];
                [self reloadComponent:1];
                [self selectRow:0 inComponent:1 animated:YES];
                if (_city.sonAddress.count) {
                    _countyArray = [NSMutableArray arrayWithArray:_city.sonAddress];
                    _county = _countyArray[0];
                    [self reloadComponent:2];
                    [self selectRow:0 inComponent:2 animated:YES];
                }
                else
                {
                    NSLog(@"county index at component %d row %d is unvalid",(int)component,(int)row);
                    Address *cityAddress = [[Address alloc] init];
                    cityAddress.areaId = 0;
                    cityAddress.parentId  = 0;
                    cityAddress.name = @"";
                    _county = cityAddress ;
                    _countyArray = [NSMutableArray arrayWithArray:@[]];
                    [self reloadComponent:2];
                    [self selectRow:0 inComponent:2 animated:YES];
                    
                }
            }
            else
            {
                NSLog(@"city index at component %d row %d is unvalid",(int)component,(int)row);
            }
            
        }
            break;
        case 1:
        {
            _city = _cityArray[row];
            if (_city.sonAddress.count) {
                _countyArray = [NSMutableArray arrayWithArray:_city.sonAddress];
                _county = _countyArray[0];
                [self reloadComponent:2];
                [self selectRow:0 inComponent:2 animated:YES];
            }
            else
            {
                NSLog(@"county index at component %d row %d is unvalid",(int)component,(int)row);
                Address *cityAddress = [[Address alloc] init];
                cityAddress.areaId = 0;
                cityAddress.parentId  = 0;
                cityAddress.name = @"";
                _county = cityAddress ;
                _countyArray = [NSMutableArray arrayWithArray:@[]];
                [self reloadComponent:2];
                [self selectRow:0 inComponent:2 animated:YES];
            }
        }
            break;
        case 2:
        {
            if (_countyArray && _countyArray.count>0) {
                _county = _countyArray[row];
            }else{
                _county = [[Address alloc] init];
            }
            
        }
            break;
        default:
            break;
    }
    [_DYCDelegate selectAddressProvince:_province andCity:_city andCounty:_county];
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.font = [UIFont systemFontOfSize:14];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}


@end
