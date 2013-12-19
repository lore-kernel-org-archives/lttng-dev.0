From: Klaus Dannecker <klaus.dannecker@gmx.de>
Subject: Re: make a trace_event in a module (driver)
Date: Thu, 19 Dec 2013 16:42:25 +0100
Message-ID: <52B313E1.8030901__10924.1810664118$1387467802$gmane$org@gmx.de>
References: <48CF5AC71E61DB46B70D0F388054EFFD267A5E6B@VAL-E-01.valcartier.drdc-rddc.gc.ca>	<5294DB13.3010307@gmx.de>	<CA+jJMxsvAc2Tq2M+qYBhM=L-zL7mhAD=J76T2C_KH7T5PJPgnA@mail.gmail.com>
	<52ADF368.7040007@gmx.de> <52AE330E.2070604@gmail.com>
	<52AF32EE.6090203@gmx.de> <52AF3CED.2060106@gmail.com>
	<52AF4804.807@gmx.de> <52B1CCD5.8010906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mout.gmx.net ([212.227.15.19])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <klaus.dannecker@gmx.de>) id 1Vtfk8-0006rO-6D
	for lttng-dev@lists.lttng.org; Thu, 19 Dec 2013 10:42:35 -0500
Received: from [192.168.178.23] ([94.217.86.99]) by mail.gmx.com (mrgmx003)
	with ESMTPSA (Nemesis) id 0M1W5x-1VeD9s45zF-00tQS1 for
	<lttng-dev@lists.lttng.org>; Thu, 19 Dec 2013 16:42:26 +0100
In-Reply-To: <52B1CCD5.8010906@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Francis Giraldeau <francis.giraldeau@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


Am 18.12.2013 17:27, schrieb Francis Giraldeau:
> Le 2013-12-16 13:35, Klaus Dannecker a =E9crit :
>> Hi Francis,
>>
>> sample.h  ->  ../instumentation/events/lttng-modul
>> lttng-trace-events-sample.c  ->  ../addons/
>> and two various example
>> trace-events-sample.c ; trace-events-sample.h
>> trace-events-sample1.c with the
>> the examples are stored in the folder ../addons/
>>
>> in the make-File i add
>> obj-m +=3D lttng-trace-events-sample.o
>> obj-m +=3D trace-events-sample.o
>> obj-m +=3D trace-events-sample1.o
>>
>> where is the error?
>> what sample is the best?
>> can i use the same trace-event in all sample?
> First, there were two definition with the same name, that is you may
> end-up enabling one, but calling the other. It's better to use unique
> names.
>
> Also, the module lttng-modsign must be loaded first, otherwise the
> tracepoint won't generate data.
>
> It's better to put the probe code in it's own module.
>
> You should put '\n' at the end of printk() (and printf() in general) to
> force a flush, otherwise the string accumulates, and is flushed later.
>
> I did put your code into addons-klaus branch on github. Grab the source,
> then:
>
> make
> sudo make modules_install
> sudo depmod -a
> sudo lttng-sessiond -v
> // make sure normal modules are loaded
>
> cd addons
> ./control-addons.sh load
> // make sure sample modules are loaded
> // verify that event-sample thread is running (pgrep -l event-sample)
>
> lttng create
> lttng enable-event -k foo1_bar
> lttng start
> // check dmesg for event-sample output
> lttng stop
> lttng view
>
> I tested it and it worked for me.
>
> https://github.com/giraldeau/lttng-modules/tree/addons-klaus
ok, so i downloadet the =

https://github.com/giraldeau/lttng-modules/tree/addons-klaus
but i can't compile this.
klaus@ubuntu:~/lttng_src/lttng-modules-addons-klaus$ make
..
   CC [M] =

/home/klaus/lttng_src/lttng-modules-addons-klaus/probes/lttng-probe-user.o
   CC [M] =

/home/klaus/lttng_src/lttng-modules-addons-klaus/lttng-context-perf-counter=
s.o
   LD [M] /home/klaus/lttng_src/lttng-modules-addons-klaus/lttng-tracer.o
   MD5SUM /home/klaus/lttng_src/lttng-modules-addons-klaus/.System.map.md5
md5sum: /boot/System.map-3.8.0-29-generic: Permission denied
make[2]: *** =

[/home/klaus/lttng_src/lttng-modules-addons-klaus/.System.map.md5] Error 1
make[1]: *** [_module_/home/klaus/lttng_src/lttng-modules-addons-klaus] =

Error 2
make[1]: Leaving directory `/usr/src/linux-headers-3.8.0-29-generic'
make: *** [default] Error 2
klaus@ubuntu:~/lttng_src/lttng-modules-addons-klaus$

when i use sudo make, i become another error:
make -C /lib/modules/3.8.0-29-generic/build =

M=3D/home/klaus/lttng_src/lttng-modules-addons-klaus modules
make[1]: Entering directory `/usr/src/linux-headers-3.8.0-29-generic'
   AS [M] =

/home/klaus/lttng_src/lttng-modules-addons-klaus/lttng-certificate.o
/home/klaus/lttng_src/lttng-modules-addons-klaus/lttng-certificate.o: =

Assembler messages:
/home/klaus/lttng_src/lttng-modules-addons-klaus/lttng-certificate.o: =

Warning: end of file in comment; newline inserted
/home/klaus/lttng_src/lttng-modules-addons-klaus/lttng-certificate.o:1: =

Error: junk at end of line, first unrecognized character valued 0x7f
/home/klaus/lttng_src/lttng-modules-addons-klaus/lttng-certificate.o:1: =

Error: junk at end of line, first unrecognized character valued 0x1
/home/klaus/lttng_src/lttng-modules-addons-klaus/lttng-certificate.o:1: =

Error: junk at end of line, first unrecognized character valued 0x3
...
/home/klaus/lttng_src/lttng-modules-addons-klaus/lttng-certificate.S:13: =

Error: file not found: signing_key.x509
make[2]: *** =

[/home/klaus/lttng_src/lttng-modules-addons-klaus/lttng-certificate.o] =

Error 1
make[1]: *** [_module_/home/klaus/lttng_src/lttng-modules-addons-klaus] =

Error 2
make[1]: Leaving directory `/usr/src/linux-headers-3.8.0-29-generic'
make: *** [default] Error 2

but the File signing_key.x509 exist!

I'm so sorry that I always get errors!

Cheers,
Klaus
> Cheers,
>
> Francis
>
