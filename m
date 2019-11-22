From: Norbert Lange <nolange79@gmail.com>
Subject: Using lttng-ust with xenomai
Date: Fri, 22 Nov 2019 10:14:42 +0100
Message-ID: <CADYdroN-i9yrpd-wjPSW36GUptRV+kOCJT=Yv6+Z5sCVBmo_SQ__33596.4964747959$1574414113$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 by lists.lttng.org (Postfix) with ESMTPS id 47K9k63Cx9z1RMF
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 04:14:54 -0500 (EST)
Received: by mail-io1-xd30.google.com with SMTP id x21so7183653ior.2
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 01:14:54 -0800 (PST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hello,

I already started a thread over at xenomai.org [1], but I guess its
more efficient to ask here aswell.
The basic concept is that xenomai thread run *below* Linux (threads
and irg handlers), which means that xenomai threads must not use any
linux services like the futex syscall or socket communication.

## tracepoints

expecting that tracepoints are the only thing that should be used from
the xenomai threads, is there anything using linux services.
the "bulletproof" urcu apparently does not need anything for the
reader lock (aslong as the thread is already registered), but I dont
know how the write-buffers are prepared.

You can call linux sycalls from xenomai threads (it will switch to the
linux shadow thread for that and lose realtime characteristics), so a
one time setup/shutdown like registering the threads is not an issue.

## membarrier syscall

I haven't got an explanation yet, but I believe this syscall does
nothing to xenomai threads (each has a shadow linux thread, that is
*idle* when the xenomai thread is active).
liburcu has configure options allow forcing the usage of this syscall
but not disabling it, which likely is necessary for Xenomai.

Any input is welcome.
Kind regards, Norbert

[1] - https://xenomai.org/pipermail/xenomai/2019-November/042027.html
