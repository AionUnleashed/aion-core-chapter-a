# 📦 AION Core 4.7.5 - Índice de Arquivos de Ajuda

Este projeto agora inclui vários scripts e guias para facilitar a compilação e execução.

## 📘 Documentação

### 🌟 [readme.md](readme.md)

**Quick Start Guide em Português**

- Resumo rápido de todos os passos
- Links para downloads necessários
- Checklist de configuração
- Comandos GM básicos

### ⚙️ [maven_mysql_setup_complete.md](maven_mysql_setup_complete.md)

**✅ Instalação Maven e MySQL - COMPLETA**

- Maven 3.6.3 instalado em `C:\apache-maven-3.6.3`
- MySQL 5.7.44 configurado com credenciais
- Databases criadas e schemas importados
- Scripts automatizados de setup
- Guia de verificação e troubleshooting

### 📖 [build_and_run_guide.md](guides/build_and_run_guide.md)

**Guia Completo e Detalhado**

- Requisitos do sistema
- Configuração passo a passo do banco de dados
- Processo de compilação detalhado (manual e automático)
- Instruções de execução
- Resolução de problemas
- Configurações importantes
- Estrutura de diretórios

---

## 🔧 Scripts de Compilação

### ⚙️ [verify_requirements.bat](../scripts/build/verify_requirements.bat)

**Execute PRIMEIRO!**

```cmd
scripts\build\verify_requirements.bat
```

- ✅ Verifica se Java está instalado
- ✅ Verifica se Maven está instalado
- ✅ Verifica se MySQL está instalado
- ✅ Verifica estrutura do projeto
- ✅ Verifica arquivos de configuração
- ✅ Mostra status geral do sistema

### 🔨 [build_all.bat](../scripts/build/build_all.bat)

**Compilação Automatizada**

```cmd
scripts\build\build_all.bat
```

- Compila AC-Commons (Maven)
- Compila Login Server (Ant)
- Compila Game Server (Ant)
- Compila Chat Server (Ant)
- Verifica erros em cada etapa
- Mostra localização dos JARs compilados

### 🎛️ [Builder.bat](../Builder.bat)

**Menu Interativo Original**

```cmd
Builder.bat
```

- Menu visual com opções
- Compilação individual de cada componente
- Modo debug disponível
- Modo install disponível

---

## 🚀 Scripts de Execução

### 🔑 [start_login.bat](../scripts/start/start_login.bat)

**Inicia o Login Server**

```cmd
scripts\start\start_login.bat
```

- Memória: 128 MB min, 256 MB max
- Porta: 2106
- Cor: Verde

### 🎮 [start_game.bat](../scripts/start/start_game.bat)

**Inicia o Game Server**

```cmd
scripts\start\start_game.bat
```

- Memória: 512 MB min, 2048 MB max
- Porta: 7777
- Cor: Azul claro
- **Requer Login Server rodando!**

### 💬 [start_chat.bat](../scripts/start/start_chat.bat)

**Inicia o Chat Server**

```cmd
scripts\start\start_chat.bat
```

- Memória: 64 MB min, 128 MB max
- Porta: 10241
- Cor: Amarelo

### 🚀 [start_all_servers.bat](../scripts/start/start_all_servers.bat)

**Inicia Todos os Servidores Automaticamente**

```cmd
scripts\start\start_all_servers.bat
```

- Abre cada servidor em uma janela separada
- Aguarda 10 segundos entre cada inicialização
- Ordem correta: Login → Game → Chat

---

## 💾 Scripts de Banco de Dados

### � [setup_database.bat](../scripts/database/setup_database.bat)

**✅ Setup Completo Automatizado - RECOMENDADO**

```cmd
scripts\database\setup_database.bat
```

**Executa tudo automaticamente:**

- ✅ Cria databases `al_server_gs` e `al_server_ls`
- ✅ Importa schema do Game Server
- ✅ Importa schema do Login Server
- ✅ Cria conta admin (user: admin, pass: admin, level: 3)
- ✅ Verifica instalação

**Configuração:**

- MySQL Path: `C:\Program Files\MySQL\MySQL Server 5.7\bin`
- User: `root`
- Password: `vertrigo`

### 📊 [create_databases.sql](../scripts/database/create_databases.sql)

**Cria os Bancos de Dados (Manual)**

```cmd
mysql -u root -p < scripts\database\create_databases.sql
```

- Cria banco `al_server_gs` (Game Server)
- Cria banco `al_server_ls` (Login Server)
- Usa charset UTF-8

### 👤 [create_admin_account.sql](../scripts/database/create_admin_account.sql)

**Cria Conta de Administrador (Manual)**

```cmd
mysql -u root -p al_server_ls < scripts\database\create_admin_account.sql
```

- Usuário: `admin`
- Senha: `admin`
- Acesso: Nível 3 (Administrador completo)
- Membership: VIP

---

## 📋 Workflow Recomendado

### 1️⃣ Primeira Vez (Instalação)

```cmd
# 1. Verificar sistema
scripts\build\verify_requirements.bat

# 2. Setup COMPLETO do banco de dados (AUTOMATIZADO)
scripts\database\setup_database.bat

# OU manualmente (se preferir):
# mysql -u root -pvertrigo < scripts\database\create_databases.sql
# mysql -u root -pvertrigo al_server_gs < AC-Game\sql\ac47_server_gs.sql
# mysql -u root -pvertrigo al_server_ls < AC-Login\sql\ac47_server_ls.sql
# mysql -u root -pvertrigo al_server_ls < scripts\database\create_admin_account.sql

# 3. Compilar
scripts\build\build_all.bat

# 4. Executar
scripts\start\start_all_servers.bat
```

### 2️⃣ Uso Diário (Servidor Pronto)

```cmd
# Opção A - Iniciar tudo
scripts\start\start_all_servers.bat

# Opção B - Iniciar individualmente
scripts\start\start_login.bat
scripts\start\start_game.bat
scripts\start\start_chat.bat
```

### 3️⃣ Recompilar Após Mudanças

```cmd
# Recompilar tudo
scripts\build\COMPILAR_TUDO.bat

# Ou usar o menu interativo
Builder.bat
# Escolher opção 5 (Build All)
```

---

## 📁 Estrutura de Arquivos de Ajuda

```
AION CORE 4.7.5/
├── 📘 docs/
│   ├── LEIA-ME.md                  ← Quick Start
│   ├── INDICE.md                   ← Este arquivo
│   └── guides/
│       └── GUIA_COMPILACAO_EXECUCAO.md  ← Guia Completo
│
├── 🔧 scripts/
│   ├── build/
│   │   ├── verificar_requisitos.bat    ← Verificar sistema
│   │   └── COMPILAR_TUDO.bat           ← Compilar tudo
│   ├── start/
│   │   ├── start_login.bat             ← Login Server
│   │   ├── start_game.bat              ← Game Server
│   │   ├── start_chat.bat              ← Chat Server
│   │   └── start_all_servers.bat       ← Todos
│   └── database/
│       ├── criar_bancos.sql            ← Criar DBs
│       └── criar_conta_admin.sql       ← Conta admin
│
└── Builder.bat                         ← Menu interativo (raiz)
```

---

## 🎯 Atalhos Rápidos

| Ação                      | Comando                                                                  |
| ------------------------- | ------------------------------------------------------------------------ |
| **Verificar requisitos**  | `scripts\build\verificar_requisitos.bat`                                 |
| **Compilar projeto**      | `scripts\build\COMPILAR_TUDO.bat`                                        |
| **Iniciar servidores**    | `scripts\start\start_all_servers.bat`                                    |
| **Criar bancos MySQL**    | `mysql -u root -p < scripts\database\criar_bancos.sql`                   |
| **Importar schema Game**  | `mysql -u root -p al_server_gs < AC-Game\sql\ac47_server_gs.sql`         |
| **Importar schema Login** | `mysql -u root -p al_server_ls < AC-Login\sql\ac47_server_ls.sql`        |
| **Criar conta admin**     | `mysql -u root -p al_server_ls < scripts\database\criar_conta_admin.sql` |

---

## ⚠️ Arquivos que Você Precisa Editar

### 1. Configuração do Banco de Dados

**Arquivo:** `AC-Commons\config\network\database.properties`

```properties
# Altere estas linhas:
database.url = jdbc:mysql://localhost:3306/al_server_gs?useUnicode=true&characterEncoding=UTF-8
database.user = root
database.password = SUA_SENHA_AQUI    ← EDITE AQUI!
```

### 2. Configurações do Game Server (Opcional)

**Arquivo:** `AC-Game\config\main\gameserver.properties`

- Nome do servidor
- Taxas de XP, drop, etc.

### 3. Configurações de Rede (Opcional)

**Arquivo:** `AC-Game\config\network\network.properties`

- IP do servidor
- Portas
- Configurações de conexão

---

## 🔗 Links Úteis

| Recurso          | Link                                                                           |
| ---------------- | ------------------------------------------------------------------------------ |
| **Java JDK 7**   | https://www.oracle.com/java/technologies/javase/javase7-archive-downloads.html |
| **Apache Maven** | https://maven.apache.org/download.cgi                                          |
| **MySQL Server** | https://dev.mysql.com/downloads/mysql/                                         |
| **AION Wiki**    | https://aion.fandom.com/                                                       |

---

## ❓ Precisa de Ajuda?

1. **Verifique os logs:**
   - Login: `AC-Login\log\`
   - Game: `AC-Game\log\`
   - Chat: `AC-Chat\log\`

2. **Consulte a documentação:**
   - [LEIA-ME.md](LEIA-ME.md) - Início rápido
   - [GUIA_COMPILACAO_EXECUCAO.md](GUIA_COMPILACAO_EXECUCAO.md) - Guia completo

3. **Execute a verificação:**
   ```cmd
   verificar_requisitos.bat
   ```

---

## 📝 Notas Importantes

- ⚠️ **Sempre compile AC-Commons primeiro** (as outras dependem dele)
- ⚠️ **Inicie Login Server antes do Game Server**
- ⚠️ **Troque a senha admin após primeira execução** (segurança!)
- ⚠️ **Faça backup do banco antes de updates**
- ⚠️ **Confira os logs se algo não funcionar**

---

## ✅ Checklist de Primeira Instalação

- [ ] Java JDK 1.7+ instalado
- [ ] Maven instalado e no PATH
- [ ] MySQL instalado e rodando
- [ ] Executado: `verificar_requisitos.bat`
- [ ] Executado: `criar_bancos.sql`
- [ ] Importado: `ac47_server_gs.sql`
- [ ] Importado: `ac47_server_ls.sql`
- [ ] Executado: `criar_conta_admin.sql`
- [ ] Editado: `database.properties` (senha)
- [ ] Compilado: `COMPILAR_TUDO.bat`
- [ ] Testado: `start_all_servers.bat`
- [ ] Criado personagem e testado login

---

**Versão:** 4.7.5.x  
**Autor Original:** GiGatR00n  
**Scripts de Ajuda:** 2026  
**Idioma:** Português (Brasil)

---

## 🎮 Bom Jogo!

Todos os scripts foram criados para tornar sua experiência mais fácil.  
Se encontrar problemas, consulte o [GUIA_COMPILACAO_EXECUCAO.md](GUIA_COMPILACAO_EXECUCAO.md).

**Divirta-se com seu servidor AION!** 🚀
