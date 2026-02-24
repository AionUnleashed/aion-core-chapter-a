# 📋 Referência Rápida de Scripts

Todos os scripts foram organizados em pastas temáticas para facilitar a manutenção.

---

## 🔧 Scripts de Setup (`scripts/setup/`)

Scripts de instalação e configuração inicial do ambiente.

### Setup-Java8u471.ps1

**Uso**: Configura JDK 8u471 no terminal atual  
**Comando**:

```powershell
.\scripts\setup\Setup-Java8u471.ps1
```

**Descrição**: Define JAVA_HOME e PATH para usar JDK 8u471

### install-jdk8-admin.bat

**Uso**: Instala JDK 8 com privilégios de administrador  
**Comando**:

```cmd
.\scripts\setup\install-jdk8-admin.bat
```

### install-jdk8-workspace.ps1

**Uso**: Instala JDK 8 local no workspace  
**Comando**:

```powershell
.\scripts\setup\install-jdk8-workspace.ps1
```

### check-environment.ps1

**Uso**: Verifica configuração do ambiente (Java, Maven, etc)  
**Comando**:

```powershell
.\scripts\setup\check-environment.ps1
```

---

## 🏗️ Scripts de Build (`scripts/build/`)

Scripts de compilação dos módulos.

### Builder.bat

**Uso**: Menu interativo de build  
**Comando**:

```cmd
.\scripts\build\Builder.bat
```

**Opções**:

1. Build AC-Commons
2. Build AC-Login
3. Build AC-Game
4. Build AC-Chat
5. Build All
6. Clean All
7. Rebuild All

### build_maven_commons.bat

**Uso**: Compila apenas AC-Commons com Maven  
**Comando**:

```cmd
.\scripts\build\build_maven_commons.bat
```

### Clean All Builds.bat

**Uso**: Limpa todos os arquivos compilados  
**Comando**:

```cmd
.\scripts\build\Clean All Builds.bat
```

### PreCompile-DAOs.ps1

**Uso**: Pre-compila DAOs do MySQL5  
**Comando**:

```powershell
.\scripts\build\PreCompile-DAOs.ps1
```

**Descrição**: Gera `ac-game-daos-precompiled.jar` com 54 DAOs

### Create-DaoJar.ps1

**Uso**: Cria JAR com DAOs compilados  
**Comando**:

```powershell
.\scripts\build\Create-DaoJar.ps1
```

---

## 🚀 Scripts de Inicialização (`scripts/start/`)

Scripts para iniciar os servidores.

### Start-GameServer.ps1

**Uso**: Inicia o Game Server  
**Comando**:

```powershell
.\scripts\start\Start-GameServer.ps1
```

**Porta**: 7777  
**Memória**: 2GB (configurável)

### Start-LoginServer.ps1

**Uso**: Inicia o Login Server  
**Comando**:

```powershell
.\scripts\start\Start-LoginServer.ps1
```

**Porta**: 2106

### Start-ChatServer.ps1

**Uso**: Inicia o Chat Server  
**Comando**:

```powershell
.\scripts\start\Start-ChatServer.ps1
```

---

## 🔨 Scripts de Manutenção (`scripts/maintenance/`)

Scripts de correção e manutenção.

### fix-commons-lang3.ps1

**Uso**: Corrige referências de commons-lang para commons-lang3  
**Comando**:

```powershell
.\scripts\maintenance\fix-commons-lang3.ps1
```

**Descrição**: Atualiza imports em arquivos Java

### Fix-DAO-Predicates.ps1

**Uso**: Corrige conflitos de Predicate (Guava vs Java 8)  
**Comando**:

```powershell
.\scripts\maintenance\Fix-DAO-Predicates.ps1
```

### Fix-JavaPath.ps1

**Uso**: Corrige PATH do Java no sistema  
**Comando**:

```powershell
.\scripts\maintenance\Fix-JavaPath.ps1
```

**Descrição**: Remove conflitos de múltiplas instalações Java

---

## 📊 Logs (`logs/build/`)

Arquivos de log de compilações.

- `build-log.txt` - Log da última compilação
- `build-log2.txt` - Log secundário
- `build-log3.txt` - Log terciário
- `build_rev.txt` - Informações de revisão do build

---

## 🔄 Fluxo de Trabalho Típico

### Primeira Instalação

```powershell
# 1. Configurar ambiente
.\scripts\setup\Setup-Java8u471.ps1

# 2. Verificar configuração
.\scripts\setup\check-environment.ps1

# 3. Compilar projeto
.\scripts\build\Builder.bat
# Escolher opção 7 (Rebuild All)

# 4. Iniciar servidores
.\scripts\start\Start-LoginServer.ps1
.\scripts\start\Start-GameServer.ps1
```

### Desenvolvimento Diário

```powershell
# 1. Configurar Java (uma vez por sessão de terminal)
.\scripts\setup\Setup-Java8u471.ps1

# 2. Rebuild apenas módulo alterado
.\scripts\build\build_maven_commons.bat  # ou Builder.bat

# 3. Reiniciar servidor
Get-Process java | Stop-Process -Force
.\scripts\start\Start-GameServer.ps1
```

### Resolução de Problemas

```powershell
# Verificar ambiente
.\scripts\setup\check-environment.ps1

# Limpar builds
.\scripts\build\Clean All Builds.bat

# Corrigir Java PATH
.\scripts\maintenance\Fix-JavaPath.ps1

# Rebuild completo
.\scripts\build\Builder.bat  # Opção 7
```

---

## 🔄 Scripts .BAT Atualizados (24/02/2026)

Os scripts `.bat` em `scripts/start/` foram atualizados para usar Maven (target/) e Java 8u471:

### start_login.bat ✅

**Antes**: `build\AC-Login.jar` + Java 7  
**Agora**: `target\ac-login-4.7.5.jar` + Java 8 + AC-Commons Maven

```cmd
cd scripts\start
start_login.bat
```

### start_game.bat ✅

**Antes**: `build\AC-Game.jar` + Java 7  
**Agora**: `target\ac-game-4.7.5.jar` + Java 8 + AC-Commons Maven

```cmd
cd scripts\start
start_game.bat
```

### start_chat.bat ✅

**Antes**: Java 7  
**Agora**: Java 8 + AC-Commons Maven (ainda usa `build/AC-Chat.jar` - Ant)

```cmd
cd scripts\start
start_chat.bat
```

### start_all_servers.bat ✅

**Antes**: Timings desatualizados (15s login, 45s game)  
**Agora**: Timings corretos (12s login, 600s game = 10 min)

```cmd
cd scripts\start
start_all_servers.bat
```

**Ver detalhes completos**: [docs/BAT_SCRIPTS_UPDATE.md](BAT_SCRIPTS_UPDATE.md)

---

## ⚙️ Variáveis de Ambiente

Scripts que modificam ambiente do terminal atual:

- `Setup-Java8u471.ps1` - Define JAVA_HOME e PATH

Scripts que requerem privilégios administrativos:

- `install-jdk8-admin.bat` - Instalação global de JDK

Scripts standalone (não modificam ambiente):

- Todos os outros scripts

---

## 📝 Notas

- **PowerShell (.ps1)**: Podem requerer `Set-ExecutionPolicy RemoteSigned`
- **Batch (.bat)**: Rodam diretamente no CMD ou PowerShell
- **PATH no terminal**: `Setup-Java8u471.ps1` deve ser executado em cada nova sessão
- **Maven**: Configurado automaticamente por `Setup-Java8u471.ps1`
- **JDK**: Versão 8u471 requerida (instalada em `C:\Program Files\Java\jdk-1.8`)

---

## 🆘 Suporte

- **Documentação Completa**: `docs/JAVA8_MIGRATION_COMPLETE.md`
- **Guia de Instalação**: `docs/getting_started.md`
- **Troubleshooting**: `docs/JAVA8_MIGRATION_COMPLETE.md` (seção "Suporte & Troubleshooting")

---

**Última Atualização**: 24/02/2026  
**Versão Java**: 1.8.0_471  
**Status**: ✅ Produção
