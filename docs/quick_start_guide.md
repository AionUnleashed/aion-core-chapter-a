# Guia Rápido de Execução - AION Core 4.7.5

## ✅ Status da Compilação

- **AC-Commons**: ✓ Compilado (ac-commons-1.3.jar)
- **AC-Login**: ✓ Compilado (AC-Login.jar) - Main-Class corrigido
- **AC-Game**: ✓ Compilado (AC-Game.jar) - 4.30 MB
- **AC-Chat**: ✓ Compilado (AC-Chat.jar) - 0.09 MB

## 🔧 Configurações Corrigidas

1. **Main-Class do AC-Login**: Alterado de `loginserver.LoginServer` para `com.aionemu.loginserver.LoginServer`
2. **Senhas do banco de dados**: Atualizadas para `vertrigo` em todos os `database.properties`
3. **AC-Commons copiado**: Bibliotecas copiadas para `AC-Game/libs/`, `AC-Login/libs/`, `AC-Chat/libs/`

## 🚀 Scripts de Inicialização Atualizados

### Localização

```
scripts/start/
├── start_login.bat
├── start_game.bat
├── start_chat.bat
└── start_all_servers.bat
```

### Uso

#### Iniciar Todos os Servidores (Recomendado)

```batch
cd scripts\start
start_all_servers.bat
```

#### Iniciar Servidores Individualmente

```batch
cd scripts\start
start_login.bat    # Inicia Login Server
start_game.bat     # Inicia Game Server (requer Login rodando)
start_chat.bat     # Inicia Chat Server
```

## 📝 Comandos Manuais (PowerShell)

### Login Server

```powershell
cd 'C:\Workspace\AION CORE 4.7.5\AC-Login'
$env:JAVA_HOME='C:\Program Files\Java\jdk1.7.0_79'
java -Xms128m -Xmx256m -server -cp "./libs/*;build/AC-Login.jar" com.aionemu.loginserver.LoginServer
```

**Portas**:

- 2106: Porta de clientes
- 9014: Porta interna para Game Server

---

### Game Server

```powershell
cd 'C:\Workspace\AION CORE 4.7.5\AC-Game'
$env:JAVA_HOME='C:\Program Files\Java\jdk1.7.0_79'
java -Xms512m -Xmx2048m -server -noverify -javaagent:./libs/ac-commons-1.3.jar -cp "./libs/*;build/AC-Game.jar" com.aionemu.gameserver.GameServer
```

**Parâmetros Importantes**:

- `-noverify`: Desabilita verificação de bytecode (necessário devido ao yGuard)
- `-javaagent:./libs/ac-commons-1.3.jar`: Habilita sistema de callbacks (necessário!)

**Portas**:

- 7777: Porta de clientes

⚠️ **IMPORTANTE**: O Login Server DEVE estar rodando antes de iniciar o Game Server!

---

### Chat Server

```powershell
cd 'C:\Workspace\AION CORE 4.7.5\AC-Chat'
$env:JAVA_HOME='C:\Program Files\Java\jdk1.7.0_79'
java -Xms64m -Xmx128m -server -cp "./libs/*;build/AC-Chat.jar" com.aionemu.chatserver.ChatServer
```

**Portas**:

- 10241: Porta de clientes
- 9021: Porta interna

## 🗄️ Banco de Dados

### Credenciais

- **Host**: localhost
- **Usuário**: root
- **Senha**: vertrigo

### Databases

- `ac47_server_ls`: Login Server
- `ac47_server_gs`: Game Server

### Conta Admin Padrão

- **Usuário**: admin
- **Senha**: admin
- **Level**: 3 (Admin completo)

## ⚠️ Problemas Conhecidos e Soluções

### Game Server não inicia

**Problema**: `java.lang.VerifyError: Expecting a stack map frame`

**Solução**: Use `-noverify` no comando Java (já incluído nos scripts atualizados)

---

### Game Server não abre porta 7777

**Problema**: Login Server não está na porta 9014

**Solução**:

1. Certifique-se que o Login Server está rodando
2. Verifique se a porta 9014 está aberta: `netstat -an | findstr 9014`
3. Aguarde pelo menos 15 segundos após iniciar o Login Server

---

### Erro de classe principal não encontrada

**Problema**: Main-Class incorreto no MANIFEST.MF

**Solução**: Já corrigido no `AC-Login/build.xml`. Recompile com:

```batch
cd AC-Login
..\AC-Tools\Ant\bin\ant.bat
```

---

### Erro de conexão com banco de dados

**Problema**: `Access denied for user 'root'@'localhost'`

**Solução**: Senha já atualizada para `vertrigo` em:

- `AC-Login/config/network/database.properties`
- `AC-Game/config/network/database.properties`
- `AC-Commons/config/network/database.properties`

## 📊 Ordem de Inicialização

```
1. Login Server (15 segundos de espera)
   ↓
2. Game Server (45 segundos de espera)
   ↓
3. Chat Server
```

## 🔍 Verificar Status dos Servidores

### PowerShell

```powershell
# Ver processos Java AION
Get-Process java | Where-Object { $_.MainModule.FileName -notlike '*vscode*' } | Select-Object Id, @{Name='Memory (MB)'; Expression={[math]::Round($_.WorkingSet64 / 1MB, 2)}}, StartTime

# Verificar portas
netstat -an | Select-String ":2106|:7777|:9014|:9021|:10241"
```

### CMD

```batch
# Ver processos Java
tasklist | findstr java

# Verificar portas
netstat -an | findstr "2106 7777 9014 9021 10241"
```

## 📁 Estrutura de Diretórios

```
C:\Workspace\AION CORE 4.7.5\
├── AC-Login/
│   ├── build/AC-Login.jar ← JAR compilado
│   ├── libs/*.jar          ← Dependências + ac-commons-1.3.jar
│   └── config/             ← Configurações
├── AC-Game/
│   ├── build/AC-Game.jar   ← JAR compilado
│   ├── libs/*.jar          ← Dependências + ac-commons-1.3.jar (IMPORTANTE!)
│   └── config/             ← Configurações
├── AC-Chat/
│   ├── build/AC-Chat.jar   ← JAR compilado
│   ├── libs/*.jar          ← Dependências + ac-commons-1.3.jar
│   └── config/             ← Configurações
└── AC-Commons/
    └── target/ac-commons-1.3.jar ← Biblioteca compartilhada
```

## 🛠️ Recompilação

Para recompilar após mudanças:

```batch
# Apenas AC-Commons
cd AC-Commons
call ..\build_maven_commons.bat

# Apenas Login
cd AC-Login
..\AC-Tools\Ant\bin\ant.bat

# Apenas Game
cd AC-Game
..\AC-Tools\Ant\bin\ant.bat

# Apenas Chat
cd AC-Chat
..\AC-Tools\Ant\bin\ant.bat

# Copiar AC-Commons atualizado
cd scripts\build
call copy_commons_libs.bat
```

## 📞 Portas Utilizadas

| Servidor | Porta | Tipo    | Descrição                   |
| -------- | ----- | ------- | --------------------------- |
| Login    | 2106  | Externa | Conexões de clientes        |
| Login    | 9014  | Interna | Comunicação com Game Server |
| Game     | 7777  | Externa | Conexões de clientes        |
| Chat     | 10241 | Externa | Conexões de clientes        |
| Chat     | 9021  | Interna | Comunicação com Game Server |

## 🎯 Próximos Passos

1. ✅ Compilação completa
2. ✅ Scripts de inicialização atualizados
3. ⏳ Testar inicialização completa dos servidores
4. ⏳ Verificar comunicação entre servidores
5. ⏳ Testar conexão de cliente

---

**Última atualização**: 23 de fevereiro de 2026
**Versão**: AION Core 4.7.5.x
