# dbt-core & bigqueyr

### Configuração do Projeto

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
