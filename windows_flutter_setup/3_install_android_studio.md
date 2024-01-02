# Install Android Studio
#### Author: <cesarbrunoms@gmail.com>

### A. Download e instalação do Android Studio
#### https://developer.android.com/studio
```shell
winget install --id=Google.AndroidStudio -e --accept-package-agreements --accept-source-agreements ;

```

### B. No PowerShell do Windows 11, você pode criar uma nova variável de ambiente usando o seguinte comando:
```shell
[Environment]::SetEnvironmentVariable("ANDROID_HOME", "C:\Users\bruno\AppData\Local\Android\Sdk", "User")

```

```shell
[Environment]::SetEnvironmentVariable("ANDROID_SDK_ROOT", "C:\Users\bruno\AppData\Local\Android\Sdk", "User")

```

### C. Para adicionar à variável PATH do seu usuário no Windows 11, você pode usar o seguinte comando no PowerShell:
```shell
$existingPath = [Environment]::GetEnvironmentVariable("Path", "User")
$newPath = "$existingPath;%ANDROID_HOME%\tools"
[Environment]::SetEnvironmentVariable("Path", $newPath, "User")

```

```shell
$existingPath = [Environment]::GetEnvironmentVariable("Path", "User")
$newPath = "$existingPath;%ANDROID_HOME%\platform-tools"
[Environment]::SetEnvironmentVariable("Path", $newPath, "User")

```

```shell
adb --version

```

