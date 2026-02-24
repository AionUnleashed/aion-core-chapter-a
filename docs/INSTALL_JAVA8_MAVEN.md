# Guia de Instalação - Fase 1: Java 8 + Maven

## Status Atual

✅ Estrutura Maven criada (Parent POM + POMs dos módulos)
✅ Dependências atualizadas para Java 8
❌ JDK 8 não instalado
❌ Maven não instalado

---

## Passo 1: Instalar JDK 8

### Opção A: OpenJDK 8 (Recomendado - Open Source)

1. Download: https://adoptium.net/temurin/releases/?version=8
   - Selecione: **Windows x64**, **JDK**, **Version 8**
   - Arquivo: `OpenJDK8U-jdk_x64_windows_hotspot_8u392b08.msi` (ou versão mais recente)

2. Executar instalador:
   - Instalar em: `C:\Program Files\Eclipse Adoptium\jdk-8.0.392.8-hotspot\`
   - Marcar: ✓ Set JAVA_HOME variable
   - Marcar: ✓ Add to PATH

### Opção B: Oracle JDK 8 (Requer conta Oracle)

1. Download: https://www.oracle.com/java/technologies/javase/javase8-archive-downloads.html
   - Arquivo: `jdk-8u401-windows-x64.exe`

2. Executar instalador:
   - Instalar em: `C:\Program Files\Java\jdk1.8.0_401\`

### Verificar Instalação:

```powershell
# Abrir novo terminal PowerShell
java -version
# Deve mostrar: java version "1.8.0_xxx"

# Verificar JAVA_HOME
echo $env:JAVA_HOME
# Deve mostrar: C:\Program Files\Eclipse Adoptium\jdk-8.0.392.8-hotspot
```

### Configurar Manualmente (se necessário):

```powershell
# Definir JAVA_HOME (permanente)
[System.Environment]::SetEnvironmentVariable('JAVA_HOME', 'C:\Program Files\Eclipse Adoptium\jdk-8.0.392.8-hotspot', 'Machine')

# Adicionar ao PATH (permanente)
$path = [System.Environment]::GetEnvironmentVariable('PATH', 'Machine')
$newPath = "$path;$env:JAVA_HOME\bin"
[System.Environment]::SetEnvironmentVariable('PATH', $newPath, 'Machine')

# Reabrir terminal após configurar
```

---

## Passo 2: Instalar Maven 3.8.8

### Download:

1. Link: https://archive.apache.org/dist/maven/maven-3/3.8.8/binaries/
   - Arquivo: `apache-maven-3.8.8-bin.zip`

2. Extrair para: `C:\apache-maven-3.8.8\`
   - Estrutura: `C:\apache-maven-3.8.8\bin\mvn.cmd`

### Configurar Variáveis de Ambiente:

```powershell
# Definir M2_HOME (permanente)
[System.Environment]::SetEnvironmentVariable('M2_HOME', 'C:\apache-maven-3.8.8', 'Machine')

# Adicionar ao PATH (permanente)
$path = [System.Environment]::GetEnvironmentVariable('PATH', 'Machine')
$newPath = "$path;$env:M2_HOME\bin"
[System.Environment]::SetEnvironmentVariable('PATH', $newPath, 'Machine')

# Reabrir terminal após configurar
```

### Verificar Instalação:

```powershell
# Abrir novo terminal PowerShell
mvn --version
# Deve mostrar: Apache Maven 3.8.8
# Java version: 1.8.0_xxx
```

---

## Passo 3: Testar Build Inicial

Após instalar Java 8 e Maven, execute:

```powershell
# Navegar para o diretório raiz do projeto
cd "C:\Workspace\AION CORE 4.7.5"

# Build inicial (sem compilar, apenas validar POMs)
mvn validate

# Build completo (pode dar erros de compilação - esperado nesta etapa)
mvn clean install -DskipTests

# Se houver erros, executar com debug:
mvn clean install -X -DskipTests
```

---

## Próximos Passos (Após instalação bem-sucedida)

1. ✅ **Refatorar commons-lang → commons-lang3**
   - Buscar imports `org.apache.commons.lang.`
   - Substituir por `org.apache.commons.lang3.`

2. ✅ **Migrar BoneCP → HikariCP**
   - Atualizar classes de connection pool
   - Ajustar configurações em `database.properties`

3. ✅ **Atualizar AC-Chat para Netty 4.x**
   - Refatorar código de rede
   - Mudanças de API: `org.jboss.netty.*` → `io.netty.*`

4. ✅ **Remover JARs obsoletos**
   - Deletar `libs/` de AC-Login, AC-Game, AC-Chat
   - Remover `jsr166-*.jar`
   - Deletar `build.xml` files

5. ✅ **Atualizar scripts de build**
   - Modificar `Builder.bat` para usar Maven
   - Atualizar `build_maven_commons.bat`

---

## Troubleshooting

### Erro: "mvn não reconhecido"

- Fechar e reabrir terminal após configurar variáveis de ambiente
- Verificar PATH: `echo $env:PATH` deve conter Maven bin

### Erro: "JAVA_HOME não configurado"

- Executar comandos de configuração acima
- Verificar: `echo $env:JAVA_HOME`

### Maven baixa arquivos muito devagar

- Configurar proxy se necessário
- Usar mirror brasileiro: editar `C:\apache-maven-3.8.8\conf\settings.xml`

### Erros de compilação (esperados nesta fase)

- Normal: commons-lang ainda não migrado para commons-lang3
- Normal: BoneCP ainda presente no código
- Prosseguir com refatorações após build structure validar

---

## Arquivos Criados Nesta Etapa

✅ `pom.xml` (parent - raiz do projeto)
✅ `AC-Commons/pom.xml` (atualizado)
✅ `AC-Login/pom.xml` (novo)
✅ `AC-Game/pom.xml` (novo)
✅ `AC-Chat/pom.xml` (novo)
✅ `docs/INSTALL_JAVA8_MAVEN.md` (este arquivo)

---

## Comandos Rápidos

```powershell
# Compilar tudo
mvn clean install

# Compilar apenas Commons
mvn clean install -pl AC-Commons

# Compilar Game + dependências
mvn clean package -pl AC-Game -am

# Ver árvore de dependências
mvn dependency:tree -pl AC-Game

# Limpar builds
mvn clean
```

---

**Última atualização**: Fase 1 - Estrutura Maven criada
**Próximo milestone**: Instalação JDK 8 + Maven → Build inicial → Refatorações de código
