# Install Flutter FVM
#### Author: <cesarbrunoms@gmail.com>

### A. Instalando Flutter, dentro do diretório, abrindo terminal dentro do diretório abaixo sitado e colocando o comando abaixo:
```shell
Set-Location -Path "C:\"
Set-Location -Path ".\_devprograms\"
git clone https://github.com/flutter/flutter.git -b stable

```

### B. No PowerShell do Windows 11, você pode criar uma nova variável de ambiente usando o seguinte comando:
```shell
[Environment]::SetEnvironmentVariable("FLUTTER_HOME", "C:\_devprograms\flutter", "User")

```

### C. Para adicionar à variável PATH do seu usuário no Windows 11, você pode usar o seguinte comando no PowerShell:
```shell
$existingPath = [Environment]::GetEnvironmentVariable("Path", "User")
$newPath = "$existingPath;%FLUTTER_HOME%\bin"
[Environment]::SetEnvironmentVariable("Path", $newPath, "User")

```

### D. Rode o comando Flutter doctor
```shell
flutter doctor

```

### E. Mude a versão do Java para 11
```shell
jdk17

```

### F. Rode o comando: flutter doctor --android-licenses
```shell
flutter doctor --android-licenses

```

### G. Pub package
```shell
dart pub global activate fvm

```

### H. Para adicionar à variável PATH do seu usuário no Windows 11, você pode usar o seguinte comando no PowerShell:
```shell
$existingPath = [Environment]::GetEnvironmentVariable("Path", "User")
$newPath = "$existingPath;C:\Users\bruno\AppData\Local\Pub\Cache\bin"
[Environment]::SetEnvironmentVariable("Path", $newPath, "User")

```

### I. Config FVM
```shell
fvm config

```

### J. Crie o diretório "FVM" antes de executar o comando abaixo
```shell
New-Item -ItemType Directory -Path "C:\_devprograms\fvm" -Force
fvm config --cache-path C:\_devprograms\fvm

```


