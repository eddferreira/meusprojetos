public class ImobiliariaController {
    // Declação das variaveis 
    public integer quartos {get; set;}    
    public integer banheiros {get; set;}  
    public integer sala {get; set;}  
    public integer copa {get; set;}  
    public integer cozinha {get; set;}  
    public integer garagens {get; set;}  
    public integer valor {get; set;}  
    public String tipImovel {get; set;}

    // Metodo pickList Tipo de Imoveis
    public List<SelectOption> GetMyOptions(){
        // Mapear o campo de lista de seleção/picklist que desejo listar
        Schema.DescribeFieldResult result = Imoveis__c.TipImovel__c.getDescribe();

        // Listar as opções validas dentro do meu campo
        List<Schema.PicklistEntry> entries = result.getPickListValues();

        // Criar a variavel de retorno do tipo lista para o objeto selectoption
        List<SelectOption> optionReturn = new List<SelectOption>();

        // Adicionar as opções do campo selecionado
        for(Schema.PicklistEntry pEntry : entries){

            // Se a opção esta ativa 
            // Ou pode aplicar o filtro que quiser, caso não querira mostrar todas as opções
            if(pEntry.isActive()){

                // Adciona o nome e o valor da variavel de retorno 
                optionReturn.add(new SelectOption(pEntry.getValue(), pEntry.getLabel()));
            }
        }
        
        // Retorna a lista do SelectOption criado na variavel de retorno 
        return optionReturn;
    }

    // Metodo salvar imoveis
    public void salvarImoveis(){
        Imoveis__c imoveis = new Imoveis__c();

        imoveis.Quartos__c = quartos;
        imoveis.Banheiro__c = banheiros;
        imoveis.Sala__c = sala;
        imoveis.Copa__c = copa;
        imoveis.Cozinha__c = cozinha;
        imoveis.Garagem__c = garagens;
        imoveis.Valor__c = valor;
        imoveis.TipImovel__c = tipImovel;
        
        try{
            if(imoveis.TipImovel__c != 'Nenhum' && imoveis.TipImovel__c != null){
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.CONFIRM, 'Imovel cadastrado com sucesso!'));

                insert imoveis;
                
                quartos = null;
                banheiros = null;
                sala = null;
                copa = null;
                cozinha = null;
                garagens = null;
                valor = null;
                tipImovel = null;

            }else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'O campo tipo imovel deve ser preenchido!'));
            }
            
        } catch (DmlException e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'Verifique todos os campos antes de salvar!'));
        }
    }
}
