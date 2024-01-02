# Install Java JDK
#### Author: <cesarbrunoms@gmail.com>

### A. Download e instalação do Java
#### https://www.oracle.com/br/java/technologies/javase/javase8-archive-downloads.html
#### https://www.oracle.com/br/java/technologies/javase/jdk11-archive-downloads.html
#### https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html

### B. Install JDK in respective directories:

```shell
New-Item -ItemType Directory -Path "C:\_devprograms\java\jdk\jdk17" -Force
New-Item -ItemType Directory -Path "C:\_devprograms\java\jdk\jdk11" -Force
New-Item -ItemType Directory -Path "C:\_devprograms\java\jdk\jdk8" -Force
New-Item -ItemType Directory -Path "C:\_devprograms\java\jre\jre8" -Force

```

### C. Install JDK
```shell
winget install --id=EclipseAdoptium.Temurin.8.JDK -e --accept-package-agreements --accept-source-agreements --location "C:\_devprograms\java\jdk\jdk8"
winget install --id=EclipseAdoptium.Temurin.11.JDK -e --accept-package-agreements --accept-source-agreements --location "C:\_devprograms\java\jdk\jdk11"
winget install --id=EclipseAdoptium.Temurin.17.JDK -e --accept-package-agreements --accept-source-agreements --location "C:\_devprograms\java\jdk\jdk17"

```

### D. Excluir as variáveis do sistema
```shell
$keyword = "java"
$pathVariable = [Environment]::GetEnvironmentVariable("Path", "Machine")
$pathEntries = $pathVariable -split ";" | Where-Object { $_ -notlike "*$keyword*" }
$newPathVariable = $pathEntries -join ";"
[Environment]::SetEnvironmentVariable("Path", $newPathVariable, "Machine")

```

### E. Chaveando as versões do JDK
```shell
notepad $PROFILE

```

Colar no notepad as duas funções a baixo
```shell
function jdk8() {
    New-Item -ItemType SymbolicLink -Path C:\_devprograms\java\current -Target C:\_devprograms\java\jdk\jdk8 -Force
}

function jdk11() {
    New-Item -ItemType SymbolicLink -Path C:\_devprograms\java\current -Target C:\_devprograms\java\jdk\jdk11 -Force
}

function jdk17() {
    New-Item -ItemType SymbolicLink -Path C:\_devprograms\java\current -Target C:\_devprograms\java\jdk\jdk17 -Force
}

```

### F. No PowerShell do Windows 11, você pode criar uma nova variável de ambiente usando o seguinte comando:
```shell
[Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\_devprograms\java\current", "User")

```

### G. Para adicionar à variável PATH do seu usuário no Windows 11, você pode usar o seguinte comando no PowerShell:
```shell
$existingPath = [Environment]::GetEnvironmentVariable("Path", "User")
$newPath = "$existingPath;%JAVA_HOME%\bin"
[Environment]::SetEnvironmentVariable("Path", $newPath, "User")

```

### Para saber se deu tudo certo
```shell
keytool

```
