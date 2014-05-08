//
//  CLSRelatorioViewController.m
//  gorjeta
//
//  Created by Celo on 26/02/14.
//  Copyright (c) 2014 Celo. All rights reserved.
//

#import "CLSRelatorioViewController.h"
#import "Entity.h"
#import "CLSAppDelegate.h"
#import <CoreData/CoreData.h>
#import <Security/Security.h>

@interface CLSRelatorioViewController ()
{
    NSArray *fetchedObjects;
    NSString *valorPessoa;
    NSString *valorTotal;
    NSString *categoriaPessoa;
}

@end

@implementation CLSRelatorioViewController

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
    [self getValues];
 
    self.textFieldValorTotal.text = valorTotal;
    self.textFieldValorPessoa.text = valorPessoa;
    self.lblCategoria.text = categoriaPessoa;
    NSLog(@"CATEG %@",categoriaPessoa);
    
 }

-(void)getValues
{
        NSManagedObjectContext *context = [(CLSAppDelegate *)[[UIApplication sharedApplication]delegate]managedObjectContext ];
    
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Entity" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:entity1];
    
    Entity *categoria;
//        NSPredicate *pred = [NSPredicate predicateWithFormat:@"valor_pessoa==%@",categoria.valor_pessoa];
//       [fetchRequest setPredicate:pred];
    NSError *error;
    fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (Entity *cat in fetchedObjects ) {
        NSLog(@"VAlOR PESSOA busca %@",cat.valor_pessoa);
        NSLog(@"VALOR TOTAL busca %@",cat.valor_total);
        valorPessoa = cat.valor_pessoa;
        valorTotal = cat.valor_total;
        categoriaPessoa = cat.categoria;
    
        
        
}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btEditar:(UIButton *)sender {
    
}

- (IBAction)btExcluir:(UIButton *)sender {
}

- (IBAction)btEdita:(UIButton *)sender {

    
//	NSManagedObjectContext *context = [(CLSAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
//    
//    NSEntityDescription *entity2 =[NSEntityDescription entityForName:@"Entity"inManagedObjectContext:context] ;
//    //Entity *valorPessoas;
//    NSFetchRequest *request = [[NSFetchRequest alloc]init];
//    
//    [request setEntity:entity2];
//    Entity  *categoria;
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"valor_pessoa==%@",categoria.valor_pessoa];
//    [request setPredicate:predicate];
// 
//    NSError *error;
//    fetchedObjects = [context executeFetchRequest:request error:&error];
//
//    for (Entity *cat in fetchedObjects ) {
//        cat.valor_pessoa = self.textFieldValorPessoa.text;
//        cat.valor_total = self.textFieldValorTotal.text;
//    }
    

    
    
  
 //   [context save:&error];
  
   

    UIAlertView *editaOK = [[UIAlertView alloc]initWithTitle:@"EDITAR" message:@"EDITADO COM SUCESSO" delegate:self cancelButtonTitle:@"FEITO" otherButtonTitles:nil, nil];
  
    [editaOK show];
    
    
}

- (IBAction)btVolta:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
