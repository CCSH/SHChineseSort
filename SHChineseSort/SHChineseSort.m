//
//  SHChineseSort.m
//  SHChineseSortExample
//
//  Created by CSH on 2018/9/20.
//  Copyright © 2018年 CSH. All rights reserved.
//

#import "SHChineseSort.h"
#import "MJExtension.h"

@interface SHChineseSort ()

//内容
@property (nonatomic, strong) id obj;
//拼音
@property (nonatomic, strong) NSString *pinyin;

@end

@implementation SHChineseSort

+ (SHChineseSort *)getSortWithDataArr:(NSArray *)dataArr keyArr:(NSArray *)keyArr{
    
    __block NSMutableArray <NSDictionary *>*chineseArr = [NSMutableArray array];
    
    //数据处理、分组(相同首字母分为一组)
    [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dic = [obj mj_JSONObject];
        NSString *name;
        for (NSString *key in keyArr) {
            name = dic[key];
            if (name.length) {
                break;
            }
        }
        
        if (!name) {
            name = obj;
        }
        
        if (name.length) {//查找条件是否存在
            
            SHChineseSort *model = [[SHChineseSort alloc]init];
            model.obj = obj;
            model.pinyin = [self pinyinWithStr:name];
            
            NSString *firstName;
            
            //判断首字符是否为字母
            NSString *regex = @"[A-Za-z]+";
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
            firstName = [[model.pinyin substringToIndex:1] uppercaseString];
            
            //判断首字母
            if (![predicate evaluateWithObject:firstName]) {
                firstName = @"#";
            }
            
            //查询是否已经存在
            BOOL isHave = NO;
            for (int i = 0; i < chineseArr.count; i++) {
                
                NSDictionary *dic = chineseArr[i];
                
                if ([dic.allKeys[0] isEqualToString:firstName]) {//存在 则刷新数据
                    //刷新数据
                    NSMutableArray *temp = [NSMutableArray arrayWithArray:(NSArray *)dic[firstName]];
                    [temp addObject:model];
                    [chineseArr replaceObjectAtIndex:i withObject:@{firstName:temp}];
                    
                    isHave = YES;
                    break;
                }
            }
            
            if (!isHave) {//不存在 则添加数据
                [chineseArr addObject:@{firstName:@[model]}];
            }
        }
    }];
    
    //内部排序(同一个首字母，内部数据源排序)
    //找到数据源的key排序 (pinyin）
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinyin" ascending:YES]];

    [chineseArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //取出内部数据
        NSMutableArray *temp = [NSMutableArray arrayWithArray:(NSArray *)obj[obj.allKeys[0]]];
        
        if (temp.count > 1) {//多余一条排序
            
            [temp sortUsingDescriptors:sortDescriptors];
            //更新排好序的数据源
            [chineseArr replaceObjectAtIndex:idx withObject:@{obj.allKeys[0]:temp}];
        }
    }];
    
    //外部排序、同时处理数据源
    //存排序号的索引下标
    NSMutableArray *indexArr = [[NSMutableArray alloc] init];
    //处理排序号的原始数据
    NSMutableArray *originalArr = [[NSMutableArray alloc] init];
    
    for (int i = 'A'; i <= 'Z'; i++) {
        
        [chineseArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString *first = obj.allKeys[0];
            
            if ([first characterAtIndex:0] == i) {//找到了 首字母
                
                //添加索引
                [indexArr addObject:obj.allKeys[0]];
                
                //添加原始数据
                NSMutableArray *temp = [[NSMutableArray alloc]init];
                for (SHChineseSort *model in obj.allValues[0]) {
                    [temp addObject:model.obj];
                }
                [originalArr addObject:temp];
                
                //处理一个删除一个，减少下次遍历
                [chineseArr removeObjectAtIndex:idx];
                
                *stop = YES;
            }
        }];
    }
    
    //删除到最后还有一个数据 那就是 #
    if (chineseArr.count) {
        
        NSDictionary *dic = chineseArr[0];
        //添加索引
        [indexArr addObject:dic.allKeys[0]];
        
        //添加原始数据
        NSMutableArray *temp = [[NSMutableArray alloc]init];
        for (SHChineseSort *model in dic.allValues[0]) {
            [temp addObject:model.obj];
        }
        [originalArr addObject:temp];
    }
    
    //构建数据源
    SHChineseSort *model = [[SHChineseSort alloc]init];
    model.indexArr = indexArr;
    model.originalArr = originalArr;
    
    return model;
}

+ (NSString *)pinyinWithStr:(NSString *)str{
    
    if (str.length) {
        //系统
        NSMutableString *pinyin = [NSMutableString stringWithString:str];
        CFStringTransform((CFMutableStringRef)pinyin, NULL, kCFStringTransformToLatin, false);
        return [[[pinyin stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]] lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    }else{
        return str;
    }
}

@end
