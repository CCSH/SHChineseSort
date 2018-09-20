//
//  SHChineseSort.h
//  SHChineseSortExample
//
//  Created by CSH on 2018/9/20.
//  Copyright © 2018年 CSH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHChineseSort : NSObject

//索引集合(A~Z #)
@property (nonatomic, copy) NSArray *indexArr;
//原始数据(按照字母已经分好组)
@property (nonatomic, copy) NSArray *originalArr;

/**
 获取拼音排序集合

 @param dataArr 数据源
 @param keyArr 如果存在则通过内容的key进行排序
 @return 排序数据
 */
+ (SHChineseSort *)getSortWithDataArr:(NSArray *)dataArr keyArr:(NSArray *)keyArr;

@end

NS_ASSUME_NONNULL_END
