From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: custom probe for loadable device driver - no output?
Date: Wed, 05 Aug 2015 15:46:19 -0400
Message-ID: <55C2680B.2000105__3553.30520910702$1438804042$gmane$org@efficios.com>
References: <CAJrJ9eH0F=AiiwjmC5QacBomDMUF_jTjeuoauyavFQUpiTQkVg@mail.gmail.com>
 <CAJrJ9eEVKUDm+BpZ7nm8J-qjsvA=DXWoALjqne7vRUE-ZaXziQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZN4dv-0007dZ-88
 for lttng-dev@lists.lttng.org; Wed, 05 Aug 2015 15:46:31 -0400
In-Reply-To: <CAJrJ9eEVKUDm+BpZ7nm8J-qjsvA=DXWoALjqne7vRUE-ZaXziQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Joe VanAndel <vanandel@ucar.edu>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Oh, that's right, we have a wrapper in lttng-modules to do the trick of
enabling the tracepoint in signed kernels even if the module is not signed.
See wrapper_lttng_fixup_sig in wrapper/tracepoint.h, it might help.

Julien

On 15-08-05 03:13 PM, Joe VanAndel wrote:
> Sorry, I=92m answering my own question:
> =

> When I built a new kernel with =93CONFIG_MODULE_SIG=94 disabled, the prob=
es
> in my loadable driver started working.
> =

> It would be helpful to have this documented in the tutorial on kernel
> tracing.
> =

> On Tue, Aug 4, 2015 at 3:46 PM, Joe VanAndel <vanandel@ucar.edu
> <mailto:vanandel@ucar.edu>> wrote:
> =

>     I=92m trying to add LTTng probes to a driver module, but I don=92t get
>     any output from my probe in the LTTng session.
> =

> =

>     Any idea what else I need to configure to get the output from my prob=
e?
> =

> =

>     Kernel: 3.10.0
> =

>     OS:  Centos 7.1.1503
> =

>     LTTng tools : from EfficiOS-RHEL7-x86-64 repository
> =

>     lttng-modules:  2.6.2
> =

> =

>     The running kernel has the following enabled:
> =

>     CONFIG_MODULES
> =

>     CONFIG_KALLSYMS
> =

>     CONFIG_HIGH_RES_TIMERS
> =

>     CONFIG_TRACEPOINTS
> =

> =

>     I=92ve defined/used tracepoints in my driver with the mainline
>     TRACE_EVENT() macros.  My tracepoints are on the open/close entry
>     points of the device.
> =

> =

>     I=92ve added the LTTng adaptation layer for my probe in LTTng-modules=
. =

> =

> =

>     I=92ve started the daemon to load my custom probe
> =

>      lttng-sessiond -d --extra-kmod-probes=3Ddb2k
> =

> =

>     I=92ve verified that my event is available, by running
> =

> =

>     lttng list --kernel | grep db2k
> =

>           db2k_hello (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> =

> =

>     There=92s an entry for my probe in =

> =

>     /sys/kernel/debug/tracing/events/db2k/db2k_hello
> =

> =

>     When I run the following as root:
> =

>     lttng create trace_db2k
> =

>     lttng enable-event --kernel --tracepoint db2k_hello --tracepoint
>     kmem_kmalloc --tracepoint kmem_kfree \
> =

>          --tracepoint timer_start --tracepoint timer_cancel
> =

>     lttng start
> =

>     =97=97=97=97=97=97=97
> =

>     the output is:
> =

>     Session trace_db2k created.
> =

>     Traces will be written in /root/lttng-traces/trace_db2k-20150804-1933=
18
> =

>     Kernel event db2k_hello created in channel channel0
> =

>     Tracing started for session trace_db2k
> =

>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

>      I run a test program that uses the driver, and then stop the session.
> =

>     # lttng stop
> =

>     Waiting for data availability.
> =

>     Tracing stopped for session trace_db2k
> =

>     # lttng view
> =

>     Trace directory: /root/lttng-traces/trace_db2k-20150804-193318
> =

>     <No output>
> =

> =

>     Here is the =93mainline=94 db2k.h
> =

>     http://pastebin.com/0i8eWF1a
> =

> =

>     Here is the =

> =

>     LTTng adaptation db2k.h
> =

>     http://pastebin.com/fXW9ppqM
> =

> =

>     Here is the =

> =

>     lttng-probe-db2k.c
> =

>     http://pastebin.com/WHuWKpPZ
> =

> =

>     The drive contains the lines:
> =

>     #define CREATE_TRACE_POINTS
> =

>     #include "trace/events/db2k.h"
> =

> =

>     static int
>     db2k_open(struct inode *inode, struct file *file)
>     {
>         int minor =3D MINOR(inode->i_rdev);
>         int stat =3D 0;
>         DEVICE_EXTENSION *pde =3D NULL;
>         dbg("db2k_open called");
>         trace_db2k_hello(minor, "open");
>     .
>     .
>     }
> =

>     -- =

>     Joe VanAndel
>     NCAR/EOL
> =

> =

> =

> =

> -- =

> Joe VanAndel
> NCAR/EOL
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =
