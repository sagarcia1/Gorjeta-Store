//
//  CLSLoginViewController.h
//  gorjeta
//
//  Created by Celo on 22/02/14.
//  Copyright (c) 2014 Celo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLSLoginViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textfieldLogin;
@property (strong, nonatomic) IBOutlet UITextField *textfieldSenha;
- (IBAction)buttonSave:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *buttonLogin;
- (IBAction)btCadastra:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *btLogin;
- (IBAction)btLogin:(UIButton *)sender;
- (IBAction)touchLabel:(UITextField *)sender;
@property (strong,nonatomic)NSString *categoria1;



@end
