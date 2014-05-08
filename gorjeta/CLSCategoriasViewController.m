//
//  CLSCategoriasViewController.m
//  gorjeta
//
//  Created by Celo on 24/02/14.
//  Copyright (c) 2014 Celo. All rights reserved.
//

#import "CLSCategoriasViewController.h"
#import "CLSLoginViewController.h"
#import "CLSViewController.h"

@interface CLSCategoriasViewController ()
{
    NSMutableArray     *content;
    NSString *categoria;
}

@end

@implementation CLSCategoriasViewController

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
    
    content= [[NSMutableArray alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Categorias" ofType:@"plist"]];
    
    
    NSLog(@"content %@",content);
 
}


    

    


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSLog(@"entrou");
    return [content count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
   

    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [[content objectAtIndex:indexPath.row]valueForKey:@"Categoria"];
    //categoria = cell.textLabel.text;
   
 
    
    
        
    
       return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
 
   
    NSString *recebeCategoria = [content objectAtIndex:indexPath.row];
    

   
    CLSViewController *muda = (CLSViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"CLSViewController"];
    [self presentViewController:muda animated:YES completion:nil];
  
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
