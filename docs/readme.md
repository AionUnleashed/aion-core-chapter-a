# 🎮 AION Core 4.7.5 - Quick Start

## ⚡ Início Rápido

### 1️⃣ Pré-requisitos

- ✅ Java JDK 1.7+ (já instalado)
- ❌ Apache Maven (precisa instalar)
- ❌ MySQL Server (precisa instalar)

### 2️⃣ Instalação

**Instale o Maven:**

- Download: https://maven.apache.org/download.cgi
- Adicione ao PATH do Windows

**Instale o MySQL:**

- Download: https://dev.mysql.com/downloads/mysql/

### 3️⃣ Configure o Banco de Dados

```cmd
mysql -u root -p < scripts\database\create_databases.sql
mysql -u root -p al_server_gs < AC-Game\sql\ac47_server_gs.sql
mysql -u root -p al_server_ls < AC-Login\sql\ac47_server_ls.sql
mysql -u root -p al_server_ls < scripts\database\create_admin_account.sql
```

**Edite as credenciais:**

- Arquivo: `AC-Commons\config\network\database.properties`
- Altere: `database.user` e `database.password`

### 4️⃣ Compile o Projeto

```cmd
scripts\build\build_all.bat
```

Este script compilará na ordem correta:

1. AC-Commons (Maven)
2. Login Server (Ant)
3. Game Server (Ant)
4. Chat Server (Ant)

### 5️⃣ Execute os Servidores

**Opção A - Iniciar tudo de uma vez:**

```cmd
scripts\start\start_all_servers.bat
```

**Opção B - Iniciar individualmente:**

```cmd
scripts\start\start_login.bat
scripts\start\start_game.bat
scripts\start\start_chat.bat
```

## 📚 Documentação Completa

Veja o guia detalhado: **[build_and_run_guide.md](guides/build_and_run_guide.md)**

## 🎯 Conta Admin Padrão

- **Usuário:** admin
- **Senha:** admin
- **Nível:** Administrador (nível 3)

⚠️ **IMPORTANTE:** Troque a senha após o primeiro login!

## 📁 Scripts Disponíveis

| Script                                   | Descrição                            |
| ---------------------------------------- | ------------------------------------ |
| `scripts\build\COMPILAR_TUDO.bat`        | Compila todo o projeto               |
| `scripts\build\verificar_requisitos.bat` | Verifica requisitos do sistema       |
| `scripts\start\start_login.bat`          | Inicia Login Server                  |
| `scripts\start\start_game.bat`           | Inicia Game Server                   |
| `scripts\start\start_chat.bat`           | Inicia Chat Server                   |
| `scripts\start\start_all_servers.bat`    | Inicia todos os servidores           |
| `Builder.bat`                            | Menu interativo de compilação (raiz) |
| `scripts\database\criar_bancos.sql`      | Cria bancos de dados MySQL           |
| `scripts\database\criar_conta_admin.sql` | Cria conta de administrador          |

## 🔧 Configurações Principais

- **Banco de Dados:** `AC-Commons\config\network\database.properties`
- **Login Server:** `AC-Login\config\network\network.properties`
- **Game Server:** `AC-Game\config\main\gameserver.properties`
- **Comandos Admin:** `AC-Game\config\administration\commands.properties`

## 🐛 Problemas Comuns

**Maven not found:**

- Instale o Maven e adicione ao PATH

**Connection refused:**

- Verifique se o MySQL está rodando
- Confirme credenciais em `database.properties`

**OutOfMemoryError:**

- Aumente a memória nos scripts de start
- Edite `start_game.bat` e aumente `-Xmx`

## 📊 Portas Padrão

- **Login Server:** 2106
- **Game Server:** 7777
- **Chat Server:** 10241
- **MySQL:** 3306

## ✅ Checklist

- [ ] Java instalado
- [ ] Maven instalado
- [ ] MySQL instalado e rodando
- [ ] Bancos criados
- [ ] Schemas importados
- [ ] Credenciais configuradas
- [ ] Projeto compilado
- [ ] Servidores iniciados

## 🎮 Comandos GM no Jogo

```
//heal - Cura completa
//speed <valor> - Aumenta velocidade
//additem <id> <qtd> - Adicionar item
//addset <nome> - Adicionar set
//reload - Recarregar configs
//announce <msg> - Anúncio global
```

---

**Versão:** 4.7.5.x  
**Autor:** GiGatR00n  
**Data:** 2026

Para mais detalhes, consulte: **[GUIA_COMPILACAO_EXECUCAO.md](GUIA_COMPILACAO_EXECUCAO.md)**
