<h1>Refresh Interface Network</h1>

```
ipconfig /flushdns
ipconfig /release
ipconfig /renew

```

or

```
# ipconfig /flushdns
Clear-DnsClientCache

# ipconfig /release
Remove-NetIPAddress -InterfaceAlias "Ethernet" -AddressFamily IPv4 -Confirm:$false
Remove-NetIPAddress -InterfaceAlias "Ethernet" -AddressFamily IPv6 -Confirm:$false
Remove-NetIPAddress -InterfaceAlias "Wi-Fi" -AddressFamily IPv4 -Confirm:$false
Remove-NetIPAddress -InterfaceAlias "Wi-Fi" -AddressFamily IPv6 -Confirm:$false

# ipconfig /renew
Restart-NetAdapter -Name "Ethernet"
Restart-NetAdapter -Name "Wi-Fi"

```
<br>


<h2>Desable Wi-Fi...</h2>

```
NETSH interface set interface name=Wi-Fi admin=DISABLE

```
<br>


<h2>Enable Wi-Fi...</h2>

```
NETSH interface set interface name=Wi-Fi admin=ENABLE

```
<br>


<h2>Desable Ethernet...</h2>

```
NETSH interface set interface name=Ethernet admin=DISABLE

```
<br>


<h2>Enable Ethernet...</h2>

```
NETSH interface set interface name=Ethernet admin=ENABLE

```
<br>

