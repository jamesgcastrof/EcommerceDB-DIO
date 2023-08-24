-- Criar o banco de dados
CREATE DATABASE EcommerceDB;

-- Usar o banco de dados
USE EcommerceDB;

-- Criação da tabela de clientes
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE, -- Adicionei a restrição UNIQUE para evitar emails duplicados
    address VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    zip_code VARCHAR(10),
    account_type ENUM('PJ', 'PF') NOT NULL
);

-- Criação da tabela de produtos
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0), -- Adicionei a restrição CHECK para garantir que o preço seja positivo
    quantity INT NOT NULL CHECK (quantity >= 0), -- Adicionei a restrição CHECK para garantir que a quantidade não seja negativa
    category_id INT, -- Adicionei uma coluna para relacionar os produtos com as categorias
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Criação da tabela de pedidos
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Adicionei um valor padrão para a data do pedido
    total DECIMAL(10,2) NOT NULL CHECK (total >= 0), -- Adicionei a restrição CHECK para garantir que o total não seja negativo
    customer_id INT NOT NULL,
    shipping_id INT, -- Adicionei uma coluna para relacionar os pedidos com as opções de envio
    coupon_id INT, -- Adicionei uma coluna para relacionar os pedidos com os cupons
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (shipping_id) REFERENCES shipping(id),
    FOREIGN KEY (coupon_id) REFERENCES coupons(id)
);

-- Criação da tabela de pagamentos
CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    payment_type ENUM('credit_card', 'debit_card', 'pix', 'boleto') NOT NULL,
    order_id INT NOT NULL UNIQUE, -- Adicionei a restrição UNIQUE para garantir que cada pedido tenha apenas um pagamento
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Criação da tabela de itens do pedido
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quantity INT NOT NULL CHECK (quantity > 0), -- Adicionei a restrição CHECK para garantir que a quantidade seja positiva
    price DECIMAL(10,2) NOT NULL CHECK (price > 0), -- Adicionei a restrição CHECK para garantir que o preço seja positivo
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Criação da tabela de envio
CREATE TABLE shipping (
	id INT AUTO_INCREMENT PRIMARY KEY,
	status ENUM('processing', 'shipped', 'delivered') NOT NULL DEFAULT 'processing', -- Adicionei um valor padrão para o status do envio
	tracking_code VARCHAR(255),
	order_id INT NOT NULL UNIQUE, -- Adicionei a restrição UNIQUE para garantir que cada pedido tenha apenas um envio
	FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Criação da tabela de categorias
CREATE TABLE categories (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL UNIQUE, -- Adicionei a restrição UNIQUE para evitar nomes duplicados
	description TEXT,
	image_url VARCHAR(255)
);

-- Criação da tabela de avaliações
CREATE TABLE reviews (
	id INT AUTO_INCREMENT PRIMARY KEY,
	rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5), -- Adicionei a restrição CHECK para limitar a nota entre 1 e 5
	comment TEXT,
	review_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Adicionei um valor padrão para a data da avaliação
	product_id INT NOT NULL,
	FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Criação da tabela de cupons
CREATE TABLE coupons (
	id INT AUTO_INCREMENT PRIMARY KEY,
	coupon_code VARCHAR(10) NOT NULL UNIQUE, -- Adicionei a restrição UNIQUE para evitar códigos duplicados
	description TEXT,
	discount_amount DECIMAL(10,2) CHECK (discount_amount >= 0), -- Adicionei a restrição CHECK para garantir que o valor do desconto não seja negativo
	discount_percentage DECIMAL(5,2) CHECK (discount_percentage BETWEEN 0 AND 100), -- Adicionei a restrição CHECK para limitar a porcentagem do desconto entre 0 e 100
	expiration_date DATETIME NOT NULL CHECK (expiration_date > CURRENT_TIMESTAMP) -- Adicionei a restrição CHECK para garantir que a data de expiração seja futura
);
