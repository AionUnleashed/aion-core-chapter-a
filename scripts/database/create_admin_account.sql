-- ==========================================
-- AION Core 4.7.5 - Criar Conta Admin
-- ==========================================
-- Execute no banco al_server_ls apos
-- importar os schemas
-- ==========================================

USE al_server_ls;

-- Criar conta de administrador
-- Usuario: admin
-- Senha: admin
-- IMPORTANTE: Troque a senha depois!
INSERT INTO account_data (name, password, access_level, membership, activated) 
VALUES ('admin', SHA1('admin'), 3, 2, 1);

-- Verificar se a conta foi criada
SELECT id, name, access_level, membership, activated 
FROM account_data 
WHERE name = 'admin';

-- ==========================================
-- Niveis de Acesso:
-- ==========================================
-- 0 = Jogador normal
-- 1 = GM nivel 1 (comandos basicos)
-- 2 = GM nivel 2 (comandos intermediarios)
-- 3 = Administrador completo (todos comandos)
-- ==========================================

-- ==========================================
-- Memberships:
-- ==========================================
-- 0 = Free (gratis)
-- 1 = Premium
-- 2 = VIP
-- ==========================================

-- ==========================================
-- Criar mais contas:
-- ==========================================
-- Para criar mais contas, use este modelo:
--
-- INSERT INTO account_data (name, password, access_level, membership, activated) 
-- VALUES ('novoUsuario', SHA1('senha123'), 0, 0, 1);
--
-- ==========================================
