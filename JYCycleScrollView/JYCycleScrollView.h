//
//  JYCycleScrollView.h
//  JYCycleScrollView
//
//  Created by luoshimei on 2023/3/27.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//! Project version number for JYCycleScrollView.
FOUNDATION_EXPORT double JYCycleScrollViewVersionNumber;

//! Project version string for JYCycleScrollView.
FOUNDATION_EXPORT const unsigned char JYCycleScrollViewVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <JYCycleScrollView/PublicHeader.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYCycleScrollView : UIView
@property (nonatomic, strong) NSMutableArray<NSString *> *imageNamesArray;
@property (nonatomic, copy) void(^tapEventBlock)(NSUInteger index);
@end

NS_ASSUME_NONNULL_END
