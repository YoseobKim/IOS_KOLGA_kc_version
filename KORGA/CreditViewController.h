//
//  CreditViewController.h
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 22..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreditViewController : UIViewController {
    UIButton *backBtn;
}

@property (nonatomic, retain) IBOutlet UIButton *backBtn;

-(IBAction)backBtnPressed:(id)sender;

@end
