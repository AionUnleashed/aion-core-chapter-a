# 🗺️ Guia de Navegação - AION Core 4.7.5

## 📍 Estrutura do Projeto (Organizada)

```
AION CORE 4.7.5/
│
├── 📘 docs/                                    # Toda documentação está aqui
│   ├── readme.md                             # ⭐ COMECE AQUI - Quick Start
│   ├── index.md                              # Índice completo de recursos
│   └── guides/
│       └── build_and_run_guide.md        # Guia detalhado completo
│
├── 🔧 scripts/                                 # Todos os scripts de automação
│   ├── build/                                 # Scripts de compilação
│   │   ├── build_all.bat                  # Compilar todo o projeto
│   │   └── verify_requirements.bat           # Verificar sistema
│   │
│   ├── start/                                 # Scripts de execução
│   │   ├── start_all_servers.bat              # Iniciar tudo (recomendado)
│   │   ├── start_login.bat                    # Apenas Login Server
│   │   ├── start_game.bat                     # Apenas Game Server
│   │   └── start_chat.bat                     # Apenas Chat Server
│   │
│   └── database/                              # Scripts SQL
│       ├── create_databases.sql                   # Criar bancos MySQL
│       └── create_admin_account.sql              # Criar conta admin
│
├── 🎮 AC-Login/                                # Código-fonte Login Server
├── 🎮 AC-Game/                                 # Código-fonte Game Server
├── 🎮 AC-Chat/                                 # Código-fonte Chat Server
├── 📦 AC-Commons/                              # Código-fonte compartilhado
├── 🔨 AC-Tools/                                # Ferramentas (Ant, etc)
│
├── Builder.bat                                 # Menu interativo (original)
├── README.md                                   # README original (inglês)
├── README_PT.md                                # ⭐ README em português
└── NAVEGACAO.md                                # ⭐ Este arquivo
```

---

## 🚀 Começo Rápido (3 Passos)

### 1️⃣ Leia a Documentação

```
docs/readme.md                    ← Comece aqui!
```

### 2️⃣ Compile o Projeto

```bash
scripts\build\build_all.bat
```

### 3️⃣ Execute os Servidores

```bash
scripts\start\start_all_servers.bat
```

---

## 📖 Onde Encontrar Cada Coisa

### 📚 Precisa de Ajuda?

- **Quick Start:** `docs/readme.md`
- **Guia Completo:** `docs/guides/build_and_run_guide.md`
- **Índice de Recursos:** `docs/index.md`

### 🔨 Compilar o Projeto?

- **Verificar Requisitos:** `scripts/build/verify_requirements.bat`
- **Compilar Tudo:** `scripts/build/build_all.bat`
- **Menu Interativo:** `Builder.bat` (na raiz)

### ▶️ Executar os Servidores?

- **Todos de uma vez:** `scripts/start/start_all_servers.bat`
- **Login Server:** `scripts/start/start_login.bat`
- **Game Server:** `scripts/start/start_game.bat`
- **Chat Server:** `scripts/start/start_chat.bat`

### 💾 Configurar Banco de Dados?

- **Criar Bancos:** `scripts/database/create_databases.sql`
- **Conta Admin:** `scripts/database/create_admin_account.sql`
- **Configuração MySQL:** `AC-Commons/config/network/database.properties`

### ⚙️ Arquivos de Configuração?

- **Banco de Dados:** `AC-Commons/config/network/database.properties`
- **Login Server:** `AC-Login/config/network/network.properties`
- **Game Server:** `AC-Game/config/main/gameserver.properties`
- **Comandos Admin:** `AC-Game/config/administration/commands.properties`

### 📊 Schemas SQL?

- **Game Server:** `AC-Game/sql/ac47_server_gs.sql`
- **Login Server:** `AC-Login/sql/ac47_server_ls.sql`

---

## ✅ Checklist de Primeira Instalação

```
[ ] 1. Ler docs/LEIA-ME.md
[ ] 2. Instalar Java JDK 1.7+
[ ] 3. Instalar Maven
[ ] 4. Instalar MySQL
[ ] 5. Executar: scripts\build\verificar_requisitos.bat
[ ] 6. Executar: mysql -u root -p < scripts\database\criar_bancos.sql
[ ] 7. Importar: AC-Game\sql\ac47_server_gs.sql
[ ] 8. Importar: AC-Login\sql\ac47_server_ls.sql
[ ] 9. Executar: mysql -u root -p al_server_ls < scripts\database\criar_conta_admin.sql
[ ] 10. Editar: AC-Commons\config\network\database.properties
[ ] 11. Compilar: scripts\build\COMPILAR_TUDO.bat
[ ] 12. Executar: scripts\start\start_all_servers.bat
[ ] 13. Testar login com admin/admin
```

---

## 🎯 Comandos Rápidos (Copy & Paste)

### Verificar Sistema

```bash
scripts\build\verificar_requisitos.bat
```

### Configurar Banco (MySQL)

```bash
mysql -u root -p < scripts\database\criar_bancos.sql
mysql -u root -p al_server_gs < AC-Game\sql\ac47_server_gs.sql
mysql -u root -p al_server_ls < AC-Login\sql\ac47_server_ls.sql
mysql -u root -p al_server_ls < scripts\database\criar_conta_admin.sql
```

### Compilar Projeto

```bash
scripts\build\COMPILAR_TUDO.bat
```

### Iniciar Servidores

```bash
# Opção 1: Tudo de uma vez
scripts\start\start_all_servers.bat

# Opção 2: Individual (nesta ordem)
scripts\start\start_login.bat
scripts\start\start_game.bat
scripts\start\start_chat.bat
```

---

## 📋 Estrutura de Trabalho Diário

### 🌅 Ao Iniciar o Dia

```bash
# Inicie os servidores
scripts\start\start_all_servers.bat
```

### 🔄 Após Fazer Mudanças no Código

```bash
# 1. Pare os servidores (Ctrl+C em cada janela)

# 2. Recompile
scripts\build\COMPILAR_TUDO.bat

# 3. Reinicie os servidores
scripts\start\start_all_servers.bat
```

### 🌙 Ao Fim do Dia

```bash
# Apenas feche as janelas dos servidores
# ou pressione Ctrl+C em cada uma
```

---

## 🆘 Resolução Rápida de Problemas

### ❌ "Maven não encontrado"

- **Solução:** Instale Maven e adicione ao PATH
- **Link:** https://maven.apache.org/download.cgi

### ❌ "Erro de conexão com banco"

- **Verificar:** MySQL está rodando?
- **Arquivo:** `AC-Commons\config\network\database.properties`
- **Testar:** `mysql -u root -p` no terminal

### ❌ "JAR não encontrado"

- **Solução:** Compile o projeto primeiro
- **Comando:** `scripts\build\COMPILAR_TUDO.bat`

### ❌ "OutOfMemoryError"

- **Arquivo:** Edite os scripts em `scripts\start\`
- **Mudança:** Aumente `-Xmx` (ex: `-Xmx4096m`)

### ❌ "Porta já em uso"

- **Verificar:** Outro servidor está rodando?
- **Arquivo:** `AC-Game\config\network\network.properties`
- **Mudança:** Altere a porta

---

## 🔗 Links Importantes

| Recurso          | Link                                                                           |
| ---------------- | ------------------------------------------------------------------------------ |
| **Java JDK 7**   | https://www.oracle.com/java/technologies/javase/javase7-archive-downloads.html |
| **Apache Maven** | https://maven.apache.org/download.cgi                                          |
| **MySQL Server** | https://dev.mysql.com/downloads/mysql/                                         |

---

## 🎮 Informações do Servidor

### Portas Padrão

- **Login:** 2106
- **Game:** 7777
- **Chat:** 10241

### Conta Admin Padrão

- **Usuário:** `admin`
- **Senha:** `admin`
- **Nível:** 3 (Administrador completo)

### Comandos GM Básicos (in-game)

```
//heal              - Cura
//speed <valor>     - Velocidade
//additem <id> <qtd> - Item
//addset <nome>     - Set completo
//reload            - Recarregar configs
//announce <msg>    - Anúncio
```

---

## 💡 Dicas Úteis

1. **Sempre compile AC-Commons primeiro** - Os outros módulos dependem dele
2. **Inicie Login antes de Game** - Game precisa conectar ao Login
3. **Verifique os logs** - Cada módulo tem pasta `log/`
4. **Faça backup do banco** - Antes de atualizações importantes
5. **Troque a senha admin** - Por segurança!

---

## 📞 Suporte

### Logs

- Login: `AC-Login/log/`
- Game: `AC-Game/log/`
- Chat: `AC-Chat/log/`

### Documentação

- `docs/LEIA-ME.md` - Início rápido
- `docs/guides/GUIA_COMPILACAO_EXECUCAO.md` - Guia completo
- `docs/INDICE.md` - Índice de tudo

---

**Versão:** 4.7.5.x  
**Autor:** GiGatR00n  
**Organização:** 2026

**🎮 Divirta-se com seu servidor AION!**
