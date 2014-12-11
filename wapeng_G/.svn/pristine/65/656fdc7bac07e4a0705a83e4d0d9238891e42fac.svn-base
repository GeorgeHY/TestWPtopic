//
//  ViewController.m
//  mapDemo
//
//  Created by iwind on 14-10-21.
//  Copyright (c) 2014年 iwind. All rights reserved.
//

#import "RegisterMapViewController.h"
#import "RegisterVC04.h"
#import "RegisterDataManager.h"
#import "GeocodeAnnotation.h"
#import "CommonUtility.h"
#import "UIView+WhenTappedBlocks.h"
#import "UIViewController+General.h"
#import "ChangeCityVC01.h"
#import "ChageCityItem.h"
@interface RegisterMapViewController ()<UIGestureRecognizerDelegate,UISearchBarDelegate>
{
    AMapSearchAPI *search;
    ReGeocodeAnnotation *reGeocodeAnnotation;
    RegisterDataManager * _dm;
    UITextField * placeText;//常驻地名称
    UITextField * placeSubText;//常住地子名称
    UISearchBar * findSearch;//查询
    NSString * keyFind;//搜索框的内容
    NSUserDefaults * ud;
    NSString * placeName;
    UIView * cover;//遮盖
    NSString * lat;
    NSString * lon;
}

@property (nonatomic, strong) MAMapView *mapView;
/*!
 @brief 当前地图的中心点经纬度坐标，改变该值时，地图缩放级别不会发生变化
 */
@property (nonatomic, assign) CLLocationCoordinate2D centerCoordinate;

//CLLocationDegrees latitude;
//CLLocationDegrees longitude;
//@property (nonatomic, assign) double latitude;
//@property (nonatomic, assign) double longitude;
@end

@implementation RegisterMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initLeftItem];
    
    [self createMapView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNoti:) name:@"changeCity" object:nil];
//     postNotificationName:@"changeCity" object:item];
}


-(void)receiveNoti:(NSNotification *)notify
{
    ChageCityItem * item = notify.object;
    
    self.type = 3;
    
    NSLog(@"%@", item.name);
    
    [self searchGeocode:item.name];
    
}
-(void)navItemClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 如果type = 1 也就是注册模块时候创建按钮
-(void)createNextBtn
{
    UIButton * nextBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame=CGRectMake(20, kMainScreenHeight - 44 - 100, kMainScreenWidth - 40, 40);
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"public_green_btn.png"] forState:UIControlStateNormal];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:nextBtn];
}
#pragma mark - 换个城市
-(void)changeCityClick
{
    ChangeCityVC01 * changeCityVC01 = [[ChangeCityVC01 alloc]init];
    [self.navigationController pushViewController:changeCityVC01 animated:YES];
}

-(void)createMapView
{
    ud=[NSUserDefaults standardUserDefaults];
    
    //搜索条
    findSearch=[[UISearchBar alloc]init];
    findSearch.frame=CGRectMake(10,0,kMainScreenWidth - 20 - 70,30);
    // findSearch.backgroundColor=[UIColor redColor];
    findSearch.delegate=self;
    [self.view addSubview:findSearch];
    
    UIButton * changeCityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changeCityBtn.frame = CGRectMake(CGRectGetMaxX(findSearch.frame) + 5, 0, 60, 30);
//    changeCityBtn.backgroundColor = [UIColor redColor];
    [changeCityBtn setTitle:@"换个城市" forState:UIControlStateNormal];
    
    [changeCityBtn setBackgroundImage:[UIImage imageNamed:@"_0001_button-拷贝"] forState:UIControlStateNormal];
    
    changeCityBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [changeCityBtn addTarget:self action:@selector(changeCityClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeCityBtn];
//    //右边的label
//    placeText=[[UITextField alloc]init];
//    placeText.frame=CGRectMake(20, 0, 140, 30);
//    //placeText.backgroundColor=[UIColor lightGrayColor];
//    placeText.placeholder=@"请填写常住地";
//    placeText.font=[UIFont systemFontOfSize:10];
//    [self.view addSubview:placeText];
//    
//    placeSubText=[[UITextField alloc]init];
//    placeSubText.font=[UIFont systemFontOfSize:10];
//    //placeSubText.backgroundColor=[UIColor lightGrayColor];
//    placeSubText.frame=CGRectMake(20, 30, 280, 20);
//    [self.view addSubview:placeSubText];
    
    _dm=[RegisterDataManager shareInstance];
    [MAMapServices sharedServices].apiKey =@"47f2eda4ae460c721e9fa424c1986bba";
    //    cover=[[UIView alloc]init];
    //    cover.frame=self.mapView.frame;
    //    cover.backgroundColor=[UIColor darkGrayColor];
    //    [self.view addSubview:cover];
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Reduction)];
    [placeText addGestureRecognizer:tap];
    [placeSubText addGestureRecognizer:tap];
    
    self.mapView=[[MAMapView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height)];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
  
    if (self.type==1) {
        self.navigationItem.title=@"常住地设置";
        [self createNextBtn];
    }else{

        self.navigationItem.title=@"";
        //确定按钮
        UIBarButtonItem* done = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(assure)];
        done.tintColor=[UIColor greenColor];
        self.navigationItem.rightBarButtonItem = done;
    }
    
    [self initGestureRecognizer];
    
    search = [[AMapSearchAPI alloc] initWithSearchKey: @"47f2eda4ae460c721e9fa424c1986bba" Delegate:self];
    
    
    
    self.mapView.showsUserLocation = YES; //YES 为打开定位，NO为关闭定位
    //    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    
    
    // NSLog(@"     %@", self.mapView);
    
    
    //[self.mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
    //NSLog(@"lat=%f  lon=%f",self.centerCoordinate.latitude,self.centerCoordinate.longitude);
    
    
    self.mapView.scaleOrigin= CGPointMake(30, 30);    //设置比例尺布局位置
}
-(void)Reduction{
    [findSearch resignFirstResponder];
}

#pragma  mark - 反向传值,用于发布橱窗活动话题等的地理位置
-(void)assure{

     [self.passDelegate sendLon:lon WithLat:lat WithPlaceName:placeName];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark searchBar delegate代理
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    keyFind=findSearch.text;
    [self searchGeocode:keyFind];
    [findSearch resignFirstResponder];
}
-(void)viewWillAppear:(BOOL)animated
{
}
#pragma mark 地理位置编码
- (void)searchGeocode:(NSString *)key
{
    AMapGeocodeSearchRequest *geoRequest = [[AMapGeocodeSearchRequest alloc] init];
    geoRequest.searchType = AMapSearchType_Geocode;
    geoRequest.address = key;
    [search AMapGeocodeSearch: geoRequest];
}
/* 地理编码回调.*/
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    
    [self mapDesc:request response:response];
}
#pragma mark 具体显示
-(void)mapDesc:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    if (response.geocodes.count == 0)
    {
        return;
    }
    
    NSMutableArray *annotations = [NSMutableArray array];
    
    [response.geocodes enumerateObjectsUsingBlock:^(AMapGeocode *obj, NSUInteger idx, BOOL *stop) {
        GeocodeAnnotation *geocodeAnnotation = [[GeocodeAnnotation alloc] initWithGeocode:obj];
        
        [annotations addObject:geocodeAnnotation];
    }];
    
    if (annotations.count == 1)
    {
        [self.mapView setCenterCoordinate:[annotations[0] coordinate] animated:YES];
    }
    else
    {
        [self.mapView setVisibleMapRect:[CommonUtility minMapRectForAnnotations:annotations]
                               animated:YES];
    }
    
    [self.mapView addAnnotations:annotations];
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *t = [touches anyObject];
    
    if (t.view == cover) {
        [self.view bringSubviewToFront:cover];
    } else if (t.view == self.mapView) {
        [self.view bringSubviewToFront:self.mapView];
    }
}
#pragma mark 搜索框开始编辑
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"dads");
    [self.view sendSubviewToBack:self.mapView];
    
}
#pragma mark  点击  下一步  切换视图控制器
-(void)goNext
{
    [self saveData];
    RegisterVC04 *registVC=[[RegisterVC04 alloc]init];
    [self.navigationController pushViewController:registVC animated:YES];
}
#pragma mark定位功能的回调函数
-(void)mapView:(MAMapView*)mapView didUpdateUserLocation:(MAUserLocation*)userLocation
updatingLocation:(BOOL)updatingLocation
{
    self.mapView.showsUserLocation=NO;
    //   NSLog(@" --   lon=%f ---  lat=%f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude);
    
    self.longitude=userLocation.location.coordinate.longitude;
    self.latitude=userLocation.location.coordinate.latitude;
    
    //    _dm.longtitude=[NSString stringWithFormat:@"%f",self.longitude];
    //    _dm.latitude=[NSString stringWithFormat:@"%f",self.latitude];
    //
    //    NSLog(@"_dm   %f     ---%f",_dm.longtitude,_dm.latitude);
    [self searchReGeocode];
    
    
    
}
#pragma mark 搜索框开始编辑
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [self.view bringSubviewToFront:cover];
    return YES;
}
//- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
#pragma mark 逆地理位置编程
- (void)searchReGeocode
{
    CGFloat lon=self.longitude;
    CGFloat lat=self.latitude;
    NSLog(@"lon=%f    lat=%f",lon,lat);
    NSString * weidu=[NSString stringWithFormat:@"%f",lon];
    [ud  setObject:weidu forKey:UD_lon];
    NSString * weiStr= [ud objectForKey:UD_lon];
    NSLog(@"wei=%@",weiStr);
    //    _dm.longtitude=weiStr;
    _dm.latitude=[NSString stringWithFormat:@"%f",lat];
    AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
    regeoRequest.searchType = AMapSearchType_ReGeocode;
    
    regeoRequest.location=[AMapGeoPoint locationWithLatitude:lat longitude:lon];
    regeoRequest.radius = 100;
    regeoRequest.requireExtension = YES;
    [search AMapReGoecodeSearch: regeoRequest];
    
    
    
}
#pragma mark定位
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        //        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        //        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
        //        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
        //        //pre.image = [UIImage imageNamed:@"location.png"];
        //        //greenPin_lift
        //        pre.image = [UIImage imageNamed:@"userlocation.png"];
        //        NSLog(@"test");
        //        pre.showsHeadingIndicator=NO;
        //        pre.lineWidth = 3;
        //        pre.lineDashPattern = @[@6, @3];
        //
        //        [self.mapView updateUserLocationRepresentation:pre];
        
        view.calloutOffset = CGPointMake(0, 0);
    }
    
    //    [self.mapView selectAnnotation:view.annotation animated:YES];
    
    
    
}
#pragma mark 逆地理位置编码回调
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    //移除地图标注功能
    [self.mapView removeAnnotation:reGeocodeAnnotation];
    
    //NSString *result = [NSString stringWithFormat:@"ReGeocode: %@", response.regeocode];
    // NSLog(@"ReGeo: %@", result);
    if (response.regeocode != nil)
    {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(request.location.latitude, request.location.longitude);
        
        reGeocodeAnnotation = [[ReGeocodeAnnotation alloc] initWithCoordinate:coordinate
                                                                    reGeocode:response.regeocode];
        
        [self.mapView addAnnotation:reGeocodeAnnotation];
    }
    
    
    
}

#pragma mark - Initialization  手势
- (void)initGestureRecognizer
{
    NSLog(@"initGestureRecognizer");
    [findSearch resignFirstResponder];
    //长按屏幕，添加大头针
    UILongPressGestureRecognizer *Lpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(LongPressClick:)];
    Lpress.delegate = self;
    Lpress.minimumPressDuration = 1.0;//1.0秒响应方法
    Lpress.allowableMovement = 50.0;
    [self.mapView addGestureRecognizer:Lpress];
    
    /* UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
     action:@selector(handleLongPress:)];
     longPress.delegate = self;
     longPress.minimumPressDuration = 0.5;
     
     [self.view addGestureRecognizer:longPress];
     */
}

#pragma mark 使得长按手势连续执行
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
#pragma mark- 处理手势，给大头针传值
//长按事件响应
-(void)LongPressClick:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        //坐标转换
        
        CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
        
        CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
        
        [self searchReGeocodeWithCoordinate:touchMapCoordinate];
    }
}
#pragma mark 处理长按手势
- (void)handleLongPress:(UILongPressGestureRecognizer *)longPress
{
    NSLog(@"handleLongPress");
    if (longPress.state == UIGestureRecognizerStateBegan)
    {
        
        CLLocationCoordinate2D coordinate = [self.mapView convertPoint:[longPress locationInView:self.view]toCoordinateFromView:self.mapView];
        
        NSString * weidu=[NSString stringWithFormat:@"%f",coordinate.longitude];
        [ud  setObject:weidu forKey:UD_lon];
        _dm.latitude=[NSString stringWithFormat:@"%f",coordinate.latitude];
        NSLog(@"weidu=%@  dm=%@",weidu,_dm.latitude);
        [self searchReGeocodeWithCoordinate:coordinate];
    }
}
#pragma mark 长按手势标注地图
- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"searchReGeocodeWithCoordinate");
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension = YES;
    //regeo.radius = 100;
    regeo.searchType = AMapSearchType_ReGeocode;
    
    //egeoRequest.requireExtension = YES;
    
    [search AMapReGoecodeSearch:regeo];
}




#pragma mark  控制标注,大头针的显示功能,或者是第一次进入定位时候的大头针
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    
    lat=[NSString stringWithFormat:@"%f",annotation.coordinate.latitude];
    lon=[NSString stringWithFormat:@"%f",annotation.coordinate.longitude];
    NSLog(@"datouzhen____lat=%@   lon=%@",lat,lon);
    // NSLog(@"当前的地名是%@",annotation.title);
    //placeText.text=annotation.title;
    NSString *local=[NSString stringWithFormat:@"%@%@",annotation.title,annotation.subtitle];
    
    findSearch.placeholder = [NSString stringWithFormat:@"当前位置:%@", local];
    
    if (self.type == 3) {
        
        findSearch.placeholder = annotation.title;
    }
    
    NSLog(@"%@",local);
    placeText.text=annotation.title;
    placeSubText.text=annotation.subtitle;
    placeName=local;
    _dm.localPlace=[NSString stringWithFormat:@"%@",local];
    if ([annotation isKindOfClass:[ReGeocodeAnnotation class]])
    {
        
        static NSString *invertGeoIdentifier = @"invertGeoIdentifier";
        NSLog(@"viewForAnnotation---");
        MAPinAnnotationView *poiAnnotationView = (MAPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:invertGeoIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:invertGeoIdentifier];
        }
        
        poiAnnotationView.animatesDrop   = YES;
        poiAnnotationView.canShowCallout = YES;
        poiAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        return poiAnnotationView;
    }
    
    return nil;
}
#pragma mark 地图调用失败时候的回调函数
-(void)mapView:(MAMapView*)mapView didFailToLocateUserWithError:(NSError*)error
{
    
    //    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"错误" message:@"请检查网络" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    //    [alert show];
    
    
}
#pragma mark - Life Cycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.type == 3) {
        return;
    }
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    
    //控制比例尺的范围
    [self.mapView setZoomLevel:17.1 animated:YES];
}

#pragma mark - 保存信息， 经纬度和常住地

-(void)saveData
{
    RegisterDataManager * dm = [RegisterDataManager shareInstance];
    //经纬度,常住地
    dm.latitude = lat;
    dm.latitude = lon;
    dm.localPlace = findSearch.text;
}

@end
