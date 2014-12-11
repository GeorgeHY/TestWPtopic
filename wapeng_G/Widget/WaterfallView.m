//
//  WaterfallView.m
//  if_wapeng
//
//  Created by 早上好 on 14-9-8.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "WaterfallView.h"
#import "Item_AnnAllWaterfall.h"
#import "AnnAllWaterfalllCell.h"
#import "UIView+WhenTappedBlocks.h"
#import "UIColor+AddColor.h"
#import "HMSegmentedControl.h"
#import "HotTopicDetailVC.h"
@implementation WaterfallView
    
//    static const NSUInteger BTN1 = 100;
//    static const NSUInteger BTN2 = 101;
//    static const NSUInteger BTN3 = 102;
//    static const NSUInteger BTN4 = 103;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataLeft = [[NSMutableArray alloc]  init];
        self.dataRight = [[NSMutableArray alloc]  init];
    }
    return self;
}

-(void)createComponent:(NSMutableArray *) data
{
   
    float he1 = 0.0;
    float he2 = 0.0;
    for (int i = 0; i < data.count; i++) {
        Item_AnnAllWaterfall * item = [data  objectAtIndex:i];
        UIImage * image = [UIImage imageNamed:item.imageParh];
        float height = image.size.height;
        if (he2 >= he1) {
            he1 = he1 + height;
            [self.dataLeft addObject:[data objectAtIndex:i]];
        }else{
            he2 = he2 + height;
            [self.dataRight addObject:[data objectAtIndex:i]];
        }
    }
    
    
    self.tableLeft = [[UITableView alloc]  initWithFrame:CGRectMake(0, 0 , self.frame.size.width/2, self.frame.size.height)];

    self.tableRight = [[UITableView alloc]  initWithFrame:CGRectMake(self.frame.size.width/2, 0  , self.frame.size.width/2 , self.frame.size.height)];
    [self addSubview:self.tableLeft];
    [self addSubview:self.tableRight];
    
    [self.tableLeft  setSeparatorStyle:UITableViewCellSeparatorStyleNone];//取消分割线
    [self.tableRight  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableLeft.showsVerticalScrollIndicator = NO;
    self.tableRight.showsVerticalScrollIndicator = NO;
    self.tableLeft.delegate = self;
    self.tableLeft.dataSource = self;
    self.tableRight.delegate = self;
    self.tableRight.dataSource = self;
    
    
    
}
-(void)selectorSegmened:(UIButton *)b{
    
}

-(void)reloadTableData:(NSMutableArray *) data{
    float he1 = 0.0;
    float he2 = 0.0;
    for (int i = 0; i < data.count; i++) {
        Item_AnnAllWaterfall * item = [data  objectAtIndex:i];
        UIImage * image = [UIImage imageNamed:item.imageParh];
        float height = image.size.height;
        if (he2 >= he1) {
            he1 = he1 + height;
            [self.dataLeft addObject:[data objectAtIndex:i]];
        }else{
            he2 = he2 + height;
            [self.dataRight addObject:[data objectAtIndex:i]];
        }
    }
    [self.tableLeft reloadData];
    [self.tableRight reloadData];
}

#pragma mark  Scrollview
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    static CGFloat height;
    
    height = (self.tableLeft.contentSize.height - self.tableRight.contentSize.height) >= 0 ? self.tableLeft.contentSize.height : self.tableRight.contentSize.height;
    CGSize size = self.tableLeft.contentSize;
    size.height = height;
    self.tableLeft.contentSize = size;
    self.tableRight.contentSize = size;
    NSArray * array = @[self.tableLeft, self.tableRight];
    
    for (UIScrollView * s in array) {
        
        if (scrollView != s) {
            
            s.contentOffset = scrollView.contentOffset;
        }
    }
    

}


#pragma mark tableView
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Item_AnnAllWaterfall * item;
    if (tableView == self.tableLeft) {
        item = [self.dataLeft objectAtIndex:indexPath.row];
        UIImage * image = [UIImage imageNamed:item.imageParh];
        float height = image.size.height;
        float lHight = [item lableHight];
        image = nil;
        item = nil;
        return height + lHight + 20 +20+50;
    }else{
        item = [self.dataRight objectAtIndex:indexPath.row];
        UIImage * image = [UIImage imageNamed:item.imageParh];
        float height = image.size.height;
        float lHight = [item lableHight];
        image = nil;
        item = nil;
        return height + lHight + 20 +20+50;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableLeft) {
        return self.dataLeft.count;
    }else{
        return self.dataRight.count;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    AnnAllWaterfalllCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[AnnAllWaterfalllCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }

    Item_AnnAllWaterfall * item;
    if (tableView == self.tableLeft) {
        item = [self.dataLeft objectAtIndex:indexPath.row];
    }else{
        item = [self.dataRight objectAtIndex:indexPath.row];
    }
    UIImage * image = [UIImage imageNamed:item.imageParh];
    float height = item.lableHight;
    [cell  changeImageHight:image.size.height changeTxtHighe:height];
    cell.photo.image = image;
    cell.content.text = item.content;
//    cell.msgCount.text = item.count;
    cell.title.text = item.title;
    cell.time.text = item.time;
    cell.image.image = [UIImage imageNamed:item.imageParh];
    cell.heartCount.text = item.heartCount;

    cell.msgCount.text = item.msgCount;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.SelectRow didSelectRowAtIndexPath];
//    HotTopicDetailVC * hotTop = [[HotTopicDetailVC alloc]
//      init];
//    
//    
//    if (tableView == self.tableLeft) {
//        
//    }else{
//    
//    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
