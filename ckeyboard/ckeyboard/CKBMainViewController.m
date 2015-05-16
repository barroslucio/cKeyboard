//
//  ViewController.m
//  ckeyboard
//
//  Created by Lúcio Barros on 09/05/15.
//  Copyright (c) 2015 BEPiD Fucapi. All rights reserved.
//

#import "CKBMainViewController.h"

// definição da quantidade máxima dos caracteres de cada campo (título e conteúdo)
#define MAX_TITLE_CHARACTERS 10
#define MAX_CONTENT_CHARACTERS 25

@interface CKBMainViewController ()
// outlets para a storyboard
@property (weak, nonatomic) IBOutlet UITextField *txtFieldTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldContent;
@property (weak, nonatomic) IBOutlet UITableView *tbViewButtons;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCancel;

// variável booleana que sinaliza se a célula está sendo editada ou não
@property (nonatomic) BOOL isEditing;
@end

@implementation CKBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // inicializa o sinalizador de ediçao como falso
    _isEditing = false;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Consulta o core data e retorna o número de Key (botões) armazenados
    return [[[KeyStore sharedStore] getAllKeys] count];
}

    // Ao selecionar uma célula da table view o usuário poderá editá-la.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Faz consulta ao core data e pega referência àquela instância de Key que foi salva
    Key *key = [[[KeyStore sharedStore] getAllKeys] objectAtIndex:indexPath.row];
    
    // manda os dados de título e conteúdo daquela instância para os text field na storyboard
    _txtFieldTitle.text = key.title;
    _txtFieldContent.text = key.content;
    
    // o sinalizador de edição é setado como verdadeiro
    _isEditing = true;
    
    // Verifica se deve ativar o botão Cancel
    [self shouldEnableButtonCancel];
    [self changeTitleAccordingToTheContext];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Referencia à celula com o identificador ButtonCell (nossa KeyTableViewCell)
    KeyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ButtonCell"];
    
    // Faz a consulta ao core data para setar as informações da Key que corresponde àquela célula
    Key *key = [[[KeyStore sharedStore] getAllKeys] objectAtIndex:indexPath.row];

    // Seta as informações da célula
    cell.lblKeyTitle.text = key.title;
    cell.keyIdentifier = key.identifier;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // a célula será deletada
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Pega referência ao objeto que já está salvo no core data
        Key *key = [[[KeyStore sharedStore] getAllKeys] objectAtIndex:indexPath.row];
        
        // manda este objeto ser deletado
        [[KeyStore sharedStore] removeKey:key];
        
        // solicita ao core data salvar as mudanças (remoção)
        [[KeyStore sharedStore] saveKeyChanges];
        
        // recarrega os dados da table view
        [self.tbViewButtons reloadData];
    }
}

- (IBAction)saveShortcut:(UIBarButtonItem *)sender {
    // só salva se os textfields possuírem conteúdo
    if(![_txtFieldTitle hasText] || ![_txtFieldContent hasText])
        return ;
    
    // caso a flag de edição seja verdadeira
    if(_isEditing) {
        // Pega referência (do core data) da instância de Key que está sendo editada
        Key *key = [[[KeyStore sharedStore] getAllKeys] objectAtIndex:[self.tbViewButtons indexPathForSelectedRow].row];
        
        // altera os dados (título e conteúdo)
        key.title = _txtFieldTitle.text;
        key.content = _txtFieldContent.text;
        
        // salva as alterações
        [[KeyStore sharedStore] saveKeyChanges];
        
        // "desliga" o sinalizador de edição
        _isEditing = false;
        
    // caso contrário, o usuário está salvando pela primeira vez, então
    } else {
        // pede à KeyStore que crie uma instância com as informações dos text fields
        [[KeyStore sharedStore] createKeyWithTitle:_txtFieldTitle.text AndContent:_txtFieldContent.text];
    }
    
    // recarrega os dados da table view
    [_tbViewButtons reloadData];
    
    // zera os text fields
    _txtFieldTitle.text = _txtFieldContent.text = @"";
    
    // trata o botão Cancell
    [self shouldEnableButtonCancel];
    
    [self changeTitleAccordingToTheContext];
}

    // ação executada quando o botão Cancel for clicado
- (IBAction)cancelAddOrEdition:(UIBarButtonItem *)sender {
    _txtFieldTitle.text = _txtFieldContent.text = @"";
    _isEditing = false;
    [self.tbViewButtons deselectRowAtIndexPath:[self.tbViewButtons indexPathForSelectedRow] animated:YES];
    [self changeTitleAccordingToTheContext];
    [self shouldEnableButtonCancel];
}

    // tratamento para o botão Cancel
- (void)shouldEnableButtonCancel {
    BOOL enableBtn;
    // caso não tenha texto nos text fields ele fica destivado, senão fica ativado
    if(_isEditing)
        enableBtn = YES;
    else if(![_txtFieldTitle hasText] && ![_txtFieldContent hasText])
        enableBtn = NO;
    else
        enableBtn = YES;
    
    [self.btnCancel setEnabled:enableBtn];
}

- (void)changeTitleAccordingToTheContext{
    if(_isEditing)
        [self.navigationItem setTitle:@"Editar Botão"];
    else
        [self.navigationItem setTitle:@"Novo Botão"];
}

    // esses actions fazem a mesma coisa, um pra cada text field
    // a cada vez que o valor num text field muda, eles verificam se o botão Cancel deve permanecer ativo
- (IBAction)activateBtnCancel1:(id)sender {
    [self shouldEnableButtonCancel];
}

- (IBAction)activateBtnCancel2:(id)sender {
    [self shouldEnableButtonCancel];
}

    // Esconder o teclado (ao clicar na tecla return)
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

    //Delimitar a quantidade de caracteres que pdem ser digitados
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    int MAX_LENGTH;
    if(textField == _txtFieldTitle) {
        MAX_LENGTH = MAX_TITLE_CHARACTERS;
    } else {
        MAX_LENGTH = MAX_CONTENT_CHARACTERS;
    }
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= MAX_LENGTH;
}

@end
