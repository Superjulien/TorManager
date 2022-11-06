# Tor_select

A simple tools for start, stop tor or generate new ip.

## Documentation

- [Tor](https://support.torproject.org/)
- [Bash](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html)
- [Proxychains](http://proxychains.sourceforge.net/howto.html)

## Installation
### Linux
Required : 
- Tor
- Bash
- Proxychains
- Wget

```
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install wget tor proxychains
sudo service tor start
sudo service tor status
git clone https://github.com/Superjulien/Tor_select.git 
```
### Setup proxychains :
```
sudo vim /etc/proxychains.conf
socks5 127.0.0.1 9050
```
Uncomment :
```
# dynamic_chain
```
Comment :
```
strict_chain
```

## Usage

```
cd Tor_select
sudo sh torselect.sh
```
```
Tor_select :

Ip Public 0.0.0.0 | Tor Status inactive | Ip Proxy No TOR


Selection :

	1 )  Start T0R
	2 )  Stop T0R
	3 )  New IP

	9 )  QUIT

>>
```
## Support

For support, email [Gmail: superjulien](mailto:contact.superjulien@gmail.com) | [Tutanota: superjulien](mailto:contacts.superjulien@tutanota.com).
