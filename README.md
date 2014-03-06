Vhagar
======

The CRM system written in ruby on rails for LDI 2014.

Running
======

Before any actions make sure that you have all necessary gems installed.

```
bundle install
```

Thanks to [guard][] gem you run applicattion with command `guard` in folder `/crm/`

## LiveReload

If you wan to use [LiveReload][] web browseer plugin you want to ssh to vagrant specying ports from Vagrantfile. Password for user `vagrant `is `vagrant` .

```
ssh -L 35729:127.0.0.1:35729 vagrant@192.168.33.10
```

Then run guard with poll and interval option

```
guard -p -l 1
```

If you notice hugh CPU usage you can increate poll interval.

Vagrant
======

In case of any problems with downloading box please download and add it manualy.

[guard]: https://github.com/guard/guard
[LiveReload]: http://livereload.com/