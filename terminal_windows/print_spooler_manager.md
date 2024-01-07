<h1>Print Spooler Manager</h1>

<h2>Stop print spooler service</h2>

```
Stop-Service -Name Spooler -Force

```
<br>

<h2>To delete the files</h2>

```
Remove-Item -Path "$env:SystemRoot\System32\spool\PRINTERS\*.*"

```
<br>

<h2>Start print spooler service</h2>

```
Start-Service -Name Spooler

```
<br>

<h2>Restart print spooler service</h2>

```
Restart-Service -Name Spooler -Force 

```
<br>

