# 🎮 AION Core 4.7.5 - Server Emulator

## 📖 Documentação

Este projeto agora está organizado com documentação completa em português!

### 📚 Guias Disponíveis

- **[Quick Start](readme.md)** - Guia rápido de início
- **[Guia Completo](guides/build_and_run_guide.md)** - Documentação detalhada de compilação e execução
- **[Índice](index.md)** - Índice completo de todos os recursos

## ⚡ Início Rápido

### Pré-requisitos

- Java JDK 1.7+
- Apache Maven 3.x
- MySQL Server 5.7+

### Compilar

```bash
scripts/build/build_all.bat
```

### Executar

```bash
scripts/start/start_all_servers.bat
```

## 📁 Estrutura do Projeto

```
AION CORE 4.7.5/
├── docs/                           # Documentação completa
│   ├── readme.md                 # Quick Start
│   ├── index.md                  # Índice geral
│   └── guides/                    # Guias detalhados
│       └── build_and_run_guide.md
│
├── scripts/                        # Scripts de automação
│   ├── build/                     # Scripts de compilação
│   │   ├── build_all.bat
│   │   └── verify_requirements.bat
│   ├── start/                     # Scripts de execução
│   │   ├── start_login.bat
│   │   ├── start_game.bat
│   │   ├── start_chat.bat
│   │   └── start_all_servers.bat
│   └── database/                  # Scripts SQL
│       ├── create_databases.sql
│       └── create_admin_account.sql
│
├── AC-Commons/                     # Módulo Commons (Maven)
├── AC-Login/                       # Login Server (Ant)
├── AC-Game/                        # Game Server (Ant)
├── AC-Chat/                        # Chat Server (Ant)
├── AC-Tools/                       # Ferramentas (Ant incluído)
│
└── Builder.bat                     # Menu interativo de build
```

## 🚀 Como Começar

1. **Verifique os requisitos:**

   ```bash
   scripts\build\verify_requirements.bat
   ```

2. **Configure o banco de dados:**

   ```bash
   mysql -u root -p < scripts\database\create_databases.sql
   mysql -u root -p al_server_gs < AC-Game\sql\ac47_server_gs.sql
   mysql -u root -p al_server_ls < AC-Login\sql\ac47_server_ls.sql
   ```

3. **Configure as credenciais do MySQL:**
   - Edite: `AC-Commons\config\network\database.properties`
   - Altere: `database.password`

4. **Compile o projeto:**

   ```bash
   scripts\build\build_all.bat
   ```

5. **Inicie os servidores:**
   ```bash
   scripts\start\start_all_servers.bat
   ```

## 🎯 Conta Admin Padrão

Após configurar o banco de dados:

```bash
mysql -u root -p al_server_ls < scripts\database\create_admin_account.sql
```

- **Usuário:** `admin`
- **Senha:** `admin`
- **Nível:** Administrador completo (nível 3)

⚠️ **Importante:** Troque a senha após o primeiro login!

## 📊 Portas Padrão

- **Login Server:** 2106
- **Game Server:** 7777
- **Chat Server:** 10241

## 🔧 Requisitos do Sistema

### Software Necessário:

- **Java JDK 1.7+** - [Download](https://www.oracle.com/java/technologies/javase/javase7-archive-downloads.html)
- **Apache Maven 3.x** - [Download](https://maven.apache.org/download.cgi)
- **MySQL Server 5.7+** - [Download](https://dev.mysql.com/downloads/mysql/)

### Memória Recomendada:

- Login Server: 256 MB
- Game Server: 2 GB
- Chat Server: 128 MB

## 📝 Comandos GM Básicos

```
//heal              - Cura completa
//speed <valor>     - Aumenta velocidade
//additem <id> <qtd> - Adicionar item
//addset <nome>     - Adicionar set completo
//reload            - Recarregar configurações
//announce <msg>    - Anúncio global
```

## 🐛 Resolução de Problemas

### Maven não encontrado

Instale o Maven e adicione ao PATH do sistema.

### Erro de conexão com banco de dados

- Verifique se o MySQL está rodando
- Confirme usuário/senha em `database.properties`

### OutOfMemoryError

Aumente a memória nos scripts de `scripts\start\`

## 📚 Documentação Completa

Para informações detalhadas, consulte:

- **[Guia Completo de Compilação e Execução](guides/build_and_run_guide.md)**
- **[Índice de Recursos](index.md)**

## ✨ Funcionalidades

Este servidor inclui:

- ✅ Idgel Dome v4.7 completamente implementado
- ✅ Sistema de Broker v4.7.5.x totalmente funcional
- ✅ Hotspot Teleport Service
- ✅ Sistema anti-cheat
- ✅ Sistema de drop customizável
- ✅ E muito mais...

## 👨‍💻 Autor

**GiGatR00n** - AION Core v4.7.5.x

## 📄 Licença

Este projeto está sob a GNU General Public License v3.0. Veja o arquivo [LICENSE](LICENSE) para detalhes.

---

**Para começar, leia:** [readme.md](readme.md) 🚀
