//
//  CLSSettingsViewController.m
//  gorjeta
//
//  Created by Celo on 06/03/14.
//  Copyright (c) 2014 Celo. All rights reserved.
//

#import "CLSSettingsViewController.h"
#import "CLSViewController.h"

@interface CLSSettingsViewController ()
{
    NSArray *arrayTableView;
   
    UISwitch *switch1;
    
    
}
@end

@implementation CLSSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    bool trocaCor=[defaults boolForKey:@"SwitchCor"];
    switch1.on = trocaCor;
    arrayTableView =[[NSArray alloc]initWithObjects:@"Estilos de fonte",@"Tema", nil];
    self.ArrayTipoFonte = [[NSArray alloc]initWithObjects:@"Helvetica-Neue",@"Kailasa",@"Teste", nil];
    self.ArrayTamanhoFonte = [[NSArray alloc]initWithObjects:@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18", nil];
    CLSViewController *controller= [[CLSViewController alloc]init];
    if (trocaCor == YES) {
        switch1.on = YES;
        controller.view.backgroundColor = [[UIColor alloc]initWithPatternImage:
                                           [UIImage imageNamed: @"fundoverdinho"]];
        
    }
    else
        switch1.on = NO;
        controller.view.backgroundColor  = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"fundoroxinho"]];

 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







- (IBAction)btBack:(UIButton *)sender {
   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [arrayTableView count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    if ([[arrayTableView objectAtIndex:indexPath.row]isEqualToString:@"Tema"]) {
        switch1 =[[UISwitch alloc]init];
        NSUserDefaults *cor =[NSUserDefaults standardUserDefaults];
        bool recebe = [cor boolForKey:@"SwitchCor"];
        switch1.on = recebe;
        cell.accessoryView =[[UIView alloc]initWithFrame:switch1.frame];
        [cell.accessoryView addSubview:switch1  ];
        [switch1 addTarget:self action:@selector(acaoSwitch:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    cell.textLabel.font = [UIFont fontWithName:@"Kailasa" size:18];
    cell.textLabel.text = [arrayTableView objectAtIndex:indexPath.row];
                
    
    
    return cell;
}

-(IBAction)acaoSwitch:(UISwitch *)sender{
    NSUserDefaults *cor  = [NSUserDefaults standardUserDefaults];
    
    if (switch1.isOn) {
        [cor setBool:YES forKey:@"SwitchCor"];
        CLSViewController *controller = [[CLSViewController alloc]init];
        controller.view.backgroundColor = [[UIColor alloc]initWithPatternImage:
                                           [UIImage imageNamed: @"fundoverdinho"]];
        NSLog(@" COR:%@",cor);
        
    }else{
        [cor setBool:NO forKey:@"SwitchCor"];
        CLSViewController *controller = [[CLSViewController alloc]init];
        controller.view.backgroundColor = [[UIColor alloc]initWithPatternImage:
                                           [UIImage imageNamed: @"fundoroxinho"]];
        NSLog(@" COR:%@",cor);
    }
    
    
    
    [cor synchronize];
}

#pragma  mark delegates pickerview

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    
    if (component ==0)
    {
       
        return [self.ArrayTipoFonte count];
        
    }
        
    
    else
    {
        
        
        return [self.ArrayTamanhoFonte count];
        
    }
        
   
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
   
    if (component ==0) {
        return  [self.ArrayTipoFonte objectAtIndex:row];
    
    }
   else
    {
        return   [self.ArrayTamanhoFonte objectAtIndex:row];
    }
  
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSMutableString *tipoFonte= [[NSMutableString alloc]init];
    NSMutableString *tamanhoFonte=[[NSMutableString alloc]init];
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
    float fontSize;
    NSString *fontStyle;
    if (component ==1) {
        tamanhoFonte =[self.ArrayTamanhoFonte objectAtIndex:row];
         fontSize = [[self.ArrayTamanhoFonte objectAtIndex:row]floatValue];

        
        [defaults setFloat:fontSize forKey:@"fontSize"];
    }
    else
    {
        tipoFonte =[self.ArrayTipoFonte objectAtIndex:row];
        fontStyle = [self.ArrayTipoFonte objectAtIndex:row];
        [defaults setObject:fontStyle forKey:@"fontStyle"];
        
    }
    
  
    CLSViewController   *controller =[[CLSViewController alloc]init];
    controller.lblCateg.font =[UIFont fontWithName:fontStyle size:fontSize ];
    controller.valorGorjeta.font =[UIFont fontWithName:fontStyle size:fontSize ];
    controller.valorPessoa.font =[UIFont fontWithName:fontStyle size:fontSize ];
    controller.valorTotal.font =[UIFont fontWithName:fontStyle size:fontSize ];

    
    
    
    [defaults synchronize];

}

@end
