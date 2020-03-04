From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.10.7, 2.11.1, 2.12.0-rc2 (Linux user-space
 tracer)
Date: Wed, 4 Mar 2020 16:27:08 -0500 (EST)
Message-ID: <1372342050.18535.1583357228871.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
Sender: linux-trace-users-owner@vger.kernel.org
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
List-Id: lttng-dev@lists.lttng.org

Hi,

This announcement covers new releases in the two actively maintained
stable branches of the LTTng-UST project (2.10.7 and 2.11.1), as well as
the second release candidate for the 2.12 branch (2.12.0-rc2).

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer,
is a low-overhead application tracer. The library "liblttng-ust" enables
tracing of applications and libraries.

* Noteworthy fixes:

All of these releases contain a fix which ensures the FD_CLOEXEC flag
is set for _all_ file descriptors received by lttng-ust over unix
socket. This fixes an issue where more file descriptors than expected
stay open over exec.

Fixes were introduced to please the address sanitizer (ASan) part of
clang-9. One documented out-of-bound access was done by jhash as an
"optimization" which was rightfully tripping ASan. Since this is
not a fast-path, the optimization was removed and we always use the
slower "valgrind-safe" code path. We also annotated the variables
emitted in the __tracepoints_ptrs to ensure ASan does not emit
redzones around those variables, which are means to be contiguous
within the section.

For the 2.10 and 2.11 branches, building with -fno-common is
enforced to prepare for the upcoming default behavior change
in gcc 10.

Please try it out, and as usual, feedback is welcome!

Thanks,

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
