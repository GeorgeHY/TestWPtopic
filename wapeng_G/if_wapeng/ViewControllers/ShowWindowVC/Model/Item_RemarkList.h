//
//  Item_RemarkList.h
//  if_wapeng
//
//  Created by 心 猿 on 14-10-21.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item_RemarkList : NSObject

@property (nonatomic, strong) NSString * content;//评论
@property (nonatomic, strong) NSString * petName;
@property (nonatomic, assign) int isButtom;//是否有下一页
@property (nonatomic, strong) NSString * momentID;//对应瞬间的id
@property (nonatomic, strong) NSString * mid;
@property (nonatomic, assign) int userType;//用户类型
@property (nonatomic, strong) NSString * createTime;//创建时间
@property (nonatomic, assign) int recordCount;//有多少条记录
@property (nonatomic, assign) int pageCount;//总共有几页
/**
 *	功能:组装html字符串
 *
 *	@param aString:评论人
 *	@param bString:评内容
 */
-(NSString *)htmlString:(NSString *)aString andBString:(NSString *)bString;

-(CGFloat)height;
@end
