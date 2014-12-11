//
//  JZJSON.h
//  CEIBS
//
//  Created by wiscom on 11-11-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define isNilNull(obj)   (!obj || [obj isEqual:[NSNull null]])
#define isNotNull(obj)   (![obj isEqual:[NSNull null]])

//如果obj是nil、null或@""，则返回nil
#define NonEmpty(obj)	 ((obj == nil || [obj isEqual:[NSNull null]] || [obj isEqual:@""]) ? nil : obj)

@interface JZJSON : NSObject {
}
@property(nonatomic,assign) BOOL		state;			// 返回子数据是否成功
@property(nonatomic,assign) BOOL		status;		// session是否失效
@property(nonatomic,retain) NSString	*data;		// 有效的数据内容
@property(nonatomic,retain) NSString	*message;		// 返回的提示信息
+(JZJSON *)jzjsonFromData:(NSData *)data;

-(BOOL)isSuccessful;
-(NSString *)description;
@end


#pragma mark -
//用于即时通讯
@interface BLIMMessage : NSObject
/*消息类型
 当from为非102用户时, 1-文字2-图片3-音频4-视频
 当from为102用户时, 1-新评论提醒2-新粉丝提醒
 */
@property(nonatomic,retain) NSString	*type;
/* 消息内容
 当from为非102用户时
	type=1时message为消息具体文字内容
	type=2,3,4时message为文件下载链接
 当from为102用户时
	type=1时为新评论提醒显示的内容
	type=2时为新粉丝提醒message为空串
 */
@property(nonatomic,retain) NSString	*message;
/* 相关跳转信息
 当from为非102用户时, 此字段暂时无用
 当from为102用户时
	type=1时此字段为帖子ID
	type=2时此字段无用
 */
@property(nonatomic,retain) NSString	*strurl;

@property(nonatomic,retain) NSString	*longitude;	//经度
@property(nonatomic,retain) NSString	*latitude;	//纬度

@property(nonatomic,retain) NSString	*timestamp;	//时间戳

+(BLIMMessage *)imMessageFromDic:(NSDictionary *)dic;
@end

