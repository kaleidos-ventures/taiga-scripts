# Taiga Bootstrap Scripts #

Scripts for initial deploy of taiga services.

It installs:

- taiga-back version 1.1.0
- taiga-front version 1.1.1

**WARNING: that scripts are in aplha state**

## Requirements ##

- Ubuntu Server 14.04
- Bash
- Git

## Notes / Warnings

- In aplha state, not tested in much environments and suffer a lot of changes.
- Designed to work mainly for taiga-vagrant(but can works without it)
- Not supports updates. Reprovisioning is stil in development.
- Does not supports installation with root user.

## Setup server-like environment ##

This environment is not ready for high scale but should work well for small organizations
using taiga.

Having fresh and updated ubuntu 14.04:

```
$ git clone https://github.com/taigaio/taiga-scripts.git
$ cd taiga-scripts
$ bash setup-server.sh
```

## Setup development-like environment ##

This setup is much like the previous but with a few differences:

- Do not install services like nginx, because they are only necessary for production
- Set all hostnames to localhost to easily run everything on localhost

Having fresh and updated ubuntu 14.04:

```
$ git clone https://github.com/taigaio/taiga-scripts.git
$ cd taiga-scripts
$ bash setup-devel.sh
```


## Community ##

[Taiga has a mailing list](http://groups.google.com/d/forum/taigaio). Feel free to join it and ask any questions you may have.

To subscribe for announcements of releases, important changes and so on, please follow [@taigaio](https://twitter.com/taigaio) on Twitter.
