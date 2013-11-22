From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: make a trace_event in a modul (driver)
Date: Fri, 22 Nov 2013 14:07:59 -0500
Message-ID: <528FAB8F.7040800__10965.7287634493$1385147433$gmane$org@gmail.com>
References: <527DF369.4020704@gmx.de>	<5283B8BD.9020703@gmx.de>	<528DD70B.8040504@gmx.de>	<CA+jJMxsybZ4mo1Mp369hhgNSCi-pfNh8VG1F5S2H5DpKL5nSsw@mail.gmail.com>	<528E37D8.3060606@gmx.de>	<CA+jJMxt89qdM98hu536heBwk90AQEPwONvpa7s-vqKGQ036euQ@mail.gmail.com>	<528F37DE.7050204@gmx.de>	<CA+jJMxtD7TZ6MEf+URHe=SkOhCVT3aD56BhuQdp48EmJvnsyJg@mail.gmail.com>
	<528F9561.3030802@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1Vjw5G-0002M0-7p
	for lttng-dev@lists.lttng.org; Fri, 22 Nov 2013 14:08:12 -0500
Received: by mail-ie0-f173.google.com with SMTP id to1so2849984ieb.32
	for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2013 11:08:00 -0800 (PST)
In-Reply-To: <528F9561.3030802@gmx.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Klaus Dannecker <klaus.dannecker@gmx.de>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Le 2013-11-22 12:33, Klaus Dannecker a =E9crit :
> Hi.
> =

> Thank's J=E9r=E9mie!
> =

> my account type is Administrator.
> sudo lttng list -k works good!
> how can I define a "tracing"group , so I no longer need the sudo command?
> =

> another problem:
> i have add mycustomevents in the lttng_module like
> http://lists.lttng.org/pipermail/lttng-dev/2013-October/021540.html
> but after
> $ make
> $ sudo make modules_install
> $ sudo depmod -a
>  and
> $ sudo lttng list -k
> my lttng-probe-mycustomevents.ko is now in
> /lib/modules/3.11.0-12-generic/extra/probes
> but i can't find my new event in the list!

On Ubuntu since kernel 3.8, modules are signed, and while unsigned
modules are loaded, if they contains tracepoints, they won't be
registered and won't be listed.

To avoid this inconvenience, a certificate x.509 must be generated and
modules signed with it, and the additional signing key must be loaded.
This process is not documented, but you can find the integration of this
process into the makefiles in lttng-modules addons.

https://github.com/giraldeau/lttng-modules/tree/addons

The module lttng-modsign is generated (look at the base makefile and
their code) and if they are loaded before your own module, tracepoints
tracepoints inside it should be registered correctly.

BTW, if you want, you can put your code directly under addons and start
your own tracepoints right away.

Cheers,

Francis
