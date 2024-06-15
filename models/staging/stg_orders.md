### Requisitos para o Modelo `stg_orders`

O modelo `stg_orders` é responsável por transformar os dados brutos de pedidos para um formato preparado para análises adicionais. Aqui estão os requisitos detalhados para cada parte do modelo.

1. **Renomeação de Colunas**
   - **Colunas Renomeadas**:
     - `id` para `order_id`
     - `store_id` para `location_id`
     - `customer` para `customer_id`
   - **Motivação**: Renomear colunas para nomes mais descritivos e consistentes com a convenção de nomenclatura do projeto.

2. **Conversão de Centavos para Dólares**
   - **Colunas Usadas**: `subtotal`, `tax_paid`, `order_total`
   - **Requisito**: Converter os valores de `subtotal`, `tax_paid` e `order_total` de centavos para dólares, arredondando para duas casas decimais.
   - **Motivação**: Facilitar a análise financeira e garantir que os valores monetários estejam em um formato padrão de dólares.

3. **Truncagem de Datas**
   - **Coluna Usada**: `ordered_at`
   - **Requisito**: Truncar a data e hora de `ordered_at` para o nível de precisão de dias.
   - **Motivação**: Facilitar a agregação e análise de dados temporais em uma granularidade diária.
