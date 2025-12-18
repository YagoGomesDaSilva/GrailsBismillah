# Relação de Cardinalidade entre as Domain Classes

Este documento explica como funcionam os relacionamentos entre `Contact`, `ContactDetails` e `ContactGroup`.

## 1. **Contact ↔ ContactDetails** (Um para Muitos)

```groovy
// Contact.groovy
static hasMany = [contactDetails: ContactDetails]
static mapping = {
    contactDetails(cascade: 'all-delete-orphan')
}

// ContactDetails.groovy
Contact contact
```

**Cardinalidade:** 1:N (Um Contact possui vários ContactDetails)

- Um `Contact` pode ter **múltiplos** `ContactDetails`
- Cada `ContactDetails` pertence a **um único** `Contact`
- O `cascade: 'all-delete-orphan'` significa que:
  - Ao deletar um `Contact`, todos seus `ContactDetails` são deletados
  - Ao remover um `ContactDetails` da coleção, ele é deletado do banco

**Exemplo:**
```groovy
Contact joao = new Contact(name: "João")
joao.addToContactDetails(new ContactDetails(mobile: "123456"))
joao.addToContactDetails(new ContactDetails(email: "joao@email.com"))
joao.save()
```

## 2. **Contact ↔ ContactGroup** (Muitos para Muitos)

```groovy
// Contact.groovy
static hasMany = [contactGroup: ContactGroup]

// ContactGroup.groovy
static belongsTo = Contact
static hasMany = [contact: Contact]
```

**Cardinalidade:** N:M (Muitos para Muitos)

- Um `Contact` pode estar em **vários** `ContactGroup`
- Um `ContactGroup` pode ter **vários** `Contact`
- O `belongsTo = Contact` indica que `ContactGroup` é o lado "fraco" da relação
- Grails criará uma **tabela de junção** automaticamente (ex: `contact_contact_group`)

**Exemplo:**
```groovy
Contact joao = new Contact(name: "João")
ContactGroup familia = new ContactGroup(name: "Família")
ContactGroup trabalho = new ContactGroup(name: "Trabalho")

joao.addToContactGroup(familia)
joao.addToContactGroup(trabalho)
joao.save()
```

## 3. **Member e as Relações**

Tanto `Contact` quanto `ContactGroup` têm:
```groovy
Member member
```

**Cardinalidade:** N:1 (Muitos para Um)

- Vários `Contact` pertencem a um `Member`
- Vários `ContactGroup` pertencem a um `Member`
- Isso permite que cada usuário (Member) tenha seus próprios contatos e grupos

## Resumo Visual

```
Member (1) ←──── (N) Contact (1) ←──── (N) ContactDetails
                      ↕ (N:M)
Member (1) ←──── (N) ContactGroup
```

## Tabelas no Banco de Dados

- `contact` - tabela principal de contatos
- `contact_details` - detalhes do contato (FK: contact_id)
- `contact_group` - grupos de contatos
- `contact_contact_group` - tabela de junção (FK: contact_id, contact_group_id)
- `member` - usuários do sistema

## Operações Cascade

### Contact → ContactDetails
- **all-delete-orphan**: Ao deletar Contact, deleta todos ContactDetails
- Ao remover ContactDetails da coleção, o registro é deletado do banco

### Contact ↔ ContactGroup
- Sem cascade explícito: apenas remove a associação na tabela de junção
- Os registros de ContactGroup não são deletados automaticamente
