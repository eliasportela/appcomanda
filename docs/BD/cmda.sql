-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Tempo de geração: 04/07/2018 às 08:54
-- Versão do servidor: 5.7.21-0ubuntu0.16.04.1
-- Versão do PHP: 7.0.25-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `cmda`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `categoria_produto`
--

CREATE TABLE `categoria_produto` (
  `id_categoria` int(11) NOT NULL,
  `nome_categoria` varchar(80) NOT NULL,
  `gerar_pedido` int(11) NOT NULL DEFAULT '1',
  `fg_ativo` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Fazendo dump de dados para tabela `categoria_produto`
--

INSERT INTO `categoria_produto` (`id_categoria`, `nome_categoria`, `gerar_pedido`, `fg_ativo`) VALUES
(1, 'Ingredientes', 0, 1),
(2, 'Pizzas', 1, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `cidade`
--

CREATE TABLE `cidade` (
  `id_cidade` int(11) NOT NULL,
  `nome_cidade` varchar(120) NOT NULL,
  `estado` varchar(60) NOT NULL,
  `sigla_estado` varchar(2) NOT NULL,
  `fg_ativo` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `nome_cliente` int(11) NOT NULL,
  `email` int(11) NOT NULL,
  `telefone` int(11) NOT NULL,
  `endereco` int(11) NOT NULL,
  `numero` int(11) NOT NULL,
  `cep` int(11) NOT NULL,
  `complemento` int(11) NOT NULL,
  `id_cidade` int(11) NOT NULL,
  `fg_ativo` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `comanda`
--

CREATE TABLE `comanda` (
  `id_comanda` int(11) NOT NULL,
  `ref_comanda` varchar(200) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `data` datetime NOT NULL,
  `observacao` text NOT NULL,
  `tipo_comanda` int(11) NOT NULL,
  `id_mesa` int(11) DEFAULT NULL,
  `id_cliente_viagem` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Fazendo dump de dados para tabela `comanda`
--

INSERT INTO `comanda` (`id_comanda`, `ref_comanda`, `status`, `data`, `observacao`, `tipo_comanda`, `id_mesa`, `id_cliente_viagem`) VALUES
(1, 'cmd001', 1, '2018-07-03 17:00:00', '', 1, 1, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `comanda_produto`
--

CREATE TABLE `comanda_produto` (
  `id_comanda` int(11) NOT NULL,
  `id_produto` int(11) NOT NULL,
  `gerar_pedido` int(11) NOT NULL,
  `data_pedido` datetime NOT NULL,
  `status_pedido` int(11) NOT NULL,
  `quantidade` decimal(10,0) NOT NULL,
  `id_tabela_produto` int(11) NOT NULL,
  `observacao` text NOT NULL,
  `fg_ativo` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Fazendo dump de dados para tabela `comanda_produto`
--

INSERT INTO `comanda_produto` (`id_comanda`, `id_produto`, `gerar_pedido`, `data_pedido`, `status_pedido`, `quantidade`, `id_tabela_produto`, `observacao`, `fg_ativo`) VALUES
(1, 12, 1, '2018-07-03 17:00:00', 1, '1', 2, '', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `item_produto`
--

CREATE TABLE `item_produto` (
  `id_produto` int(11) NOT NULL,
  `id_produto_item` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Fazendo dump de dados para tabela `item_produto`
--

INSERT INTO `item_produto` (`id_produto`, `id_produto_item`) VALUES
(12, 1),
(12, 2),
(13, 1),
(13, 3),
(14, 1),
(14, 4),
(14, 3);

-- --------------------------------------------------------

--
-- Estrutura para tabela `mesa`
--

CREATE TABLE `mesa` (
  `id_mesa` int(11) NOT NULL,
  `nome_mesa` varchar(80) NOT NULL,
  `fg_ativo` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Fazendo dump de dados para tabela `mesa`
--

INSERT INTO `mesa` (`id_mesa`, `nome_mesa`, `fg_ativo`) VALUES
(1, 'MESA 01', 1),
(2, 'MESA 02', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `produto`
--

CREATE TABLE `produto` (
  `id_produto` int(11) NOT NULL,
  `nome_produto` varchar(200) NOT NULL,
  `ref_produto` varchar(200) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `fg_ativo` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Fazendo dump de dados para tabela `produto`
--

INSERT INTO `produto` (`id_produto`, `nome_produto`, `ref_produto`, `id_categoria`, `fg_ativo`) VALUES
(1, 'Mozzarella', '1001', 1, 1),
(2, 'Tomate', '1002', 1, 1),
(3, 'Catupiry', '1003', 1, 1),
(4, 'Milho', '1004', 1, 1),
(5, 'Presunto', '1005', 1, 1),
(6, 'Cebola', '1006', 1, 1),
(7, 'Azeitonas Verdes', '1007', 1, 1),
(8, 'Chedder', '1008', 1, 1),
(9, 'Calabresa', '1009', 1, 1),
(10, 'Pimenta Calabresa', '1010', 1, 1),
(11, 'Parmesão', '1011', 1, 1),
(12, 'Mozzarella', '01', 2, 1),
(13, 'Mozzarella c/ Catupiry', '02', 2, 1),
(14, 'Mozzarella c/ Milho e Catupiry', '03', 2, 1),
(15, 'Bauru', '04', 2, 1),
(16, 'Bauru c/ Catupiry', '05', 2, 1),
(17, 'Bauru c/ Chedder', '06', 2, 1),
(18, 'Calabresa Mineira', '07', 2, 1),
(19, 'Calabresa Baiana', '08', 2, 1),
(20, 'Calabresa Paulista', '09', 2, 1),
(21, 'Calacatu', '10', 2, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tabela_preco`
--

CREATE TABLE `tabela_preco` (
  `id_tabela` int(11) NOT NULL,
  `nome_tabela` varchar(60) NOT NULL,
  `fg_ativo` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Fazendo dump de dados para tabela `tabela_preco`
--

INSERT INTO `tabela_preco` (`id_tabela`, `nome_tabela`, `fg_ativo`) VALUES
(1, 'Esfiha', 1),
(2, 'Broto', 1),
(3, 'Grande', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tabela_produto`
--

CREATE TABLE `tabela_produto` (
  `id_tabela_produto` int(11) NOT NULL,
  `id_produto` int(11) NOT NULL,
  `id_tabela` int(11) NOT NULL,
  `valor` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Fazendo dump de dados para tabela `tabela_produto`
--

INSERT INTO `tabela_produto` (`id_tabela_produto`, `id_produto`, `id_tabela`, `valor`) VALUES
(1, 12, 2, '18.00'),
(2, 12, 3, '20.00');

--
-- Índices de tabelas apagadas
--

--
-- Índices de tabela `categoria_produto`
--
ALTER TABLE `categoria_produto`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Índices de tabela `cidade`
--
ALTER TABLE `cidade`
  ADD PRIMARY KEY (`id_cidade`);

--
-- Índices de tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`),
  ADD KEY `id_cidade` (`id_cidade`);

--
-- Índices de tabela `comanda`
--
ALTER TABLE `comanda`
  ADD PRIMARY KEY (`id_comanda`),
  ADD UNIQUE KEY `ref_comanda` (`ref_comanda`),
  ADD KEY `id_mesa` (`id_mesa`),
  ADD KEY `id_cliente_viagem` (`id_cliente_viagem`);

--
-- Índices de tabela `comanda_produto`
--
ALTER TABLE `comanda_produto`
  ADD KEY `id_comanda` (`id_comanda`),
  ADD KEY `id_produto` (`id_produto`),
  ADD KEY `id_tabela_produto` (`id_tabela_produto`);

--
-- Índices de tabela `item_produto`
--
ALTER TABLE `item_produto`
  ADD KEY `id_produto` (`id_produto`),
  ADD KEY `id_produto_item` (`id_produto_item`);

--
-- Índices de tabela `mesa`
--
ALTER TABLE `mesa`
  ADD PRIMARY KEY (`id_mesa`);

--
-- Índices de tabela `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`id_produto`),
  ADD UNIQUE KEY `ref_produto` (`ref_produto`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Índices de tabela `tabela_preco`
--
ALTER TABLE `tabela_preco`
  ADD PRIMARY KEY (`id_tabela`);

--
-- Índices de tabela `tabela_produto`
--
ALTER TABLE `tabela_produto`
  ADD PRIMARY KEY (`id_tabela_produto`),
  ADD KEY `id_produto` (`id_produto`),
  ADD KEY `id_tabela` (`id_tabela`);

--
-- AUTO_INCREMENT de tabelas apagadas
--

--
-- AUTO_INCREMENT de tabela `categoria_produto`
--
ALTER TABLE `categoria_produto`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de tabela `cidade`
--
ALTER TABLE `cidade`
  MODIFY `id_cidade` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de tabela `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de tabela `comanda`
--
ALTER TABLE `comanda`
  MODIFY `id_comanda` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de tabela `mesa`
--
ALTER TABLE `mesa`
  MODIFY `id_mesa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de tabela `produto`
--
ALTER TABLE `produto`
  MODIFY `id_produto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT de tabela `tabela_preco`
--
ALTER TABLE `tabela_preco`
  MODIFY `id_tabela` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de tabela `tabela_produto`
--
ALTER TABLE `tabela_produto`
  MODIFY `id_tabela_produto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Restrições para dumps de tabelas
--

--
-- Restrições para tabelas `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`id_cidade`) REFERENCES `cidade` (`id_cidade`);

--
-- Restrições para tabelas `comanda`
--
ALTER TABLE `comanda`
  ADD CONSTRAINT `comanda_ibfk_1` FOREIGN KEY (`id_mesa`) REFERENCES `mesa` (`id_mesa`),
  ADD CONSTRAINT `comanda_ibfk_2` FOREIGN KEY (`id_cliente_viagem`) REFERENCES `cliente` (`id_cliente`);

--
-- Restrições para tabelas `comanda_produto`
--
ALTER TABLE `comanda_produto`
  ADD CONSTRAINT `comanda_produto_ibfk_1` FOREIGN KEY (`id_comanda`) REFERENCES `comanda` (`id_comanda`),
  ADD CONSTRAINT `comanda_produto_ibfk_2` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`),
  ADD CONSTRAINT `comanda_produto_ibfk_3` FOREIGN KEY (`id_tabela_produto`) REFERENCES `tabela_produto` (`id_tabela_produto`);

--
-- Restrições para tabelas `item_produto`
--
ALTER TABLE `item_produto`
  ADD CONSTRAINT `item_produto_ibfk_1` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`),
  ADD CONSTRAINT `item_produto_ibfk_2` FOREIGN KEY (`id_produto_item`) REFERENCES `produto` (`id_produto`);

--
-- Restrições para tabelas `produto`
--
ALTER TABLE `produto`
  ADD CONSTRAINT `produto_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categoria_produto` (`id_categoria`);

--
-- Restrições para tabelas `tabela_produto`
--
ALTER TABLE `tabela_produto`
  ADD CONSTRAINT `tabela_produto_ibfk_1` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`),
  ADD CONSTRAINT `tabela_produto_ibfk_2` FOREIGN KEY (`id_tabela`) REFERENCES `tabela_preco` (`id_tabela`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
