# Progresso da Migração - Fase 1: Java 8

## Status: Estrutura Maven Completa ✅ | Aguardando Instalação de Ferramentas ⏳

---

## ✅ Concluído Até Agora (Durante queda de energia - Restaurado)

### 1. **Estrutura Maven Multi-Módulo Criada**

- ✅ [pom.xml](../pom.xml) - Parent POM raiz com `dependencyManagement` centralizado
- ✅ [AC-Commons/pom.xml](../AC-Commons/pom.xml) - Atualizado para herdar do parent
  - Removido `BoneCP`, adicionado `HikariCP`
  - Atualizado `commons-lang` → `commons-lang3`
  - Todas as dependências referenciando versões do parent
- ✅ [AC-Login/pom.xml](../AC-Login/pom.xml) - Novo, convertido de build.xml
- ✅ [AC-Game/pom.xml](../AC-Game/pom.xml) - Novo, convertido de build.xml
- ✅ [AC-Chat/pom.xml](../AC-Chat/pom.xml) - Novo, com Netty 4.1.100.Final

### 2. **Dependências Atualizadas (Gerenciadas pelo Parent POM)**

- `mysql-connector-java`: 5.1.18 → 8.0.33 ✅
- `slf4j-api`: 1.7.2 → 1.7.36 ✅
- `logback-classic/core`: 1.0.9 → 1.2.12 ✅
- `commons-io`: 2.1 → 2.11.0 ✅
- `commons-lang`: 2.6 → `commons-lang3` 3.12.0 ✅
- `guava`: 13.0.1 → 31.1-jre ✅
- `javassist`: 3.15.0-GA → 3.29.2-GA ✅
- `quartz`: 2.1.7 → 2.3.2 ✅
- `BoneCP` → `HikariCP` 4.0.3 ✅
- `netty`: 3.6.2 → 4.1.100.Final (AC-Chat) ✅

### 3. **Configurações de Compilação**

- ✅ Java source/target: 1.8
- ✅ `maven-compiler-plugin`: 3.11.0
- ✅ `maven-jar-plugin`: 3.3.0
- ✅ Encoding UTF-8
- ✅ Custom source directories mantidos (src/, config/, data/)

### 4. **Documentação Criada**

- ✅ [docs/INSTALL_JAVA8_MAVEN.md](INSTALL_JAVA8_MAVEN.md) - Guia completo de instalação
- ✅ [check-environment.ps1](../check-environment.ps1) - Script de verificação automática
- ✅ [docs/PROGRESS_PHASE1.md](PROGRESS_PHASE1.md) - Este arquivo (status do progresso)

---

## ⏳ Próximos Passos Imediatos

### PASSO 1: Instalar Ferramentas (VOCÊ PRECISA FAZER)

#### A. Instalar JDK 8

1. **Download OpenJDK 8** (recomendado):
   - Link: https://adoptium.net/temurin/releases/?version=8
   - Versão: Windows x64, JDK
   - Instalar em: `C:\Program Files\Eclipse Adoptium\jdk-8.0.392.8-hotspot\`

2. **Configurar variáveis de ambiente**:

   ```powershell
   # Abrir PowerShell como Administrador

   # Definir JAVA_HOME
   [System.Environment]::SetEnvironmentVariable('JAVA_HOME', 'C:\Program Files\Eclipse Adoptium\jdk-8.0.392.8-hotspot', 'Machine')

   # Adicionar ao PATH
   $path = [System.Environment]::GetEnvironmentVariable('PATH', 'Machine')
   $newPath = "$env:JAVA_HOME\bin;$path"
   [System.Environment]::SetEnvironmentVariable('PATH', $newPath, 'Machine')
   ```

3. **Verificar**:
   ```powershell
   # Reabrir terminal
   java -version
   # Deve mostrar: java version "1.8.0_xxx"
   ```

#### B. Instalar Maven 3.8.8

1. **Download**:
   - Link: https://archive.apache.org/dist/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.zip
   - Extrair para: `C:\apache-maven-3.8.8\`

2. **Configurar variáveis de ambiente**:

   ```powershell
   # Abrir PowerShell como Administrador

   # Definir M2_HOME
   [System.Environment]::SetEnvironmentVariable('M2_HOME', 'C:\apache-maven-3.8.8', 'Machine')

   # Adicionar ao PATH
   $path = [System.Environment]::GetEnvironmentVariable('PATH', 'Machine')
   $newPath = "$env:M2_HOME\bin;$path"
   [System.Environment]::SetEnvironmentVariable('PATH', $newPath, 'Machine')
   ```

3. **Verificar**:
   ```powershell
   # Reabrir terminal
   mvn --version
   # Deve mostrar: Apache Maven 3.8.8
   # Java version: 1.8.0_xxx
   ```

#### C. Verificar Ambiente

```powershell
cd "C:\Workspace\AION CORE 4.7.5"
.\check-environment.ps1
```

---

### PASSO 2: Build Inicial Maven (APÓS INSTALAR FERRAMENTAS)

```powershell
cd "C:\Workspace\AION CORE 4.7.5"

# 1. Validar estrutura Maven (não compila, apenas valida POMs)
mvn validate

# 2. Build completo (vai falhar - esperado nesta fase)
mvn clean install -DskipTests

# Se falhar, executar com debug para ver detalhes:
mvn clean install -X -DskipTests
```

**Erros Esperados no Build Inicial:**

- ❌ Imports de `org.apache.commons.lang.*` (não existe no commons-lang3)
- ❌ Referências a `BoneCPConfig`, `BoneCPDataSource`
- ❌ Imports de `org.jboss.netty.*` no AC-Chat (Netty 3.x)

**Estes erros serão corrigidos nos próximos passos.**

---

### PASSO 3: Refatorações de Código (APÓS BUILD TENTAR)

#### A. Migrar commons-lang → commons-lang3

```powershell
# Script será criado para fazer busca e substituição automática
# Em todos os arquivos .java:
# BUSCAR: org.apache.commons.lang.
# SUBSTITUIR: org.apache.commons.lang3.
```

#### B. Migrar BoneCP → HikariCP

- Atualizar classes em `AC-Commons/src/com/aionemu/commons/database/`
- Modificar `AC-Commons/config/network/database.properties`

#### C. Atualizar AC-Chat para Netty 4.x

- Refatorar código de rede
- Mudanças de package: `org.jboss.netty.*` → `io.netty.*`
- Atualizar Bootstrap, Channel, Handler APIs

---

## 📋 Checklist de Progresso

### Estrutura Maven ✅

- [x] Parent POM criado
- [x] AC-Commons POM atualizado
- [x] AC-Login POM criado
- [x] AC-Game POM criado
- [x] AC-Chat POM criado
- [x] Dependências centralizadas no parent

### Instalação de Ferramentas ⏳

- [ ] JDK 8 instalado
- [ ] JAVA_HOME configurado
- [ ] Maven 3.8.8 instalado
- [ ] M2_HOME configurado
- [ ] Ambiente verificado (check-environment.ps1)

### Build Maven ⏳

- [ ] `mvn validate` executado com sucesso
- [ ] `mvn clean install` executado (pode falhar)
- [ ] Erros de compilação identificados
- [ ] Log de erros analisado

### Refatorações de Código ⏳

- [ ] commons-lang → commons-lang3 migrado
- [ ] BoneCP → HikariCP migrado
- [ ] AC-Chat Netty 4.x atualizado
- [ ] JARs obsoletos removidos (libs/, jsr166)
- [ ] build.xml files deletados

### Scripts de Build ⏳

- [ ] Builder.bat atualizado para Maven
- [ ] build_maven_commons.bat atualizado
- [ ] build_all.bat criado

### Testes Finais Fase 1 ⏳

- [ ] Build completo sem erros
- [ ] Login Server inicia
- [ ] Game Server inicia
- [ ] Chat Server inicia
- [ ] Teste de conexão cliente
- [ ] Teste de gameplay básico
- [ ] Estabilidade 24h

---

## 🔧 Scripts de Ajuda Disponíveis

1. **check-environment.ps1** - Verifica instalação de Java e Maven
2. **Builder.bat** - Build script (será atualizado para Maven)
3. **build_maven_commons.bat** - Build AC-Commons (será atualizado)

---

## 📁 Arquivos Importantes

### POMs Criados/Atualizados

- `pom.xml` (305 linhas) - Parent POM
- `AC-Commons/pom.xml` (111 linhas) - Commons module
- `AC-Login/pom.xml` (192 linhas) - Login Server
- `AC-Game/pom.xml` (204 linhas) - Game Server
- `AC-Chat/pom.xml` (204 linhas) - Chat Server

### Arquivos Originais (Preservados)

- `AC-Login/build.xml` - Será deletado após build Maven funcionar
- `AC-Game/build.xml` - Será deletado após build Maven funcionar
- `AC-Chat/build.xml` - Será deletado após build Maven funcionar
- `AC-*/libs/*.jar` - Serão deletados após Maven baixar dependências

---

## 🚦 Status Atual

**Você está aqui:** 🔵 Estrutura Maven criada → **⏳ Aguardando instalação de JDK 8 + Maven**

```
[✅ POMs Criados] → [⏳ Instalar Tools] → [⏳ Build] → [⏳ Refatorar] → [⏳ Testar] → [Fase 1 Completa]
```

---

## 💡 Dica Rápida

Execute isto agora para verificar o status:

```powershell
cd "C:\Workspace\AION CORE 4.7.5"
.\check-environment.ps1
```

---

## 📞 Quando estiver pronto...

Após instalar JDK 8 e Maven, execute:

```powershell
mvn clean install -DskipTests -X
```

E me avise dos resultados para prosseguirmos com as refatorações!

---

**Data**: 2026-02-24
**Fase**: 1 (Java 1.7 → Java 8)
**Status**: Estrutura Maven ✅ | Aguardando instalação de ferramentas ⏳
**Próximo Marco**: Build inicial Maven bem-sucedido
