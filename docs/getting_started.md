# 🎯 INÍCIO RÁPIDO - AION Core 4.7.5

## ✅ Projeto Organizado!

Todos os arquivos foram movidos para pastas apropriadas:

```
docs/                    → 📚 Toda documentação
scripts/build/           → 🔨 Scripts de compilação
scripts/start/           → ▶️  Scripts de execução
scripts/database/        → 💾 Scripts SQL
```

---

## 🚀 3 Passos para Começar

### 1️⃣ Leia

```
readme_pt.md          ou
docs/readme.md
```

### 2️⃣ Compile

```bash
./scripts/build/ build_all.bat
```

### 3️⃣ Execute

```bash
./scripts/start/start_all_servers.bat
```

---

## 📖 Documentação Completa

- **[readme_pt.md](readme_pt.md)** - Visão geral
- **[navigation.md](navigation.md)** - Guia de navegação
- **[docs/readme.md](readme.md)** - Quick Start detalhado
- **[docs/index.md](index.md)** - Índice completo
- **[docs/guides/build_and_run_guide.md](guides/build_and_run_guide.md)** - Guia completo

---

## 🎯 MySQL (Git Bash)

```bash
# Configurar banco
mysql -u root -p < scripts/database/create_databases.sql
mysql -u root -p al_server_gs < AC-Game/sql/ac47_server_gs.sql
mysql -u root -p al_server_ls < AC-Login/sql/ac47_server_ls.sql
mysql -u root -p al_server_ls < scripts/database/create_admin_account.sql
```

---

## ⚙️ Pré-requisitos

- ✅ Java 1.7 (você tem!)
- ✅ MySQL 5.7 (você tem!)
- ❌ Maven (precisa instalar)

**Maven:** https://maven.apache.org/download.cgi

---

**🎮 Boa sorte com seu servidor!**

Veja [readme_pt.md](readme_pt.md) para mais detalhes.
