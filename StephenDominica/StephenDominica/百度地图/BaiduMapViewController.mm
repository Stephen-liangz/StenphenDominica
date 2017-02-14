//
//  BaiduMapViewController.m
//  StephenDominica
//
//  Created by Mac on 16/6/14.
//  Copyright © 2016年 Mac. All rights reserved.
//

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

#import "BaiduMapViewController.h"

//自定义注释
#import "OSJHBaiduMapAnnotationView.h"

#import "UIImage+Rotate.h"

@interface RouteAnnotation : BMKPointAnnotation
{
    int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
    int _degree;
}

@property (nonatomic) int type;
@property (nonatomic) int degree;
@end
@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end


@interface BaiduMapViewController () <BMKMapViewDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate ,BMKRouteSearchDelegate, BMKRouteSearchDelegate,UITextFieldDelegate>
{
    BMKMapView *_mapView;///<地图view
    UIScrollView *controlView;///<控制面板
    CGFloat controlDefaultHeight;///<控制面板默认高度
    
    UIButton *_mapTypeSwitchBtn;///<地图类型切换按钮
    NSInteger _mapType;
    
    BMKLocationService *_locService;///<定位服务
    BMKGeoCodeSearch *_geocodesearch;///<地理位置编码
    
    BMKRouteSearch* _routesearch;///<路径规划
    
    BMKUserLocation *_userLocation;///<用户当前的百度地图位置信息
    /**
     //导航起始点
     BMKPlanNode 线路检索节点信息,一个路线检索节点可以通过经纬度坐标或城市名加地名确定
     NSString*              _cityName;
     NSString*              _name;
     CLLocationCoordinate2D _pt;
     **/
    BMKPlanNode *_startPlanNode;///<导航的起点
    BMKPlanNode *_endPlanNode;///<导航的终点
}

@end

@implementation BaiduMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"百度地图呀";
    
    self.noSilde = YES;
    
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
    _mapView.delegate = self;
    self.view = _mapView;
    _mapView.showsUserLocation = YES;
    
    //显示比例尺
    _mapView.showMapScaleBar = YES;
    //显示俯视角度
    _mapView.overlooking = -30;
    //自定义比例尺的位置
    _mapView.mapScaleBarPosition = CGPointMake(_mapView.frame.size.width - 70, MainScreenHeight - 38);
    //设置指南针
    [_mapView setCompassPosition:CGPointMake(10, 70)];
    
    //交通
    [_mapView setTrafficEnabled:YES];
    //建筑3D显示
    [_mapView setBuildingsEnabled:YES];
    //热力图
    [_mapView setBaiduHeatMapEnabled:NO];
    
    // 地图比例尺级别，在手机上当前可使用的级别为3-19级
    _mapView.zoomLevel = 12.;
    //地图旋转角度，在手机上当前可使用的范围为－180～180度
    _mapView.rotation = 10;
    //地图俯视角度，在手机上当前可使用的范围为－45～0度
    _mapView.overlooking = -30;
    
    
    //定位功能的初始化
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;//设置代理位self
    //启动LocationService
//    [_locService startUserLocationService];//启动定位服务
    
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    //编码服务的初始化(就是获取经纬度,或者获取地理位置服务)
    _geocodesearch.delegate = self;//设置代理为self
    _mapView.zoomEnabled = YES;
    
    //设置自定义UI
    [self loadUI];
    //地图设置
    [self mapViewSetting];
    
    
    _startPlanNode = [[BMKPlanNode alloc]init];
    _endPlanNode = [[BMKPlanNode alloc]init];
    
   
    
    _startPlanNode.name = @"国际社区";
    _startPlanNode.cityName = @"重庆市";
    
    //路径查询初始化
    _routesearch = [[BMKRouteSearch alloc]init];
    _routesearch.delegate = self;
}

#pragma mark - 百度地图代理设置
- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _routesearch.delegate = self;
    _geocodesearch.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _routesearch.delegate = nil;
    _geocodesearch.delegate = nil;
}


#pragma mark - 自定义UI
- (void)loadUI
{
    UIBarButtonItem* btnWayPoint = [[UIBarButtonItem alloc]init];
    btnWayPoint.target = self;
    btnWayPoint.action = @selector(locationAction);
    btnWayPoint.title = @"定位";
    btnWayPoint.enabled=TRUE;
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = btnWayPoint;
    
    //控制view
    controlDefaultHeight = 45;
    
    controlView = [[UIScrollView alloc]initWithFrame:Rect(0, 0, MainScreenWidth, controlDefaultHeight)];
    controlView.showsVerticalScrollIndicator = NO;
    controlView.showsHorizontalScrollIndicator = NO;
    controlView.backgroundColor = RGB(231, 231, 231);
    [self.view addSubview:controlView];
    
    _mapTypeSwitchBtn = ({
        UIButton *btn = [[UIButton alloc]initWithFrame:Rect(8, 8, 100, 20)];
        [btn setTitle:@"切换地图类型" forState:UIControlStateNormal];
        [btn setTitleColor:RGB(6, 129, 239) forState:UIControlStateNormal];
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn addTarget:self action:@selector(switchMapType) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [controlView addSubview:_mapTypeSwitchBtn];
    //设置地图类型枚举数值
    _mapType = 2;
    
    UIButton* showControlBtn;///< 显示控制面板按钮
    showControlBtn = ({
        UIButton *btn = [[UIButton alloc]initWithFrame:Rect(MainScreenWidth - 108, 8, 100, 20)];
        [btn setTitle:@"显示控制面板" forState:UIControlStateNormal];
        [btn setTitleColor:RGB(6, 129, 239) forState:UIControlStateNormal];
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn addTarget:self action:@selector(showControl) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [controlView addSubview:showControlBtn];
    
    //当前位置label
    UILabel *nowLoctionInfoLab;///<当前位置label tag = 10
    nowLoctionInfoLab = ({
        UILabel *lab = [[UILabel alloc]initWithFrame:Rect(8, showControlBtn.bottom + 12, MainScreenWidth - 16, 40)];
        lab.textColor = RGB(12, 150, 222);
        lab.font = [UIFont systemFontOfSize:16];
        lab.numberOfLines = 0;
        lab.adjustsFontSizeToFitWidth = YES;
        lab.text = @"当前位置信息";
        lab.tag = 10;
        lab.layer.borderColor = [UIColor darkGrayColor].CGColor;
        lab.layer.borderWidth = 1;
        lab;
    });
    [controlView addSubview:nowLoctionInfoLab];
    
    //导航设置
    
    //导航位置信息
    UITextField *startTF =[[UITextField alloc]initWithFrame:Rect(8, nowLoctionInfoLab.bottom + 12, MainScreenWidth - 100, 30)];///<起点TF tag = 11
    startTF.placeholder = @"起始位置";
    startTF.delegate = self;
    startTF.tag = 11;
    startTF.adjustsFontSizeToFitWidth = YES;
    [controlView addSubview:startTF];
    
    UITextField *endTF =[[UITextField alloc]initWithFrame:Rect(8, startTF.bottom + 8, MainScreenWidth - 100, 30)];///<终点TF tag = 12
    endTF.placeholder = @"目标位置";
    endTF.delegate = self;
    endTF.tag = 12;
    startTF.adjustsFontSizeToFitWidth = YES;
    [controlView addSubview:endTF];
    
    //设置导航方式按钮 设置当前位置为起始位置
    UIButton *btn = [[UIButton alloc]initWithFrame:Rect(MainScreenWidth - 88, startTF.top, 80, 30)];///< 设置当前位置为其实位置
    [btn setTitle:@"设置当前位置" forState:UIControlStateNormal];
    [btn setTitleColor:RGB(6, 129, 239) forState:UIControlStateNormal];
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor cyanColor].CGColor;
    btn.tag = 13;
    [btn addTarget:self action:@selector(setLocationForStart) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:btn];
    
    //导航方式按钮
    NSArray *routeArray = @[@"公交",@"驾车",@"步行",@"骑行"];
    CGFloat routeBtnWidth = MainScreenWidth/4;
    
    for (int i = 0; i < routeArray.count; i ++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:Rect(i*routeBtnWidth, endTF.bottom + 12, routeBtnWidth, 30)];
        [btn setTitle:routeArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(6, 129, 239) forState:UIControlStateNormal];
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor cyanColor].CGColor;
        btn.tag = i + 100;
        [btn addTarget:self action:@selector(routeSearch:) forControlEvents:UIControlEventTouchUpInside];
        
        [controlView addSubview:btn];
    }
    
    //MapView UI 设置
    UISwitch *compassSwitch = [[UISwitch alloc]initWithFrame:Rect(8,endTF.bottom + 50 , 60, 30)];
    [compassSwitch addTarget:self action:@selector(compassSwitchAction:) forControlEvents:UIControlEventValueChanged];
    [controlView addSubview:compassSwitch];
    
    //导航按钮
    UIButton *daohangbtn = [[UIButton alloc]initWithFrame:Rect(compassSwitch.right + 20, compassSwitch.top, 80, 30)];///< 设置当前位置为其实位置
    [daohangbtn setTitle:@"开始导航" forState:UIControlStateNormal];
    [daohangbtn setTitleColor:RGB(6, 129, 239) forState:UIControlStateNormal];
    daohangbtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    daohangbtn.titleLabel.font = [UIFont systemFontOfSize:16];
    daohangbtn.layer.borderWidth = 1;
    daohangbtn.layer.borderColor = [UIColor cyanColor].CGColor;
    daohangbtn.tag = 16;
    [daohangbtn addTarget:self action:@selector(openMapDrivingRoute) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:daohangbtn];
    

    //设置control面板的活动范围
    [controlView setContentSize:CGSizeMake(MainScreenWidth, compassSwitch.bottom )];
}


#pragma mark - mapView设置
- (void)mapViewSetting
{
    // 添加一个PointAnnotation  默认注释
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    annotation.coordinate = coor;
    annotation.title = @"这里是北京";
    [_mapView addAnnotation:annotation];
    
//        //添加一个自定义annotation
//        OSJHBaiduMapAnnotation* annotationCustom = [[OSJHBaiduMapAnnotation alloc]initWithAnnotationModelWithDict:@{@"nameStr":@"自定义啊",@"titleStr":@"自定义标题",@"latitute":@"39.91",@"longitude":@"116.404"}];
//    
//        OSJHBaiduMapAnnotationView* annotationViewCustom = [[OSJHBaiduMapAnnotationView alloc]initWithAnnotation:annotationCustom reuseIdentifier:@"annotationCustom"];
//        [_mapView addAnnotation:annotationCustom];
}
#pragma mark - showControl 放大变小控制面板
- (void)locationAction
{
    [_locService startUserLocationService];
}
#pragma mark - showControl 放大变小控制面板
- (void)showControl
{
    if (controlView.height == controlDefaultHeight) {
        [self showControlView];
    }else{
        [self hideControlView];
    }
}
- (void)hideControlView
{
    [controlView setFrame:Rect(0, 0, MainScreenWidth, controlDefaultHeight)];
}
- (void)showControlView
{
    [controlView setFrame:Rect(0, 0, MainScreenWidth, MainScreenHeight/3)];
}
#pragma mark - switchMapType 地图显示类型
- (void)switchMapType
{
    [_mapView setMapType:(_mapType%3)];
    NSLog(@"地图类型枚举数值 %ld",_mapType%3);
    _mapType += 1;
    
//    //是否显示POI
//    if (_mapType%2 == 0) {
//        [_mapView setShowMapPoi:NO];
//    }else{
//        [_mapView setShowMapPoi:YES];
//    }
}

#pragma mark - setLocationForStart  设置当前定位位置为导航起始位置
- (void)setLocationForStart
{
    if(_userLocation){
        CLLocationCoordinate2D point = (CLLocationCoordinate2D){_userLocation.location.coordinate.latitude,_userLocation.location.coordinate.longitude};
        [self reverseGeoCodeSearchAction:point];
    }
    
}
#pragma mark - 长按设置导航终点
- (void)setPlanEndNode:(CLLocationCoordinate2D)point
{
    [self reverseGeoCodeSearchAction:point];
}

#pragma mark - 反地理位编码检索
- (void)reverseGeoCodeSearchAction:(CLLocationCoordinate2D)point
{
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
                                                            BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = point;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

#pragma mark - routeSearch 导航搜索
- (void)routeSearch:(UIButton *)btn
{
    NSInteger type = btn.tag - 100;
    switch (type) {
        case 0:
        {
            NSLog(@"导航搜索 公交");
        }
            break;
        case 1:
        {
            NSLog(@"导航搜索 驾车");
//            BMKPlanNode* start = [[BMKPlanNode alloc]init];
//            start.name = @"重庆市";
//            start.cityName = @"重庆市";
//            BMKPlanNode* end = [[BMKPlanNode alloc]init];
//            end.name = @"成都市";
//            end.cityName = @"成都市";
            
            BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc]init];
//            if (_startPlanNode) {
                drivingRouteSearchOption.from = _startPlanNode;
//            }else{
//                drivingRouteSearchOption.from = start;
//            }
            
//            if (_startPlanNode) {
                drivingRouteSearchOption.to = _endPlanNode;
            
            drivingRouteSearchOption.drivingRequestTrafficType = BMK_DRIVING_REQUEST_TRAFFICE_TYPE_PATH_AND_TRAFFICE;//不获取路况信息
            BOOL flag = [_routesearch drivingSearch:drivingRouteSearchOption];
            if(flag)
            {
                NSLog(@"car检索发送成功");
                [self hideControlView];
            }
            else
            {
                NSLog(@"car检索发送失败");
            }
            
        }
            break;
        case 2:
        {
            NSLog(@"导航搜索 步行");
        }
            break;
        case 3:
        {
            NSLog(@"导航搜索 骑行");
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - mapView ui 设置 switch
- (void)compassSwitchAction:(UISwitch *)sender
{
    if (!sender.isOn) {
        [_mapView setCompassPosition:CGPointMake(10, 70)];
    }else{
        [_mapView setCompassPosition:CGPointMake(MainScreenWidth - 47, 70)];
    }
    
}
#pragma mark - navi(导航开始)
//导航
- (void)openMapDrivingRoute {
    //初始化调启导航时的参数管理类
    BMKNaviPara* para = [[BMKNaviPara alloc]init];
    //初始化起点节点
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    //指定起点经纬度
    CLLocationCoordinate2D coor1;
    coor1.latitude = 29.629247;
    coor1.longitude = 106.549728;
    start.pt = coor1;
    //指定起点名称
    start.name = @"我的位置";
    //指定起点
    para.startPoint = start;
    //初始化终点节点
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    //指定终点经纬度
    CLLocationCoordinate2D coor2;
    coor2.latitude = 29.604603;
    coor2.longitude = 106.609029;
    end.pt = coor2;
    //指定终点名称
    end.name = @"鬼晓得";
    //指定终点
    para.endPoint = end;
    //指定返回自定义scheme
    para.appScheme = @"baidumapsdk://mapsdk.baidu.com";
//    调启百度地图客户端导航
    [BMKNavigation openBaiduMapNavigation:para];

//    UIWebView *webView = [[UIWebView alloc]initWithFrame:Rect(0 , 0, MainScreenWidth, MainScreenHeight)];
//    [webView setUserInteractionEnabled:YES];//是否支持交互
//    //[webView setDelegate:self];
//    [webView setOpaque:NO];//opaque是不透明的意思
//    [webView setScalesPageToFit:YES];//自动缩放以适应屏幕
//    [self.view addSubview:webView];
//    //加载网页的方式
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://app.navi.baidu.com/mobile/#navi/naving/positions=%5B%7B%22xy%22:%2212935910.859845%2c4825010.196954%22%2c%22keyword%22:%22我的位置%22%2c%22type%22:%221%22%7D,%7B%22xy%22:%2212957239.906352%2c4825010.196954%22%2c%22keyword%22:%22天安门%22%2c%22type%22:%221%22%7D%5D&app_version=mapiossdk_3.0.0&fromprod=map_sdk&sy=&endp=&start=&startwd=&endwd=&ctrl_type=&mrsl=/vt=map&state=entry"]]];
}

#pragma mark - UITextFieldDelegate 导航TF控制
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

#pragma mark - BMKMapViewDelegate
/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorGreen;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        
//        UILabel *dsa = [[UILabel alloc]initWithFrame:Rect(0, 0, 50, 20)];
//        dsa.text = @"dsadsa";
//        dsa.textColor = [UIColor whiteColor];
//        [newAnnotationView addSubview:dsa];
        return newAnnotationView;
        
    }
    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
        return [self getRouteAnnotationView:mapView viewForAnnotation:(RouteAnnotation*)annotation];
    }
    
    return nil;
}
/**
 *根据overlay生成对应的View
 *@param mapView 地图View
 *@param overlay 指定的overlay
 *@return 生成的覆盖物View
 */
- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor alloc] initWithRed:0 green:1 blue:1 alpha:1];
        polylineView.strokeColor = [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}

#pragma mark 底图手势操作
/**
 *点中底图标注后会回调此接口
 *@param mapview 地图View
 *@param mapPoi 标注点信息
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi
{
    NSLog(@"onClickedMapPoi-%@",mapPoi.text);
    NSString* showmeg = [NSString stringWithFormat:@"您点击了底图标注:%@,\r\n当前经度:%f,当前纬度:%f,\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d", mapPoi.text,mapPoi.pt.longitude,mapPoi.pt.latitude, (int)_mapView.zoomLevel,_mapView.rotation,_mapView.overlooking];
    NSLog(@"%@",showmeg);
}
/**
 *点中底图空白处会回调此接口
 *@param mapview 地图View
 *@param coordinate 空白处坐标点的经纬度
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"onClickedMapBlank-latitude==%f,longitude==%f",coordinate.latitude,coordinate.longitude);
    NSString* showmeg = [NSString stringWithFormat:@"您点击了地图空白处(blank click).\r\n当前经度:%f,当前纬度:%f,\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d", coordinate.longitude,coordinate.latitude,
                         (int)_mapView.zoomLevel,_mapView.rotation,_mapView.overlooking];
    NSLog(@"%@",showmeg);
    
}

/**
 *双击地图时会回调此接口
 *@param mapview 地图View
 *@param coordinate 返回双击处坐标点的经纬度
 */
- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"onDoubleClick-latitude==%f,longitude==%f",coordinate.latitude,coordinate.longitude);
    NSString* showmeg = [NSString stringWithFormat:@"您双击了地图(double click).\r\n当前经度:%f,当前纬度:%f,\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d", coordinate.longitude,coordinate.latitude,
                         (int)_mapView.zoomLevel,_mapView.rotation,_mapView.overlooking];
    NSLog(@"%@",showmeg);
}

/**
 *长按地图时会回调此接口
 *@param mapview 地图View
 *@param coordinate 返回长按事件坐标点的经纬度
 */
- (void)mapview:(BMKMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"onLongClick-latitude==%f,longitude==%f",coordinate.latitude,coordinate.longitude);
    NSString* showmeg = [NSString stringWithFormat:@"您长按了地图(long pressed).\r\n当前经度:%f,当前纬度:%f,\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d", coordinate.longitude,coordinate.latitude,
                         (int)_mapView.zoomLevel,_mapView.rotation,_mapView.overlooking];
    
    NSLog(@"%@",showmeg);
    
    //设置终点
    [self setPlanEndNode:coordinate];
}
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSString* showmeg = [NSString stringWithFormat:@"地图区域发生了变化(x=%d,y=%d,\r\nwidth=%d,height=%d).\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d",(int)_mapView.visibleMapRect.origin.x,(int)_mapView.visibleMapRect.origin.y,(int)_mapView.visibleMapRect.size.width,(int)_mapView.visibleMapRect.size.height,(int)_mapView.zoomLevel,_mapView.rotation,_mapView.overlooking];
    NSLog(@"%@",showmeg);
    
}


#pragma mark - BMKLocationServiceDelegate
/**
 *在将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser
{
    NSLog(@"即将开始定位");
}

/**
 *在停止定位后，会调用此函数
 */
- (void)didStopLocatingUser
{
    NSLog(@"停止定位");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(userLocation){
            NSLog(@"heading is %@",userLocation.heading);
        }
    });
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //展示定位
    _mapView.showsUserLocation = YES;
    //更新位置数据
    [_mapView updateLocationData:userLocation];
    //获取用户的坐标
    _mapView.centerCoordinate = userLocation.location.coordinate;
    
    NSLog(@"%@",userLocation.location);
    NSLog(@"当前经纬度 \n lat:%f,long:%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    //设置用户当前位置信息
    _userLocation = userLocation;
    
    //更新显示当前的位置信息
    UILabel *lab = [self.view viewWithTag:10];
    lab.text = [NSString stringWithFormat:@"%@",userLocation.location];
    
    _mapView.zoomLevel = 17 ;

    
    [_locService stopUserLocationService];
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"定位失败 失败信息:%@",error);
}

#pragma mark - BMKGeoCodeSearchDelegate
/**
 *返回地址信息搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结BMKGeoCodeSearch果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    
}

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //这里打印出反向地理编码的结果,包括城市,地址等信息
        NSLog(@"测试结果 %@  %@",result.addressDetail.city,result.address);
        
        UITextField *tf = [self.view viewWithTag:12];
        tf.text = [NSString stringWithFormat:@"%@ %@",result.addressDetail.city,result.address];
        _endPlanNode.pt = _userLocation.location.coordinate;
        _endPlanNode.cityName = result.addressDetail.city;
        _endPlanNode.name = result.address;
        
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

#pragma mark - BMKRouteSearchDelegate
/**
 *返回公交搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果，类型为BMKTransitRouteResult
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetTransitRouteResult:(BMKRouteSearch*)searcher result:(BMKTransitRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    
}
/**
 *返回驾乘搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果，类型为BMKDrivingRouteResult
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        // 添加途经点
        if (plan.wayPoints) {
            for (BMKPlanNode* tempNode in plan.wayPoints) {
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item = [[RouteAnnotation alloc]init];
                item.coordinate = tempNode.pt;
                item.type = 5;
                item.title = tempNode.name;
                [_mapView addAnnotation:item];
            }
        }
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
}

/**
 *返回步行搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果，类型为BMKWalkingRouteResult
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetWalkingRouteResult:(BMKRouteSearch*)searcher result:(BMKWalkingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    
}

/**
 *返回骑行搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果，类型为BMKRidingRouteResult
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetRidingRouteResult:(BMKRouteSearch*)searcher result:(BMKRidingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    
}
#pragma mark - configImages(配置资图片)
//下面2个为私有方法
//配置图片文件路径
- (NSString*)getMyBundlePath1:(NSString *)filename
{
    
    NSBundle * libBundle = MYBUNDLE ;
    if ( libBundle && filename ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
        return s;
    }
    return nil ;
}
//使用图片文件
- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
    BMKAnnotationView* view = nil;
    switch (routeAnnotation.type) {
        case 0:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 1:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 2:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 3:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 4:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"];
                view.canShowCallout = TRUE;
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            view.annotation = routeAnnotation;
            
        }
            break;
        case 5:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"waypoint_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"waypoint_node"];
                view.canShowCallout = TRUE;
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_waypoint.png"]];
            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            view.annotation = routeAnnotation;
        }
            break;
        default:
            break;
    }
    
    return view;
}

//根据polyline设置地图范围
- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [_mapView setVisibleMapRect:rect];
    _mapView.zoomLevel = _mapView.zoomLevel - 0.3;
}

@end
