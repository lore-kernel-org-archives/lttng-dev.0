From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.9.5,
 2.10.4 (Linux user-space tracer)
Date: Fri, 24 May 2019 10:18:02 -0400 (EDT)
Message-ID: <399399626.12918.1558707482732.JavaMail.zimbra__40302.6795991295$1558707499$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 459T3w5DZ6z10hM
 for <lttng-dev@lists.lttng.org>; Fri, 24 May 2019 10:18:04 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 975531CB485
 for <lttng-dev@lists.lttng.org>; Fri, 24 May 2019 10:18:03 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org
List-Id: lttng-dev@lists.lttng.org

Hi,

Those are bugfix releases of the stable 2.9 and 2.10 branches of the
LTTng-UST project. The most notable fix is the one regarding
alignment of ring buffer shm space reservation, which may cause
LTTng-UST channels to fail to be created for large number of
sub-buffers.

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer,
is a low-overhead application tracer. The library "liblttng-ust" enables
tracing of applications and libraries.

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

Changelog:
2019-05-24 (Scavenger Hunt Day) lttng-ust 2.10.4
        * Cleanup: bitfields: streamline use of underscores
        * Silence compiler "always false comparison" warning
        * Fix: bitfield: shift undefined/implementation defined behaviors
        * Fix: Update coding style link
        * Fix: alignment of ring buffer shm space reservation
        * ust-ctl API: clarify getter usage requirements
        * Fix: don't access packet header for stream_id and stream_instance_id getters
        * compat: work around broken _SC_NPROCESSORS_CONF on MUSL libc
        * doc: remove repeated word in coding style
        * tap-driver.sh: flush stdout after each test result
        * Move wait_shm_mmap initialization to library constructor

2019-05-24 (Scavenger Hunt Day) lttng-ust 2.9.5
        * Cleanup: bitfields: streamline use of underscores
        * Silence compiler "always false comparison" warning
        * Fix: bitfield: shift undefined/implementation defined behaviors
        * Fix: Update coding style link
        * Fix: alignment of ring buffer shm space reservation
        * ust-ctl API: clarify getter usage requirements
        * Fix: don't access packet header for stream_id and stream_instance_id getters
        * compat: work around broken _SC_NPROCESSORS_CONF on MUSL libc
        * doc: remove repeated word in coding style
        * tap-driver.sh: flush stdout after each test result
        * Move wait_shm_mmap initialization to library constructor



-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
