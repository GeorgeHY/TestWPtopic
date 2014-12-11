//
//  JZJSON.m
//  CEIBS
//
//  Created by wiscom on 11-11-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "JZJSON.h"


@implementation JZJSON
@synthesize state=_state, status=_status, data=_data, message=_message;



+(JZJSON *)jzjsonFromData:(NSData *)data;
{
	if (data == nil) 
	{
		return nil;
	}
	NSString *string = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	if (!isNilNull(string)) 
	{
		NSDictionary *dic = [string JSONValue];
		if (!isNilNull(dic)) 
		{
			NSDictionary *json = [dic objectForKey:@"json"];
			if (!isNilNull(json)) 
			{
				JZJSON *ajzjson = [[JZJSON alloc] init];
				
				NSString *value = nil;
				
				value = [json objectForKey:@"state"];
				ajzjson.state = [value isEqual:@"1"];
				
				value = [json objectForKey:@"status"];
				ajzjson.status = [value boolValue];
				
				value = [json objectForKey:@"msg"];
				if (isNotNull(value)) 
				{
					ajzjson.message = [NSString stringWithFormat:@"%@", value];
				}
				
				NSString *sdata = [json objectForKey:@"data"];
				if (!isNilNull(sdata)) 
				{
					ajzjson.data = sdata;
				}
				return [ajzjson autorelease];
			}
		}
	}
	return nil;
}

- (id)init 
{
    self = [super init];
    if (self) 
	{
		_message = @"";
    }
    return self;
}
-(void)setMessage:(NSString *)message
{
	if (message == nil) 
	{
		_message = @"";
	}
	else
	{
		[_message release];
		_message = [message retain];
	}
}
-(BOOL)isSuccessful
{
	return _state && _status;
}
-(NSString *)description
{
	NSString *string = [NSString stringWithFormat:@"\n state : %@", (_state ? @"1" : @"0")];
	string = [string stringByAppendingFormat:@"   status : %@", (_status ? @"1" : @"0")];
	string = [string stringByAppendingFormat:@"\n msg : %@", _message];
	string = [string stringByAppendingFormat:@"\n data : %@", _data];
	return string;
}
- (void)dealloc
{
    [_data release];
	[_message release];
    [super dealloc];
}
@end


#pragma mark -
@implementation BLIMMessage
@synthesize type, message, strurl, longitude, latitude, timestamp;
+(BLIMMessage *)imMessageFromDic:(NSDictionary *)dic
{
	if (dic == nil) {
		return nil;
	}
	BLIMMessage *object = [[[BLIMMessage alloc] init] autorelease];
	NSString *value = nil;
	
	value = [dic objectForKey:@"type"];
	if (!isNilNull(value)) {
		object.type = value;
	}
	
	value = [dic objectForKey:@"message"];
	if (!isNilNull(value)) {
		object.message = value;
	}
	
	value = [dic objectForKey:@"url"];
	if (!isNilNull(value)) {
		object.strurl = value;
	}
	
	value = [dic objectForKey:@"longitude"];
	if (!isNilNull(value)) {
		object.longitude = value;
	}
	
	value = [dic objectForKey:@"latitude"];
	if (!isNilNull(value)) {
		object.latitude = value;
	}
	
	value = [dic objectForKey:@"timestamp"];
	if (!isNilNull(value)) {
		object.timestamp = value;
	}
	
	return object;
}
- (void)dealloc
{
	[type release];
    [message release];
	[strurl release];
	[longitude release];
	[latitude release];
	[timestamp release];
    [super dealloc];
}
@end

