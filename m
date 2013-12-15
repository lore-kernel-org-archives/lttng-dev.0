From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: make a trace_event in a module (driver)
Date: Sun, 15 Dec 2013 17:54:06 -0500
Message-ID: <52AE330E.2070604__47993.8466138721$1387148263$gmane$org@gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD267A5E6B@VAL-E-01.valcartier.drdc-rddc.gc.ca>	<5294DB13.3010307@gmx.de>	<CA+jJMxsvAc2Tq2M+qYBhM=L-zL7mhAD=J76T2C_KH7T5PJPgnA@mail.gmail.com>
	<52ADF368.7040007@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1VsKZu-0006lz-KQ
	for lttng-dev@lists.lttng.org; Sun, 15 Dec 2013 17:54:30 -0500
Received: by mail-qc0-f171.google.com with SMTP id c9so3222037qcz.30
	for <lttng-dev@lists.lttng.org>; Sun, 15 Dec 2013 14:54:21 -0800 (PST)
In-Reply-To: <52ADF368.7040007@gmx.de>
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

Le 2013-12-15 13:22, Klaus Dannecker a =E9crit :
> Hello,
> =

> now its work!
> i have download the new lttng-tools. (git pull)
> =

> the next problem:
> with
> sudo insmod
> /lib/modules/3.8.0-29-generic/extra/addons/lttng-trace-events-sample.ko
> and
> lttng list -k
> hurray! i see the new event!

Great!

> now i start a lttng session and load the trace-events-sample.ko
> (compiling the sample in the linux source code)
> but i see not the event in the session. (looking in the eclipse viewer)
> what i am doing wrong?

Could it be possible that the tracepoint is not called? To verify this,
I would recommend you to display the information in dmesg just before
the tracepoint:

if (printk_ratelimit())
	printk("hello event!");

Then: dmesg -c

What does exactly the module is supposed to record?

Cheers,

Francis
