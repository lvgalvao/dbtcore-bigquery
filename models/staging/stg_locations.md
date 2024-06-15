### Requisitos para o Modelo `stg_locations`

O modelo `stg_locations` é responsável por transformar os dados brutos de locais (lojas) para um formato preparado para análises adicionais. Aqui estão os requisitos detalhados para cada parte do modelo.

1. **Renomeação de Colunas**
   - **Colunas Renomeadas**:
     - `id` para `location_id`
     - `name` para `location_name`
   - **Motivação**: Renomear colunas para nomes mais descritivos e consistentes com a convenção de nomenclatura do projeto.

2. **Manutenção de Colunas Numéricas**
   - **Colunas Mantidas**:
     - `tax_rate`
   - **Motivação**: Manter a coluna `tax_rate` para análises financeiras e fiscais.

3. **Truncagem de Datas**
   - **Coluna Usada**: `opened_at`
   - **Requisito**: Truncar a data e hora de `opened_at` para o nível de precisão de dias.
   - **Motivação**: Facilitar a agregação e análise de dados temporais em uma granularidade diária.
