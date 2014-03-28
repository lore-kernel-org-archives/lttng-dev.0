From: loody <miloody@gmail.com>
Subject: trace_block_rq_complete duplicate define
Date: Fri, 28 Mar 2014 16:18:10 +0800
Message-ID: <CANudz+sSf8BOG1ZFJarA4FJN2pz5Qp7u-AXbednyp4cRtgUMzA__27973.7414829016$1395994748$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <miloody@gmail.com>) id 1WTRzT-0005i7-U2
 for lttng-dev@lists.lttng.org; Fri, 28 Mar 2014 04:18:21 -0400
Received: by mail-ie0-f180.google.com with SMTP id as1so4411594iec.25
 for <lttng-dev@lists.lttng.org>; Fri, 28 Mar 2014 01:18:10 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

hi all:
My environment is like below:
1. kernel 3.8.13
2. lttng modules is 2.4.0 ( i also try lttng-modules-2.3.5 but result
is the same)
I will get "trace_block_rq_complete duplicate define" like below:
is there kernel or lttng modules patch I need to fix this compile error?

Thanks for your help in advance,

  CC [M]  /media/sdb1/software/lttng/lttng.arm.ok/lttng-modules-2.4.0/probes/lttng-probe-block.o
In file included from
/media/sdb1/software/lttng/lttng.arm.ok/lttng-modules-2.4.0/probes/../instrumentation/events/lttng-module/../../../probes/lttng-events.h:157:0,
                 from
/media/sdb1/software/lttng/lttng.arm.ok/lttng-modules-2.4.0/probes/../instrumentation/events/lttng-module/../../../probes/define_trace.h:148,
                 from
/media/sdb1/software/lttng/lttng.arm.ok/lttng-modules-2.4.0/probes/../instrumentation/events/lttng-module/block.h:877,
                 from
/media/sdb1/software/lttng/lttng.arm.ok/lttng-modules-2.4.0/probes/lttng-probe-block.c:41:
/media/sdb1/software/lttng/lttng.arm.ok/lttng-modules-2.4.0/probes/../instrumentation/events/lttng-module/../../../probes/../instrumentation/events/lttng-module/block.h:240:1:
error: conflicting types for 'trace_block_rq_complete'
In file included from
/media/sdb1/software/lttng/lttng.arm.ok/lttng-modules-2.4.0/probes/lttng-probe-block.c:30:0:
include/trace/events/block.h:124:1: note: previous definition of
'trace_block_rq_complete' was here
make[3]: *** [/media/sdb1/software/lttng/lttng.arm.ok/lttng-modules-2.4.0/probes/lttng-probe-block.o]
Error 1
make[2]: *** [/media/sdb1/software/lttng/lttng.arm.ok/lttng-modules-2.4.0/probes]
Error 2
make[1]: *** [_module_/media/sdb1/software/lttng/lttng.arm.ok/lttng-modules-2.4.0]
Error 2
make[1]: Leaving directory
`/media/sdb2/Novatek2/NT72668/fpga.kernel/kernel.3.8/private/VDLinux_3.8.2/linux-3.8.2'
