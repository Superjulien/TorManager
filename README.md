# TorOps

[![Version](https://img.shields.io/badge/Version-1.0.9-blue.svg)](https://github.com/Superjulien/TorOps) [![Shell](https://img.shields.io/badge/Shell_Script-grey?&logo=gnu-bash&logoColor=white.svg)](https://en.wikipedia.org/wiki/Unix_shell)

**TorOps** is a Bash script that simplifies the management of the Tor service on your Linux system. It provides a user-friendly interface to start, stop, and refresh the IP address used by the Tor network.

## Introduction

[Tor](https://www.torproject.org/) is a decentralized network that enables users to browse the internet anonymously by routing their connections through a network of nodes. However, managing the Tor service via the command line can be complex for non-technical users. This is where **TorOps** comes in, simplifying the process with an intuitive Bash script.

**Disclaimer:** However, it's important to note that TorOps does not allow you to route the entire operating system through Tor. It focuses on managing the Tor service for specific connections. It's essential to use `proxychains` to route traffic through Tor.

## Features

- **Start Tor:** Initiate the Tor service.
- **Stop Tor:** Safely and cleanly halt the Tor service.
- **Refresh IP Address:** Update the IP address used by Tor to enhance anonymity.
- **Monitor Public IP Address:** TorOps allows you to monitor your public IP address both with and without Tor.

## Prerequisites

To use TorOps, ensure that your system meets the following requirements:

- **Operating System:** TorOps is designed for Linux-based systems.
- **Bash Shell:** Make sure you are using the Bash shell (bash).
- **Installed Dependencies:** TorOps requires the following dependencies to be installed on your system:
  - `systemctl`
  - `wget`
  - `proxychains`
  - `curl`
  - `tor`

## Installation

Follow these steps to install and use TorOps on your system:

### Step 1: Clone the Repository

Clone this repository to your local machine using the following command:

```shell
git clone https://github.com/Superjulien/TorOps.git
```

### Step 2: Access the Directory

Navigate to the project directory using the following command:

```shell
cd TorOps
```

### Step 3: Install Dependencies

Before using TorOps, ensure that the required dependencies are installed on your system. You can install them using the package manager relevant to your Linux distribution. Here are examples for some popular distributions:

#### Debian/Ubuntu

```shell
sudo apt-get install systemctl wget proxychains curl tor
```

#### CentOS/RHEL

```shell
sudo yum install systemctl wget proxychains curl tor
```

#### Arch Linux

```shell
sudo pacman -S systemctl wget proxychains curl tor
```

Please consult your distribution's package manager for specific instructions if you are using a different Linux distribution.

### Step 4:  Setup proxychains

Edit the proxychains configuration file using your preferred text editor (e.g., vim, nano):

```shell
sudo vim /etc/proxychains.conf
```

In the configuration file, add the following line to specify the SOCKS5 proxy for Tor:

```shell
socks5 127.0.0.1 9050
```

Uncomment the `dynamic_chain` and `quiet_mode` lines:

```shell
# dynamic_chain
# quiet_mode
```

Comment out the `strict_chain` line:

```shell
strict_chain
```

### Step 5: Starting and Checking the Tor Service

To manually start the Tor service and check its status, you can use the following commands:

#### Start Tor Service

```shell
sudo service tor start
```

#### Check Tor Service Status

To verify whether the Tor service is running, you can use the following command:

```shell
sudo service tor status
```

The `sudo service tor status` command will display the current status of the Tor service, indicating whether it is active or inactive.

Make sure to run these commands in your terminal to start Tor and check its status. These commands can be helpful if you prefer managing Tor manually in addition to using the TorOps script.

### Step 6: Run the Script

Execute the TorOps script with superuser privileges (sudo) using the following command to use the interface:

```shell
sudo bash torops.sh
```

This command will launch the TorOps interface, allowing you to interactively choose options for starting, stopping, or refreshing Tor.

```
TorOps :

Ip Public 0.0.0.0 | Tor Status inactive | Ip Proxy No TOR


Selection :

	1 )  Start Tor
	2 )  Stop Tor
	3 )  Refresh IP Address

	q )  QUIT

>>
```

If you prefer to use command-line options, you can also run the script with the following commands:

```shell
sudo bash torops.sh [start|stop|refresh]
```

- To start Tor:

```shell
sudo bash torops.sh start
```

- To stop Tor:

```shell
sudo bash torops.sh stop
```

- To refresh the IP address used by Tor:

```shell
sudo bash torops.sh refresh
```

These commands provide an alternative way to manage the Tor service directly from the command line.

## Disclaimer

Please be aware that TorOps is designed to manage the Tor service for specific connections and does not route the entire operating system through Tor. It is crucial to utilize `proxychains` for routing traffic through the Tor network.

## How It Works

TorOps operates by interacting with the Tor service and using `proxychains` to route traffic through Tor. Here's a detailed breakdown of how it works:

1. When you run the script, it first checks if you have the necessary prerequisites installed on your system, such as `systemctl`, `wget`, `proxychains`, `curl`, and `tor`. If any of these dependencies are missing, the script will notify you and exit.

2. The script also checks if you have administrator (root) privileges to perform certain operations, as managing the Tor service requires elevated privileges. If you're not the administrator, the script will prompt you to run it with `sudo`.

3. Once the initial checks are completed, the script displays an interactive menu with the following options:
   - **Start TOR**: This option starts the Tor service if it's not already running. You'll see progress messages during startup.
   - **Stop TOR**: This option stops the Tor service if desired. You'll see progress messages during shutdown.
   - **Refresh IP**: This option refreshes your public IP address using Tor. This may take a moment as all outgoing requests are routed through the Tor network.

4. The script uses `proxychains` to perform network requests through the Tor network. It also checks the status of the Tor service using `systemctl`.

### Starting Tor

When you select the "Start Tor" option, TorOps executes the `service tor start` command with superuser privileges. This starts the Tor service.

### Stopping Tor

When you choose the "Stop Tor" option, TorOps executes the `service tor stop` command with superuser privileges. This cleanly stops the Tor service, and your internet connection returns to a standard state.

### Refreshing the IP Address

The "Refresh IP Address" option allows you to update the IP address used by Tor. TorOps executes `systemctl reload tor` to refresh the IP address, enhancing your anonymity.

## Sponsoring

This software is provided to you free of charge, with the hope that if you find it valuable, you'll consider making a donation to a charitable organization of your choice :

- SPA (Society for the Protection of Animals): The SPA is one of the oldest and most recognized organizations in France for the protection of domestic animals. It provides shelters, veterinary care, and works towards responsible adoption.

  [![SPA](https://img.shields.io/badge/Sponsoring-SPA-red.svg)](https://www.la-spa.fr/)

- French Popular Aid: This organization aims to fight against poverty and exclusion by providing food aid, clothing, and organizing recreational activities for disadvantaged individuals.

  [![SPF](https://img.shields.io/badge/Sponsoring-Secours%20Populaire%20Français-red.svg)](https://www.secourspopulaire.fr)

- Doctors Without Borders (MSF): MSF provides emergency medical assistance to populations in danger around the world, particularly in conflict zones and humanitarian crises.

  [![MSF](https://img.shields.io/badge/Sponsoring-Médecins%20Sans%20Frontières-red.svg)](https://www.msf.fr)

- Restaurants of the Heart : Restaurants of the Heart provides meals, emergency accommodation, and social services to the underprivileged.

  [![RDC](https://img.shields.io/badge/Sponsoring-Restaurants%20du%20Cœur-red.svg)](https://www.restosducoeur.org)

- French Red Cross: The Red Cross offers humanitarian aid, emergency relief, first aid training, as well as social and medical activities for vulnerable individuals.

   [![CRF](https://img.shields.io/badge/Sponsoring-Croix%20Rouge%20Française-red.svg)](https://www.croix-rouge.fr)

Every small gesture matters and contributes to making a real difference.

## Support

For support email : 

[![Gmail: superjulien](https://img.shields.io/badge/Gmail-Contact%20Me-purple.svg)](mailto:contact.superjulien@gmail.com) [![Tutanota: superjulien](https://img.shields.io/badge/Tutanota-Contact%20Me-green.svg)](mailto:contacts.superjulien@tutanota.com)
