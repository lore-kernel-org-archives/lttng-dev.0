From: John Steele Scott <toojays@toojays.net>
Subject: lttng-ust with --std=c99 -pedantic
Date: Sun, 10 Jun 2012 09:07:01 +0930
Message-ID: <jr0mmu$efe$1__9565.88853518969$1339285070$gmane$org@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from plane.gmane.org ([80.91.229.3])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <gcsld-lttng-dev@m.gmane.org>) id 1SdVDY-00075m-KP
	for lttng-dev@lists.lttng.org; Sat, 09 Jun 2012 19:37:16 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsld-lttng-dev@m.gmane.org>) id 1SdVDU-0005oc-9f
	for lttng-dev@lists.lttng.org; Sun, 10 Jun 2012 01:37:12 +0200
Received: from ppp121-45-127-134.lns20.adl6.internode.on.net ([121.45.127.134])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <lttng-dev@lists.lttng.org>; Sun, 10 Jun 2012 01:37:12 +0200
Received: from toojays by ppp121-45-127-134.lns20.adl6.internode.on.net with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <lttng-dev@lists.lttng.org>; Sun, 10 Jun 2012 01:37:12 +0200
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

I want to add lttng-ust tracepoints to a program which builds with "--std=
=3Dc99 -pedantic". Right now this does not work.

Using the demo program as an example, if you enable --std=3Dc99, the first =
issue looks like:

jscott@saaz:~/src/lttng-ust/tests/demo$ ccache gcc -std=3Dc99 -DHAVE_CONFIG=
_H -I. -I../.. -I../../include/lttng  -I../../include -Wall -g -O2 -MT demo=
.o -MD -MP -MF .deps/demo.Tpo -c -o demo.o demo.c
In file included from demo.c:34:0:
ust_tests_demo.h: In function =91__tracepoint_cb_ust_tests_demo___starting=
=92:
ust_tests_demo.h:27:23: warning: implicit declaration of function =91typeof=
=92 [-Wimplicit-function-declaration]
ust_tests_demo.h:27:218: error: expected =91;=92 before =91_________p1=92
ust_tests_demo.h:27:395: error: =91_________p1=92 undeclared (first use in =
this function)
ust_tests_demo.h:27:395: note: each undeclared identifier is reported only =
once for each function it appears in
In file included from demo.c:34:0:
ust_tests_demo.h: In function =91__tracepoint_cb_ust_tests_demo___done=92:
ust_tests_demo.h:35:214: error: expected =91;=92 before =91_________p1=92
ust_tests_demo.h:35:383: error: =91_________p1=92 undeclared (first use in =
this function)
In file included from demo.c:35:0:
ust_tests_demo2.h: In function =91__tracepoint_cb_ust_tests_demo2___loop=92:
ust_tests_demo2.h:27:299: error: expected =91;=92 before =91_________p1=92
ust_tests_demo2.h:27:470: error: =91_________p1=92 undeclared (first use in=
 this function)
In file included from demo.c:36:0:
ust_tests_demo3.h: In function =91__tracepoint_cb_ust_tests_demo3___done=92:
ust_tests_demo3.h:27:215: error: expected =91;=92 before =91_________p1=92
ust_tests_demo3.h:27:386: error: =91_________p1=92 undeclared (first use in=
 this function)

This can be easily resolved by using __typeof__() instead of typeof(). Then=
 I can build with --std=3Dc99. But adding -pedantic still fails:

jscott@saaz:~/src/lttng-ust/tests/demo$ ccache gcc -std=3Dc99 -Dtypeof=3D__=
typeof__ -pedantic -DHAVE_CONFIG_H -I. -I../.. -I../../include/lttng  -I../=
../include -Wall -g -O2 -MT demo.o -MD -MP -MF .deps/demo.Tpo -c -o demo.o =
demo.c
In file included from ust_tests_demo.h:25:0,
                 from demo.c:34:
../../include/lttng/tracepoint.h: In function =91__tracepoints__init=92:
../../include/lttng/tracepoint.h:251:4: warning: ISO C forbids conversion o=
f object pointer to function pointer type [-pedantic]
../../include/lttng/tracepoint.h:255:4: warning: ISO C forbids conversion o=
f object pointer to function pointer type [-pedantic]
../../include/lttng/tracepoint.h:260:4: warning: ISO C forbids conversion o=
f object pointer to function pointer type [-pedantic]
../../include/lttng/tracepoint.h:264:4: warning: ISO C forbids conversion o=
f object pointer to function pointer type [-pedantic]
../../include/lttng/tracepoint.h:268:4: warning: ISO C forbids conversion o=
f object pointer to function pointer type [-pedantic]
In file included from demo.c:34:0:
ust_tests_demo.h: In function =91__tracepoint_cb_ust_tests_demo___starting=
=92:
ust_tests_demo.h:27:161: warning: ISO C forbids braced-groups within expres=
sions [-pedantic]
ust_tests_demo.h:27:549: warning: ISO C forbids conversion of object pointe=
r to function pointer type [-pedantic]
In file included from demo.c:34:0:
ust_tests_demo.h: In function =91__tracepoint_cb_ust_tests_demo___done=92:
ust_tests_demo.h:35:161: warning: ISO C forbids braced-groups within expres=
sions [-pedantic]
ust_tests_demo.h:35:537: warning: ISO C forbids conversion of object pointe=
r to function pointer type [-pedantic]
In file included from demo.c:35:0:
ust_tests_demo2.h: In function =91__tracepoint_cb_ust_tests_demo2___loop=92:
ust_tests_demo2.h:27:245: warning: ISO C forbids braced-groups within expre=
ssions [-pedantic]
ust_tests_demo2.h:27:624: warning: ISO C forbids conversion of object point=
er to function pointer type [-pedantic]
In file included from demo.c:36:0:
ust_tests_demo3.h: In function =91__tracepoint_cb_ust_tests_demo3___done=92:
ust_tests_demo3.h:27:161: warning: ISO C forbids braced-groups within expre=
ssions [-pedantic]
ust_tests_demo3.h:27:540: warning: ISO C forbids conversion of object point=
er to function pointer type [-pedantic]

This is with 4.6.1-9ubuntu3 on Ubuntu 11.10, lttng-ust master 5a821c.

Would it be particularly difficult to make the lttng-ust tracepoints compat=
ible with programs built with -pedantic?

cheers,

John
