# Visão geral do projeto Aion-Core-v4.7.5

## Resumo rápido
Este repositório contém **código-fonte completo** de um servidor Aion, organizado em múltiplos módulos (Chat, Commons, Game, Login, Tools e EventEngine). Há várias pastas `src/` com código Java e pastas `config/`, `data/`, `sql/` e `libs/` para configurações, dados, scripts e dependências.

O README do projeto afirma que o autor publicou o código-fonte completo e que o sistema de licenciamento comercial foi removido.

## Estrutura principal (top-level)
- `AC-Chat/` – servidor de chat
- `AC-Commons/` – bibliotecas e código compartilhado
- `AC-Game/` – servidor de jogo (principal)
- `AC-Login/` – servidor de login
- `AC-Tools/` – ferramentas auxiliares e utilitários
- `AL-EventEngine/` – engine de eventos
- Arquivos adicionais: `README.md`, `LICENSE`, scripts `.bat`, etc.

## Principais módulos e conteúdo

### AC-Chat
- Contém `src/` (código Java) e `libs/` (dependências).
- Scripts de build: `build.xml` e `build_chatserver.bat`.
- Configurações em `config/`.

### AC-Commons
- Contém `src/` (código Java compartilhado).
- `pom.xml` indica uso de Maven aqui.
- `libs/` e arquivos de configuração.

### AC-Game
- Contém `src/` (código Java do servidor principal).
- `data/`, `sql/`, `libs/` e `config/`.
- Build com Ant (`build.xml`) e scripts `.bat`.

### AC-Login
- Contém `src/` (código Java do servidor de login).
- `data/`, `sql/`, `libs/` e `config/`.
- Build com Ant (`build.xml`) e scripts `.bat`.

### AC-Tools
- Conjunto de ferramentas auxiliares e conversores.
- Várias subpastas como `Parsers`, `Droplist_Converter`, etc.

### AL-EventEngine
- Documentação e pasta `EventEngine/` com conteúdo do engine.

## Posso editar todos os arquivos Java?
Sim. Existem múltiplas pastas `src/` nos módulos principais (Chat, Commons, Game, Login), então o **código-fonte Java está presente** e pode ser editado.

## Posso abrir no VS Code?
Sim. É possível abrir a pasta raiz no VS Code e trabalhar normalmente nos arquivos `src/`.  
Você provavelmente vai precisar configurar manualmente:
- JDK instalado localmente
- Dependências em `libs/`
- Configuração de build (Ant e/ou Maven)

## Base atual de build
- **Ant** é usado nos módulos principais (`build.xml` em AC-Game, AC-Login, AC-Chat).
- **Maven** aparece pelo menos em `AC-Commons/pom.xml`.

## Evoluir para Java 21 ou 25 (visão geral)
Para migração futura, você precisará revisar:
1. **Ferramenta de build** (Ant/Maven) para usar o `--release 21` (ou 25).
2. **Dependências** em `libs/` e no `pom.xml` (compatibilidade com Java 21/25).
3. **APIs removidas/depreciadas** no Java moderno.
4. **Configuração do projeto no VS Code** para o novo JDK.

## Conclusão
O repositório contém **código-fonte completo** (com várias pastas `src/`), então é editável no VS Code e viável para evolução futura. Há uma mistura de Ant e Maven, e a migração para Java 21/25 exigirá ajustes no build e dependências.