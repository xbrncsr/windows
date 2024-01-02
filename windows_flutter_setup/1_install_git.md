# Install Git
#### Author: <cesarbrunoms@gmail.com>

### Permissions PowerShell
```shell
Get-ExecutionPolicy

```

```shell
set-ExecutionPolicy unrestricted

```

ou
```shell
set-executionPolicy remotesigned

```



### A. Install Git

```shell
winget install --id=Git.Git -e --accept-package-agreements --accept-source-agreements ;

```

### B. Config Git

```shell
git config --global user.email bruno.cesar@outlook.it
git config --global user.name cesarbrunoms

```
