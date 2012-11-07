From: David Bryant <david.bryant@quantum.com>
Subject: Fix filter: pointer to string, not string,
 should be on stack -- query
Date: Wed, 7 Nov 2012 18:06:32 +1030
Message-ID: <509A0F80.1070308__30055.6902344853$1352273848$gmane$org@quantum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0b-000ceb01.pphosted.com ([67.231.152.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=7658a0e5fd=david.bryant@quantum.com>)
	id 1TW0Bw-0006is-Li
	for lttng-dev@lists.lttng.org; Wed, 07 Nov 2012 02:36:52 -0500
Received: from pps.filterd (m0001158 [127.0.0.1])
	by mx0b-000ceb01.pphosted.com (8.14.5/8.14.5) with SMTP id
	qA77WRkH025598
	for <lttng-dev@lists.lttng.org>; Tue, 6 Nov 2012 23:36:52 -0800
Received: from ppoxedge2.quantum.com ([146.174.252.28])
	by mx0b-000ceb01.pphosted.com with ESMTP id 18fadj8gu8-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Tue, 06 Nov 2012 23:36:51 -0800
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

I'm trying to understand the following changeset:

commit 27f4b6094f399f2fe231b58801dce98cbd21baa9
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Tue Sep 4 12:17:07 2012 -0400

Fix filter: pointer to string, not string, should be on stack

Fixes #329

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Bug link: https://bugs.lttng.org/issues/329

The patch forces the ctf_string() argument to be an lvalue. It appears =

to be in support of tracepoint filtering of the sort:

lttng enable-event ust_tests_demo2:loop -u --filter 'stringfield=3D=3D"text=
"'

Because the argument must be an lvalue the examples/easy-ust won't =

compile (anymore) with the following patch:

diff -u --recursive easy-ust/sample_component_provider.h =

easy-ust-reproduce/sample_component_provider.h
--- easy-ust/sample_component_provider.h 2012-11-07 17:00:09.879299565 +1030
+++ easy-ust-reproduce/sample_component_provider.h 2012-11-07 =

16:57:02.121647871 +1030
@@ -61,6 +61,11 @@
*/
#include <lttng/tracepoint.h>

+#ifndef SEE_ONCE
+#define SEE_ONCE
+static inline char * echo(char * c) { return c; }
+#endif
+
/*
* The following tracepoint event writes a message (c string) into the
* field message of the trace event message in the provider
@@ -100,7 +105,7 @@
* The ctf_string macro takes a c string and writes it into a field
* named "message"
*/
- ctf_string(message, text)
+ ctf_string(message, echo(text))
)
)
/*

Compilation results in:

$ make
gcc -I/home/dbryant/local5/include -I. -c -o sample.o sample.c
gcc -I/home/dbryant/local5/include -I. -c -o tp.o tp.c
In file included from =

/home/dbryant/local5/include/lttng/ust-tracepoint-event.h:338:0,
from /home/dbryant/local5/include/lttng/tracepoint-event.h:41,
from sample_component_provider.h:140,
from tp.c:25:
././sample_component_provider.h: In function =

=91__event_prepare_filter_stack__sample_component___message=92:
././sample_component_provider.h:76:1: error: lvalue required as unary =

=91&=92 operand
make: *** [tp.o] Error 1

I'm trying to make sense of all this. I've been passing =

generated-on-the-fly rvalues through ctf_string() using v2.0.5 with no =

(noticeable) problems. Now I can't. Should I never have been doing that, =

or has this change had an unintended consequence? Admittedly I haven't =

been filtering tracepoints on text criteria and am not considering =

things from that angle. Should ctf_string() arguments always be string =

literals?!

Thanks,
Dave

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any dis=
closure, copying, or further distribution of confidential information is no=
t permitted unless such privilege is explicitly granted in writing by Quant=
um. Quantum reserves the right to have electronic communications, including=
 email and attachments, sent across its networks filtered through anti viru=
s and spam software programs and retain such messages in order to comply wi=
th applicable data security and retention requirements. Quantum is not resp=
onsible for the proper and complete transmission of the substance of this c=
ommunication or for any delay in its receipt.
