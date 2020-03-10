From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: [RELEASE] Babeltrace 2.0.2 - Amqui
Date: Tue, 10 Mar 2020 19:06:13 -0400
Message-ID: <20200310230613.GA234639@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 by lists.lttng.org (Postfix) with ESMTPS id 48cW161Tp0z1FfB
 for <lttng-dev@lists.lttng.org>; Tue, 10 Mar 2020 19:06:17 -0400 (EDT)
Received: by mail-qt1-f194.google.com with SMTP id e13so231350qts.6
 for <lttng-dev@lists.lttng.org>; Tue, 10 Mar 2020 16:06:17 -0700 (PDT)
Content-Disposition: inline
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

Hi everyone!

Today we're releasing the first patch-level release of Babeltrace 2.0
"Amqui".

What's new since Babeltrace 2.0.1?
==================================

This release contains the following note-worthy fixes:

  - Fixed a segmentation fault when trying to instantiate a trimmer
    downstream of a component that creates streams without packets.
    See 5cf4fb3d2 [1].

  - The trimmer component class rejected streams that are not
    packetized. Since the trimmer supports streams without packets,
    there is no reason to reject them.
    See a26dd09ff [2].

  - The configure script silently accepted invalid Python
    configurations such as building with `--enable-python-plugins`,
    but without `--enable-python-bindings`, which resulted in users
    being unable to import the `bt2` package.
    See 3530dd01a [3].

The full change log follows.

2020-03-10 Babeltrace 2.0.2 (International Bagpipe Day)
	* common: cast arguments to character classification functions to unsigned char
	* flt.utils.muxer: initialize variable to silence -Wmaybe-uninitialized warning
	* Fix: configure.ac: silently accepting invalid Python configuration
	* Cleanup: configure.ac: remove redundant `AC_ARG_ENABLE` parameters
	* Fix: plugin-dev.h: Disable address sanitizer on pointer array section variables
	* Fix: cli: use BT_CLI_LOGE_APPEND_CAUSE instead of printf to print errors
	* tests: improve flt.utils.trimmer/test_trimming to test streams without packets
	* Fix: flt-utils.trimmer: accept streams without packet support
	* Fix: lib: don't assume that streams have packets in auto seek
	* Fix: correct typo in README
	* Update working version to Babeltrace 2.0.2


Important links
===============
Babeltrace 2.0.2 tarball:
    https://www.efficios.com/files/babeltrace/babeltrace2-2.0.2.tar.bz2

Babeltrace website:
    https://babeltrace.org

Mailing list (for support and development):
    `lttng-dev at lists.lttng.org`

IRC channel:
    `#lttng` on `irc.oftc.net`

Git repository:
    https://bugs.lttng.org/projects/babeltrace

GitHub project:
    https://github.com/efficios/babeltrace

Continuous integration:
    https://ci.lttng.org/view/Babeltrace/

Code review:
    https://review.lttng.org/q/project:babeltrace

[1] https://github.com/efficios/babeltrace/commit/5cf4fb3d2
[2] https://github.com/efficios/babeltrace/commit/a26dd09ff
[3] https://github.com/efficios/babeltrace/commit/3530dd01a
