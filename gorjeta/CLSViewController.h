//
//  CLSViewController.h
//  gorjeta
//
//  Created by Celo on 17/12/13.
//  Copyright (c) 2013 Celo. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CLSViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UINavigationControllerDelegate,UIActionSheetDelegate>// protocolos que serao usados para a picker
{
    NSMutableArray *listaqtd;//array para receber a picker
    NSMutableArray *segundalista;
    
    
}
- (IBAction)btReset:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblShake;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityTaxi;
@property (strong, nonatomic) IBOutlet UIButton *btTaxi;
@property (strong, nonatomic) IBOutlet UILabel *lblCallTaxi;
@property (strong, nonatomic) IBOutlet UILabel *lblTotalzao;
- (IBAction)actionPicker:(id)sender;
- (IBAction)btGorjeta:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblNumPessoas;
@property (strong, nonatomic) IBOutlet UILabel *lblporcent;
@property (strong, nonatomic) IBOutlet UILabel *lblReais;
- (IBAction)actionCerveja:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblNumPess;
@property (strong, nonatomic) IBOutlet UILabel *lblTotal;
- (IBAction)btPrefer:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblGorjeta;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerCategoria;
- (IBAction)btSalvar:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblCateg;
@property (strong, nonatomic) IBOutlet UILabel *lblChekin;
- (IBAction)SwitchTrocaCor:(UISwitch *)sender;
@property (strong, nonatomic) IBOutlet UISwitch *switchTroca;
- (IBAction)btLogoff:(UIButton *)sender;
- (IBAction)btPreference:(UIButton *)sender;
@property (nonatomic,strong) NSString *cat;
@property (nonatomic,strong)NSManagedObjectContext *context1;
@property (weak, nonatomic) IBOutlet UILabel *gorjeta;
@property (weak, nonatomic) IBOutlet UILabel *valorGorjeta;
@property (weak, nonatomic) IBOutlet UILabel *valorTotal;
@property (weak, nonatomic) IBOutlet UILabel *subPessoa;
@property (weak, nonatomic) IBOutlet UILabel *valorPessoa;
@property (weak, nonatomic) IBOutlet UILabel *totalPessoa;
@property (weak, nonatomic) IBOutlet UILabel *numPessoa;
@property (strong, nonatomic) IBOutlet UILabel *lblValorConta;

@end
