<h1>DISM SFC</h1>

```
DISM /Online /Cleanup-image /Restorehealth
sfc /scannow
```
or

```
Repair-WindowsImage -Online -StartComponentCleanup -RestoreHealth
sfc /scannow
```