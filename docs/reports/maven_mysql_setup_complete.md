# ✅ Maven e MySQL - Configuração Completa

## 🎉 Instalação Concluída!

### 📦 Maven 3.6.3 Instalado

**Localização:** `C:\apache-maven-3.6.3`

**Teste:**

```bash
C:\apache-maven-3.6.3\bin\mvn -version
```

**Saída:**

```
Apache Maven 3.6.3 (cecedd343002696d0abb50b32b541b8a6ba2883f)
Maven home: C:\apache-maven-3.6.3
Java version: 1.7.0_79, vendor: Oracle Corporation
```

### 🗄️ MySQL 5.7.44 Configurado

**Localização:** `C:\Program Files\MySQL\MySQL Server 5.7`

**Credenciais:**

- User: `root`
- Password: `vertrigo`

**Databases Criadas:**

- `al_server_gs` (Game Server)
- `al_server_ls` (Login Server)

**Teste de Conexão:**

```bash
"C:\Program Files\MySQL\MySQL Server 5.7\bin\mysql.exe" -u root -pvertrigo -e "SHOW DATABASES;"
```

### ⚙️ Configuração Atualizada

**Arquivo:** `AC-Commons\config\network\database.properties`

```properties
database.driver = com.mysql.jdbc.Driver
database.url = jdbc:mysql://localhost:3306/al_server_gs?useUnicode=true&characterEncoding=UTF-8
database.user = root
database.password = vertrigo
```

✅ **Senha atualizada para: `vertrigo`**

---

## 🚀 Scripts Disponíveis

### 1️⃣ Setup Completo do Banco de Dados

```bash
scripts\database\setup_database.bat
```

**O que faz:**

- Cria databases `al_server_gs` e `al_server_ls`
- Importa schema do Game Server (`AC-Game\sql\ac47_server_gs.sql`)
- Importa schema do Login Server (`AC-Login\sql\ac47_server_ls.sql`)
- Cria conta admin (user: admin, pass: admin, level: 3)
- Verifica instalação

### 2️⃣ Compilar Todo o Projeto

```bash
scripts\build\build_all.bat
```

**O que faz:**

- Configura ambiente Maven automaticamente
- Compila AC-Commons (Maven)
- Compila AC-Login (Ant)
- Compila AC-Game (Ant)
- Compila AC-Chat (Ant)

### 3️⃣ Iniciar Servidores

```bash
scripts\start\start_all_servers.bat
```

---

## 📊 Verificação da Instalação

### ✅ Java

```bash
java -version
# Output: java version "1.7.0_79"
```

### ✅ Maven

```bash
C:\apache-maven-3.6.3\bin\mvn -version
# Output: Apache Maven 3.6.3
```

### ✅ MySQL

```bash
"C:\Program Files\MySQL\MySQL Server 5.7\bin\mysql.exe" --version
# Output: Ver 14.14 Distrib 5.7.44
```

### ✅ Databases

```bash
"C:\Program Files\MySQL\MySQL Server 5.7\bin\mysql.exe" -u root -pvertrigo -e "SHOW DATABASES LIKE 'al_server%';"
# Output: al_server_gs, al_server_ls
```

---

## 🛠️ Configuração do PATH (Opcional)

Para usar Maven e MySQL globalmente sem especificar o caminho completo:

### Opção 1: Session Temporária

```bash
set PATH=C:\apache-maven-3.6.3\bin;C:\Program Files\MySQL\MySQL Server 5.7\bin;%PATH%
```

### Opção 2: Permanente (Requer Admin)

```bash
setx PATH "%PATH%;C:\apache-maven-3.6.3\bin;C:\Program Files\MySQL\MySQL Server 5.7\bin" /M
```

**Nota:** O script `build_all.bat` já configura o PATH automaticamente!

---

## 🎯 Próximos Passos

1. ✅ Maven instalado
2. ✅ MySQL configurado
3. ✅ Databases criadas e schemas importados
4. ✅ Credenciais atualizadas em `database.properties`
5. ⏭️ **Compilar o projeto:** `scripts\build\build_all.bat`
6. ⏭️ **Iniciar servidores:** `scripts\start\start_all_servers.bat`

---

## 🎮 Conta Admin Padrão

Após executar `setup_database.bat`:

- **Username:** `admin`
- **Password:** `admin`
- **Access Level:** 3 (Administrator)

⚠️ **IMPORTANTE:** Troque a senha após o primeiro login!

---

## 📝 Arquivos Criados/Modificados

### Criados:

- ✅ `scripts\build\setup_maven_environment.bat` - Configuração manual do Maven
- ✅ `scripts\database\setup_database.bat` - Setup completo automatizado

### Modificados:

- ✅ `AC-Commons\config\network\database.properties` - Senha atualizada para `vertrigo`
- ✅ `scripts\build\build_all.bat` - Configuração automática do Maven

---

## 🔧 Troubleshooting

### Maven não encontrado

- Verifique se extraiu para `C:\apache-maven-3.6.3`
- Execute `scripts\build\build_all.bat` que configura automaticamente

### Erro de conexão MySQL

- Verifique se MySQL está rodando
- Teste credenciais: `mysql -u root -pvertrigo`

### Erro ao importar schema

- Verifique se databases foram criadas
- Execute `scripts\database\setup_database.bat` novamente

---

**Tudo pronto para compilar e executar o AION Core 4.7.5! 🚀**
