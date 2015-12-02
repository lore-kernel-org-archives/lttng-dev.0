From: John Smith <whalajam@gmail.com>
Subject: gcc 4.8.4 linker crashes if use "-O3 -flto" with
	TRACEPOINT_LOGLEVEL()
Date: Tue, 1 Dec 2015 18:22:50 -0800
Message-ID: <CANgVouXfryijBmu+43_+RQEEcwiyKOf-mg6pptKuPpDDN9MygA__21591.7552858174$1449082696$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0683788527=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f177.google.com ([209.85.223.177])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <whalajam@gmail.com>) id 1a3x4K-0000Ku-8S
 for lttng-dev@lists.lttng.org; Tue, 01 Dec 2015 21:22:57 -0500
Received: by ioir85 with SMTP id r85so31128396ioi.1
 for <lttng-dev@lists.lttng.org>; Tue, 01 Dec 2015 18:22:50 -0800 (PST)
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

--===============0683788527==
Content-Type: multipart/alternative; boundary=001a113ec55471cb220525e0f326

--001a113ec55471cb220525e0f326
Content-Type: text/plain; charset=UTF-8

Hi,
gcc linker crashes when using -flto gcc (link time optimization), wondering
if you can provide a work around. The cause seems to be the
TRACEPOINT_LOGLEVEL() generated 2 lines.

Environment:
uname -a
... 3.19.0-30-generic #34~14.04.1-Ubuntu SMP Fri Oct 2 22:09:39 UTC 2015
x86_64 x86_64 x86_64 GNU/Linux

gcc version:
gcc version 4.8.4 (Ubuntu 4.8.4-2ubuntu1~14.04)

Here is a simple sample program that crashes the gcc linker:

tst.c:
[
#include "tst_trace.h"
main(void) {
int i;
for (i = 0; i < 10; i++)
tracepoint(tst, tst_main);
}
]

tst_trace.c:
[
#define TRACEPOINT_CREATE_PROBES
#define TRACEPOINT_DEFINE
#include "./tst_trace.h"
]

tst_trace.h:
[
#undef TRACEPOINT_PROVIDER
#define TRACEPOINT_PROVIDER tst
#undef TRACEPOINT_INCLUDE
#define TRACEPOINT_INCLUDE "./tst_trace.h"
#if !defined(_TST_TRACE_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
#define _TST_TRACE_H
#include <lttng/tracepoint.h>
TRACEPOINT_EVENT(
tst, tst_main, TP_ARGS(), TP_FIELDS()
)
TRACEPOINT_LOGLEVEL(tst, tst_main, TRACE_DEBUG_UNIT)
#endif /* _TST_TRACE_H */
#include <lttng/tracepoint-event.h>
]

these compile & link command options:
[
cc -O3 -g -flto -I. -c -o tst.o tst.c
cc -O3 -g -flto -I. -c -o tst_trace.o tst_trace.c
g++ -O3 -g -flto tst_trace.o tst.o -o tst -l lttng-ust -l dl
]

crash the linker:
[
lto1: internal compiler error: Segmentation fault
Please submit a full bug report,
with preprocessed source if appropriate.
]
thanks, John

--001a113ec55471cb220525e0f326
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div>gcc linker crashes when using -flto gcc=
 (link time optimization), wondering if you can provide a work around. The =
cause seems to be the TRACEPOINT_LOGLEVEL() generated 2 lines.</div><div><b=
r></div><div>Environment:</div><div>uname -a<br>... 3.19.0-30-generic #34~1=
4.04.1-Ubuntu SMP Fri Oct 2 22:09:39 UTC 2015 x86_64 x86_64 x86_64 GNU/Linu=
x</div><p>gcc version:<br>gcc version 4.8.4 (Ubuntu 4.8.4-2ubuntu1~14.04)</=
p><p>Here is a simple sample program that crashes the gcc linker:</p><p>tst=
.c:<br>[<br>#include &quot;tst_trace.h&quot; <br>main(void) {<br>    int i;=
<br>    for (i =3D 0; i &lt; 10; i++)<br>        tracepoint(tst, tst_main);=
<br>}<br>]</p><p>tst_trace.c:<br>[<br>#define TRACEPOINT_CREATE_PROBES<br>#=
define TRACEPOINT_DEFINE<br>#include &quot;./tst_trace.h&quot; <br>]</p><p>=
tst_trace.h:<br>[<br>#undef TRACEPOINT_PROVIDER<br>#define TRACEPOINT_PROVI=
DER tst<br>#undef TRACEPOINT_INCLUDE<br>#define TRACEPOINT_INCLUDE &quot;./=
tst_trace.h&quot; <br>#if !defined(_TST_TRACE_H) || defined(TRACEPOINT_HEAD=
ER_MULTI_READ)<br>#define _TST_TRACE_H<br>#include &lt;lttng/tracepoint.h&g=
t;<br>TRACEPOINT_EVENT(<br>    tst, tst_main, TP_ARGS(), TP_FIELDS()<br>)<b=
r>TRACEPOINT_LOGLEVEL(tst, tst_main, TRACE_DEBUG_UNIT)<br>#endif /* _TST_TR=
ACE_H */<br>#include &lt;lttng/tracepoint-event.h&gt;<br>]</p><p>these comp=
ile &amp; link command options:<br>[<br>cc -O3 -g -flto -I. -c -o tst.o tst=
.c<br>cc -O3 -g -flto -I. -c -o tst_trace.o tst_trace.c<br>g++ -O3 -g -flto=
 tst_trace.o tst.o -o tst -l lttng-ust -l dl<br>]</p><p>crash the linker:<b=
r>[<br>lto1: internal compiler error: Segmentation fault<br>Please submit a=
 full bug report,<br>with preprocessed source if appropriate.<br>]</p><div>=
thanks, John</div><div><br></div></div>

--001a113ec55471cb220525e0f326--


--===============0683788527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0683788527==--
