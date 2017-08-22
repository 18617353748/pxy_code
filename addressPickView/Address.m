//
//  Address.m
//  DYCPickView
//
//  Created by DYC on 15/9/10.
//  Copyright (c) 2015年 DYC. All rights reserved.
//

#import "Address.h"

@implementation Address
- (instancetype)init
{
    self = [super init];
    if (self) {
        _sonAddress = [NSMutableArray array];
    }
    return self;
}


/**
 *  将某个对象写入文件时会调用
 *  在这个方法中说清楚哪些属性需要存储
 
 
 @property (assign,nonatomic) NSInteger areaId;
 @property (strong,nonatomic) NSString *name;
 @property (strong,nonatomic) NSString *indexChar;
 @property (assign,nonatomic) NSInteger level;
 @property (assign,nonatomic) NSInteger hot;
 @property (assign,nonatomic) NSInteger commend;
 @property (assign,nonatomic) NSInteger postCode;
 @property (assign,nonatomic) NSInteger parentId;
 @property (assign,nonatomic) NSInteger areaCode;
 @property (assign,nonatomic) NSInteger fatherCode;
 @property (strong,nonatomic) NSMutableArray *sonAddress;
 
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:@(self.areaId) forKey:@"areaId"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.indexChar forKey:@"indexChar"];
    
    [encoder encodeObject:@(self.level) forKey:@"level"];
    [encoder encodeObject:@(self.hot) forKey:@"hot"];
    [encoder encodeObject:@(self.commend) forKey:@"commend"];
    
    [encoder encodeObject:@(self.postCode) forKey:@"postCode"];
    [encoder encodeObject:@(self.parentId) forKey:@"parentId"];
    [encoder encodeObject:@(self.areaCode) forKey:@"areaCode"];
    
    [encoder encodeObject:@(self.fatherCode) forKey:@"fatherCode"];
    [encoder encodeObject:self.sonAddress forKey:@"sonAddress"];
    
    
}

/**
 *  从文件中解析对象时会调用
 *  在这个方法中说清楚哪些属性需要存储
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        // 读取文件的内容
        self.areaId = [[decoder decodeObjectForKey:@"areaId"] integerValue];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.indexChar = [decoder decodeObjectForKey:@"indexChar"];
        
        self.level = [[decoder decodeObjectForKey:@"level"] integerValue];
        self.hot = [[decoder decodeObjectForKey:@"hot"] integerValue];
        self.commend = [[decoder decodeObjectForKey:@"commend"] integerValue];
        
        self.postCode = [[decoder decodeObjectForKey:@"postCode"] integerValue];
        self.parentId = [[decoder decodeObjectForKey:@"parentId"] integerValue];
        self.areaCode = [[decoder decodeObjectForKey:@"areaCode"] integerValue];
        
        self.fatherCode = [[decoder decodeObjectForKey:@"fatherCode"] integerValue];
        self.sonAddress = [decoder decodeObjectForKey:@"sonAddress"];
        
    }
    return self;
}



@end
