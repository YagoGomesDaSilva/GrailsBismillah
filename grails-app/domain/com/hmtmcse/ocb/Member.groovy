package com.hmtmcse.ocb

class Member {

    Integer id
    String firstName
    String lastName
    String email
    String password
    String memberType = GlobalConfig.USER_TYPE.REGULAR_MEMBER
    String identityHash
    Long identityHashLastUpdate
    Boolean isActive = true

    Date dateCreated
    Date lastUpdated

    static constraints = {
        email(email: true, nullable: false, unique: true, blank: false)
        password(blank: false)
        lastName(nullable: true)
        identityHash(nullable: true)
        identityHashLastUpdate(nullable: true)
    }

    def beforeInsert (){
        this.password = this.password.encodeAsMD5()
    }

    def beforeUpdate(){
        this.password = this.password.encodeAsMD5()
    }


    /*
    GORM Events são como "gatilhos" (triggers) que existem dentro do código da sua aplicação Grails.
    Eles permitem que você execute lógicas específicas automaticamente sempre que um objeto de domínio
    (uma tabela do banco) sofre alguma alteração, como ser salvo, atualizado ou deletado.

    Em termos simples: É uma forma de interceptar o ciclo de vida de um dado.

    Os eventos do GORM são uma funcionalidade exclusiva das Domain Classes (aquelas que ficam na pasta grails-app/domain).
    Esses eventos são gatilhos de banco de dados.
    O GORM (Grails Object Relational Mapping) é a biblioteca que vigia essas classes específicas.

    1. Antes de salvar (Pre-processing)
        beforeInsert: Executa antes de criar um novo registro no banco.
        Uso comum: Registrar a data de criação (dateCreated), gerar um código único, criptografar uma senha antes de salvar.

        beforeUpdate: Executa antes de alterar um registro existente.
        Uso comum: Atualizar a data de modificação (lastUpdated), verificar se um dado sensível foi alterado.

        beforeDelete: Executa antes de apagar um registro.
        Uso comum: Verificar se o item pode ser deletado ou apagar arquivos físicos (imagens) associados ao registro.

        beforeValidate: Executa antes do Grails verificar as restrições (constraints).
        Uso comum: Limpar dados (ex: remover espaços em branco de uma string) antes de validar se ela está vazia.

    2. Depois de salvar (Post-processing)
        afterInsert, afterUpdate, afterDelete: Executam logo após a operação no banco ter sucesso.
        Uso comum: Enviar um e-mail de notificação, atualizar um cache, registrar um log de auditoria.
    */

}
