# Guia de Compilação e Execução - AION Core 4.7.5

## 📋 Requisitos do Sistema

### Software Necessário:
1. **Java Development Kit (JDK) 1.7+**
   - ✅ Detectado: Java 1.7.0_79 (já instalado)
   
2. **Apache Maven 3.x**
   - ❌ Não detectado no sistema
   - Download: https://maven.apache.org/download.cgi
   - Necessário para compilar o módulo AC-Commons

3. **Apache Ant** (incluído no projeto)
   - ✅ Incluído em: `AC-Tools\Ant\`
   
4. **MySQL Server 5.x ou superior**
   - Necessário para executar os servidores
   - Configuração em: `AC-Commons\config\network\database.properties`

---

## ⚙️ Configuração Inicial

### 1. Instalar Apache Maven

**Opção A - Download Manual:**
1. Baixe o Maven de: https://maven.apache.org/download.cgi
2. Extraia para: `C:\Program Files\Apache\Maven`
3. Adicione ao PATH do sistema:
   - Painel de Controle → Sistema → Configurações Avançadas
   - Variáveis de Ambiente → Path
   - Adicione: `C:\Program Files\Apache\Maven\bin`
4. Verifique a instalação:
   ```cmd
   mvn -version
   ```

**Opção B - Via Chocolatey (se instalado):**
```cmd
choco install maven
```

### 2. Configurar o Banco de Dados

1. Instale o MySQL Server (se ainda não tiver)
2. Crie os bancos de dados necessários:
   ```sql
   CREATE DATABASE al_server_gs CHARACTER SET utf8 COLLATE utf8_general_ci;
   CREATE DATABASE al_server_ls CHARACTER SET utf8 COLLATE utf8_general_ci;
   ```

3. Importe os esquemas SQL:
   ```cmd
   mysql -u root -p al_server_gs < "AC-Game\sql\ac47_server_gs.sql"
   mysql -u root -p al_server_ls < "AC-Login\sql\ac47_server_ls.sql"
   ```

4. Configure as credenciais do banco em:
   - `AC-Commons\config\network\database.properties`
   
   Edite as linhas:
   ```properties
   database.url = jdbc:mysql://localhost:3306/al_server_gs?useUnicode=true&characterEncoding=UTF-8
   database.user = root
   database.password = SUA_SENHA_AQUI
   ```

---

## 🔨 Compilação do Projeto

### Método 1: Compilação Automatizada (Recomendado)

Execute o arquivo `Builder.bat` na raiz do projeto:

```cmd
Builder.bat
```

**Menu de Opções:**
- **Opção 5** - Build All (Compila tudo)
- **Opção 1** - Build Login server
- **Opção 2** - Build Game server
- **Opção 3** - Build Chat server
- **Opção 4** - Build Commons

**Ordem recomendada para primeira compilação:**
1. Primeiro: Opção 4 (Build Commons)
2. Depois: Opção 5 (Build All) ou compilar individualmente cada servidor

---

### Método 2: Compilação Manual Passo a Passo

#### Passo 1: Compilar AC-Commons (OBRIGATÓRIO - Compile primeiro!)

```cmd
cd "C:\Workspace\AION CORE 4.7.5\AC-Commons"
mvn clean package
```

**Saída esperada:**
```
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
```

O JAR compilado estará em: `AC-Commons\target\ac-commons-1.3.jar`

---

#### Passo 2: Compilar Login Server

```cmd
cd "C:\Workspace\AION CORE 4.7.5\AC-Login"
..\AC-Tools\Ant\bin\ant
```

**Ou execute diretamente:**
```cmd
build_login.bat
```

Arquivos compilados: `AC-Login\target\`

---

#### Passo 3: Compilar Game Server

```cmd
cd "C:\Workspace\AION CORE 4.7.5\AC-Game"
..\AC-Tools\Ant\bin\ant
```

**Ou execute diretamente:**
```cmd
build_gameserver.bat
```

Arquivos compilados: `AC-Game\target\`

---

#### Passo 4: Compilar Chat Server

```cmd
cd "C:\Workspace\AION CORE 4.7.5\AC-Chat"
..\AC-Tools\Ant\bin\ant
```

**Ou execute diretamente:**
```cmd
build_chatserver.bat
```

Arquivos compilados: `AC-Chat\target\`

---

## 🚀 Execução dos Servidores

### Ordem de Inicialização

Para executar o servidor AION corretamente, inicie na seguinte ordem:

#### 1. Login Server (Primeiro)

```cmd
cd "C:\Workspace\AION CORE 4.7.5\AC-Login"
java -Xms128m -Xmx256m -jar target\AC-Login.jar
```

**Ou crie um script** `start_login.bat`:
```bat
@echo off
cd AC-Login
java -Xms128m -Xmx256m -jar target\AC-Login.jar
pause
```

**Porta padrão:** 2106
**Logs:** Verificar `AC-Login\log\`

---

#### 2. Game Server (Segundo)

```cmd
cd "C:\Workspace\AION CORE 4.7.5\AC-Game"
java -Xms512m -Xmx2048m -jar target\AC-Game.jar
```

**Ou crie um script** `start_game.bat`:
```bat
@echo off
cd AC-Game
java -Xms512m -Xmx2048m -jar target\AC-Game.jar
pause
```

**Porta padrão:** 7777
**Logs:** Verificar `AC-Game\log\`

---

#### 3. Chat Server (Terceiro - Opcional)

```cmd
cd "C:\Workspace\AION CORE 4.7.5\AC-Chat"
java -Xms64m -Xmx128m -jar target\AC-Chat.jar
```

**Ou crie um script** `start_chat.bat`:
```bat
@echo off
cd AC-Chat
java -Xms64m -Xmx128m -jar target\AC-Chat.jar
pause
```

**Porta padrão:** 10241
**Logs:** Verificar `AC-Chat\log\`

---

## 🔧 Configurações Importantes

### Arquivos de Configuração Principais:

1. **Login Server:**
   - `AC-Login\config\network\network.properties` - Portas e IPs
   
2. **Game Server:**
   - `AC-Game\config\main\gameserver.properties` - Configurações gerais
   - `AC-Game\config\network\network.properties` - Portas e IPs
   - `AC-Game\config\administration\admin.properties` - Comandos admin
   
3. **Chat Server:**
   - `AC-Chat\config\chatserver.properties` - Configurações do chat

4. **Banco de Dados (compartilhado):**
   - `AC-Commons\config\network\database.properties` - MySQL config

---

## 📊 Verificação da Compilação

### Verificar se os JARs foram criados:

```cmd
dir /s /b *.jar | findstr target
```

**Arquivos esperados:**
- `AC-Commons\target\ac-commons-1.3.jar`
- `AC-Login\target\AC-Login.jar`
- `AC-Game\target\AC-Game.jar`
- `AC-Chat\target\AC-Chat.jar`

---

## 🐛 Resolução de Problemas

### Problema 1: "Maven não encontrado"
**Solução:** Instale o Maven e adicione ao PATH do sistema.

### Problema 2: "JAVA_HOME não configurado"
**Solução:** 
```cmd
setx JAVA_HOME "C:\Program Files\Java\jdk1.7.0_79"
```

### Problema 3: "Erro de conexão com o banco de dados"
**Solução:** 
- Verifique se o MySQL está rodando
- Confirme usuário/senha em `database.properties`
- Teste a conexão: `mysql -u root -p`

### Problema 4: "OutOfMemoryError"
**Solução:** Aumente a memória nos scripts de inicialização:
```bat
java -Xms1024m -Xmx4096m -jar target\AC-Game.jar
```

### Problema 5: "Port already in use"
**Solução:** 
- Verifique se outro processo está usando a porta
- Altere a porta em `network.properties`

---

## 📁 Estrutura de Diretórios Após Compilação

```
AION CORE 4.7.5/
├── AC-Commons/
│   └── target/
│       └── ac-commons-1.3.jar ✅
├── AC-Login/
│   ├── target/
│   │   └── AC-Login.jar ✅
│   ├── config/
│   └── log/
├── AC-Game/
│   ├── target/
│   │   └── AC-Game.jar ✅
│   ├── config/
│   ├── data/
│   └── log/
└── AC-Chat/
    ├── target/
    │   └── AC-Chat.jar ✅
    ├── config/
    └── log/
```

---

## 🎮 Criando Conta de Administrador

Após iniciar os servidores, você precisará criar uma conta admin no banco de dados:

```sql
USE al_server_ls;

-- Criar conta (usuário: admin, senha: admin)
INSERT INTO account_data (name, password, access_level, membership, activated) 
VALUES ('admin', SHA1('admin'), 3, 2, 1);

-- Verificar
SELECT * FROM account_data WHERE name = 'admin';
```

**Níveis de Acesso:**
- 0 = Jogador normal
- 1 = GM nível 1
- 2 = GM nível 2  
- 3 = Administrador completo

---

## 📝 Comandos Úteis do Servidor

### No Game Server (em jogo):

```
//reload - Recarrega configurações
//announce - Anúncio global
//heal - Cura completa
//speed <valor> - Aumenta velocidade
//additem <id> <quantidade> - Adicionar item
//addset <nome_set> - Adicionar set completo
```

**Arquivo de configuração:** `AC-Game\config\administration\commands.properties`

---

## ✅ Checklist de Inicialização

- [ ] Java JDK 1.7+ instalado
- [ ] Maven instalado e no PATH
- [ ] MySQL Server instalado e rodando
- [ ] Bancos de dados criados (al_server_gs, al_server_ls)
- [ ] Esquemas SQL importados
- [ ] database.properties configurado
- [ ] AC-Commons compilado (mvn clean package)
- [ ] Login Server compilado
- [ ] Game Server compilado  
- [ ] Chat Server compilado (opcional)
- [ ] Login Server iniciado
- [ ] Game Server iniciado
- [ ] Chat Server iniciado (opcional)
- [ ] Conta admin criada no banco

---

## 🔗 Links Úteis

- **Java JDK 7:** https://www.oracle.com/java/technologies/javase/javase7-archive-downloads.html
- **Maven:** https://maven.apache.org/download.cgi
- **MySQL:** https://dev.mysql.com/downloads/mysql/

---

## 📞 Suporte

- Verifique os logs em cada pasta `log/` para diagnóstico
- Logs do Login: `AC-Login\log\`
- Logs do Game: `AC-Game\log\`
- Logs do Chat: `AC-Chat\log\`

---

**Autor:** GiGatR00n  
**Versão:** 4.7.5.x  
**Data:** 2026

---

## 🚦 Status de Inicialização Esperado

### Login Server iniciado corretamente:
```
[INFO] LoginServer is now listening on port 2106
[INFO] LoginServer is ready!
```

### Game Server iniciado corretamente:
```
[INFO] GameServer is now listening on port 7777
[INFO] GameServer is ready!
[INFO] Connected to LoginServer
```

### Chat Server iniciado corretamente:
```
[INFO] ChatServer is now listening on port 10241
[INFO] ChatServer is ready!
```

---

**Boa sorte com seu servidor AION! 🎮**
