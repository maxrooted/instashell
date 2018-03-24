# Instashell v1.5
## Author: github.com/thelinuxchoice
## IG: instagram.com/thelinuxchoice

Instashell is an Shell Script to perform multi-threaded brute force attack against Instagram, this script can bypass login limiting on wrong passwords, and it can test infinite number of passwords with a rate of +400 passwords/min.

![insta](https://user-images.githubusercontent.com/34893261/37858917-a6f23ae2-2eea-11e8-9f58-9a688390cfb0.png)

### Features
- Save/Resume sessions
- Anonymous attack through TOR
- Multi-thread (400 pass/min, 20 threads)

### Usage:
```
git clone https://github.com/thelinuxchoice/instashell
cd instashell
chmod +x instashell.sh
service tor start
sudo ./instashell.sh
```

### Install requirements (Curl, Tor, Openssl):

```
chmod +x install.sh
sudo ./install.sh
```

### How it works?

Script uses an Android ApkSignature to perform authentication in addition using TOR to change the ip address once blocked for many tries and continue attack.

