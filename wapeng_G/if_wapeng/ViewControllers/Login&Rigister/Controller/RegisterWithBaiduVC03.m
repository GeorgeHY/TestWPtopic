////
////  RegisterWithBaiduVC03.m
////  if_wapeng
////
////  Created by 心 猿 on 14-7-28.
////  Copyright (c) 2014年 funeral. All rights reserved.
////
//
//#import "RegisterWithBaiduVC03.h"
//#import "RegisterVC04.h"
//#import "ChangeCityVC01.h"
//#import "AFN_HttpBase.h"
//#import "ChageCityItem.h"
//#import "UIViewController+General.h"
//#import "RegisterDataManager.h"
//@interface RegisterWithBaiduVC03 (){
//    AFN_HttpBase * http;
//    RegisterDataManager * _dm;
//    ChageCityItem * _item;
////    BMKPointAnnotation* pointAnnotation;
////    BMKAnnotationView* newAnnotation;
////    BMKGeoCodeSearch* _geocodesearch;
//    CGPoint point;
//}
//
//@end
//
//@implementation RegisterWithBaiduVC03
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        http = [[AFN_HttpBase alloc]init];
//        self.title = @"常住地设置";
//      
//    }
//    return self;
//}/*
//-(void)viewWillAppear:(BOOL)animated
//{
//    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
//    _geocodesearch.delegate = self;
//    _locService.delegate = self;
//}
//-(void)viewWillDisappear:(BOOL)animated {
//    [_mapView viewWillDisappear];
//    _mapView.delegate = nil; // 不用时，置nil
//    _geocodesearch.delegate = nil;
//    _locService.delegate = nil;
//}*/
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    //创建百度地图等一系列动作
//    
//    _dm = [RegisterDataManager shareInstance];
//    
//    [self initLeftItem];/*
//    [self createBaiduMapView];
//    [self createLoacionServices];*/
//    [http  thirdRequestWithUrl:@"/wpa/wb/mpub/kindergartenAction_getList.action" succeed:^(NSObject *obj, BOOL isFinished) {
//        
//    } failed:^(NSObject *obj, BOOL isFinished) {
//        
//    } andKeyValuePairs:@"string",@"string", nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCityText:) name:@"changeCity" object:nil];
//    
//    UIImage *backImage = [UIImage imageNamed:@"public_back"];
//    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, backImage.size.width, backImage.size.height)];
//    [back setImage:backImage forState:UIControlStateNormal];
//    [back setImage:[UIImage imageNamed:@"public_back_hightLight"] forState:UIControlStateHighlighted];
//    [back addTarget:self action:@selector(navItemClick:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:back];
//    self.navigationItem.leftBarButtonItem = left;
//}
////General
//-(void)navItemClick:(UIButton *)button
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
///*
//-(void)createLoacionServices
//{
//    _locService = [[BMKLocationService alloc]init];
//    NSLog(@"进入普通定位状态");
//    [_locService startUserLocationService];
//    _mapView.showsUserLocation = NO;//先关闭定位图层
//    _mapView.userTrackingMode = BMKUserTrackingModeNone;
//    _mapView.showsUserLocation = YES;
//}
// 
//#pragma mark -- 创建百度地图
//-(void)createBaiduMapView
//{
//    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 120, kMainScreenWidth, kMainScreenHeight - 200)];
//    _mapView.delegate = self;
// 
//    百度地图有17个地图级别{"20m","50m","100m","200m","500m","1km","2km","5km","10km","20km","25km","50km","100km","200km","500km","1000km","2000km"}
//     
//     
//     //但是，提供的开发包只支持16个级别， Level: 3~18, 比例尺如下    {"50m","100m","200m","500m","1km","2km","5km","10km","20km","25km","50km","100km","200km","500km","1000km","2000km"}
// 
//    [_mapView setZoomLevel:18];
//    [self.view addSubview:_mapView];
//    // 添加一个PointAnnotation
//    if (pointAnnotation == nil) {
//        [self addPointAnnotation];
//    }
//    
//    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
//    _geocodesearch.delegate = self;
//    
//    [self addAnnotation];
//}
////初始化大头针
//- (void)addPointAnnotation
//{
//    pointAnnotation = [[BMKPointAnnotation alloc]init];
//    CLLocationCoordinate2D coor;
//    coor.latitude = 139.915;
//    coor.longitude = 16.404;
//    pointAnnotation.coordinate = coor;
//    pointAnnotation.title = @"test";
//    pointAnnotation.subtitle = @"此Annotation可拖拽!";
//    [_mapView addAnnotation:pointAnnotation];
//    
//}
////添加标注手势
//-(void)addAnnotation
//{
//    UILongPressGestureRecognizer * lgr = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
//    [_mapView addGestureRecognizer:lgr];
//}
////手势动作
//-(void)longPress:(UILongPressGestureRecognizer *)gesture
//{
//    if (gesture.state == UIGestureRecognizerStateEnded) {
//        point = [gesture locationInView:_mapView];
//        CLLocationCoordinate2D lc2d = [_mapView convertPoint:point toCoordinateFromView:_mapView];
//        BMKPointAnnotation * annotation = [[BMKPointAnnotation alloc]init];
//        annotation.coordinate = lc2d;
//        annotation.title = @"摸我呀";
//        annotation.subtitle = @"呃呃呃";
//        [_mapView addAnnotation:annotation];
//        pointAnnotation.coordinate = lc2d;
//        pointAnnotation.title = @"摸我呀";
//        pointAnnotation.subtitle = @"100元";
//        [self startHttpRequest:lc2d];
//    }else
//    {
//        return;
//    }
//}
//
//
////开始反向编码
//-(void)startHttpRequest:(CLLocationCoordinate2D)pt
//{
//    NSLog(@"%f-----%f", pt.latitude, pt.longitude);
//    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
//    reverseGeocodeSearchOption.reverseGeoPoint = pt;
//    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
//    //    [reverseGeocodeSearchOption release];
//    if(flag)
//    {
//        NSLog(@"反geo检索发送成功");
//    }
//    else
//    {
//        NSLog(@"反geo检索发送失败");
//    }
//    
//}
////如果通过换个城市也会走这个方法，同样会获得city
//#pragma mark -- BMKGeoCodeSearchDelegate
//-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
//{
//    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
//	[_mapView removeAnnotations:array];
//	array = [NSArray arrayWithArray:_mapView.overlays];
//	[_mapView removeOverlays:array];
//	if (error == 0) {
//		BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
//		item.coordinate = result.location;
//		item.title = result.address;
//		[_mapView addAnnotation:item];
//        _mapView.centerCoordinate = result.location;
//        NSString* titleStr;
//        NSString* showmeg;
//        titleStr = @"反向地理编码";
//        
//        _dm.city =  result.addressDetail.city;
//        showmeg = [NSString stringWithFormat:@"%@",item.title];
//        self.cityTextField.text = showmeg;
//	}
//}
//#pragma mark - BMKMapViewDelegate
//// 根据anntation生成对应的View
//- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
//{
//    NSString *AnnotationViewID = @"renameMark";
//    if (newAnnotation == nil) {
//        newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
//        // 设置颜色
//		((BMKPinAnnotationView*)newAnnotation).pinColor = BMKPinAnnotationColorPurple;
//        // 从天上掉下效果
//		((BMKPinAnnotationView*)newAnnotation).animatesDrop = YES;
//        // 设置可拖拽
//		((BMKPinAnnotationView*)newAnnotation).draggable = YES;
//    }
//    return newAnnotation;
//    
//    
//}
//// 当点击annotation view弹出的泡泡时，调用此接口
//- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
//{
//    NSLog(@"paopaoclick");
//}
//-(void)changeCityText:(NSNotification *)notify
//{
//    _item = notify.object;
//    self.cityString = _item.name;
//    self.cityTextField.text = self.cityString;
//    
//    //重新定位
// 
//     CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(39.915352,116.397105);
// 
//    
//    CLLocationCoordinate2D lc2d = CLLocationCoordinate2DMake(_item.latitude.floatValue, _item.longitude.floatValue);
//    //换个城市并且显示在地图上
//    [self startHttpRequest:lc2d];
//}
//- (IBAction)nextBtnClick:(id)sender {
//
//    if (self.cityTextField && self.cityTextField.text.length == 0) {
//        [SVProgressHUD showSimpleText:dTips_noData];
//        return;
//    }
//    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
//    
//    //保存张常驻地 和经纬度
//    
//    NSString * longtitude = [NSString stringWithFormat:@"%f",pointAnnotation.coordinate.longitude];
//    NSString * latitoude = [NSString stringWithFormat:@"%f", pointAnnotation.coordinate.latitude];
//    
//    _dm.localPlace = self.cityTextField.text;
//    _dm.longtitude = longtitude;
//    _dm.latitude = latitoude;
//    
//    [_dm printfSelf];
//
//    //构造假数据
//    
//    [d setObject:longtitude forKey:UD_account_longitude];
//    [d setObject:latitoude forKey:UD_account_latitude];
//    [d setObject:_item.mid forKey:UD_zoneArea1];//保存城市id
//    [d setObject:_item.sid forKey:UD_zoneArea2];
//    coor.latitude = 139.915;
//    coor.longitude = 16.404;
//    [d setObject:@"139.915" forKey:UD_account_longitude];
//    [d setObject:@"16.404" forKey:UD_account_latitude];
//    [d setObject:@"1" forKey:UD_zoneArea1];//保存城市id
//    [d setObject:@"2" forKey:UD_zoneArea2];
//
//    RegisterVC04 * vc04 = [[RegisterVC04 alloc]initWithNibName:@"RegisterVC04" bundle:nil];
////
//    [self.navigationController pushViewController:vc04 animated:YES];
//}
// 
//
//
////停止定位
//-(void)stopLocationServer:(CLLocationCoordinate2D)lc2d
//{
//    //第一次进入时进行反编码
//    [self startHttpRequest:lc2d];
//    [_locService stopUserLocationService];
//    _mapView.showsUserLocation = NO;
//}
//
//-(void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation{
//    
////    NSLog(@”!latitude!!!  %f”,userLocation.location.coordinate.latitude);//获取经度
////    
////    NSLog(@”!longtitude!!!  %f”,userLocation.location.coordinate.longitude);//获取纬度
//    
//    localLatitude=userLocation.location.coordinate.latitude;//把获取的地理信息记录下来
//    
//    localLongitude=userLocation.location.coordinate.longitude;
//    
//    CLGeocoder *Geocoder=[[CLGeocoder alloc]init];//CLGeocoder用法参加之前博客
//    
//    CLGeocodeCompletionHandler handler = ^(NSArray *place, NSError *error) {
////
//        for (CLPlacemark *placemark in place) {
//            
//            cityStr=placemark.thoroughfare;
//            
//            cityName=placemark.locality;
//            
////            NSLog(@”city %@”,cityStr);//获取街道地址
////            
////            NSLog(@”cityName %@”,cityName);//获取城市名
//            
//            break;
//            
//        }
//
//};
//#pragma mark -- BMKLocationServiceDelegate
//
///**
// *在地图View将要启动定位时，会调Fnext用此函数
// *@param mapView 地图View
// 
//- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
//{
//	NSLog(@"start locate");
//}
//
///**
// *用户方向更新后，会调用此函数
// *@param userLocation 新的用户位置
// 
//- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
//{
//    [_mapView updateLocationData:userLocation];
//    //    NSLog(@"heading is %@",userLocation.heading);
//}
//
///**
// *用户位置更新后，会调用此函数
// *@param userLocation 新的用户位置
// 
//- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
//{
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    [_mapView updateLocationData:userLocation];
//    
//    CLLocationCoordinate2D lc2d;
//    lc2d = userLocation.location.coordinate;
//    [_mapView setCenterCoordinate:lc2d];
//    //定位成功一次后停止定位
//    [self stopLocationServer:lc2d];
//}
//
///**
// *在地图View停止定位后，会调用此函数
// *@param mapView 地图View
// 
//- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
//{
//    NSLog(@"stop locate");
//}
//
///**
// *定位失败后，会调用此函数
// *@param mapView 地图View
// *@param error 错误号，参考CLError.h中定义的错误号
// 
//- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
//{
//    NSLog(@"location error");
//}
//
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [_cityTextField resignFirstResponder];
//}
//#pragma mark - uitextefielddelegate
//
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [_cityTextField resignFirstResponder];
//    return YES;
//}
//
//-(void)navItemClick:(UIButton *)button
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//*/
//
//- (IBAction)nextBtnClick:(id)sender{
//    RegisterVC04 *registVC=[[RegisterVC04 alloc]init];
//    [self.navigationController pushViewController:registVC animated:YES];
//}
//
//- (IBAction)changeCity:(id)sender {
//    
//    ChangeCityVC01 * vc01 = [[ChangeCityVC01 alloc]init];
//    [self.navigationController pushViewController:vc01 animated:YES];
//}
//
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    [_cityTextField resignFirstResponder];
//}
//
//#pragma mark  - 退出键盘
//- (IBAction)editEnd:(id)sender {
//}
//@end
