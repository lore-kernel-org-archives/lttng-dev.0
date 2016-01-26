From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Bogus openembedded gcc patch
Date: Tue, 26 Jan 2016 01:02:52 +0000 (UTC)
Message-ID: <1037243108.4336.1453770172960.JavaMail.zimbra__34643.2465281852$1453770244$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aNs2D-0005Vl-1v
 for lttng-dev@lists.lttng.org; Mon, 25 Jan 2016 20:03:07 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>, Khem Raj <raj.khem@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, openembedded-core <openembedded-core@lists.openembedded.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

We are noticing the presence of the following patch in various
openembedded gcc versions:

0024-PR-target-32219.patch

"From e0d15f4f8bf28c351b9215ca37f1caa24df0e1fd Mon Sep 17 00:00:00 2001
From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 29 Mar 2013 09:18:54 +0400
Subject: [PATCH 24/35] PR target/32219

* varasm.c (default_binds_local_p_1): Weak data is not local.

Signed-off-by: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>

Upstream-Status: Backport"

However, contrarily to its "Backport" status, that patch is
not upstream in gcc, and we're starting to wonder if this
would be the patch that breaks handling of start/stop automatic
hidden symbols we use in lttng-ust.

We are only experiencing problems on the various openembedded
compilers, but on no other distro (with same compiler versions),
which leads us to suspect a buggy distro-specific gcc patch.

We've been testing with openembedded gcc-4.9.2-r0.

The original gold linker issue that this patch was trying to
address seems to have been fixed in the gold linke since
then.

Refs:
http://lists.lttng.org/pipermail/lttng-dev/2014-May/023112.html
https://gcc.gnu.org/ml/gcc-help/2014-05/msg00042.html
http://cgit.openembedded.org/openembedded-core/commit/?id=3cb2b003db7371b3a47d02c08352a262e1e419b4
https://sourceware.org/bugzilla/show_bug.cgi?id=15435

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
