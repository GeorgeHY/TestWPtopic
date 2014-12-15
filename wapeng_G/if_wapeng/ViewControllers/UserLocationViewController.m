//
//  UserLocationViewController.m
//  Category_demo
//
//  Created by songjian on 13-3-21.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "UserLocationViewController.h"
#import "AppDelegate.h"
#import "POIAnnotation.h"
//#import "PoiDetailViewController.h"
#import "CommonUtility.h"
#import "Location.h"


#define GeoPlaceHolder @"名称"
static NSString* cellIdentifier = @"poiCell";
@interface UserLocationViewController () <UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain)UISegmentedControl *showSegment;

@property (nonatomic, retain)UISegmentedControl *modeSegment;

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *displayController;

@property (nonatomic, strong) NSMutableArray *tips;

@property (nonatomic, assign) CLLocationCoordinate2D currentCoor;

@property (nonatomic, strong) UITableView * poiTabelView;

@end

@implementation UserLocationViewController
{
    CLLocationManager * locationManager;
    
}
@synthesize tips = _tips;
@synthesize searchBar = _searchBar;
@synthesize displayController = _displayController;

@synthesize showSegment, modeSegment;


#pragma mark - MAMapViewDelegate

//- (void)mapView:(MAMapView *)mapView didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated
//{
//    self.modeSegment.selectedSegmentIndex = mode;
//}

#pragma mark - Action Handle

//- (void)showsSegmentAction:(UISegmentedControl *)sender
//{
//    self.mapView.showsUserLocation = !sender.selectedSegmentIndex;
//}

//- (void)modeAction:(UISegmentedControl *)sender
//{
//    self.mapView.userTrackingMode = sender.selectedSegmentIndex;
//}

#pragma mark - NSKeyValueObservering

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"showsUserLocation"])
    {
        NSNumber *showsNum = [change objectForKey:NSKeyValueChangeNewKey];
        
        self.showSegment.selectedSegmentIndex = ![showsNum boolValue];
    }
}

#pragma mark - Initialization

- (void)initToolBar
{
    CGRect frame = self.mapView.bounds;
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width-50,frame.size.height-90, 40, 20)];
    [btn setTitle:@"当前位置" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(modeAction) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    [self.mapView addSubview:btn];
}

- (void)modeAction
{
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
}

- (void)initObservers
{
    /* Add observer for showsUserLocation. */
    [self.mapView addObserver:self forKeyPath:@"showsUserLocation" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)returnAction
{
    [super returnAction];
    
    self.mapView.userTrackingMode  = MAUserTrackingModeNone;
    
    [self.mapView removeObserver:self forKeyPath:@"showsUserLocation"];
}

#pragma mark - Life Cycle


-(id)init{
    self = [super init];
    if (self) {
        self.dataSource = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)createPoiTableView
{
    self.poiTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, SearchBarHeight+self.mapView.bounds.size.height, kMainScreenWidth, kMainScreenHeight-SearchBarHeight-self.mapView.bounds.size.height)];
    self.poiTabelView.delegate = self;
    self.poiTabelView.dataSource = self;
    
    [self.poiTabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    ;
    //self.poiTabelView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.poiTabelView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initToolBar];
    
    [self initSearchBar];
    
    [self initSearchDisplay];
    
    [self createPoiTableView];
    
    [self searchPoiByCenterCoordinate];
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AppDelegate * app = [AppDelegate shareInstace];
    app.mTbc.mainView.hidden = YES;

    
    [self initObservers];
}
-(void)viewWillDisappear:(BOOL)animated
{
    AppDelegate * app = [AppDelegate shareInstace];
    app.mTbc.mainView.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    locationManager = [[CLLocationManager alloc]init];
    if ([[[UIDevice currentDevice] systemVersion]floatValue] >= 8.0) {
        [locationManager requestWhenInUseAuthorization];
    }
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    /* 清除存在的annotation. */
    [self.mapView removeAnnotations:self.mapView.annotations];
}


- (void)initSearchBar
{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44)];
    self.searchBar.barStyle     = UIBarStyleDefault;
    self.searchBar.translucent  = YES;
    self.searchBar.delegate     = self;
    self.searchBar.placeholder  = GeoPlaceHolder;
    self.searchBar.keyboardType = UIKeyboardTypeDefault;
    
    [self.view addSubview:self.searchBar];
}

- (void)initSearchDisplay
{
    self.displayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.displayController.delegate                = self;
    self.displayController.searchResultsDataSource = self;
    self.displayController.searchResultsDelegate   = self;
}

-(void) mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
{
    CLLocationCoordinate2D  coor = userLocation.coordinate;
    self.currentCoor = coor;
}
/* 根据中心点坐标来搜周边的POI. */
- (void)searchPoiByCenterCoordinate
{
    AMapPlaceSearchRequest *request = [[AMapPlaceSearchRequest alloc] init];
    
    request.searchType          = AMapSearchType_PlaceAround;
    request.location            = [AMapGeoPoint locationWithLatitude:self.currentCoor.latitude longitude:self.currentCoor.longitude];
    request.keywords            = @"餐饮";
    /* 按照距离排序. */
    request.sortrule            = 1;
    request.requireExtension    = YES;
    
    /* 添加搜索结果过滤 */
    AMapPlaceSearchFilter *filter = [[AMapPlaceSearchFilter alloc] init];
    filter.costFilter = @[@"100", @"200"];
    filter.requireFilter = AMapRequireGroupbuy;
    request.searchFilter = filter;
    
    [self.search AMapPlaceSearch:request];
}

#pragma mark - MAMapViewDelegate

//- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
//{
//    id<MAAnnotation> annotation = view.annotation;
//    
//    if ([annotation isKindOfClass:[POIAnnotation class]])
//    {
//        POIAnnotation *poiAnnotation = (POIAnnotation*)annotation;
//        
//        PoiDetailViewController *detail = [[PoiDetailViewController alloc] init];
//        detail.poi = poiAnnotation.poi;
//        
//        /* 进入POI详情页面. */
//        [self.navigationController pushViewController:detail animated:YES];
//    }
//}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[POIAnnotation class]])
    {
        static NSString *poiIdentifier = @"poiIdentifier";
        MAPinAnnotationView *poiAnnotationView = (MAPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:poiIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:poiIdentifier];
        }
        
        poiAnnotationView.canShowCallout = YES;
        poiAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        return poiAnnotationView;
    }
    
    return nil;
}

#pragma mark - AMapSearchDelegate

/* POI 搜索回调. */
- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)respons
{
    
    
//    if (request.searchType != self.searchType)
//    {
//        return;
//    }
    
    if (respons.pois.count == 0)
    {
        return;
    }
    
    NSMutableArray *poiAnnotations = [NSMutableArray arrayWithCapacity:respons.pois.count];
    __weak UserLocationViewController *weakSelf = self;
    
    [respons.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"~~~~~~~~~~ obj = %@",obj);
        [poiAnnotations addObject:[[POIAnnotation alloc] initWithPOI:obj]];
        Location *location = [[Location alloc]init]; 
        location.name = obj.name;
        location.coor = obj.location;
        [weakSelf.dataSource addObject:location];
        
        
        
    }];
    
    /* 将结果以annotation的形式加载到地图上. */
    [self.mapView addAnnotations:poiAnnotations];
    
    /* 如果只有一个结果，设置其为中心点. */
    if (poiAnnotations.count == 1)
    {
        self.mapView.centerCoordinate = [poiAnnotations[0] coordinate];
    }
    /* 如果有多个结果, 设置地图使所有的annotation都可见. */
    else
    {
        [self.mapView showAnnotations:poiAnnotations animated:NO];
    }
}

#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    Location * location = self.dataSource[indexPath.row];
    cell.textLabel.text = location.name;
    return cell;
    
}

@end
