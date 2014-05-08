//
//  CLSViewController.m
//  gorjeta
//
//  Created by Celo on 17/12/13.
//  Copyright (c) 2013 Celo. All rights reserved.
//

#import "CLSViewController.h"
#import "CLSLoginViewController.h"
#import "CLSPreferencesViewController.h"
#import "CLSCategoriasViewController.h"
#import "CLSAppDelegate.h"
#import "CLSSettingsViewController.h"
#import <Security/Security.h>
#import "CLSCallTaxi.h"
#import <CoreLocation/CoreLocation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "SIAlertView.h"
#import "Reachability.h"




@interface CLSViewController ()<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *subTotal;

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong,nonatomic) NSMutableArray *content;
@property (strong,nonatomic)Reachability *hostReachability;
@property (strong,nonatomic)Reachability *internetReachability;
@property (strong,nonatomic)Reachability *wifiReachability;


- (IBAction)mudarSlider:(id)sender;

@end

@implementation CLSViewController
{
    NSString *totalStr;
    NSString *calcGorjetastr;
    NSString *subTotal1;
    NSString *total1;
    float calcTotal;
    float Total;
    NSString *latitude;
    NSString *longitude;
    float calcGorjeta;
    BOOL isShowingNoInternetScreen;
    CLLocationManager *locationmanager;
    CLLocation *local;
    Reachability * r;
    NetworkStatus internetStatus;
    
}
-(void)reset{
    _subTotal.text=@"";
    _slider.value=0;
    _gorjeta.text=@"";
    _valorTotal.text=@"";
    _valorGorjeta.text=@"";
    _totalPessoa.text=@"";
    calcTotal = 0;
    Total = 0;
    calcGorjeta = 0;
    
    
    [self.picker reloadAllComponents];
    [self.picker selectRow:0 inComponent:0 animated:YES];
    [self.picker selectRow:0 inComponent:1 animated:YES];

    
}
- (IBAction)btnReset:(UIButton *)sender {

    [self reset];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    locationmanager = [[CLLocationManager alloc]init];
    locationmanager.delegate= self;
    locationmanager.distanceFilter = kCLHeadingFilterNone;
    locationmanager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationmanager startUpdatingLocation];
    NSLog(@"%@",latitude);
    
    
        NSString *teste;
   
 
//    for (NSString* family in [UIFont familyNames])
//    {
//        NSLog(@"%@", family);
//        
//        for (NSString* name in [UIFont fontNamesForFamilyName: family])
//        {
//            NSLog(@"  %@", name);
//        }
//    }
    self.picker.transform = CGAffineTransformMakeScale(.8, 0.8);

        self.lblValorConta.font = [UIFont fontWithName:@"Minecraftia" size:14];
        self.subTotal.font = [UIFont fontWithName:@"Minecraftia" size:14];
    self.lblNumPess.font =[UIFont fontWithName:@"Minecraftia" size:14];
    self.gorjeta.font = [UIFont fontWithName:@"Minecraftia" size:14];
    self.lblGorjeta.font = [UIFont fontWithName:@"Minecraftia" size:14];
    self.lblporcent.font = [UIFont fontWithName:@"Minecraftia" size:14];
    self.lblReais.font = [UIFont fontWithName:@"Minecraftia" size:14];
    self.lblValorConta.font = [UIFont fontWithName:@"Minecraftia" size:14];
    self.lblTotal.font = [UIFont fontWithName:@"Minecraftia" size:14];
    self.totalPessoa.font = [UIFont fontWithName:@"Minecraftia" size:14];
    self.lblCallTaxi.font =[UIFont fontWithName:@"Minecraftia" size:13];
    self.lblChekin.font= [UIFont fontWithName:@"Minecraftia" size:13];
    self.valorTotal.font=[UIFont fontWithName:@"Minecraftia" size:14];
    self.lblTotalzao.font = [UIFont fontWithName:@"Minecraftia" size:14];
    self.valorGorjeta.font =[UIFont fontWithName:@"Minecraftia" size:14];
    self.lblShake.font= [UIFont fontWithName:@"Minecraftia" size:12];

    
    
    
 
    
//    [[UISlider appearance]setThumbImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
//       [[UISlider appearance]setThumbImage:[UIImage imageNamed:@"icon"] forState:UIControlStateHighlighted];
    
    

    self.lblCateg.text = self.cat;
    NSLog(@"%@Parametro",self.cat);
    

    
    NSManagedObjectContext *categoriaObj = [(CLSAppDelegate *)[[UIApplication sharedApplication]delegate]managedObjectContext ];

    
    
    self.pickerCategoria.tag = 12;
  
    _picker.tag = 11;
    
    
  
          
            
            self.view.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"fundoroxinho"]];
        
   
    


     _content= [[NSMutableArray alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Categorias" ofType:@"plist"]];
    listaqtd = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil];//cria o array que vai receber numeros de 0 a 9
    segundalista = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",nil];//segundo array para inicializar o picker em 1
    
    [self    CalculoSubtotal];
    [self TotalPessoa];
    [self Calculototal];
    [self CalculoGorjeta];
    NSLog(@"LOCATION %@ %@",latitude,longitude);
   //[self jsonFoursquare];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mudarSlider:(id)sender {
    int valorSlider = _slider.value;//recebe o valor do slider como um intero
    NSString *stringslider = [[NSString alloc]initWithFormat:@"%i",valorSlider];//tranforma o valor int em uma string
    _gorjeta.text = stringslider;
    
    [self CalculoGorjeta];
   [self    CalculoSubtotal];
    [self Calculototal];
    [self TotalPessoa];
    
    [self.subTotal resignFirstResponder];
    
    
}

#pragma mark metodos



-(void)Calculototal
{
    calcTotal =[_subTotal.text floatValue] + [_valorGorjeta.text floatValue];
    
    totalStr = [[NSString alloc]initWithFormat:@"%.2f",calcTotal ];
    
    _valorTotal.text = totalStr;
}//metodo que retorna o valor total

-(void) CalculoGorjeta
{
     calcGorjeta = [_subTotal.text floatValue] *[_gorjeta.text intValue]/100;//calcula gorgeta
    calcGorjetastr = [[NSString alloc]initWithFormat:@"%.2f",calcGorjeta];
    _valorGorjeta.text = calcGorjetastr;
}

-(void) CalculoSubtotal
{
    float subTotal = [_subPessoa.text floatValue]/[_numPessoa.text intValue];
   subTotal1 = [[NSString alloc]initWithFormat:@"%.2f",subTotal];
    if (subTotal1 == 0) {
        _subPessoa.text = @"0,00";
    }
    _subPessoa.text = subTotal1;
    
}

#pragma mark actionSheet
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (actionSheet.tag) {
        case 1:
            switch (buttonIndex) {
                case 0:
                    [self mudarTela];
                    break;
                    
                default:
                    break;
            };
            break;
            
        default:
            break;
    }
}

-(void) TotalPessoa
{
    @try {
        if ([_numPessoa.text intValue]==0) {
            Total = 0;
            _totalPessoa.text =total1;
        }
        else
        {
        Total = [_valorTotal.text floatValue]/[_numPessoa.text intValue];
        total1=[[NSString alloc]initWithFormat:@"%.2f", Total];
        NSLog(@"%f ",Total);
        
        
        _totalPessoa.text=total1;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"erro");
    }
  
    
    
   
        
}
//metodo obrigatorio para contar o numero de componentes da pickerview
//retorna o numero de linhas do picker

#pragma mark delegates

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{   int valueReturn;
    if ([pickerView isEqual:self.pickerCategoria]) {
        valueReturn = 1;
    }
    if ([pickerView isEqual:_picker]) {
        valueReturn = 2;
    }
    return valueReturn;
    // cria 2 componentes da picker
}
//-(UIView * )pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//    CGSize rowSize= [pickerView rowSizeForComponent:component];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,rowSize.width,rowSize.height )];
//    label.textColor = [UIColor blackColor];
//    return  label;
//}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    int aux;

        
    
    if (component == 0 ) {// se o componente estiver em  0 o aux  vai receber a lista do primeiro picker
        aux = [listaqtd count];
    }
    
    if (component == 1 ) {
        aux=[segundalista count]; // senao o aux recebe a segunda lista
    }
    
     
    
    
    return aux;
    
}//metodo obrigatorio que retorna o valor do nsmutable


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//ele passa o row e o componente como parametro, e faz o mesmo if para verificar se esta na primeira ou na segunda picker
    NSString *aux;
    if (pickerView.tag ==11) {
        if (component == 0 ) {
            aux=[listaqtd objectAtIndex:row];
            
        }
        if (component ==1 )
        {
            aux=[segundalista objectAtIndex:row];
        }
        

    }
        
  
        return aux;
  
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView.tag ==11) {
        
    
    NSMutableString *aux=[[NSMutableString alloc]initWithFormat:self.numPessoa.text];
    if (component == 0 ) {
        [aux replaceCharactersInRange:NSMakeRange(0,1) withString:[listaqtd objectAtIndex:row]];
        //se for selecionado o componente 0  ele colocar o numero selecionado no range 0 da string na tela
      		 // NSAttributedString *attString = [[NSAttributedString alloc] initWithString:aux attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    }
    
    if (component == 1 ) {
        [aux replaceCharactersInRange:NSMakeRange(1,1) withString:[segundalista objectAtIndex:row]];
        //se for selecionado o componente 0  ele colocar o numero selecionado no range 1 da string na tela
        // e escolhe da segunda lista pois foi trocado e o valor inicial dela e 1
        
        
    }
    
    _numPessoa.text = aux;//recebe o valor editado dos pickers
    [self    CalculoSubtotal];
    [self TotalPessoa ];
    }
   
    
    
}//metodo para quando a picker for selecionada

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [self Calculototal];
    [self CalculoSubtotal];
    [self CalculoGorjeta];
    [self TotalPessoa];
    float result = [self.subTotal.text floatValue];
    
    self.subTotal.text =[ [NSString alloc]initWithFormat:@"%1.2f",result ];
    
}




- (IBAction)btPreference:(UIButton *)sender {
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"Check-in via" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Facebook", nil];
    action.tag = 1;
    [[[action valueForKey:@"_buttons"]objectAtIndex:0]setImage:[UIImage imageNamed:@"FacebookIcon"]  forState:UIControlStateNormal];
    [action showInView:[UIApplication sharedApplication].keyWindow];
}

-(void)mudarTela
{
    r=[Reachability reachabilityWithHostName:@"www.google.com"];
    internetStatus = [r currentReachabilityStatus ];
    if ((internetStatus != ReachableViaWiFi)&&(internetStatus !=ReachableViaWWAN)) {
        
        if (!isShowingNoInternetScreen) {
            [self alert];
           isShowingNoInternetScreen = NO;
            
        }
    }
    else
    {
    CLSPreferencesViewController *preference = (CLSPreferencesViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"CLSPreferencesViewController"];
    [self presentViewController:preference  animated:YES completion:nil];
    }
}
-(void)alert{
    SIAlertView *alert = [[SIAlertView alloc]initWithTitle:@"Ops!" andMessage:@"Seu iPhone não está conectado à internet, por favor conecte-se para acessar este recurso!"];
    [alert addButtonWithTitle:@"Ok" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
        NSLog(@"voltar");
    }];
    alert.titleFont = [UIFont fontWithName:@"Minecraftia" size:15];
    alert.messageFont = [UIFont fontWithName:@"Minecraftia" size:11];
    alert.buttonFont =[UIFont fontWithName:@"Minecraftia" size:15];
    alert.transitionStyle = SIAlertViewTransitionStyleBounce;
    [alert show];
}



-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [self reset];
}


- (IBAction)actionCerveja:(UIButton *)sender {
    r=[Reachability reachabilityWithHostName:@"www.google.com"];
    internetStatus = [r currentReachabilityStatus ];
    if ((internetStatus != ReachableViaWiFi)&&(internetStatus !=ReachableViaWWAN)) {
        if (!isShowingNoInternetScreen) {
            [self alert];
            isShowingNoInternetScreen = NO;

        }
    }
    else
    {
    CLSCallTaxi *set = (CLSCallTaxi*)[self.storyboard instantiateViewControllerWithIdentifier:@"CLSCallTaxi"];
    [self presentViewController:set animated:YES completion:nil];
    
    }
}

- (IBAction)btPrefer:(UIButton *)sender {
    //[self mudaTela];
}

-(void)mudaTela
{
    CLSSettingsViewController *set = (CLSSettingsViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"CLSSettingsViewController"];
    [self presentViewController:set animated:YES completion:nil];
}


- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    
    UILabel *pickerLabel = (UILabel *)view;
    
    
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, 40, 32);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont fontWithName:@"Minecraftia" size:19]];
    }
    if (component == 0) {
       [pickerLabel setText:[listaqtd objectAtIndex:row]];
    }
    if  (component ==1)
    {
    [pickerLabel setText:[segundalista objectAtIndex:row]];
    }
    return pickerLabel;
    
}



- (IBAction)btReset:(UIButton *)sender {
    SIAlertView *reset = [[SIAlertView alloc]initWithTitle:@"Reset" andMessage:@"Para você criar um novo calculo faça o movimento de shake (Chacoalhar) do iphone"];
    [reset addButtonWithTitle:@"Entendi" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
        NSLog(@"reset");
    }];
    reset.buttonColor = [UIColor blueColor];
    reset.buttonFont = [UIFont fontWithName:@"Minecraftia" size:15];
    reset.titleFont = [UIFont fontWithName:@"Minecraftia" size:15];
    reset.messageFont = [UIFont fontWithName:@"Minecraftia" size:11];
    reset.buttonFont =[UIFont fontWithName:@"Minecraftia" size:15];
    reset.transitionStyle=SIAlertViewTransitionStyleDropDown;
    [reset show];
    
}
@end
