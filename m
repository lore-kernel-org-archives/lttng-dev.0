From: Christian Babeux <christian.babeux@efficios.com>
Subject: lttng-ust, libtool and cross-compilation
Date: Mon, 30 Jul 2012 11:57:17 -0400
Message-ID: <CAGDH53n-_vt5_9j_WNgVueF7FdzWcmc8yz0ZC4e=jKMqV8t5ZQ__25521.2749740624$1343663932$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lpp01m010-f48.google.com ([209.85.215.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1SvsLU-0004Nm-MH
	for lttng-dev@lists.lttng.org; Mon, 30 Jul 2012 11:57:25 -0400
Received: by lagz14 with SMTP id z14so3906060lag.35
	for <lttng-dev@lists.lttng.org>; Mon, 30 Jul 2012 08:57:18 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, David Goulet <dgoulet@efficios.com>, Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi all,

When cross-compiling lttng-ust, some users might encounter an issue
regarding missing libraries like this one:

/usr/lib/gcc/powerpc-linux-gnu/4.4.5/../../../../powerpc-linux-gnu/bin/ld:
warning: liblttng-ust-tracepoint.so.0, needed by
../../liblttng-ust/.libs/liblttng-ust.so, not found (try using -rpath
or -rpath-link)
../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
`init_tracepoint'
../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
`__tracepoint_probe_unregister'
../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
`__tracepoint_probe_register'
../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
`exit_tracepoint'

After some digging, this issue seems to appear only in cross-compilation
setup, especially on Debian based system.

The lttng-ust libraries dependencies can be summarized as follow:

+-----------------+ -> liblttng-ust-tracepoint.so -> liburcu-bp.so
| liblttng-ust.so | -> liblttng-ust-runtime.so
+-----------------+ -> liblttng-ust-support.so    -> libringbuffer.so

The problem arise when linking libraries with indirect libraries dependencies.
Other project have had this issue in the past [1].

This "bug" is caused by an upstream modification in the libtool package
on Debian system [2]. The libtool "link_all_deplibs" flag is set to "no"
by default on linux targets (AFAIK, other distros set it to unknown).

This has the unfortunate consequence of breaking cross-compilation
builds because gnu-ld doesn't use rpath on cross-compilation targets.
Hence the undefined reference errors messages.

Here are some possible ways to handle this problematic situation:

1 - Cook our own libtool.m4 in the lttng-ust tree with the
    libtool link_all_deplibs flag set to 'unknown'.

    Pro: No action required on the user side.
    Con: Additional work for the maintainer to ensure that the proper
	 libtool.m4 is present in sources packages. Additionnal maintenance.

2 - Add explicit dependencies to indirect libraries in the appropriates
    Makefile.am (such as the ones found in tests/{hello, hello.cxx, fork}).

    Pro: No action required on the user side.
    Con: Tedious.

3 - Add a configure flag to detect bogus version of libtool and automagically
    fix it.

    Pro: Less maintenance.
    Con: Require user interaction when cross-compiling.

Other components of LTTng might be affected be the same issue.

Any thoughts or additional input is quite welcome!

Thanks,

Christian

[1] - https://lists.isc.org/pipermail/bind10-dev/2011-August/002535.html
[2] - http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=297726
