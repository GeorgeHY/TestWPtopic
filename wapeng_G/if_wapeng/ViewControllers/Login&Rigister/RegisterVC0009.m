
/*
 具体用法：查看MJRefresh.h
 */
NSString *const MJCollectionViewCellIdentifier = @"Cell";

/**
 *  随机颜色
 */
#define MJRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

#import "RegisterVC0009.h"
#import "MJRefresh.h"
#import "Cell_RegsiterViewController09.h"

@interface RegisterVC0009 ()
{
    NSMutableArray * _dataSourceArr;
    Cell_RegsiterViewController09 * _cell;
    NSIndexPath *_indexPath;
    UICollectionView *_collectionView;
}
@property (strong, nonatomic) NSMutableArray *fakeColors;

@end
 static BOOL s=YES;
@implementation RegisterVC0009

/**
 *  初始化
 */
- (id)init
{
    // UICollectionViewFlowLayout的初始化（与刷新控件无关）
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(80,111);
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 20;
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *backImage = [UIImage imageNamed:@"public_back"];
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, backImage.size.width, backImage.size.height)];
    [back setImage:backImage forState:UIControlStateNormal];
    [back setImage:[UIImage imageNamed:@"public_back_hightLight"] forState:UIControlStateHighlighted];
    [back addTarget:self action:@selector(navItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = left;
    
    
    _dataSourceArr=[[NSMutableArray alloc]init];
    // 注册cell要用到的xib
    [self.collectionView registerNib:[UINib nibWithNibName:@"Cell_RegsiterViewController09" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    // 1.初始化collectionView
    [self setupCollectionView];
    
    // 2.集成刷新控件
    [self addHeader];
    [self addFooter];
    self.collectionView.frame=CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
    UIButton *btn01=[UIButton buttonWithType:UIButtonTypeCustom];
    btn01.frame=CGRectMake(0, self.view.frame.size.height-30, self.view.frame.size.width*0.5, 50);
    [btn01 setTitle:@"全部选择" forState:UIControlStateNormal];
    btn01.backgroundColor=[UIColor blueColor];
    [btn01 addTarget:self action:@selector(allSelect) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn01];
    
    
    
}
//[_collectionView reloadData];
-(void)allSelect
{
    s=NO;
    NSLog(@"--");
    [self.collectionView reloadData];
}
/**
 *  初始化collectionView
 */
- (void)setupCollectionView
{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.alwaysBounceVertical = YES;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:MJCollectionViewCellIdentifier];
}

-(void)navItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)addHeader
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加下拉刷新头部控件
    [self.collectionView addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        
        // 增加5条假数据
        for (int i = 0; i<5; i++) {
            [_dataSourceArr insertObject:@"nihao我" atIndex:i];
        }
        
        // 模拟延迟加载数据，因此1秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.collectionView reloadData];
            // 结束刷新
            [vc.collectionView headerEndRefreshing];
        });
    }];
    
#warning 自动刷新(一进入程序就下拉刷新)
    [self.collectionView headerBeginRefreshing];
}

- (void)addFooter
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [self.collectionView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        
        // 增加5条假数据
        for (int i = 0; i<5; i++) {
            [vc.fakeColors addObject:@"nihao我"];
        }
        
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.collectionView reloadData];
            // 结束刷新
            [vc.collectionView footerEndRefreshing];
        });
    }];
}

/**
 为了保证内部不泄露，在dealloc中释放占用的内存
 */
- (void)dealloc
{
    NSLog(@"MJCollectionViewController--dealloc---");
}

#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSourceArr.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MJCollectionViewCellIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = self.fakeColors[indexPath.row];
    
    _indexPath=indexPath;
    _collectionView=collectionView;
    static NSString *ID = @"cell";
    Cell_RegsiterViewController09 *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:_indexPath];
    if (cell==nil) {
        Cell_RegsiterViewController09 *cell=[[Cell_RegsiterViewController09 alloc]init];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Cell_RegsiterViewController09" owner:self options:nil]lastObject];
    }
    cell.myLabel.text=[_dataSourceArr objectAtIndex:indexPath.row];
    cell.myIcon.tag=indexPath.row;
    [cell.myIcon addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _cell=cell;
    if(s=YES){
        cell.myIcon.backgroundColor=[UIColor redColor];
    }
    else
    {
        cell.myIcon.backgroundColor=[UIColor greenColor];

    }
    return cell;
}
-(void)btnClick:(id)sender
{
//    NSLog(@"row=%u",_indexPath.row);
//    Cell_RegsiterViewController09 * cell = (Cell_RegsiterViewController09 *)[_collectionView cellForItemAtIndexPath:_indexPath];
//    NSLog(@"s=%d",s);
//    if(s==YES){
//        cell.myIcon.backgroundColor=[UIColor greenColor];
//        [_collectionView reloadData];
//        s=NO;
//    }
//    else{
//        cell.myIcon.backgroundColor=[UIColor redColor];
//        [_collectionView reloadData];
//        s=YES;
//    }
//    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cell_RegsiterViewController09 * cell = (Cell_RegsiterViewController09 *)[collectionView cellForItemAtIndexPath:indexPath];
    if(s==YES){
        cell.myIcon.backgroundColor=[UIColor redColor];
       //[_collectionView reloadData];
        s=NO;
    }
    else{
        cell.myIcon.backgroundColor=[UIColor greenColor];
        //[_collectionView reloadData];
        s=YES;
    }
    
}
//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    Cell_RegsiterViewController09 * cell = (Cell_RegsiterViewController09 *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.myIcon.backgroundColor=[UIColor redColor];
//}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
@end
