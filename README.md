# Projeto EcommerceDB

Este projeto contém scripts SQL para criar e manipular um banco de dados de comércio eletrônico chamado `EcommerceDB`.

## Estrutura do banco de dados

O banco de dados `EcommerceDB` contém várias tabelas para armazenar informações sobre clientes, produtos, pedidos, pagamentos, envios, categorias, avaliações e cupons.

A tabela `customers` armazena informações sobre os clientes, incluindo nome, sobrenome, email, endereço, cidade, estado, CEP e tipo de conta (PJ ou PF).

A tabela `products` armazena informações sobre os produtos, incluindo nome, descrição, preço e quantidade. Os produtos também podem ser relacionados a uma categoria através da coluna `category_id`.

A tabela `orders` armazena informações sobre os pedidos, incluindo data do pedido, total e ID do cliente. Os pedidos também podem ser relacionados a uma opção de envio através da coluna `shipping_id` e a um cupom através da coluna `coupon_id`.

A tabela `payments` armazena informações sobre os pagamentos, incluindo tipo de pagamento e ID do pedido.

A tabela `order_items` armazena informações sobre os itens do pedido, incluindo quantidade, preço, ID do pedido e ID do produto.

A tabela `shipping` armazena informações sobre o envio dos pedidos, incluindo status, código de rastreamento e ID do pedido.

A tabela `categories` armazena informações sobre as categorias dos produtos, incluindo nome, descrição e URL da imagem.

A tabela `reviews` armazena informações sobre as avaliações dos produtos, incluindo nota, comentário, data da avaliação e ID do produto.

A tabela `coupons` armazena informações sobre os cupons de desconto, incluindo código do cupom, descrição, valor do desconto, porcentagem do desconto e data de expiração.

## Como usar

Para usar esses scripts SQL, você precisa ter o MySQL instalado em seu computador. Depois de instalar o MySQL, siga estas etapas:

1. Abra o prompt de comando do MySQL e faça login com seu usuário e senha.
2. Execute o script `create_database.sql` para criar o banco de dados `EcommerceDB`.
3. Execute o script `create_tables.sql` para criar as tabelas no banco de dados.
4. (Opcional) Execute outros scripts SQL para inserir ou consultar dados no banco de dados.
