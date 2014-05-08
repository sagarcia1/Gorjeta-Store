//
//  CLSSettingsViewController.h
//  gorjeta
//
//  Created by Celo on 06/03/14.
//  Copyright (c) 2014 Celo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLSSettingsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong, nonatomic) IBOutlet UISwitch *swtichTrocaCor;
- (IBAction)acaoSwitch:(UISwitch *)sender;
- (IBAction)btBack:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UISwitch *actionSwitch;
- (IBAction)actionSwitch:(UISwitch *)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerFonte;
@property (strong, nonatomic) NSArray *ArrayTamanhoFonte;
@property (strong, nonatomic) NSArray *ArrayTipoFonte;


@end
