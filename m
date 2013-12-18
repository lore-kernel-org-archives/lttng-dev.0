From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: make a trace_event in a module (driver)
Date: Wed, 18 Dec 2013 11:27:01 -0500
Message-ID: <52B1CCD5.8010906__18948.366205632$1387384096$gmane$org@gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD267A5E6B@VAL-E-01.valcartier.drdc-rddc.gc.ca>	<5294DB13.3010307@gmx.de>	<CA+jJMxsvAc2Tq2M+qYBhM=L-zL7mhAD=J76T2C_KH7T5PJPgnA@mail.gmail.com>
	<52ADF368.7040007@gmx.de> <52AE330E.2070604@gmail.com>
	<52AF32EE.6090203@gmx.de> <52AF3CED.2060106@gmail.com>
	<52AF4804.807@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-gg0-f181.google.com ([209.85.161.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1VtJxo-0004Oo-H5
	for lttng-dev@lists.lttng.org; Wed, 18 Dec 2013 11:27:18 -0500
Received: by mail-gg0-f181.google.com with SMTP id y1so736350ggc.40
	for <lttng-dev@lists.lttng.org>; Wed, 18 Dec 2013 08:27:06 -0800 (PST)
In-Reply-To: <52AF4804.807@gmx.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Klaus Dannecker <klaus.dannecker@gmx.de>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Le 2013-12-16 13:35, Klaus Dannecker a =E9crit :
> Hi Francis,
> =

> sample.h  ->  ../instumentation/events/lttng-modul
> lttng-trace-events-sample.c  ->  ../addons/
> and two various example
> trace-events-sample.c ; trace-events-sample.h
> trace-events-sample1.c with the
> the examples are stored in the folder ../addons/
> =

> in the make-File i add
> obj-m +=3D lttng-trace-events-sample.o
> obj-m +=3D trace-events-sample.o
> obj-m +=3D trace-events-sample1.o
> =

> where is the error?
> what sample is the best?
> can i use the same trace-event in all sample?

First, there were two definition with the same name, that is you may
end-up enabling one, but calling the other. It's better to use unique
names.

Also, the module lttng-modsign must be loaded first, otherwise the
tracepoint won't generate data.

It's better to put the probe code in it's own module.

You should put '\n' at the end of printk() (and printf() in general) to
force a flush, otherwise the string accumulates, and is flushed later.

I did put your code into addons-klaus branch on github. Grab the source,
then:

make
sudo make modules_install
sudo depmod -a
sudo lttng-sessiond -v
// make sure normal modules are loaded

cd addons
./control-addons.sh load
// make sure sample modules are loaded
// verify that event-sample thread is running (pgrep -l event-sample)

lttng create
lttng enable-event -k foo1_bar
lttng start
// check dmesg for event-sample output
lttng stop
lttng view

I tested it and it worked for me.

https://github.com/giraldeau/lttng-modules/tree/addons-klaus

Cheers,

Francis
