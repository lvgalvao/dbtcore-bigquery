### Requisitos para o Modelo `stg_order_items`

O modelo `stg_order_items` é responsável por transformar os dados brutos de itens de pedidos para um formato preparado para análises adicionais. Aqui estão os requisitos detalhados para cada parte do modelo.

1. **Renomeação de Colunas**
   - **Colunas Renomeadas**:
     - `id` para `order_item_id`
     - `sku` para `product_id`
   - **Motivação**: Renomear colunas para nomes mais descritivos e consistentes com a convenção de nomenclatura do projeto.

2. **Manutenção de Colunas Essenciais**
   - **Colunas Mantidas**:
     - `order_id`
   - **Motivação**: Manter a coluna `order_id` para assegurar a referência entre itens de pedidos e pedidos.
