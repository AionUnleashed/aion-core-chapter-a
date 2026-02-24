-- ==========================================
-- AION Core 4.7.5 - Configuracao do Banco
-- ==========================================
-- Execute este script no MySQL para criar
-- os bancos de dados necessarios
-- ==========================================

-- Criar banco de dados do Game Server
CREATE DATABASE IF NOT EXISTS al_server_gs 
CHARACTER SET utf8 
COLLATE utf8_general_ci;

-- Criar banco de dados do Login Server
CREATE DATABASE IF NOT EXISTS al_server_ls 
CHARACTER SET utf8 
COLLATE utf8_general_ci;

-- Exibir bancos criados
SHOW DATABASES LIKE 'al_server%';

-- ==========================================
-- Proximos passos:
-- ==========================================
-- 1. Importe o schema do Game Server:
--    mysql -u root -p al_server_gs < AC-Game\sql\ac47_server_gs.sql
--
-- 2. Importe o schema do Login Server:
--    mysql -u root -p al_server_ls < AC-Login\sql\ac47_server_ls.sql
--
-- 3. Configure as credenciais em:
--    AC-Commons\config\network\database.properties
-- ==========================================
