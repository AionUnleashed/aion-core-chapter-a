## Plan: Modernização Java 1.7 → Java 21 em 3 Fases

Migração progressiva do AION Core 4.7.5 de Java 1.7 para Java 21 através de três fases estratégicas (Java 8 → Java 11 → Java 21). A pesquisa revelou que o projeto usa **JAXB extensivamente** (300+ arquivos de data holders e templates), sistema de **compilação dinâmica de scripts** baseado em tools.jar, e **APIs internas sun.\*** — todos incompatíveis com Java 9+. Java 11 representa o maior desafio (remoção de Java EE APIs e modularização), enquanto Java 8 e 21 são transições mais suaves. Sem testes automatizados, cada fase exigirá validação manual rigorosa de todos os subsistemas (login, combat, quests, crafting, chat, etc).

**Decisões**:

- Três fases balanceiam gradualismo (reduz risco) e eficiência
- Java 8 primeiro: preparação com mínimas quebras, familiarização incremental
- Java 11 LTS: resolve modularização e JAXB (maior complexidade)
- Java 21 LTS: LTS mais recente com melhorias de performance/segurança
- **Padronizar build system: Ant → Maven** em todos os módulos (AC-Login, AC-Game, AC-Chat)
  - Estrutura multi-módulo com parent POM
  - Gerenciamento centralizado de dependências
  - Elimina duplicação de JARs nas pastas libs/
  - XMLs de dados (data/, config/, scripts/) permanecem intactos
- BoneCP → HikariCP (BoneCP não mantido desde 2013)
- MySQL Connector deve saltar de 5.1.18 (2011) para 8.x (segurança + Java 11+ support)

---

### **Por que Migrar para Maven?**

**Vantagens:**

- ✅ **Gerenciamento centralizado**: Uma única versão de cada dependência compartilhada entre módulos
- ✅ **Eliminação de duplicação**: Atualmente há ~25 JARs duplicados em AC-Login/libs, AC-Game/libs, AC-Chat/libs
- ✅ **Build simplificado**: Um comando (`mvn clean install`) compila tudo na ordem correta
- ✅ **IDE integration**: Melhor suporte em IntelliJ, Eclipse, VS Code
- ✅ **Repositórios Maven**: Acesso a milhares de bibliotecas atualizadas
- ✅ **Consistência**: Todos os módulos seguem o mesmo padrão de build

**O que MUDA:**

- `build.xml` → `pom.xml` em cada módulo
- `libs/` folders → dependências declaradas em POM
- `Builder.bat` chama Maven em vez de Ant
- Estrutura de pastas: MANTIDA (src/, config/, data/, scripts/)

**O que NÃO MUDA:**

- ❌ Nenhum XML de dados/configuração (data/, config/, scripts/ permanecem intactos)
- ❌ Nenhuma lógica de negócios ou código-fonte (apenas imports de dependências atualizadas)
- ❌ Estrutura de diretórios (Maven aceita custom source directories)
- ❌ Funcionalidades dos servidores (Login, Game, Chat)
- ❌ Database schemas ou queries

**Estrutura Maven Multi-Módulo (após Fase 1):**

```
AION CORE 4.7.5/
├── pom.xml                  (Parent POM - gerencia todos os módulos)
├── AC-Commons/
│   ├── pom.xml             (Módulo Commons)
│   ├── src/                (código fonte - MANTIDO)
│   ├── config/             (configurações - MANTIDO)
│   └── target/             (Maven output)
├── AC-Login/
│   ├── pom.xml             (Módulo Login - NOVO)
│   ├── src/                (código fonte - MANTIDO)
│   ├── config/             (configurações - MANTIDO)
│   ├── data/               (scripts - MANTIDO)
│   └── target/             (Maven output)
├── AC-Game/
│   ├── pom.xml             (Módulo Game - NOVO)
│   ├── src/                (código fonte - MANTIDO)
│   ├── config/             (configurações - MANTIDO)
│   ├── data/               (XMLs, scripts, static_data - MANTIDO)
│   └── target/             (Maven output)
└── AC-Chat/
    ├── pom.xml             (Módulo Chat - NOVO)
    ├── src/                (código fonte - MANTIDO)
    ├── config/             (configurações - MANTIDO)
    └── target/             (Maven output)
```

---

### **FASE 1: Java 1.7 → Java 8**

**Objetivo**: Base sólida com mudanças mínimas, preparação para modularização futura

**Steps**

1. **Instalar JDK 8 e atualizar ferramentas**
   - Baixar e instalar OpenJDK 8u392 ou Oracle JDK 8u401 (Windows x64)
   - Configurar variáveis de ambiente: `JAVA_HOME=C:\Program Files\Java\jdk1.8.0_xxx`, adicionar `%JAVA_HOME%\bin` ao PATH
   - Baixar Maven 3.8.8 e instalar em [AC-Tools/Maven](AC-Tools/Maven) ou `C:\apache-maven-3.8.8`
   - Configurar `M2_HOME` e adicionar `%M2_HOME%\bin` ao PATH
   - Verificar instalação: `java -version`, `mvn -version`

2. **Atualizar configurações de compilação**
   - Criar estrutura Maven multi-módulo\*\*
   - Criar [pom.xml](pom.xml) raiz do projeto (parent POM) com:
     - Módulos: AC-Commons, AC-Login, AC-Game, AC-Chat
     - `dependencyManagement` centralizado para versões comuns
     - Propriedades: `<java.version>1.8</java.version>`, `<maven.compiler.source>1.8</maven.compiler.source>`, `<maven.compiler.target>1.8</maven.compiler.target>`
   - Centralizar e atualizar dependências no parent POM\*\*
   - No [pom.xml](pom.xml) raiz, adicionar `<dependencyManagement>` com versões:
     - `mysql-connector-java`: 8.0.33
     - `slf4j-api`: 1.7.36
     - `logback-classic` e `logback-core`: 1.2.12
     - `commons-io`: 2.11.0
     - `commons-lang3`: 3.12.0 (nova artifact ID)
     - `guava`: 31.1-jre
     - `javassist`: 3.29.2-GA
     - `quartz`: 2.3.2
     - `com.zaxxer:HikariCP`: 4.0.3 (substitui BoneCP)
     - `trove4j`: 3.0.3
     - `javolution`: 5.5.1
     - `joda-time`: 2.1
     - `netty-all`: 4.1.100.Final (para AC-Chat, substitui Netty 3.6.2)
   - Remover dependências duplicadas dos módulos individuais
   - **AC-Chat**: Atualizar código de rede para Netty 4.x API (mudança significativa: `org.jboss.netty.*` → `io.netty.*`, Bootstrap mudou estrutura)
   - Atualizar plugins no parent POM: `maven-compiler-plugin` → 3.11.0, `maven-jar-plugin` → 3.3.0
   - **Deletar**: pastas libs/ inteiras de AC-Login, AC-Game, AC-Chat (dependências gerenciadas pelo Maven)
   - **Manter**: AC-Commons/libs/ apenas se houver JARs não disponíveis em repositórios Maven
   - `commons-lang`: 2.6 → `commons-lang3` 3.12.0 (nova artifact, requer mudança de imports em código)
   - `guava`: 13.0.1 → 31.1-jre
   - `javassist`: 3.15.0-GA → 3.29.2-GA
   - `quartz`: 2.1.7 → 2.3.2 e arquivos Ant\*\*
   - Deletar `jsr166-1.7.0.jar` e `jsr166-1.0.0.jar` (Java 8 já tem concurrency nativo)
   - Verificar se há imports de `jsr166y.*` ou `edu.emory.mathcs.*` e substituir por `java.util.concurrent.*` nativo
   - **Deletar build.xml** de AC-Login, AC-Game, AC-Chat (substituídos por pom.xml)
   - **Opcional**: Manter AC-Tools/Ant para referência histórica, mas não é mais usad

3. **Refatorar código para mudanças de dependências**
   - Buscar todos os imports `org.apache.commons.lang.` e renomear para `org.apache.commons.lang3.`
   - Buscar referências a `BoneCPDataSource` e substituir por `HikariDataSource` em [AC-Commons/src/com/aionemu/commons/database](AC-Commons/src/com/aionemu/commons/database)
   - Ajustar arquivos de configuração de pool ([AC-Commons/config/network/database.properties](AC-Commons/config/network/database.properties)) para sintaxe HikariCP

4. **Remover backports obsoletos**
   - Atualizar scripts de build\*\*
   - Atualizar [Builder.bat](Builder.bat) para usar Maven em vez de Ant:
     - Opção 1: `mvn clean package -pl AC-Login -am`
     - Opção 2: `mvn clean package -pl AC-Game -am`
     - Opção 3: `mvn clean package -pl AC-Chat -am`
     - Opção 5: `mvn clean package` (build all)
   - Atualizar [build_maven_commons.bat](build_maven_commons.bat) para `mvn clean package -pl AC-Commons`
     8 - Criar [build_all.bat](build_all.bat): `mvn clean package` no root

5. **Compilar e corrigir erros**
   - Executar `mvn clean install` no diretório raiz (compila todos os módulos na ordem correta)
   - Maven resolve automaticamente dependências inter-módulos (AC-Commons → outros)
   - Corrigir erros de compilação (esperados: poucos, principalmente avisos de deprecated APIs e mudanças Netty
   - Executar [build_maven_commons.bat](build_maven_commons.bat) (Commons primeiro devido a dependências)
   - Executar [Builder.bat](Builder.bat): opções 1 (Login), 2 (Game), 3 (Chat)
   - Corrigir erros de compilação (esperados: poucos, principalmente avisos de deprecated APIs)
   - Verificar warnings, resolver os críticos

6. **Aproveitar Java 8 (modernização opcional mas recomendada)**
   - Substituir anonymous classes por lambdas em callbacks (ex: `Runnable`, listeners)
   - Usar `Stream API` em loops de coleções complexos
   - Introduzir `Optional<T>` em métodos que retornam null
   - Migrar `java.util.Date` para `java.time.LocalDateTime` onde viável (iniciar em novas funcionalidades)

**Verificação Fase 1**

- **Build**: Todos os módulos compilam sem erros (`mvn clean install` bem-sucedido)
- **Maven**: Verificar que dependências foram resolvidas corretamente (checar `~/.m2/repository/`)
- **Startup**: Login Server, Game Server, Chat Server iniciam sem exceções nos logs
- **Autenticação**: Cliente conecta ao Login Server e faz login com sucesso
- **Gameplay básico**: Criar personagem, entrar no mundo, andar, usar habilidades, inventário funciona
- **Chat**: Mensagens funcionam entre jogadores (CRÍTICO: testar extensivamente devido upgrade Netty 3→4)
  - Chat global, whisper, group chat, legion chat
  - Conexão/desconexão de usuários
  - Reconexão após perda de rede
- **Data loading**: NPCs, items, quests carregam corretamente (verificar logs de [AC-Game/data/static_data](AC-Game/data/static_data))
- **Estabilidade**: Executar por 24 horas em servidor de teste sem crashes

**Notas Importantes Fase 1:**

- **Netty 3 → 4**: Maior mudança técnica desta fase. API mudou significativamente:
  - Package: `org.jboss.netty.*` → `io.netty.*`
  - Bootstrap, Channel, Handler estrutura diferente
  - Testar chat intensivamente antes de prosseguir
- **Maven multi-módulo**: Compile sempre do root (`mvn clean install`) ou use `-am` (also-make) flag para resolver inter-módulo deps

---

### **FASE 2: Java 8 → Java 11 (FASE CRÍTICA)**

**Objetivo**: Lidar com modularização do Java e remoção de Java EE APIs (JAXB, tools.jar)

**Steps**

1. **Instalar JDK 11**
   - Baixar OpenJDK 11.0.21 ou Oracle JDK 11.0.21 (Windows x64)
   - Atualizar `JAVA_HOME=C:\Program Files\Java\jdk-11.0.21`, verificar PATH
   - Maven 3.8.8 (já instalado) é compatível
   - Verificar: `java -version` deve mostrar "11.0.21"

2. **Adicionar dependências JAXB ao [AC-Commons/pom.xml](AC-Commons/pom.xml)**
   - `jakarta.xml.bind:jakarta.xml.bind-api:2.3.3`
   - `org.glassfish.jaxb:jaxb-runtime:2.3.3`
   - `com.sun.xml.bind:jaxb-core:2.3.0.1`
   - Estas restauram JAXB removido do JDK 11, essencial para 95+ DataHolder classes e 200+ Template classes

3. **Refatorar sistema de compilação dinâmica de scripts**
   - Abrir [AC-Commons/src/com/aionemu/commons/scripting/impl/javacompiler/ScriptCompilerImpl.java](AC-Commons/src/com/aionemu/commons/scripting/impl/javacompiler/ScriptCompilerImpl.java)
   - Substituir uso de `com.sun.tools.javac.Main` por `javax.tools.JavaCompiler` e `ToolProvider.getSystemJavaCompiler()`
   - Atualizar [AC-Commons/src/com/aionemu/commons/scripting/impl/javacompiler/BinaryClass.java](AC-Commons/src/com/aionemu/commons/scripting/impl/javacompiler/BinaryClass.java) para não depender de classes internas javac
   - Remover `javac-1.6.jar` de [AC-Commons/libs](AC-Commons/libs)

4. **Configurar JVM flags para APIs internas (sun.misc.Unsafe)**
   - Editar scripts de startup dos servers (procurar `.bat` em cada módulo):
     - [AC-Login/startLS.bat](AC-Login): adicionar flags JVM
     - [AC-Game/startGS.bat](AC-Game): adicionar flags JVM
     - [AC-Chat/startCS.bat](AC-Chat): adicionar flags JVM
   - Flags necessárias:
     ```
     --add-opens java.base/jdk.internal.misc=ALL-UNNAMED
     --add-opens java.base/sun.nio.ch=ALL-UNNAMED
     --add-opens java.base/sun.misc=ALL-UNNAMED
     ```
   - Netty já atualizado para 4.1.x na Fase 1 (verificar estabilidadorldLoader.java) e classes de concurrency

5. **Atualizar configurações de build para Java 11**
   - [AC-Commons/pom.xml](AC-Commons/pom.xml): `<source>11</source>`, `<target>11</target>`
   - Todos `build.xml`: `source="11"`, `target="11"`
   - Atualizar `maven-compiler-plugin` → 3.11.0 (se ainda não na Fase 1)

6. **Atualizar dependências para compatibilidade Java 11**
   - `guava`: 31.1-jre → 32.1.3-jre
   - `mysql-connector-java`: verificar 8.0.33 funciona com Java 11 ✓
   - Verificar`mvn clean install` no diretório raiz
   - Maven automaticamente propaga mudanças entre de 3.6.2 para Netty 4.1.x (mudança de API significativa, testar cuidadosamente)

7. **Resolver APIs deprecated/removidas**
   - Buscar uso de `Thread.destroy()`, `Thread.stop()` — foram removidos, substituir por interrupção cooperativa
   - Buscar `finalize()` methods — substituir por `java.lang.ref.Cleaner` se necessário
   - Verificar uso de `sun.misc.BASE64Encoder` — substituir por `java.util.Base64`

8. **Compilar e corrigir erros de modularização**
   - Executar [build_maven_commons.bat](build_maven_commons.bat)
   - Executar [Builder.bat](Builder.bat) para todos os módulos
   - Corrigir erros de split packages ou acesso a módulos internos
   - Adicionar mais `--add-opens` se necessário para casos específicos

**Verificação Fase 2**

- **Todos os testes da Fase 1** devem passar
- **JAXB crítico**: Verificar carga de todos os data files em [AC-Game/data/static_data](AC-Game/data/static_data) — NPCs, items, quests, skills, etc. Logs não devem ter erros de unmarshalling
- **Scripts dinâmicos**: Testar reload de scripts de quest ou AI durante runtime (comando `/reload scripts` se existir)
- **Compilação runtime**: Sistema de script compilation deve funcionar sem tools.jar
- **Gameplay completo**: Quests funcionam, NPCs dropam items, combate funciona, skills carregam
- **Memória**: Monitorar uso de memória (G1GC padrão no Java 11 pode comportar-se diferente)
- **Estabilidade**: Executar por 48 horas em servidor de teste com jogadores simulados

---

### **FASE 3: Java 11 → Java 21 (OTIMIZAÇÃO)**

**Objetivo**: Aproveitar LTS mais recente, melhorias de performance, segurança e recursos modernos

**Steps**

1. **Instalar JDK 21**
   - Baixar OpenJDK 21.0.2 ou Oracle JDK 21.0.2 (Windows x64)
   - Atualizar `JAVA_HOME=C:\Program Files\Java\jdk-21.0.2`, verificar PATH
   - Considerar atualizar Maven para 3.9.x (opcional, 3.8.8 ainda funciona)
   - Verificar: `java -version` deve mostrar "21.0.2"

2. **Atualizar configurações para Java 21**
   - [AC-Commons/pom.xml](AC-Commons/pom.xml): `<source>21</source>`, `<target>21</target>` (ou 17 se preferir conservador)
   - Todos `build.xml`: `source="21"`, `target="21"`
   - `maven-compiler-plugin` → 3.12.1

3. **Atualizar dependências para Java 21**
   - `mysql-connector-java` → `mysql-connector-j` 8.3.0 (mudança de artifact no MySQL 8.x)
   - `logback-classic` e `logback-core`: 1.2.12 → 1.4.14 (suporte Java 21)
   - `slf4j-api`: 1.7.36 → 2.0.9
   - `guava`: 32.1.3-jre → 33.0.0-jre
   - Verificar todas as dependências têm versões testadas com Java 21

4. **Aproveitar recursos modernos do Java (opcional)**
   - **Records (Java 16+)**: Usar para DTOs imutáveis e data holders simples
   - **Text Blocks (Java 15+)**: Simplificar SQL queries multi-linha e XML templates
   - **Pattern Matching for switch (Java 21)**: Modernizar lógica de switch complexa
   - **Virtual Threads (Java 21)**: Avaliar uso para handlers de network IO (requer testes de performance)
   - \*\*Sequenc`mvn clean install` no diretório raiz
   - Gerar distribuições finais com `mvn package -P release` (se profile configurado)
   - Resolver warnings finais de deprecation
   - JARs gerados em cada módulo: `target/*.jar` casos)
   - Considerar **ZGC** para baixa latência em game server: `-XX:+UseZGC` em [AC-Game startup script](AC-Game)
   - Ajustar heap sizes: `-Xms4g -Xmx8g` (adaptar ao hardware)
   - Monitorar GC logs: `-Xlog:gc*:file=gc.log`

5. **Compilação e otimização final**
   - Executar [build_maven_commons.bat](build_maven_commons.bat)
   - Executar [Builder.bat](Builder.bat) opção 5 (Build All) ou individualmente
   - Resolver warnings finais de deprecation
   - Gerar distribuições finais (JARs) para deployment

6. **Performance tuning**
   - Executar benchmarks de carga (múltiplos jogadores simultâneos)
   - Comparar métricas de latência, throughput, uso de memória vs Java 11
   - Ajustar thread pools se necessário (HikariCP, executor services)
   - Otimizar configurações de rede em [AC-Game/config/network](AC-Game/config/network)

**Verificação Fase 3**

- **Todos os testes das fases anteriores** devem passar
- **Testes de stress**: Simular 50-100+ jogadores simultâneos (mínimo)
- **Funcionalidades principais completas**:
  - Combate (PvE e PvP)
  - Sistema de quests (iniciar, completar, recompensas)
  - Crafting e gathering
  - Trade entre jogadores
  - Sistema de grupos/raids
  - Instâncias/dungeons
  - Eventos agendados (Quartz scheduler)
  - Chat (whisper, group, global)
- **Performance**: Latência < 100ms, sem lag perceptível
- **Estabilidade**: Executar por 7 dias em ambiente de staging antes de produção
- **Logs limpos**: Sem exceções ou warnings críticos nos logs de [AC-Game/log](AC-Game/log), [AC-Login/log](AC-Login/log), [AC-Chat/log](AC-Chat/log)

---

### **Gerenciamento de Riscos e Rollback**

**Para cada fase:**

1. **Backup completo antes de iniciar** (código, database, configurações, builds antigos)
2. **Criar branch Git**: `upgrade/java-8`, `upgrade/java-11`, `upgrade/java-21`
3. **Documentar mudanças**: Manter log em `docs/java-migration-log.md` com detalhes de problemas encontrados e soluções
4. **Critérios de sucesso obrigatórios antes de avançar**:
   - Compilação 100% sem erros
   - Todos os servers iniciam sem exceções
   - Funcionalidades core funcionam conforme esperado
   - Nenhuma regressão crítica detectada
   - Aprovação após período de teste (24h, 48h, 7 dias conforme fase)
5. **Plano de rollback**:
   - Manter JDK anterior instalado em paralelo (`C:\Program Files\Java\jdk-X`)
   - Poder reverter `JAVA_HOME` rapidamente
   - Manter builds compilados da versão anterior em pasta separada
   - Database backup antes de cada fase (caso migrations sejam necessárias)

---

### **Comandos Maven Úteis**

**Build Commands:**

```bash
# Compilar todos os módulos (do diretório raiz)
mvn clean install

# Compilar apenas AC-Commons
mvn clean install -pl AC-Commons

# Compilar AC-Game e suas dependências (AC-Commons)
mvn clean package -pl AC-Game -am

# Compilar AC-Login e suas dependências
mvn clean package -pl AC-Login -am

# Compilar AC-Chat e suas dependências
mvn clean package -pl AC-Chat -am

# Compilar sem rodar testes (mais rápido)
mvn clean install -DskipTests

# Compilar modo verbose (debug)
mvn clean install -X

# Limpar todos os builds
mvn clean
```

**Dependency Management:**

```bash
# Ver árvore de dependências de um módulo
mvn dependency:tree -pl AC-Game

# Verificar dependências desatualizadas
mvn versions:display-dependency-updates

# Verificar plugins desatualizados
mvn versions:display-plugin-updates

# Resolver dependências (baixar para .m2/repository)
mvn dependency:resolve
```

**Troubleshooting:**

```bash
# Forçar update de snapshots
mvn clean install -U

# Purgar cache local e rebuild
mvn dependency:purge-local-repository

# Compilar offline (não baixar nada)
mvn clean install -o
```

---

### **Observações Importantes**

- **Sem testes automatizados** aumenta significativamente o risco — cada funcionalidade deve ser testada manualmente de forma exaustiva
- **JAXB na Fase 2 é crítico**: 300+ arquivos dependem. Qualquer falha bloqueia todo o data loading system
- **Sistema de scripts na Fase 2**: Refatoração complexa, testar intensamente
- **Migração para Maven**: Adiciona complexidade inicial mas simplifica manutenção futura
- **Netty 4.x upgrade**: Mudança de API significativa no AC-Chat, requer testes extensivos
- **Performance pode variar**: GC e JIT compilation mudaram significativamente entre versões — monitorar métricas
- **Tempo estimado**:
  - Fase 1: 2-3 semanas (incluindo migração Maven + testes)
  - Fase 2: 3-4 semanas (maior complexidade)
  - Fase 3: 1-2 semanas (mais tranquilo)
  - **Total**: 6-9 semanas para migração completa e validação

---

Este é o **plano DRAFT atualizado com Maven**. Revise e me informe se:

- Alguma etapa precisa de mais detalhes
- Quer ver exemplos específicos de POMs (parent, AC-Login, AC-Game, AC-Chat)
- Quer priorizar certas funcionalidades na validação
- Há restrições de ambiente ou infraestrutura que não considerei
- Prefere uma abordagem diferente em algum ponto específico
- Quer que eu crie os POMs imediatamente ou prefere revisar o plano primeiro

**Próximos passos possíveis:**

1. Criar estrutura Maven completa (parent POM + POMs dos módulos)
2. Começar implementação da Fase 1
3. Criar exemplos de código para mudanças complexas (BoneCP→HikariCP, Netty 3→4, sistema de scripts)
4. Detalhar processo de migração específico para algum módulo

Quando aprovar, posso fornecer os POMs completos e começar a implementação!
