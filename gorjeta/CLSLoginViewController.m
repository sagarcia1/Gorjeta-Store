//
//  CLSLoginViewController.m
//  gorjeta
//
//  Created by Celo on 22/02/14.
//  Copyright (c) 2014 Celo. All rights reserved.
//

#import "CLSLoginViewController.h"
#import "CLSViewController.h"
#import "CLSPreferencesViewController.h"
#import "CLSWrapper.h"
#import "CLSCategoriasViewController.h"

@interface CLSLoginViewController ()

@end

@implementation CLSLoginViewController
{
    KeychainItemWrapper *key;
    NSString *login;
    NSString *senha;
}

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
    
    BOOL didRunBefore = [[NSUserDefaults standardUserDefaults] boolForKey:@"FirstViewController_didRunBefore"];
    if (!didRunBefore) {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"FirstViewController_didRunBefore"];
        UIAlertView *alertInicio = [[UIAlertView alloc]initWithTitle:@"Primeiro acesso" message:@"Antes de começar cadastre o seu usuario" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertInicio show];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonSave:(UIButton *)sender {
}
- (IBAction)btCadastra:(UIButton *)sender {
   KeychainItemWrapper  *key1 = [[KeychainItemWrapper alloc]initWithIdentifier:@"PassWord" accessGroup:nil];
        login = self.textfieldLogin.text;
        senha =self.textfieldSenha.text  ;
    if ((login.length == 0 )&&(senha.length == 0)) {
        UIAlertView *erro = [[UIAlertView alloc]initWithTitle:@"ERRO" message:@"CAMPOS VAZIOS" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [erro show];

       

    }
    else if(senha.length !=  0){
   
    
    
    [key1 setObject:login forKey:(__bridge id)kSecAttrAccount];
        
    [key1 setObject:senha forKey:(__bridge id)kSecAttrLabel];
        
        
       // [key resetKeychainItem];
    
 
        
    UIAlertView *cadastro   =[[UIAlertView alloc]initWithTitle:@"CADASTRO" message:@"CADASTRADO COM SUCESSO" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [cadastro show];
        self.textfieldSenha.text = @"";
        self.textfieldLogin.text=@"";
    }else {
        UIAlertView *senhaVazia   =[[UIAlertView alloc]initWithTitle:@"CADASTRO" message:@"CAMPO SENHA VAZIO " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [senhaVazia show];
        
    }
    
}
- (IBAction)btLogin:(UIButton *)sender {
    
    KeychainItemWrapper *key2 = [[KeychainItemWrapper alloc]initWithIdentifier:@"PassWord" accessGroup:nil];
    
    login = [key2 objectForKey:(__bridge id)kSecAttrAccount];
   
    NSString *login1 = self.textfieldLogin.text;
    senha = [key2 objectForKey:(__bridge id)kSecAttrLabel];
    NSString *senha1 = self.textfieldSenha.text;
    if ( ([login1 isEqualToString:login]) && ([senha1 isEqualToString:senha]) ) {
        NSLog(@"logado");
        NSLog(@"%@ login final",login);
        NSLog(@"%@ senha final",senha);
        UIAlertView *logado =[[UIAlertView alloc]initWithTitle:@"LOGADO" message:@"LOGADO COM SUCESSO" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [logado show];
  CLSCategoriasViewController      *viewc = (CLSCategoriasViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"CLSViewController"];
        [self presentViewController:viewc animated:NO completion:nil];
    }
    else{
        UIAlertView *erro = [[UIAlertView alloc]initWithTitle:@"ERRO" message:@"Usuário e senha incorretos" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
      
        
        
        NSLog(@"não logado");
         NSLog(@"%@ login final",login);
        NSLog(@"%@ senha final",senha);
           NSLog(@"%@ senha", [key2 objectForKey:(__bridge id)kSecValueData]);
        [erro show];
    }

}

- (IBAction)touchLabel:(UITextField *)sender {
    [UIView animateWithDuration:0.1 animations:^{
      
        
        
    }];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
     [self.view endEditing:YES];
}

@end
