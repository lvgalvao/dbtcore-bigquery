### Requisitos para o Modelo `stg_supplies`

#### 1. Geração de UUID para Suprimentos
- **Colunas Usadas**: `id` e `sku`
- **Descrição**: Concatenar as colunas `id` e `sku` para criar um identificador único (`supply_uuid`) para cada suprimento.
- **Motivação**: A criação de um identificador único ajuda a garantir a unicidade de registros e facilita a identificação de suprimentos em análises subsequentes.

#### 2. Renomeação de Colunas
- **Colunas Renomeadas**:
  - `id` para `supply_id`
  - `sku` para `product_id`
  - `name` para `supply_name`
- **Motivação**: Renomear colunas para nomes mais descritivos e consistentes com a convenção de nomenclatura do projeto.

#### 3. Conversão de Centavos para Dólares
- **Coluna Usada**: `cost`
- **Descrição**: Converter o valor do custo de centavos para dólares, arredondando para duas casas decimais.
- **Motivação**: Facilitar a análise financeira e garantir que os valores monetários estejam em um formato padrão de dólares.

#### 4. Classificação de Itens Perecíveis
- **Coluna Usada**: `perishable`
- **Descrição**: Determinar se o suprimento é perecível e armazenar essa informação como um valor booleano (`is_perishable_supply`).
- **Motivação**: Identificar itens perecíveis é importante para o gerenciamento de estoque e análises de logística.
