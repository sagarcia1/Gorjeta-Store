//
//  CLSRelatorioViewController.h
//  gorjeta
//
//  Created by Celo on 26/02/14.
//  Copyright (c) 2014 Celo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLSRelatorioViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *textFieldValorTotal;
@property (strong, nonatomic) IBOutlet UITextField *textFieldValorPessoa;
- (IBAction)btEditar:(UIButton *)sender;
- (IBAction)btExcluir:(UIButton *)sender;
- (IBAction)btEdita:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblCategoria;


@end
