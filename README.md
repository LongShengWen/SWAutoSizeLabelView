# SWAutoSizeLabelView
这是一个基于 UICollectionView 些的 tag 视图控件(我也不懂怎么描述,看看图片吧)

## 效果图
<img src="https://github.com/LongShengWen/SWAutoSizeLabelView/blob/master/SWAutoSizeLabelView/image/DemoImage.jpeg" width = "300" height = "450"  />

## 接入说明

1. 支持 cocoapods
在 Podfile 中添加 
```
pod 'SWAutoSizeLabelView'
```
执行 pod 安装命令即可
```
pod install
```
2. 手动接入
将 AutoSizeLabelView 目录下的文件引入整个目录下，还需引入 pod 'Masonry' 即可使用。

## 使用说明

引入头文件
```
#import "swAutoSizeLabelView.h"
```
```
swAutoSizeLabelView _autoresizeLabelFlow = [swAutoSizeLabelView new];
[self.view addSubview:_autoresizeLabelFlow];
// 加好预约
[_autoresizeLabelFlow mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.mas_equalTo(self.view).mas_offset(20);
      make.left.mas_equalTo(self.view).mas_offset(20);
      make.height.mas_equalTo(50);
      make.width.mas_equalTo(50);
}];
 _autoresizeLabelFlow2.lineBreak = NO;
_autoresizeLabelFlow2.bounces = NO;
// 这里的 self.data 为数据详情看demo
_autoresizeLabelFlow2.data = self.data;
_autoresizeLabelFlow.textNormalColor = [UIColor redColor];
// 刷新数据
[_autoresizeLabelFlow2 reload];

// 点击单元格的回调
_autoresizeLabelFlow2.selectHandler = ^(NSUInteger index, swAutoSizeLabelModel *model) {
    NSLog(@"index - %ld title = %@",index,model.itemTitle);
};
// 完成布局时的回调
_autoresizeLabelFlow2.finshLayout = ^(CGSize size) {
    NSLog(@"with - %f \n height - %f",size.width,size.height);
};
```
