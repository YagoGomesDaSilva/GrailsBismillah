#  GrailsBismillah - Sistema de Gerenciamento de Contatos

<p align="center">
  <img src="https://grails.apache.org/images/grails_logo.svg" alt="Grails Logo" width="120"/>
</p>

> **Um sistema completo de agenda de contatos desenvolvido com Grails 7.0.4, seguindo as melhores práticas do framework e com suporte a Docker para facilitar a implantação.**

---

##  Índice

- [Sobre o Projeto](#-sobre-o-projeto)
- [Funcionalidades](#-funcionalidades)
- [Tecnologias Utilizadas](#-tecnologias-utilizadas)
- [Arquitetura do Sistema](#-arquitetura-do-sistema)
- [Pré-requisitos](#-pré-requisitos)
- [Como Executar](#-como-executar)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [Relacionamentos do Banco de Dados](#-relacionamentos-do-banco-de-dados)
- [Peculiaridades e Destaques](#-peculiaridades-e-destaques)
- [Documentação Oficial](#-documentação-oficial)

---

##  Sobre o Projeto

O **GrailsBismillah** É uma aplicação web de **agenda de contatos** desenvolvida com o framework **Grails 7.0.4**. O sistema permite que usuários se cadastrem, façam login e gerenciem seus próprios contatos de forma organizada, com suporte a:

- Múltiplos detalhes por contato (telefone, email, endereço, etc.)
- Organização de contatos em grupos personalizados
- Sistema de autenticação e autorização seguro
- Interface responsiva com Bootstrap 5

###  Objetivo

Este projeto foi desenvolvido como uma aplicação de referência para aprender e demonstrar os conceitos fundamentais do Grails, incluindo:

- Domain Classes com relacionamentos complexos (1:N e N:M)
- Interceptors para controle de autenticação
- Services para lógica de negócio
- Views GSP com layouts Sitemesh
- Integração com Docker e MariaDB

---

##  Funcionalidades

| Funcionalidade | Descrição |
|----------------|-----------|
|  **Autenticação** | Sistema de login/logout com criptografia MD5 |
|  **Registro de Usuário** | Cadastro de novos membros |
|  **Gerenciamento de Contatos** | CRUD completo de contatos |
|  **Detalhes do Contato** | Múltiplos telefones, emails, endereços por contato |
|  **Grupos de Contatos** | Organização em categorias (família, trabalho, etc.) |
|  **Dashboard** | Painel inicial com visão geral |
|  **Internacionalização (i18n)** | Suporte a múltiplos idiomas |

---

##  Tecnologias Utilizadas

### Backend
| Tecnologia | Versão | Descrição |
|------------|--------|-----------|
| **Grails** | 7.0.4 | Framework full-stack para JVM |
| **Groovy** | - | Linguagem de programação |
| **Java** | 17 | JDK base |
| **GORM/Hibernate 5** | - | ORM para persistência |
| **Spring Boot** | - | Base do Grails 7.x |

### Frontend
| Tecnologia | Versão | Descrição |
|------------|--------|-----------|
| **GSP** | - | Groovy Server Pages (templates) |
| **Bootstrap** | 5.3.3 | Framework CSS |
| **Bootstrap Icons** | 1.11.3 | Biblioteca de ícones |
| **jQuery** | 3.7.1 | Biblioteca JavaScript |
| **Sitemesh** | - | Sistema de layouts do Grails |

### Banco de Dados
| Tecnologia | Ambiente | Descrição |
|------------|----------|-----------|
| **H2** | Development/Test | Banco em memória |
| **MariaDB** | Production/Docker | Banco relacional |
| **HikariCP** | - | Connection pool de alta performance |

### DevOps e Ferramentas
| Tecnologia | Descrição |
|------------|-----------|
| **Docker** | Containerização |
| **Docker Compose** | Orquestração de containers |
| **Gradle** | Build tool e gerenciador de dependências |
| **Asset Pipeline** | Compilação de assets (CSS/JS) |

---

##  Arquitetura do Sistema

```

                        FRONTEND                              
        
     Views          Layouts         Assets             
     (GSP)         (Sitemesh)    (Bootstrap/jQuery)    
        

                             

                      CONTROLLERS                             
         
   Dashboard      Authentication   Contact/Group       
   Controller       Controller       Controllers       
         
                                                              
   
                INTERCEPTORS (Segurança)                   
    SecurityInterceptor | MemberInterceptor                
   

                             

                       SERVICES                               
         
   Member         Authentication   Contact/Details     
   Service           Service           Services        
         

                             

                    DOMAIN CLASSES                            
         
     Member        Contact      ContactGroup       
         
                                                             
                                           
                    ContactDetails                         
                                           

                             

                    GORM / HIBERNATE                          

                             

               DATABASE (H2 / MariaDB)                        

```

---

##  Pré-requisitos

### Para execução local:
- **JDK 17** ou superior
- **Gradle** (incluído via wrapper)

### Para execução com Docker:
- **Docker** instalado
- **Docker Compose** instalado

---

##  Como Executar

###  Opção 1: Docker Compose (Recomendado)

A forma mais simples de rodar o projeto completo com banco de dados MariaDB:

```bash
# Clonar o repositório
git clone <url-do-repositorio>
cd GrailsBismillah

# Subir todos os serviços (MariaDB + Aplicação)
docker-compose up -d --build

# Verificar se os containers estão rodando
docker-compose ps

# Ver logs da aplicação
docker-compose logs -f grails-app

# Ver logs do banco de dados
docker-compose logs mariadb
```

 **Acesse:** http://localhost:8080

#### Credenciais do Banco (Docker):
| Parâmetro | Valor |
|-----------|-------|
| Host | localhost |
| Porta | 3306 |
| Database | meubanco |
| Usuário | user_app |
| Senha | 123456 |
| Root Password | root123 |

---

###  Opção 2: Execução Local (Desenvolvimento)

Usando o wrapper do Gradle com banco H2 em memória:

```bash
# Windows
.\gradlew bootRun

# Linux/Mac
./gradlew bootRun
```

 **Acesse:** http://localhost:8080

---

###  Opção 3: Usando o Grails Wrapper

```bash
# Windows
.\grailsw run-app

# Linux/Mac
./grailsw run-app
```

---

###  Gerar WAR para Deploy

```bash
.\gradlew bootWar
```

O arquivo será gerado em build/libs/.

---

##  Estrutura do Projeto

```
GrailsBismillah/
 grails-app/
    assets/                    # Recursos estéticos
       images/
       javascripts/
       stylesheets/
   
    conf/                      # Configuraçães
       application.yml        # Config principal
       logback-spring.xml     # Configuração de logs
       spring/                # Beans do Spring
   
    controllers/               # Controllers (MVC)
       com/hmtmcse/ocb/
           AuthenticationController.groovy
           ContactController.groovy
           ContactDetailsController.groovy
           ContactGroupController.groovy
           DashboardController.groovy
           MemberController.groovy
           MemberInterceptor.groovy
           SecurityInterceptor.groovy
   
    domain/                    # Entidades do banco
       com/hmtmcse/ocb/
           Contact.groovy
           ContactDetails.groovy
           ContactGroup.groovy
           Member.groovy
   
    i18n/                      # Internacionalização
       messages.properties
       messages_pt_BR.properties
       ... (16+ idiomas)
   
    services/                  # Camada de negócio
       com/hmtmcse/ocb/
           AppInitializationService.groovy
           AuthenticationService.groovy
           ContactService.groovy
           ContactDetailsService.groovy
           ContactGroupService.groovy
           MemberService.groovy
   
    views/                     # Views GSP
        layouts/               # Layouts Sitemesh
        authentication/        # Telas de login/registro
        contact/               # CRUD de contatos
        contactDetails/        # Detalhes do contato
        contactGroup/          # Grupos de contatos
        dashboard/             # Painel principal
        Member/                # Gerenciamento de membros

 src/
    main/groovy/               # Classes auxiliares
    test/groovy/               # Testes unitários
    integration-test/groovy/   # Testes de integração

 docker-compose.yml             # Orquestração Docker
 Dockerfile                     # Imagem da aplicação
 build.gradle                   # Dependências e build
 gradle.properties              # Propriedades do Gradle
```

---

##  Relacionamentos do Banco de Dados

### Diagrama de Entidades

```
         
     Member                 ContactGroup   
         
 id                  1     id              
 firstName        name            
 lastName            N     member (FK)     
 email (unique)           
 password (MD5)                    
 memberType                         N:M
 isActive                          
         
                                            
          1            N       Contact      
         
                             id              
                             name            
                             image           
                             member (FK)     
                            
                                     
                                      1:N
                                     
                            
                             ContactDetails  
                            
                             id              
                             mobile          
                             phone           
                             email           
                             website         
                             address         
                             type            
                             contact (FK)    
                            
```

### Cardinalidades

| Relação | Tipo | Descrição |
|---------|------|-----------|
| **Member  Contact** | 1:N | Um membro possui vários contatos |
| **Member  ContactGroup** | 1:N | Um membro possui vários grupos |
| **Contact  ContactDetails** | 1:N | Um contato possui vários detalhes (cascade: all-delete-orphan) |
| **Contact  ContactGroup** | N:M | Contatos podem pertencer a máltiplos grupos (tabela de junção automática) |

---

##  Peculiaridades e Destaques

### 1.  Sistema de Segurança com Interceptors

O projeto utiliza **Interceptors** do Grails para controle de acesso:

```groovy
// SecurityInterceptor.groovy
class SecurityInterceptor {
    SecurityInterceptor() {
        matchAll().excludes(controller: "authentication")
    }
    
    boolean before() {
        if (!authenticationService.isAuthenticated()) {
            redirect(controller: "authentication", action: "login")
            return false
        }
        return true
    }
}
```

- Todas as rotas são protegidas **exceto** as de autenticação
- Redirecionamento automático para login

---

### 2.  Criptografia de Senha com GORM Events

```groovy
// Member.groovy
def beforeInsert() {
    this.password = this.password.encodeAsMD5()
}

def beforeUpdate() {
    this.password = this.password.encodeAsMD5()
}
```

- **beforeInsert**: Criptografa antes de salvar novo registro
- **beforeUpdate**: Mantém a senha criptografada nas atualizaçães

---

### 3.  Cascade Delete Orphan

```groovy
// Contact.groovy
static mapping = {
    contactDetails(cascade: 'all-delete-orphan')
}
```

- Ao deletar um **Contact**, todos os **ContactDetails** são removidos automaticamente
- Evita registros órfãos no banco de dados

---

### 4.  Sistema de Layouts Sitemesh

O projeto utiliza o sistema de templates do Grails com três níveis:

| Tag | Uso | Descrição |
|-----|-----|-----------|
| g:layoutBody/ | Layout | Injeta o corpo da view |
| content tag="..."  | View | Define blocos nomeados |
| g:pageProperty name="page..."/ | Layout | Recupera blocos nomeados |
| g:render template="..."/ | Qualquer | Reutiliza componentes |

---

### 5.  Internacionalização Completa

O projeto suporta **16+ idiomas** incluindo:
-  Português (Brasil)
-  Português (Portugal)
-  Inglês
-  Espanhol
-  Francês
-  Alemão
-  Japonês
-  Chinês
- E mais...

---

### 6.  Configuração Docker Multi-Stage

O projeto está preparado para deploy em containers:

- **MariaDB**: Banco de dados de produção
- **Grails App**: Aplicação containerizada
- **Health Checks**: Verificação automática de saúde do banco
- **Volumes Persistentes**: Dados do banco preservados

---

### 7.  Hot Reload com DevTools

```gradle
developmentOnly "org.springframework.boot:spring-boot-devtools"
```

- Recarregamento automático durante desenvolvimento
- Sem necessidade de reiniciar a aplicação

---

### 8.  Connection Pool de Alta Performance

```gradle
runtimeOnly "com.zaxxer:HikariCP"
```

- **HikariCP**: O connection pool mais rápido para JVM
- Gerenciamento eficiente de conexões com o banco

---

##  Documentação Oficial

### Grails 7.0.4
- [User Guide](https://grails.apache.org/docs/7.0.4/guide/index.html)
- [API Reference](https://grails.apache.org/docs/7.0.4/api/index.html)
- [Grails Guides](https://guides.grails.org/index.html)

### Features Utilizadas
- [Spring Boot DevTools](https://docs.spring.io/spring-boot/reference/using/devtools.html)
- [Asset Pipeline](https://github.com/wondrify/asset-pipeline#readme)
- [Geb Testing](https://groovy.apache.org/geb/manual/current/)
- [Scaffolding](https://grails.apache.org/docs/7.0.4/guide/scaffolding.html)

---

##  Licença

Este projeto é de uso educacional e livre para estudos.

---

<p align="center">
  <b>Desenvolvido por Yago Gomes usando Grails Framework</b>
</p>
