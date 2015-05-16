//
//  KeyStore.m
//  ckeyboard
//
//  Created by Patrick Magalhães de Lima on 14/05/15.
//  Copyright (c) 2015 BEPiD Fucapi. All rights reserved.
//

#import "KeyStore.h"

@interface KeyStore ()
//objeto que permitirá gerenciar objetos salvos no core data
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation KeyStore

static NSString *MODEL_ENTITY_NAME = @"Key";

+ (instancetype) sharedStore {
    //Cria um instância static de KeyStore
    static KeyStore *sharedStore;
    if(!sharedStore) {
        //Inicializa a instância
        sharedStore = [[self alloc] initPrivate];

        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        // Seta o objeto com uma referência à instância que gerencia os objetos do
        // core data da aplicação
        sharedStore.managedObjectContext = appDelegate.managedObjectContext;
    }
    return sharedStore;
}

- (instancetype)init {
    // retorna exceção caso o usuário tente iniciar uma instância diretamete
    @throw [NSException exceptionWithName:@"Couldn't create instance" reason:@"Use [KeyStore sharedStore]" userInfo:NULL];
}

    // método de inicialização privado (padrão Singleton)
- (instancetype)initPrivate {
    return (self = [super init]);
}

    // Cria uma instância de Key que será salva (e gerenciada) pelo core data
- (Key *)createKeyWithTitle:(NSString *)title AndContent:(NSString *)content {
    // Cria a instância da entidade Key
    Key *key = [NSEntityDescription insertNewObjectForEntityForName:MODEL_ENTITY_NAME inManagedObjectContext:self.managedObjectContext];
    // Seta as informações daquele objeto
    key.identifier = [[[NSUUID alloc] init] UUIDString];
    key.title = title;
    key.content = content;
    
    NSError *error;
    // Salva as alterações no core data ou imprime o erro, caso ocorra
    if(![self.managedObjectContext save:&error]) {
        NSLog(@"Occured an error saving the key! -> %@ - %@", error, error.debugDescription);
        abort();
    }
    // Retorna a instância de Key que foi criada
    return key;
}

    // Retorna todos as instâncias de Key salvas no core data
- (NSArray*)getAllKeys {
    // Prepara a requisição que será feita ao core data
    NSFetchRequest *fetchedRequestKey = [[NSFetchRequest alloc] initWithEntityName:MODEL_ENTITY_NAME];
    NSError *error;
    // Executa a requisição definida e guarda seu resultado num array
    NSArray *objects = [self.managedObjectContext executeFetchRequest:fetchedRequestKey error:&error];
    
    if(error) {
        NSLog(@"Error fetching requesting key! -> %@ - %@", error, error.userInfo);
    }
    
    //retorna o array com os objetos (instâncias de Key) salvos no core data
    return objects;
}

    // Salva as alterações de um determinado objeto que JÁ ESTEJA NO ESTADO GERENCIADO pelo core data
- (BOOL)saveKeyChanges {
    NSError *error;
    // verifica se há mudanças nos objetos
    if ([self.managedObjectContext hasChanges]) {
        // tenta salvar
        BOOL successful = [self.managedObjectContext save:&error];
        //em caso de não haver sucesso, imprimir a descrição do erro
        if (!successful) {
            NSLog(@"Error saving: %@", [error localizedDescription]);
        }
        // retorna falso (houve erro)
        return successful;
    }
    // caso tudo dê certo, retorna verdadeiro
    return YES;
}

    // Remove uma instância de Key caso ela esteja salva no core data
- (void)removeKey:(Key *)key {
    // envia mensagem de exclusão
    [self.managedObjectContext deleteObject:key];
}

@end
