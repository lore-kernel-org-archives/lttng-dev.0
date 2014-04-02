From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: trace_block_rq_complete duplicate define
Date: Wed, 2 Apr 2014 17:29:51 +0000 (UTC)
Message-ID: <300482672.5102.1396459791312.JavaMail.zimbra__20902.3865209476$1396520217$gmane$org@efficios.com>
References: <CANudz+sSf8BOG1ZFJarA4FJN2pz5Qp7u-AXbednyp4cRtgUMzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WVOz9-0001a8-9S
 for lttng-dev@lists.lttng.org; Wed, 02 Apr 2014 13:30:05 -0400
In-Reply-To: <CANudz+sSf8BOG1ZFJarA4FJN2pz5Qp7u-AXbednyp4cRtgUMzA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: loody <miloody@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "loody" <miloody@gmail.com>
> To: lttng-dev@lists.lttng.org
> Sent: Friday, March 28, 2014 4:18:10 AM
> Subject: [lttng-dev] trace_block_rq_complete duplicate define
> 
> hi all:
> My environment is like below:
> 1. kernel 3.8.13
> 2. lttng modules is 2.4.0 ( i also try lttng-modules-2.3.5 but result
> is the same)
> I will get "trace_block_rq_complete duplicate define" like below:
> is there kernel or lttng modules patch I need to fix this compile error?
> 
> Thanks for your help in advance,

Hi,

This kind of issue may happen if a stale "version.h" is found in your
kernel build tree. Doing a make mrproper on your kernel tree might help.
The kernel has changed the location where it is put around version 3.4,
and it has caused some problems, because the previous auto-generated header
is not cleaned up during a normal "make", and takes precedence over the
new generated header.

I've tried building lttng-modules master as of commit
01adf18ef2cecd8b4522d128b942f27345e91961 against
v3.8
v3.8.2
v3.8.13

with CONFIG_BLOCK enabled and CONFIG_EVENT_TRACING enabled in the
kernel config, and it all works fine.

Perhaps if you could share your kernel .config with us it could help
reproducing your issue. Also make sure that your kernel tree is a pristine
mainline kernel. Perhaps the vendor sending you this kernel has introduced
changes into it.

Thanks,

Mathieu

> 
>   CC [M]
>   /media/sdb1/software/lttng/lttng.arm.ok/lttng-modules-2.4.0/probes/lttng-probe-block.o
> In file included from
> /media/sdb1/software/lttng/lttng.arm.ok/lttng-modules-2.4.0/probes/../instrumentation/events/lttng-module/../../../probes/lttng-events.h:157:0,
>                  from
> /media/sdb1/software/lttng/lttng.arm.ok/lttng-modules-2.4.0/probes/../instrumentation/events/lttng-module/../../../probes/define_trace.h:148,
>                  from
> /media/sdb1/software/lttng/lttng.arm.ok/lttng-modules-2.4.0/probes/../instrumentation/events/lttng-module/block.h:877,
>                  from
> /media/sdb1/software/lttng/lttng.arm.ok/lttng-modules-2.4.0/probes/lttng-probe-block.c:41:
> /media/sdb1/software/lttng/lttng.arm.ok/lttng-modules-2.4.0/probes/../instrumentation/events/lttng-module/../../../probes/../instrumentation/events/lttng-module/block.h:240:1:
> error: conflicting types for 'trace_block_rq_complete'
> In file included from
> /media/sdb1/software/lttng/lttng.arm.ok/lttng-modules-2.4.0/probes/lttng-probe-block.c:30:0:
> include/trace/events/block.h:124:1: note: previous definition of
> 'trace_block_rq_complete' was here
> make[3]: ***
> [/media/sdb1/software/lttng/lttng.arm.ok/lttng-modules-2.4.0/probes/lttng-probe-block.o]
> Error 1
> make[2]: ***
> [/media/sdb1/software/lttng/lttng.arm.ok/lttng-modules-2.4.0/probes]
> Error 2
> make[1]: ***
> [_module_/media/sdb1/software/lttng/lttng.arm.ok/lttng-modules-2.4.0]
> Error 2
> make[1]: Leaving directory
> `/media/sdb2/Novatek2/NT72668/fpga.kernel/kernel.3.8/private/VDLinux_3.8.2/linux-3.8.2'
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
