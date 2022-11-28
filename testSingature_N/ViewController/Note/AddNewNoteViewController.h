//
//  AddNewNoteViewController.h
//  FlipViewTest
//
//  Created by Mac Pro on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddNewNoteViewController;
@protocol addDelegate <NSObject>

-(void)refreshFlipView;

@end
@interface AddNewNoteViewController : UIViewController<UITextViewDelegate,UIGestureRecognizerDelegate>
{
    UITextView *textView;
    NSString *dateString;
    UILabel *dateLabel;
}
@property (nonatomic,assign) id<addDelegate>delegateForAdd;
@end
