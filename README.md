# dbt-core & bigqueyr

[Excalidraw](https://link.excalidraw.com/l/8pvW6zbNUnD/394XJa9Ha8M)

Objetivos:

1) Configurar bigquery
2) Boas práticas com sqlfluff e pre-commit
3) Ingerindo dados raw com freshness
4) Staging
5) Revisitando staging para aplicar macros
6) Revisitando raw para aplicar macro de schema

## Configuração do Projeto

### 1. Clonar o Repositório

Primeiro, clone o repositório do projeto:

```bash
git clone https://github.com/lvgalvao/dbtcore-bigquery.git
cd dbtcore-bigquery
```

### 2. Inicializar o Poetry

Em seguida, inicialize o Poetry e instale as dependências:

```bash
poetry init
poetry install
```

### 3. Instalar Dependências Adicionais

Adicione o dbt Core, dbt-bigquery, pre-commit e sqlfluff ao ambiente do Poetry:

```bash
poetry add dbt-core dbt-bigquery
poetry add --dev pre-commit sqlfluff
```
### Configurando o Projeto com Pre-commit e SQLFluff

Neste projeto, vamos usar **pre-commit** para garantir que nosso código SQL e configuração estejam em conformidade com as melhores práticas antes de cada commit. Também usaremos **SQLFluff** para aplicar regras de formatação específicas ao nosso código SQL.

### Passos para Configuração

1. **Instalar Pre-commit e SQLFluff**
2. **Configurar Pre-commit**
3. **Configurar SQLFluff**

### 1. Instalar Pre-commit e SQLFluff

Primeiro, instale as ferramentas necessárias usando `poetry`:

```bash
poetry add --group dev pre-commit sqlfluff
```

### 2. Configurar Pre-commit

Crie um arquivo `.pre-commit-config.yaml` no diretório raiz do seu projeto com o seguinte conteúdo:

```yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: check-yaml
      - id: end-of-file-fixer
      - id: trailing-whitespace
      - id: requirements-txt-fixer
  - repo: https://github.com/charliermarsh/ruff-pre-commit
    rev: v0.3.4
    hooks:
      - id: ruff
        args: [--fix, --exit-non-zero-on-fix]
      - id: ruff-format
  - repo: https://github.com/sqlfluff/sqlfluff
    rev: 0.11.2
    hooks:
      - id: sqlfluff-lint
      - id: sqlfluff-fix
```

Em seguida, instale os hooks do pre-commit:

```bash
pre-commit install
```

### 3. Configurar SQLFluff

Crie um arquivo `.sqlfluff` no diretório raiz do seu projeto com o seguinte conteúdo:

```ini
[sqlfluff]
templater = dbt
dialect = bigquery
runaway_limit = 10
max_line_length = 80
indent_unit = space

[sqlfluff:templater:dbt]
profiles_dir = .

[sqlfluff:indentation]
tab_space_size = 4

[sqlfluff:layout:type:comma]
spacing_before = touch
line_position = trailing

[sqlfluff:rules:capitalisation.keywords]
capitalisation_policy = lower

[sqlfluff:rules:aliasing.table]
aliasing = explicit

[sqlfluff:rules:aliasing.column]
aliasing = explicit

[sqlfluff:rules:aliasing.expression]
allow_scalar = False

[sqlfluff:rules:capitalisation.identifiers]
extended_capitalisation_policy = lower

[sqlfluff:rules:capitalisation.functions]
capitalisation_policy = lower

[sqlfluff:rules:capitalisation.literals]
capitalisation_policy = lower

[sqlfluff:rules:ambiguous.column_references]  # Number in group by
group_by_and_order_by_style = implicit
```

### 4. Atualizar o README

Atualize o arquivo `README.md` do seu projeto para incluir as instruções de configuração do projeto.

#### Exemplo de Atualização do README

```markdown
# jaffle-shop

Este é o projeto `jaffle-shop` configurado para usar dbt Core e BigQuery. Além disso, estamos utilizando o Pre-commit e SQLFluff para garantir a qualidade do código.

## Configuração do Projeto

### 1. Instalar Dependências

Instale as dependências necessárias usando `poetry`:

```bash
poetry install
```

### 2. Configurar Pre-commit

Instale os hooks do pre-commit:

```bash
pre-commit install
```

### 3. Configurar SQLFluff

Certifique-se de que o arquivo `.sqlfluff` está no diretório raiz do projeto com o seguinte conteúdo:

```ini
[sqlfluff]
templater = dbt
dialect = bigquery
runaway_limit = 10
max_line_length = 80
indent_unit = space

[sqlfluff:templater:dbt]
profiles_dir = .

[sqlfluff:indentation]
tab_space_size = 4

[sqlfluff:layout:type:comma]
spacing_before = touch
line_position = trailing

[sqlfluff:rules:capitalisation.keywords]
capitalisation_policy = lower

[sqlfluff:rules:aliasing.table]
aliasing = explicit

[sqlfluff:rules:aliasing.column]
aliasing = explicit

[sqlfluff:rules:aliasing.expression]
allow_scalar = False

[sqlfluff:rules:capitalisation.identifiers]
extended_capitalisation_policy = lower

[sqlfluff:rules:capitalisation.functions]
capitalisation_policy = lower

[sqlfluff:rules:capitalisation.literals]
capitalisation_policy = lower

[sqlfluff:rules:ambiguous.column_references]  # Number in group by
group_by_and_order_by_style = implicit
```

### 4. Executar Seeds e Modelos

Carregue os dados das seeds e execute os modelos:

```bash
dbt seed
dbt run
```

### 5. Verificar e Corrigir o Código

Para verificar e corrigir o código SQL, utilize os comandos do SQLFluff:

```bash
sqlfluff lint models/
sqlfluff fix models/
```

Com esses passos, você terá configurado o projeto `jaffle-shop` com dbt Core e BigQuery, utilizando Pre-commit e SQLFluff para garantir a qualidade e consistência do código.

## Quickstart com dbt Core e BigQuery

### Resumo dos Passos

1. **Crie o Projeto no GCP.**
2. **Habilite a API do BigQuery no Google Cloud.**
3. **Configure o BigQuery no GCP.**
4. **Instale e Configure o dbt Core.**
5. **Crie e Configure uma Conta de Serviço no Google Cloud.**
6. **Configure o Perfil do dbt com a Conta de Serviço.**
7. **Defina as Variáveis de Ambiente no Arquivo `.env`.**
8. **Carregue as Variáveis de Ambiente e Execute os Comandos dbt.**

Com esses passos, você terá configurado com sucesso uma conta de serviço no Google Cloud Platform para uso com dbt Core e BigQuery.

### Criação do Projeto no GCP:

1. **Acesse o console do Google Cloud Platform**
    - Vá para o [Google Cloud Console](https://console.cloud.google.com/).
    - Crie um novo projeto.

### Habilitando a API do BigQuery no Google Cloud Platform

1. **Acesse o Console do Google Cloud:**
   - Vá para o [Google Cloud Console](https://console.cloud.google.com/).

2. **Selecione o Projeto:**
   - No topo da página, clique na lista suspensa de projetos e selecione o projeto no qual você deseja habilitar a API do BigQuery.

3. **Acesse a Biblioteca de APIs:**
   - No menu de navegação à esquerda, clique em `APIs e serviços` > `Biblioteca`.

4. **Procure pela API do BigQuery:**
   - Na barra de pesquisa, digite "BigQuery" e selecione "BigQuery API" nos resultados.

5. **Habilite a API:**
   - Clique no botão `Habilitar`.

### Configuração do BigQuery no GCP

Após habilitar a API do BigQuery, siga os passos abaixo para configurar o BigQuery:

1. **Acesse o BigQuery:**
   - No menu de navegação à esquerda, clique em `BigQuery` (pode estar dentro da seção "Big Data").

2. **Crie um Dataset:**
   - No painel de navegação do BigQuery, clique em `+` próximo ao nome do projeto e selecione `Criar Dataset`.
   - Preencha as informações necessárias:
     - **ID do Dataset:** Nome do dataset (por exemplo, `meu_dataset`).
     - **Localização dos Dados:** Escolha a localização (por exemplo, `US`).
   - Clique em `Criar Dataset`.

### Instalação e Configuração do dbt Core

Depois de configurar o BigQuery, você precisa instalar e configurar o dbt Core. Siga os passos abaixo:

1. **Instale o dbt Core:**
   - Execute o seguinte comando no terminal:
     ```bash
     poetry add dbt-core dbt-bigquery
     ```

2. **Inicie um Novo Projeto dbt:**
   - Crie uma pasta para o projeto dbt e navegue até ela:
     ```bash
     mkdir analytics
     cd analytics
     ```
   - Inicie um novo projeto dbt:
     ```bash
     dbt init analytics
     ```

3. **Configure o Perfil dbt para BigQuery:**
   - No diretório home do seu sistema, edite o arquivo `profiles.yml` (crie-o se não existir):
     ```yaml
     my_bigquery_project:
       target: dev
       outputs:
         dev:
           type: bigquery
           method: service-account
           project: "seu_projeto_gcp"
           dataset: "seu_dataset"
           keyfile: "/caminho/para/sua_chave.json"
           threads: 1
           timeout_seconds: 300
           location: "US"
           priority: interactive
           retries: 1
     ```
   - **project:** Nome do projeto no GCP.
   - **dataset:** Nome do dataset criado no BigQuery.
   - **keyfile:** Caminho para o arquivo de chave JSON da conta de serviço.

### Criando uma Conta de Serviço no Google Cloud Platform

Aqui estão os detalhes passo a passo para criar uma conta de serviço no Google Cloud Platform, incluindo exemplos de nomes e descrições adequados:

#### 1. Acessando o Console do Google Cloud
- Vá para o [Google Cloud Console](https://console.cloud.google.com/).

#### 2. Selecionando o Projeto
- No topo da página, clique na lista suspensa de projetos e selecione o projeto no qual você deseja criar a conta de serviço.

#### 3. Navegando para Contas de Serviço
- No menu de navegação à esquerda, clique em `IAM e administração` > `Contas de serviço`.

#### 4. Criando uma Nova Conta de Serviço
- Clique em `+ Criar Conta de Serviço`.

#### 5. Preenchendo os Detalhes da Conta de Serviço

- **Nome da Conta de Serviço:**
  - **Exemplo:** `dbt-service-account`
  - **Descrição:** Nome claro e conciso que descreva o propósito da conta.
- **ID da Conta de Serviço:** Será preenchido automaticamente com base no nome da conta. Você pode editá-lo se necessário.
  - **Exemplo:** `dbt-service-account@seu-projeto.iam.gserviceaccount.com`
- **Descrição da Conta de Serviço:**
  - **Exemplo:** `Conta de serviço utilizada para executar jobs automatizados do dbt Core no BigQuery.`

  Preencha os campos como mostrado abaixo:

  ![Criar Conta de Serviço](https://via.placeholder.com/800x400?text=Google+Cloud+Console+-+Criar+Conta+de+Servi%C3%A7o)

#### 6. Concedendo Permissões à Conta de Serviço
- Clique em `Criar e Continuar`.
- Na seção de permissões, adicione as permissões necessárias. Por exemplo:
  - **Função:** `BigQuery Admin`
  - Clique em `Continuar`.

#### 7. Criando a Chave JSON
- Na seção `Conceda aos usuários acesso a esta conta de serviço`, você pode adicionar usuários se necessário, ou clicar em `Concluído`.
- Na lista de contas de serviço, encontre a conta de serviço recém-criada.
- Clique no ícone de ações (três pontos verticais) ao lado da conta de serviço e selecione `Criar chave`.
- Selecione o formato `JSON` e clique em `Criar`.
- Um arquivo JSON será baixado para o seu computador. Este é o arquivo de chave que você usará para configurar o dbt.

#### 8. Configurando o Perfil do dbt com a Conta de Serviço

Edite o arquivo `profiles.yml` para incluir as credenciais do BigQuery usando a conta de serviço. Aqui está um exemplo de como deve ser o arquivo `profiles.yml`:

```yaml
analytics:
  outputs:
    dev:
      type: bigquery
      method: "{{ env_var('DBT_METHOD') }}"
      project: "{{ env_var('DBT_PROJECT') }}"
      dataset: "{{ env_var('DBT_DATASET') }}"
      keyfile: "{{ env_var('DBT_KEYFILE_PATH') }}"
      threads: "{{ env_var('DBT_THREADS') | int }}"
      timeout_seconds: "{{ env_var('DBT_JOB_TIMEOUT') | int }}"
      location: "{{ env_var('DBT_LOCATION') }}"
      priority: "{{ env_var('DBT_PRIORITY') }}"
      retries: "{{ env_var('DBT_JOB_RETRIES') | int }}"
  target: dev
```

Seguindo esses passos, você terá configurado com sucesso uma conta de serviço no Google Cloud Platform para uso com dbt Core e BigQuery.

### Verificando a Configuração

Para garantir que tudo está configurado corretamente, execute o comando `dbt debug` no seu prompt de comando:

```sh
dbt debug
```

Se tudo estiver configurado corretamente, você verá uma mensagem indicando que a conexão com o BigQuery foi bem-sucedida.

## Raw

### Conceito de `raw` no dbt

No contexto do dbt (data build tool), `raw` refere-se aos dados brutos que são carregados diretamente de fontes externas, como sistemas de produção, arquivos CSV, APIs, entre outros. Estes dados não foram processados ou transformados e são mantidos em seu estado original.

#### Importância dos Dados Brutos (`raw`)

1. **Fonte da Verdade**: Dados brutos servem como a fonte da verdade, capturando exatamente o que foi coletado no ponto de origem.
2. **Auditoria e Rastreamento**: Manter os dados em seu estado original permite auditorias e rastreamentos para verificar como os dados foram transformados ao longo do pipeline.
3. **Transformações Reprodutíveis**: Ter uma camada de dados brutos facilita a criação de transformações reprodutíveis e verificáveis.

#### Onde Inserir Dados Brutos no dbt

No dbt, os dados brutos são geralmente definidos como `sources` ou carregados como `seeds`.

1. **Sources**:
   - Definidos no arquivo `sources.yml`.
   - Usados para referenciar tabelas que já existem no banco de dados.
   - Exemplos de configuração de `sources`:
     ```yaml
     version: 2

     sources:
       - name: ecom
         schema: raw
         description: Dados de e-commerce para a Jaffle Shop
         tables:
           - name: raw_customers
             description: Um registro por pessoa que comprou um ou mais itens
           - name: raw_orders
             description: Um registro por pedido (consistindo em um ou mais itens do pedido)
           - name: raw_items
             description: Itens incluídos em um pedido
           - name: raw_stores
             description: Registro de cada loja com a data de abertura
           - name: raw_products
             description: Um registro por SKU para itens vendidos nas lojas
           - name: raw_supplies
             description: Um registro por suprimento por SKU de itens vendidos nas lojas
     ```

2. **Seeds**:
   - Arquivos CSV que são carregados diretamente no banco de dados como tabelas.
   - Definidos na pasta `seeds` do projeto dbt.
   - Exemplos de arquivos `CSV`:
     - `raw_customers.csv`
     - `raw_orders.csv`
     - `raw_items.csv`
     - `raw_stores.csv`
     - `raw_products.csv`
     - `raw_supplies.csv`
   - Comando para carregar seeds:
     ```bash
     dbt seed
     ```

#### Cuidados ao Inserir Dados Brutos

1. **Integridade dos Dados**:
   - Verifique a qualidade e integridade dos dados antes de carregá-los.
   - Certifique-se de que os dados brutos não contêm registros duplicados ou inválidos.

2. **Documentação**:
   - Documente todas as tabelas de dados brutos no arquivo `sources.yml`.
   - Inclua descrições claras e detalhadas para cada tabela e coluna.

3. **Consistência de Formato**:
   - Mantenha um formato consistente nos arquivos CSV.
   - Certifique-se de que todos os campos estão corretamente delimitados e escapados.

4. **Atualização e Carregamento**:
   - Estabeleça um processo regular de atualização para os dados brutos.
   - Use `dbt seed` para carregar novos dados ou atualizar os existentes.

5. **Segurança e Acesso**:
   - Restrinja o acesso aos dados brutos para evitar modificações não autorizadas.
   - Mantenha backups regulares dos arquivos CSV e das tabelas de dados brutos.

#### Exemplo de Carregamento de Seeds

1. **Estrutura do Projeto dbt**:
   ```
   ├── models
   ├── seeds
   │   ├── raw_customers.csv
   │   ├── raw_orders.csv
   │   ├── raw_items.csv
   │   ├── raw_stores.csv
   │   ├── raw_products.csv
   │   └── raw_supplies.csv
   └── dbt_project.yml
   ```

2. **Arquivo CSV (`raw_customers.csv`)**:
   ```csv
   id,name,email
   1,John Doe,john@example.com
   2,Jane Smith,jane@example.com
   ```

3. **Comando para Carregar os Seeds**:
   ```bash
   dbt seed
   ```

### Conclusão

Os dados brutos (`raw`) no dbt são fundamentais para garantir que as transformações de dados sejam reprodutíveis e auditáveis. Eles servem como a base para todas as operações subsequentes de transformação e análise de dados. Manter uma boa prática de carregamento e documentação de dados brutos é essencial para um pipeline de dados robusto e confiável.

## Conceito de Freshness no dbt

## Staging

### Conceito de `staging` no dbt

No contexto do dbt (data build tool), `staging` refere-se a uma camada intermediária onde os dados brutos (`raw`) são transformados e preparados para análises mais detalhadas ou para serem carregados em modelos mais complexos. Esta camada é crucial para limpar, padronizar e estruturar os dados antes de serem utilizados em modelos analíticos ou dashboards.

#### Importância dos Dados de `staging`

1. **Limpeza e Padronização**: A camada de `staging` é onde você limpa e padroniza os dados, removendo inconsistências e preparando-os para análises mais detalhadas.
2. **Transformações Intermediárias**: Permite aplicar transformações intermediárias que não alteram os dados brutos, mas os tornam mais utilizáveis.
3. **Facilidade de Uso**: Estrutura os dados de maneira que sejam mais fáceis de serem consultados e utilizados por analistas e cientistas de dados.
4. **Modularidade e Reuso**: Cria uma camada reutilizável de dados transformados que pode ser usada por vários modelos analíticos.

#### Onde Inserir os Dados de `staging` no dbt

No dbt, os dados de `staging` são geralmente definidos como modelos dentro da estrutura de diretórios do projeto.

1. **Modelos de `staging`**:
   - Definidos na pasta `models/staging` do projeto dbt.
   - Utilizam os dados brutos (`raw`) como fonte e aplicam transformações intermediárias.

#### Estrutura de Diretório

A estrutura típica de diretórios para modelos de `staging` pode ser assim:

```
├── models
│   ├── staging
│   │   ├── stg_customers.sql
│   │   ├── stg_orders.sql
│   │   ├── stg_order_items.sql
│   │   ├── stg_products.sql
│   │   ├── stg_stores.sql
│   │   └── stg_supplies.sql
```

#### Cuidados ao Criar Modelos de `staging`

1. **Documentação**:
   - Documente todas as transformações aplicadas nos modelos de `staging`.
   - Utilize arquivos YAML para descrever as tabelas e colunas transformadas.

2. **Nomenclatura Consistente**:
   - Use uma convenção de nomenclatura clara e consistente para todos os modelos de `staging`.
   - Prefixe os modelos com `stg_` para indicar que são modelos de `staging`.

3. **Manutenção de Integridade**:
   - Garanta que as transformações não alterem a integridade dos dados.
   - Preserve a chave primária e as relações importantes dos dados brutos.

4. **Performance**:
   - Otimize as consultas SQL para garantir que os modelos de `staging` sejam executados de maneira eficiente.

#### Exemplo de Modelo de `staging`

Aqui está um exemplo de um modelo de `staging` para `stg_customers`:

```sql
-- models/staging/stg_customers.sql

with source as (
    select * from {{ source('ecom', 'raw_customers') }}
),

renamed as (
    select
        id as customer_id,
        name as customer_name
    from source
)

select * from renamed
```

#### Documentação em YAML

Adicione uma documentação detalhada para os modelos de `staging` usando arquivos YAML:

```yaml
version: 2

models:
  - name: stg_customers
    description: "Dados de clientes transformados e padronizados"
    columns:
      - name: customer_id
        description: "Identificador único do cliente"
      - name: customer_name
        description: "Nome do cliente"

  - name: stg_orders
    description: "Dados de pedidos transformados e padronizados"
    columns:
      - name: order_id
        description: "Identificador único do pedido"
      - name: location_id
        description: "Identificador da localização"
      - name: customer_id
        description: "Identificador do cliente"
      - name: subtotal_cents
        description: "Subtotal em centavos"
      - name: tax_paid_cents
        description: "Imposto pago em centavos"
      - name: order_total_cents
        description: "Total do pedido em centavos"
      - name: subtotal
        description: "Subtotal em dólares"
      - name: tax_paid
        description: "Imposto pago em dólares"
      - name: order_total
        description: "Total do pedido em dólares"
      - name: ordered_at
        description: "Data do pedido truncada para dia"

  - name: stg_order_items
    description: "Dados de itens de pedidos transformados e padronizados"
    columns:
      - name: order_item_id
        description: "Identificador único do item do pedido"
      - name: order_id
        description: "Identificador do pedido"
      - name: product_id
        description: "Identificador do produto"

  - name: stg_products
    description: "Dados de produtos transformados e padronizados"
    columns:
      - name: product_id
        description: "Identificador único do produto"
      - name: product_name
        description: "Nome do produto"
      - name: product_type
        description: "Tipo do produto"
      - name: product_description
        description: "Descrição do produto"
      - name: product_price
        description: "Preço do produto em dólares"
      - name: is_food_item
        description: "Indica se o produto é um item alimentício"
      - name: is_drink_item
        description: "Indica se o produto é uma bebida"

  - name: stg_stores
    description: "Dados de lojas transformados e padronizados"
    columns:
      - name: location_id
        description: "Identificador único da loja"
      - name: location_name
        description: "Nome da loja"
      - name: tax_rate
        description: "Taxa de imposto da loja"
      - name: opened_date
        description: "Data de abertura da loja truncada para dia"

  - name: stg_supplies
    description: "Dados de suprimentos transformados e padronizados"
    columns:
      - name: supply_uuid
        description: "Identificador único do suprimento"
      - name: supply_id
        description: "Identificador do suprimento"
      - name: product_id
        description: "Identificador do produto"
      - name: supply_name
        description: "Nome do suprimento"
      - name: supply_cost
        description: "Custo do suprimento em dólares"
      - name: is_perishable_supply
        description: "Indica se o suprimento é perecível"
```

### Conclusão

Os modelos de `staging` no dbt desempenham um papel crucial na preparação dos dados brutos para análises mais complexas. Eles permitem a limpeza, padronização e transformação intermediária dos dados, facilitando o uso e a análise. Seguir boas práticas na criação e documentação desses modelos é essencial para garantir a integridade, performance e reutilização dos dados transformados.

A configuração de `freshness` no dbt (data build tool) é uma funcionalidade que permite monitorar a atualidade dos dados nas tabelas de origem, garantindo que você esteja sempre trabalhando com dados atualizados e confiáveis.

#### Componentes Principais

1. **`freshness`**:
   - Seção que define a verificação de atualidade dos dados.

2. **`loaded_at_field`**:
   - Coluna na tabela de origem que contém timestamps indicando quando os dados foram inseridos ou atualizados.

3. **`warn_after`**:
   - Define o tempo após o qual o dbt emitirá um aviso se os dados não tiverem sido atualizados.
   - **Exemplo**:
     ```yaml
     warn_after:
       count: 24
       period: hour
     ```
   - Isso significa que um aviso será emitido se os dados não forem atualizados em 24 horas.

4. **`error_after`**:
   - Define o tempo após o qual o dbt emitirá um erro se os dados não tiverem sido atualizados.
   - **Exemplo**:
     ```yaml
     error_after:
       count: 48
       period: hour
     ```
   - Isso significa que um erro será emitido se os dados não forem atualizados em 48 horas.

#### Diferença entre `warn` e `error`

- **Warn (Aviso)**:
  - Serve como um alerta de que os dados podem estar desatualizados.
  - O processo de execução continua, mas um aviso é emitido.
  - Útil para monitorar dados que estão começando a ficar desatualizados.

- **Error (Erro)**:
  - Indica um problema crítico com a atualidade dos dados.
  - Pode interromper o processo de execução, emitindo um erro.
  - Usado para dados que são críticos e precisam estar sempre atualizados.

#### Exemplo de Configuração

```yaml
version: 2

sources:
  - name: ecom
    schema: raw
    description: Dados de e-commerce para a Jaffle Shop
    freshness:
      warn_after:
        count: 24
        period: hour
      error_after:
        count: 48
        period: hour
    tables:
      - name: raw_customers
        description: Um registro por pessoa que comprou um ou mais itens
      - name: raw_orders
        description: Um registro por pedido (consistindo em um ou mais itens do pedido)
        loaded_at_field: ordered_at
      - name: raw_items
        description: Itens incluídos em um pedido
      - name: raw_stores
        loaded_at_field: opened_at
        description: Registro de cada loja com a data de abertura
      - name: raw_products
        description: Um registro por SKU para itens vendidos nas lojas
      - name: raw_supplies
        description: Um registro por suprimento por SKU de itens vendidos nas lojas
```

#### Testando a Configuração de Freshness

1. **Verificar Configuração**:
   - Certifique-se de que a configuração `freshness` está definida corretamente no arquivo `sources.yml`.

2. **Executar o Comando**:
   - No terminal, navegue até o diretório do projeto dbt e execute:
     ```bash
     dbt source freshness
     ```

3. **Analisar a Saída**:
   - O dbt verificará os timestamps na coluna especificada (`loaded_at_field`) e emitirá avisos ou erros com base nos tempos definidos em `warn_after` e `error_after`.

#### Exemplo de Saída

```plaintext
Running with dbt=1.0.0
Found 2 sources, 5 tables, 2 freshness checks

Freshness checks for source ecom.raw_orders:
 - loaded_at_field: ordered_at
 - warn_after: 24 hours
 - error_after: 48 hours

Freshness results:
 - source: ecom.raw_orders
   status: warn (27 hours ago)

Warnings:
 - The source 'ecom.raw_orders' is 27 hours old, which exceeds the warning threshold of 24 hours.

Errors:
 - The source 'ecom.raw_orders' is 51 hours old, which exceeds the error threshold of 48 hours.
```

#### Conclusão

A configuração de `freshness` no dbt é uma ferramenta poderosa para garantir que seus dados estejam atualizados, emitindo avisos e erros quando os dados excedem os limites definidos. Isso ajuda a manter a integridade das suas análises e a confiança nos seus dados.



## Macros

Macros são uma funcionalidade poderosa do dbt (data build tool) que permitem a reutilização de código SQL e a personalização dinâmica de comportamentos em seus modelos de dados. Eles são escritos em Jinja, uma linguagem de template para Python, e permitem a criação de trechos de código reutilizáveis que podem ser chamados em qualquer lugar do seu projeto dbt.

### O que é um Macro?

Um macro no dbt é uma função definida pelo usuário que pode ser utilizada para gerar ou manipular SQL de maneira programática. Eles são especialmente úteis para evitar duplicação de código, aplicar transformações consistentes e implementar lógica condicional nos seus scripts SQL.

### Benefícios dos Macros

1. **Reutilização de Código**: Macros permitem encapsular lógica comum em uma única definição reutilizável, reduzindo a repetição de código.
2. **Manutenção Simplificada**: Alterações na lógica centralizada dentro de um macro são refletidas em todos os lugares onde o macro é utilizado, facilitando a manutenção.
3. **Customização e Flexibilidade**: Macros podem usar parâmetros para gerar SQL dinamicamente, adaptando-se às necessidades específicas de diferentes modelos ou situações.
4. **Padronização**: Garantem que operações comuns, como formatação de datas ou tratamento de valores nulos, sejam realizadas de maneira consistente em todo o projeto.

### Exemplo de Uso de Macro

Um exemplo clássico de uso de macro no dbt é a conversão de valores em centavos para dólares de forma consistente em diferentes modelos e bancos de dados. O macro `cents_to_dollars` mostrado anteriormente é um exemplo prático de como isso pode ser implementado:

```jinja
{% macro cents_to_dollars(column_name) %}
    round(cast(({{ column_name }} / 100) as numeric), 2)
{% endmacro %}
```

Este macro define como os valores em centavos devem ser convertidos para dólares, com implementações específicas para PostgreSQL e BigQuery.

### Uso em um Modelo

Você pode chamar este macro dentro de um modelo dbt da seguinte forma:

```sql
select
    {{ cents_to_dollars('amount_in_cents') }} as amount_in_dollars
from
    {{ ref('transactions') }}
```

Neste exemplo, a coluna `amount_in_cents` será convertida para `amount_in_dollars` usando a lógica definida no macro `cents_to_dollars`.

### Conclusão

Macros são uma parte essencial do dbt, permitindo a criação de código SQL eficiente, reutilizável e fácil de manter. Eles ajudam a padronizar transformações de dados e a implementar lógica complexa de maneira simplificada, contribuindo para a qualidade e consistência dos seus pipelines de dados.

## Refatorando dolar e schema
