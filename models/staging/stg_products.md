### Requisitos para o Modelo `stg_products`

O modelo `stg_products` é responsável por transformar os dados brutos de produtos para um formato preparado para análises adicionais. Aqui estão os requisitos detalhados para cada parte do modelo.

1. **Renomeação de Colunas**
   - **Colunas Renomeadas**:
     - `sku` para `product_id`
     - `name` para `product_name`
     - `type` para `product_type`
     - `description` para `product_description`
   - **Motivação**: Renomear colunas para nomes mais descritivos e consistentes com a convenção de nomenclatura do projeto.

2. **Conversão de Centavos para Dólares**
   - **Coluna Usada**: `price`
   - **Requisito**: Converter o valor do preço de centavos para dólares, arredondando para duas casas decimais.
   - **Motivação**: Facilitar a análise financeira e garantir que os valores monetários estejam em um formato padrão de dólares.

3. **Classificação de Itens por Tipo**
   - **Coluna Usada**: `type`
   - **Requisito**:
     - Determinar se o produto é um item alimentício (`is_food_item`) se o tipo for `jaffle`.
     - Determinar se o produto é uma bebida (`is_drink_item`) se o tipo for `beverage`.
   - **Motivação**: Classificar os produtos de acordo com seu tipo para facilitar análises e relatórios baseados em categorias de produtos.
