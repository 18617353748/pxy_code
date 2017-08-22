//
//  DYCAddress.m
//  DYCPickView
//
//  Created by DYC on 15/9/10.
//  Copyright (c) 2015年 DYC. All rights reserved.
//
#import "Address.h"
#import "DYCAddress.h"
@interface DYCAddress()<NSXMLParserDelegate>
@property (strong,nonatomic) Address *address;
@property (strong,nonatomic) NSMutableArray *array;
@property (nonatomic,strong) NSMutableArray *provinces;
@property (nonatomic,strong) NSMutableArray *citys;
@property (nonatomic,strong) NSMutableArray *areas;
@property (assign,nonatomic) BOOL bAreaId;
@property (assign,nonatomic) BOOL bName;
@property (assign,nonatomic) BOOL bIndexChar;
@property (assign,nonatomic) BOOL bLevel;
@property (assign,nonatomic) BOOL bHot;
@property (assign,nonatomic) BOOL bCommend;
@property (assign,nonatomic) BOOL bPostCode;
@property (assign,nonatomic) BOOL bParentId;
@property (assign,nonatomic) BOOL bAreaCode;
@property (assign,nonatomic) BOOL bFatherCode;
@end
@implementation DYCAddress
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(BOOL)handlerAddress
{
   
    NSString *isHave = [Global unArchiverData:K_ISADDRESS_FLAG];
    if (isHave!=nil && [isHave isEqualToString:@"K_ISADDRESS_FLAG"]) {
        return YES;
    }
    
    _array = [NSMutableArray array];
    
   
    
    //
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"area_json" ofType:@"txt"];
//    NSString *str = [[NSString alloc] initWithContentsOfFile:plistPath encoding:0 error:nil];
//    NSData *mydata = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSError *Error;
    NSString *Data = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"address_json_licaishi" ofType:@"txt"]encoding:NSUTF8StringEncoding error:&Error];// address_json_licaishi area_json
    NSData *mydata = [Data dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *_myJsonData = [NSJSONSerialization JSONObjectWithData:mydata options:kNilOptions error:nil];
    NSDictionary *result = GET_OBJECT_OR_NULL(_myJsonData[@"result"]);
    _provinces = GET_OBJECT_OR_NULL(result[@"provinces"]);
    _citys = GET_OBJECT_OR_NULL(result[@"citys"]);
    _areas = GET_OBJECT_OR_NULL(result[@"areas"]);
    [self setMYArray:nil];
   
    return YES;
    
    //
    
    
    
    
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"SYS_AREA" ofType:@"xml"];
//    NSData *data = [NSData dataWithContentsOfFile:path];
//    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
//    xmlParser.delegate = self;
//    return [xmlParser parse];
    
    
}
-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"start parse");
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"RECORD"]) {
        _address = [[Address alloc] init];
    }
    if ([elementName isEqualToString:@"AREA_ID"]) {
        _bAreaId = YES;
    }
    if ([elementName isEqualToString:@"NAME"]) {
        _bName = YES;
    }
    if ([elementName isEqualToString:@"INDEX_CHAR"]) {
        _bIndexChar = YES;
    }
    if ([elementName isEqualToString:@"LEVEL"]) {
        _bLevel = YES;
    }
    if ([elementName isEqualToString:@"HOT"]) {
        _bHot = YES;
    }
    if ([elementName isEqualToString:@"COMMEND"]) {
        _bCommend = YES;
    }
    if ([elementName isEqualToString:@"POST_CODE"]) {
        _bPostCode = YES;
    }
    if ([elementName isEqualToString:@"PARENT_ID"]) {
        _bParentId = YES;
    }
    if ([elementName isEqualToString:@"AREA_CODE"]) {
        _bAreaCode = YES;
    }
    if ([elementName isEqualToString:@"FATHER_CODE"]) {
        _bFatherCode = YES;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    _address.areaId = _bAreaId?[string integerValue]:_address.areaId;
    _address.name = _bName?string:_address.name;
    _address.indexChar = _bIndexChar?string:_address.indexChar;
    _address.level = _bLevel?[string integerValue]:_address.level;
    _address.hot = _bLevel?[string integerValue]:_address.hot;
    _address.commend = _bCommend?[string integerValue]:_address.commend;
    _address.postCode = _bPostCode?[string integerValue]:_address.postCode;
    _address.parentId = _bParentId?[string integerValue]:_address.parentId;
    _address.areaCode = _bAreaCode?[string integerValue]:_address.areaCode;
    _address.fatherCode = _bFatherCode?[string integerValue]:_address.fatherCode;
}

//step 4 ：解析完当前节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"RECORD"]) {
        switch (_address.level) {
            case 2:
            {
                [_array addObject:_address];
            }
                break;
            case 3:
            {
                for (__weak Address *parentAddress in _array) {
                    if (parentAddress.areaId == _address.parentId) {
                        [parentAddress.sonAddress addObject:_address];
                    }
                }
            }
                break;
            case 4:
            {
                for (__weak Address *parentAddress  in _array) {
                    for (__weak Address *grandAddress in parentAddress.sonAddress) {
                        if (grandAddress.areaId == _address.parentId) {
                            [grandAddress.sonAddress addObject:_address];
                        }
                    }
                }
            }
                break;
            default:
                break;
        }
        _address = nil;
    }
    if ([elementName isEqualToString:@"AREA_ID"]) {
        _bAreaId = NO;
    }
    if ([elementName isEqualToString:@"NAME"]) {
        _bName = NO;
    }
    if ([elementName isEqualToString:@"INDEX_CHAR"]) {
        _bIndexChar = NO;
    }
    if ([elementName isEqualToString:@"LEVEL"]) {
        _bLevel = NO;
    }
    if ([elementName isEqualToString:@"HOT"]) {
        _bHot = NO;
    }
    if ([elementName isEqualToString:@"COMMEND"]) {
        _bCommend = NO;
    }
    if ([elementName isEqualToString:@"POST_CODE"]) {
        _bPostCode = NO;
    }
    if ([elementName isEqualToString:@"PARENT_ID"]) {
        _bParentId = NO;
    }
    if ([elementName isEqualToString:@"AREA_CODE"]) {
        _bAreaCode = NO;
    }
    if ([elementName isEqualToString:@"FATHER_CODE"]) {
        _bFatherCode = NO;
    }
}

//step 5；解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if (_dataDelegate) {
        [_dataDelegate addressList:_array];
    }
}
//获取cdata块数据
- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    //    NSLog(@"%@",NSStringFromSelector(_cmd) );
}

#pragma mark - 我来解析
-(void)setMYArray:(NSArray *)provinces{
     Address *address = nil;
    for (int i=0; i<_provinces.count; i++) {//省
        NSDictionary *dict = _provinces[i];
        address = [[Address alloc] init];
        address.areaId = [GET_OBJECT_OR_NULL(dict[@"id"]) integerValue];
        address.parentId  = [GET_OBJECT_OR_NULL(dict[@"pid"]) integerValue];
        address.name = GET_OBJECT_OR_NULL(dict[@"rname"]);
        address.sonAddress = [[NSMutableArray alloc] initWithCapacity:10];
        for (int k = 0; k<_citys.count; k++) {//市
            NSDictionary *temp_city = _citys[k];
            Address *cityAddress = [[Address alloc] init];
            cityAddress.areaId = [GET_OBJECT_OR_NULL(temp_city[@"id"]) integerValue];
            cityAddress.parentId  = [GET_OBJECT_OR_NULL(temp_city[@"pid"]) integerValue];
            cityAddress.name = GET_OBJECT_OR_NULL(temp_city[@"rname"]);
            
            NSInteger pid = [temp_city[@"pid"] integerValue];
            if (pid == address.areaId) {
                cityAddress.sonAddress = [[NSMutableArray alloc] initWithCapacity:10];
                for (int m = 0; m<_areas.count; m++) {//区
                    
                    NSDictionary *area_dict = _areas[m];
                    Address *areaAddress = [[Address alloc] init];
                    areaAddress.areaId = [GET_OBJECT_OR_NULL(area_dict[@"id"]) integerValue];
                    areaAddress.parentId  = [GET_OBJECT_OR_NULL(area_dict[@"pid"]) integerValue];
                    areaAddress.name = GET_OBJECT_OR_NULL(area_dict[@"rname"]);
                    
                    NSInteger areapid = [area_dict[@"pid"] integerValue];
                    if (areapid == cityAddress.areaId) {
                        [cityAddress.sonAddress addObject:areaAddress];
                    }
                }
                [address.sonAddress addObject:cityAddress];
            }
            
        }
        [_array addObject:address];
    }
    [Global archiverData:_array key:K_ADDRESS_DATA];
    [Global archiverData:@"K_ISADDRESS_FLAG" key:K_ISADDRESS_FLAG];
    if (_dataDelegate) {
        [_dataDelegate addressList:_array];
    }
}










/**
 
 
 os开发txt文件转plist文件 [此博文包含视频] (2014-01-09 12:02:43)
 转载
 ▼
	
 
 NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"zujin" ofType:@"txt"];
 
 //gbk编码 如果txt文件为utf-8的则使用NSUTF8StringEncoding
 
 NSStringEncoding gbk = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
 
 //定义字符串接收从txt文件读取的内容
 
 NSString *str = [[NSString alloc] initWithContentsOfFile:plistPath encoding:gbk error:nil];
 
 //将字符串转为nsdata类型
 
 NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
 
 //将nsdata类型转为NSDictionary
 
 NSDictionary *pDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
 
 
 
 NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
 
 NSString *plistPath1 = [paths objectAtIndex:0];
 
 //得到完整的文件名
 
 NSString *filename=[plistPath1 stringByAppendingPathComponent:@"zujin.plist"];
 
 //输入写入
 
 
 
 [pDic writeToFile:filename atomically:YES];
 
 
 ***/

@end
