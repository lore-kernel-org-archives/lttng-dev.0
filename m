From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: snapshot data corrupted after the output buffer
	is	filled
Date: Sat, 15 Nov 2014 17:59:54 +0000 (UTC)
Message-ID: <734976879.13957.1416074394667.JavaMail.zimbra__34398.7096487128$1416074461$gmane$org@efficios.com>
References: <CAF2baFfMNzRQnx-FC7kFRr5m4NpZBEcEohnwf50uOs2vv9=GBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0869957179=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Xphdj-0004NK-B0
 for lttng-dev@lists.lttng.org; Sat, 15 Nov 2014 13:00:06 -0500
In-Reply-To: <CAF2baFfMNzRQnx-FC7kFRr5m4NpZBEcEohnwf50uOs2vv9=GBw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anders Wallin <wallinux@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0869957179==
Content-Type: multipart/alternative;
	boundary="----=_Part_13956_180714991.1416074394665"

------=_Part_13956_180714991.1416074394665
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- Original Message -----

> From: "Anders Wallin" <wallinux@gmail.com>
> To: lttng-dev@lists.lttng.org
> Sent: Friday, November 14, 2014 8:28:18 AM
> Subject: [lttng-dev] snapshot data corrupted after the output buffer is
> filled

> Hi,

> it looks like snapshot events became faulty after the output max size is
> reached.
> The next snapshot get mixed events from different buffers. I have tested =
it
> on 2.3, 2.4 and 2.5
> and it's in all of them, but it hits earlier in 2.5 due to the problem
> reported in
> http://lists.lttng.org/pipermail/lttng-dev/2014-November/023773.html

> There should never be more then 2 HUNKS in a diff between 2 consecutive
> snapshots, here I got
> 11 as the worst case.

Hi Anders,=20

This is not a bug, rather just per-cpu buffering at work.It does have some=
=20
rather non-obvious consequences in terms of snapshot event flow.=20

To understand this, we need to keep in mind that LTTng does everything=20
in per-cpu buffers, and that overwrite of oldest events in buffer full cond=
itions=20
happens per-cpu.=20

The use-case you show below really makes sense when you start to consider=
=20
on which CPU (and thus per-cpu buffer) the application is running. Initiall=
y,=20
the first app runs on CPU 6. As long as the following applications run on=
=20
other cpus, we keep the same first event. Then when enough events are=20
written in cpu 6 buffer to overwrite the first event, we see a first event =
change.=20
Then, depending on the scheduling of applications, older parts of per-cpu=
=20
buffers are overwritten, and others are not (if there are less events in th=
ose=20
buffer). This means some per-cpu buffers will have events going further bac=
k=20
in time compared to other higher-throughput CPUs.=20

This is why you see more than 2 hunks in your diff. Babeltrace merges those=
=20
per-cpu buffers back into a single text output, and the fact that some even=
ts=20
have been overwritten for a time-range for high-throughput buffers, but not=
=20
for low-throughput buffers, make it appear as if events are missing in the=
=20
stream if your model is a single system-wide buffer, but the missing events=
=20
make sense if you see it as a merge of per-cpu buffers.=20

Our current behavior is to gather all available data when taking a snapshot=
,=20
and babeltrace behavior is to show all events available in the streams. We=
=20
could perhaps consider a different babeltrace behavior (a flag) that would=
=20
allow it to only show the events for the intersection of time range of all=
=20
streams, based on the packet header timestamp begin/end. This would=20
take care of hiding events that happen in low-throughput streams when=20
there is no intersection with snapshotted high-throughput streams.=20

And perhaps this should be the default ?=20

Thanks!=20

Mathieu=20

> TESTCASE;

> tracetest code:
> ---------------------------------------------------------------
> #include <stdio.h>
> #include "tracetest-tp.h"

> int main(int argc, char* argv[])
> {
> int i;
> for (i =3D 0; i < 1000; i++) {
> tracepoint(tracetest, first_tp, i, "test");
> }
> return 0;
> }
> ---------------------------------------------------------------

> test script:
> ---------------------------------------------------------------
> #!/bin/bash
> : ${NO_OF_SUBBUF:=3D6}
> : ${SUBBUF_SIZE:=3D4096}
> : ${KERNEL_TRACE:=3DNO}
> : ${LOOPS:=3D10}

> SESSION=3Dtest
> CHANNEL1=3Dch1
> CHANNEL2=3Dch2

> CH2_SUBBUF_SIZE=3D$(($SUBBUF_SIZE*$NO_OF_SUBBUF))

> LTTNG=3D'lttng -n'
> killall lttng-consumerd > /dev/null 2>&1
> killall lttng-sessiond > /dev/null 2>&1
> if [ -z $DEBUG ]; then
> lttng-sessiond --no-kernel -d
> else
> lttng-sessiond -v --no-kernel --verbose-consumer -b
> fi
> sleep 1

> if [ ! -z $DEBUG ]; then
> export LTTNG_UST_DEBUG=3D1
> fi

> rm -rf $HOME/lttng-traces
> rm snapshot/*.bt

> $LTTNG --version

> $LTTNG create $SESSION --snapshot
> $LTTNG enable-channel -u --subbuf-size $SUBBUF_SIZE --num-subbuf
> $NO_OF_SUBBUF --overwrite $CHANNEL1
> $LTTNG enable-channel -u --subbuf-size $CH2_SUBBUF_SIZE --num-subbuf 2
> --overwrite $CHANNEL2
> $LTTNG enable-event -u -c $CHANNEL1 "*"
> $LTTNG start
> $LTTNG list $SESSION

> mkdir -p snapshot/

> h=3D1
> for i in $(seq 1 $LOOPS); do
> $APP
> $LTTNG snapshot record
> # print no of events and first and last event
> last=3D$(ls -1drt $HOME/lttng-traces/$SESSION*/* | tail -1)
> babeltrace $last > snapshot/$ i.bt
> cat snapshot/$ i.bt | wc -l
> cat snapshot/$ i.bt | head -1
> cat snapshot/$ i.bt | tail -1
> diff -u snapshot/$ i.bt snapshot/$ h.bt > snapshot/$i_$h.diff
> cat snapshot/$i_$h.diff | grep "@@" | wc -l | xargs echo "NUMBER OF DIFF
> HUNKS =3D "
> h=3D$i
> done

> $LTTNG stop
> $LTTNG destroy $SESSION

> ---------------------------------------------------------------

> result from run (removed some output lines for readability)
> ---------------------------------------------------------------
> lttng (LTTng Trace Control) 2.4.2 - =C3=89poque Opaque
> Snapshot mode set. Every channel enabled for that session will be set in
> overwrite mode and mmap output.
> Warning: The number of subbuffers (6) is rounded to the next power of 2 (=
8)
> UST channel ch1 enabled for session test
> Warning: The subbuf size (24576) is rounded to the next power of 2 (32768=
)
> UST channel ch2 enabled for session test
> UST event * created in channel ch1
> Tracing started for session test
> Tracing session test: [active snapshot]
> Trace path:

> =3D=3D=3D Domain: UST global =3D=3D=3D

> Buffer type: per UID

> Channels:
> -------------
> - ch1: [enabled]

> Attributes:
> overwrite mode: 1
> subbufers size: 4096
> number of subbufers: 8
> switch timer interval: 0
> read timer interval: 0
> output: mmap()

> Events:
> * (type: tracepoint) [enabled]
> - ch2: [enabled]

> Attributes:
> overwrite mode: 1
> subbufers size: 32768
> number of subbufers: 2
> switch timer interval: 0
> read timer interval: 0
> output: mmap()

> Events:
> None

> Snapshot recorded successfully for session test
> 1011
> [07:09:43.278933559] (+?.?????????) 07f8cf84a38f ust_baddr_statedump:soin=
fo:
> { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000, sopath =3D "[vdso]", size =
=3D 0, mtime
> =3D -1 }
> [07:09:43.279975100] (+0.000000975) 07f8cf84a38f tracetest:first_tp: { cp=
u_id
> =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> NUMBER OF DIFF HUNKS =3D 0
> Snapshot recorded successfully for session test
> 2022
> [07:09:43.278933559] (+?.?????????) 07f8cf84a38f ust_baddr_statedump:soin=
fo:
> { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000, sopath =3D "[vdso]", size =
=3D 0, mtime
> =3D -1 }
> [07:09:43.337703508] (+0.000001238) 07f8cf84a38f tracetest:first_tp: { cp=
u_id
> =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> NUMBER OF DIFF HUNKS =3D 1
> Snapshot recorded successfully for session test
> 3033
> [07:09:43.278933559] (+?.?????????) 07f8cf84a38f ust_baddr_statedump:soin=
fo:
> { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000, sopath =3D "[vdso]", size =
=3D 0, mtime
> =3D -1 }
> [07:09:43.432827051] (+0.000000308) 07f8cf84a38f tracetest:first_tp: { cp=
u_id
> =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> NUMBER OF DIFF HUNKS =3D 1
> Snapshot recorded successfully for session test
> 4044
> [07:09:43.278933559] (+?.?????????) 07f8cf84a38f ust_baddr_statedump:soin=
fo:
> { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000, sopath =3D "[vdso]", size =
=3D 0, mtime
> =3D -1 }
> [07:09:43.475784825] (+0.000000501) 07f8cf84a38f tracetest:first_tp: { cp=
u_id
> =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> NUMBER OF DIFF HUNKS =3D 1
> Snapshot recorded successfully for session test
> 4735
> [07:09:43.279031320] (+?.?????????) 07f8cf84a38f tracetest:first_tp: { cp=
u_id
> =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 0 }
> [07:09:43.549945106] (+0.000000517) 07f8cf84a38f tracetest:first_tp: { cp=
u_id
> =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> NUMBER OF DIFF HUNKS =3D 12
> Snapshot recorded successfully for session test
> 4437
> [07:09:43.335916076] (+?.?????????) 07f8cf84a38f ust_baddr_statedump:soin=
fo:
> { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000, sopath =3D "[vdso]", size =
=3D 0, mtime
> =3D -1 }
> [07:09:43.654229030] (+0.000000436) 07f8cf84a38f tracetest:first_tp: { cp=
u_id
> =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> NUMBER OF DIFF HUNKS =3D 3
> Snapshot recorded successfully for session test
> 4746
> [07:09:43.335916076] (+?.?????????) 07f8cf84a38f ust_baddr_statedump:soin=
fo:
> { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000, sopath =3D "[vdso]", size =
=3D 0, mtime
> =3D -1 }
> [07:09:43.747509349] (+0.000000502) 07f8cf84a38f tracetest:first_tp: { cp=
u_id
> =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> NUMBER OF DIFF HUNKS =3D 11
> Snapshot recorded successfully for session test
> 5757
> [07:09:43.335916076] (+?.?????????) 07f8cf84a38f ust_baddr_statedump:soin=
fo:
> { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000, sopath =3D "[vdso]", size =
=3D 0, mtime
> =3D -1 }
> [07:09:43.814938128] (+0.000001371) 07f8cf84a38f tracetest:first_tp: { cp=
u_id
> =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> NUMBER OF DIFF HUNKS =3D 1
> Snapshot recorded successfully for session test
> 6066
> [07:09:43.335916076] (+?.?????????) 07f8cf84a38f ust_baddr_statedump:soin=
fo:
> { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000, sopath =3D "[vdso]", size =
=3D 0, mtime
> =3D -1 }
> [07:09:43.919112586] (+0.000000990) 07f8cf84a38f tracetest:first_tp: { cp=
u_id
> =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> NUMBER OF DIFF HUNKS =3D 11
> Snapshot recorded successfully for session test
> 6077
> [07:09:43.335916076] (+?.?????????) 07f8cf84a38f ust_baddr_statedump:soin=
fo:
> { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000, sopath =3D "[vdso]", size =
=3D 0, mtime
> =3D -1 }
> [07:09:44.004234933] (+0.000001213) 07f8cf84a38f tracetest:first_tp: { cp=
u_id
> =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> NUMBER OF DIFF HUNKS =3D 2
> Waiting for data availability
> Tracing stopped for session test
> Session test destroyed
> ---------------------------------------------------------------

> Regards

> Anders Wallin

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_13956_180714991.1416074394665
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;" data-mce-style=3D"border-left: 2px s=
olid #1010FF; margin-left: 5px; padding-left: 5px; color: #000; font-weight=
: normal; font-style: normal; text-decoration: none; font-family: Helvetica=
,Arial,sans-serif; font-size: 12pt;"><b>From: </b>"Anders Wallin" &lt;walli=
nux@gmail.com&gt;<br><b>To: </b>lttng-dev@lists.lttng.org<br><b>Sent: </b>F=
riday, November 14, 2014 8:28:18 AM<br><b>Subject: </b>[lttng-dev] snapshot=
 data corrupted after the output buffer is&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;filled<br><div><br></div><div dir=3D"ltr"><div>Hi,</div><div=
><br></div><div>it looks like snapshot events became faulty after the outpu=
t max size is reached.</div><div>The next snapshot get mixed events from di=
fferent buffers. I have tested it on 2.3, 2.4 and 2.5</div><div>and it's in=
 all of them, but it hits earlier in 2.5 due to the &nbsp;problem reported =
in</div><div><a href=3D"http://lists.lttng.org/pipermail/lttng-dev/2014-Nov=
ember/023773.html" target=3D"_blank" data-mce-href=3D"http://lists.lttng.or=
g/pipermail/lttng-dev/2014-November/023773.html">http://lists.lttng.org/pip=
ermail/lttng-dev/2014-November/023773.html</a><br data-mce-bogus=3D"1"></di=
v><div><br></div><div>There should never be more then 2 HUNKS in a diff bet=
ween 2 consecutive snapshots, here I got&nbsp;</div><div>11 as the worst ca=
se.</div></div></blockquote><div>Hi Anders,<br></div><div><br></div><div>Th=
is is not a bug, rather just per-cpu buffering at work.It does have some<br=
></div><div>rather non-obvious consequences in terms of snapshot event flow=
.<br></div><div><br></div><div>To understand this, we need to keep in mind =
that LTTng does everything<br></div><div>in per-cpu buffers, and that overw=
rite of oldest events in buffer full conditions<br></div><div>happens per-c=
pu.<br></div><div><br></div><div>The use-case you show below really makes s=
ense when you start to consider<br></div><div>on which CPU (and thus per-cp=
u buffer) the application is running. Initially,<br></div><div>the first ap=
p runs on CPU 6. As long as the following applications run on<br></div><div=
>other cpus, we keep the same first event. Then when enough events are<br><=
/div><div>written in cpu 6 buffer to overwrite the first event, we see a fi=
rst event change.<br></div><div>Then, depending on the scheduling of applic=
ations, older parts of per-cpu<br></div><div>buffers are overwritten, and o=
thers are not (if there are less events in those<br></div><div>buffer). Thi=
s means some per-cpu buffers will have events going further back<br></div><=
div>in time compared to other higher-throughput CPUs.<br></div><div><br></d=
iv><div>This is why you see more than 2 hunks in your diff. Babeltrace merg=
es those<br></div><div>per-cpu buffers back into a single text output, and =
the fact that some events<br></div><div>have been overwritten for a time-ra=
nge for high-throughput buffers, but not<br></div><div>for low-throughput b=
uffers, make it appear as if events are missing in the<br></div><div>stream=
 if your model is a single system-wide buffer, but the missing events<br></=
div><div>make sense if you see it as a merge of per-cpu buffers.<br></div><=
div><br></div><div>Our current behavior is to gather all available data whe=
n taking a snapshot,<br></div><div>and babeltrace behavior is to show all e=
vents available in the streams. We<br></div><div>could perhaps consider a d=
ifferent babeltrace behavior (a flag) that would<br></div><div>allow it to =
only show the events for the intersection of time range of all<br></div><di=
v>streams, based on the packet header timestamp begin/end. This would<br></=
div><div>take care of hiding events that happen in low-throughput streams w=
hen<br></div><div>there is no intersection with snapshotted high-throughput=
 streams.<br></div><div><br></div><div>And perhaps this should be the defau=
lt ?<br></div><div><br></div><div>Thanks!<br></div><div><br></div><div>Math=
ieu<br></div><div><br></div><blockquote style=3D"border-left:2px solid #101=
0FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-sty=
le:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-=
size:12pt;" data-mce-style=3D"border-left: 2px solid #1010FF; margin-left: =
5px; padding-left: 5px; color: #000; font-weight: normal; font-style: norma=
l; text-decoration: none; font-family: Helvetica,Arial,sans-serif; font-siz=
e: 12pt;"><div dir=3D"ltr"><div><br></div><div>TESTCASE;</div><div><br></di=
v><div>tracetest code:</div><div>------------------------------------------=
---------------------</div><div>#include &lt;stdio.h&gt;</div><div>#include=
 "tracetest-tp.h"</div><div><br></div><div>int main(int argc, char* argv[])=
</div><div>{</div><div>&nbsp; &nbsp; &nbsp; &nbsp; int i;</div><div>&nbsp; =
&nbsp; &nbsp; &nbsp; for (i =3D 0; i &lt; 1000; i++) {</div><div>&nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; tracepoint(tracetest, first_t=
p, i, "test");</div><div>&nbsp; &nbsp; &nbsp; &nbsp; }</div><div>&nbsp; &nb=
sp; &nbsp; &nbsp; return 0;</div><div>}</div><div>-------------------------=
--------------------------------------</div><div><br></div><div>test script=
:</div><div>---------------------------------------------------------------=
</div><div>#!/bin/bash&nbsp;</div><div>: ${NO_OF_SUBBUF:=3D6}</div><div>: $=
{SUBBUF_SIZE:=3D4096}</div><div>: ${KERNEL_TRACE:=3DNO}</div><div>: ${LOOPS=
:=3D10}</div><div><br></div><div>SESSION=3Dtest</div><div>CHANNEL1=3Dch1</d=
iv><div>CHANNEL2=3Dch2</div><div><br></div><div>CH2_SUBBUF_SIZE=3D$(($SUBBU=
F_SIZE*$NO_OF_SUBBUF))</div><div><br></div><div><br></div><div>LTTNG=3D'ltt=
ng -n'</div><div>killall lttng-consumerd &gt; /dev/null 2&gt;&amp;1</div><d=
iv>killall lttng-sessiond &gt; /dev/null 2&gt;&amp;1</div><div>if [ -z $DEB=
UG ]; then</div><div>&nbsp; &nbsp; lttng-sessiond --no-kernel -d</div><div>=
else</div><div>&nbsp; &nbsp; lttng-sessiond -v --no-kernel --verbose-consum=
er -b</div><div>fi</div><div>sleep 1</div><div><br></div><div>if [ ! -z $DE=
BUG ]; then</div><div>&nbsp; &nbsp; export LTTNG_UST_DEBUG=3D1</div><div>fi=
</div><div><br></div><div>rm -rf $HOME/lttng-traces</div><div>rm snapshot/*=
.bt</div><div><br></div><div>$LTTNG --version</div><div><br></div><div>$LTT=
NG create $SESSION --snapshot</div><div>$LTTNG enable-channel -u --subbuf-s=
ize $SUBBUF_SIZE --num-subbuf $NO_OF_SUBBUF --overwrite $CHANNEL1</div><div=
>$LTTNG enable-channel -u --subbuf-size $CH2_SUBBUF_SIZE --num-subbuf 2 --o=
verwrite $CHANNEL2</div><div>$LTTNG enable-event -u -c $CHANNEL1 "*"</div><=
div>$LTTNG start</div><div>$LTTNG list $SESSION</div><div><br></div><div>mk=
dir -p snapshot/</div><div><br></div><div>h=3D1</div><div>for i in $(seq 1 =
$LOOPS); do</div><div>&nbsp; &nbsp; $APP</div><div>&nbsp; &nbsp; $LTTNG sna=
pshot record</div><div>&nbsp; &nbsp; # print no of events and first and las=
t event &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp;</div><div>&nbsp; &nbsp; last=3D$(ls -1drt $HOME/lttng-traces/$=
SESSION*/* | tail -1)</div><div>&nbsp; &nbsp; babeltrace $last &gt; snapsho=
t/$<a href=3D"http://i.bt" target=3D"_blank" data-mce-href=3D"http://i.bt">=
i.bt</a><br data-mce-bogus=3D"1"></div><div>&nbsp; &nbsp; cat snapshot/$<a =
href=3D"http://i.bt" target=3D"_blank" data-mce-href=3D"http://i.bt">i.bt</=
a> | wc -l</div><div>&nbsp; &nbsp; cat snapshot/$<a href=3D"http://i.bt" ta=
rget=3D"_blank" data-mce-href=3D"http://i.bt">i.bt</a> | head -1</div><div>=
&nbsp; &nbsp; cat snapshot/$<a href=3D"http://i.bt" target=3D"_blank" data-=
mce-href=3D"http://i.bt">i.bt</a> | tail -1</div><div>&nbsp; &nbsp; diff -u=
 snapshot/$<a href=3D"http://i.bt" target=3D"_blank" data-mce-href=3D"http:=
//i.bt">i.bt</a> snapshot/$<a href=3D"http://h.bt" target=3D"_blank" data-m=
ce-href=3D"http://h.bt">h.bt</a> &gt; snapshot/$i_$h.diff</div><div>&nbsp; =
&nbsp; cat snapshot/$i_$h.diff | grep "@@" | wc -l | xargs echo "NUMBER OF =
DIFF HUNKS =3D "</div><div>&nbsp; &nbsp; h=3D$i</div><div>done</div><div><b=
r></div><div><div class=3D"gmail_signature"><div class=3D"gmail_signature">=
$LTTNG stop</div><div class=3D"gmail_signature">$LTTNG destroy $SESSION</di=
v><div class=3D"gmail_signature"><br></div><div class=3D"gmail_signature">-=
--------------------------------------------------------------</div><div cl=
ass=3D"gmail_signature"><br></div><div class=3D"gmail_signature">result fro=
m run (removed some output lines for readability)</div><div class=3D"gmail_=
signature">---------------------------------------------------------------<=
/div><div class=3D"gmail_signature">lttng (LTTng Trace Control) 2.4.2 - =C3=
=89poque Opaque</div><div class=3D"gmail_signature">Snapshot mode set. Ever=
y channel enabled for that session will be set in overwrite mode and mmap o=
utput.</div><div class=3D"gmail_signature">Warning: The number of subbuffer=
s (6) is rounded to the next power of 2 (8)</div><div class=3D"gmail_signat=
ure">UST channel ch1 enabled for session test</div><div class=3D"gmail_sign=
ature">Warning: The subbuf size (24576) is rounded to the next power of 2 (=
32768)</div><div class=3D"gmail_signature">UST channel ch2 enabled for sess=
ion test</div><div class=3D"gmail_signature">UST event * created in channel=
 ch1</div><div class=3D"gmail_signature">Tracing started for session test</=
div><div class=3D"gmail_signature">Tracing session test: [active snapshot]<=
/div><div class=3D"gmail_signature">&nbsp; &nbsp; Trace path:&nbsp;</div><d=
iv class=3D"gmail_signature"><br></div><div class=3D"gmail_signature">=3D=
=3D=3D Domain: UST global =3D=3D=3D</div><div class=3D"gmail_signature"><br=
></div><div class=3D"gmail_signature">Buffer type: per UID</div><div class=
=3D"gmail_signature"><br></div><div class=3D"gmail_signature">Channels:</di=
v><div class=3D"gmail_signature">-------------</div><div class=3D"gmail_sig=
nature">- ch1: [enabled]</div><div class=3D"gmail_signature"><br></div><div=
 class=3D"gmail_signature">&nbsp; &nbsp; Attributes:</div><div class=3D"gma=
il_signature">&nbsp; &nbsp; &nbsp; overwrite mode: 1</div><div class=3D"gma=
il_signature">&nbsp; &nbsp; &nbsp; subbufers size: 4096</div><div class=3D"=
gmail_signature">&nbsp; &nbsp; &nbsp; number of subbufers: 8</div><div clas=
s=3D"gmail_signature">&nbsp; &nbsp; &nbsp; switch timer interval: 0</div><d=
iv class=3D"gmail_signature">&nbsp; &nbsp; &nbsp; read timer interval: 0</d=
iv><div class=3D"gmail_signature">&nbsp; &nbsp; &nbsp; output: mmap()</div>=
<div class=3D"gmail_signature"><br></div><div class=3D"gmail_signature">&nb=
sp; &nbsp; Events:</div><div class=3D"gmail_signature">&nbsp; &nbsp; &nbsp;=
 * (type: tracepoint) [enabled]</div><div class=3D"gmail_signature">- ch2: =
[enabled]</div><div class=3D"gmail_signature"><br></div><div class=3D"gmail=
_signature">&nbsp; &nbsp; Attributes:</div><div class=3D"gmail_signature">&=
nbsp; &nbsp; &nbsp; overwrite mode: 1</div><div class=3D"gmail_signature">&=
nbsp; &nbsp; &nbsp; subbufers size: 32768</div><div class=3D"gmail_signatur=
e">&nbsp; &nbsp; &nbsp; number of subbufers: 2</div><div class=3D"gmail_sig=
nature">&nbsp; &nbsp; &nbsp; switch timer interval: 0</div><div class=3D"gm=
ail_signature">&nbsp; &nbsp; &nbsp; read timer interval: 0</div><div class=
=3D"gmail_signature">&nbsp; &nbsp; &nbsp; output: mmap()</div><div class=3D=
"gmail_signature"><br></div><div class=3D"gmail_signature">&nbsp; &nbsp; Ev=
ents:</div><div class=3D"gmail_signature">&nbsp; &nbsp; &nbsp; None</div><d=
iv class=3D"gmail_signature"><br></div><div class=3D"gmail_signature">Snaps=
hot recorded successfully for session test</div><div class=3D"gmail_signatu=
re">1011</div><div class=3D"gmail_signature">[07:09:43.278933559] (+?.?????=
????) 07f8cf84a38f ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =
=3D 0x7FFF645EE000, sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }</div><d=
iv class=3D"gmail_signature">[07:09:43.279975100] (+0.000000975) 07f8cf84a3=
8f tracetest:first_tp: { cpu_id =3D 5 }, { my_string_field =3D "test", my_i=
nteger_field =3D 999 }</div><div class=3D"gmail_signature">NUMBER OF DIFF H=
UNKS =3D &nbsp;0</div><div class=3D"gmail_signature">Snapshot recorded succ=
essfully for session test</div><div class=3D"gmail_signature">2022</div><di=
v class=3D"gmail_signature">[07:09:43.278933559] (+?.?????????) 07f8cf84a38=
f ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000,=
 sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }</div><div class=3D"gmail_s=
ignature">[07:09:43.337703508] (+0.000001238) 07f8cf84a38f tracetest:first_=
tp: { cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 99=
9 }</div><div class=3D"gmail_signature">NUMBER OF DIFF HUNKS =3D &nbsp;1</d=
iv><div class=3D"gmail_signature">Snapshot recorded successfully for sessio=
n test</div><div class=3D"gmail_signature">3033</div><div class=3D"gmail_si=
gnature">[07:09:43.278933559] (+?.?????????) 07f8cf84a38f ust_baddr_statedu=
mp:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000, sopath =3D "[vdso]=
", size =3D 0, mtime =3D -1 }</div><div class=3D"gmail_signature">[07:09:43=
.432827051] (+0.000000308) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 6 =
}, { my_string_field =3D "test", my_integer_field =3D 999 }</div><div class=
=3D"gmail_signature">NUMBER OF DIFF HUNKS =3D &nbsp;1</div><div class=3D"gm=
ail_signature">Snapshot recorded successfully for session test</div><div cl=
ass=3D"gmail_signature">4044</div><div class=3D"gmail_signature">[07:09:43.=
278933559] (+?.?????????) 07f8cf84a38f ust_baddr_statedump:soinfo: { cpu_id=
 =3D 6 }, { baddr =3D 0x7FFF645EE000, sopath =3D "[vdso]", size =3D 0, mtim=
e =3D -1 }</div><div class=3D"gmail_signature">[07:09:43.475784825] (+0.000=
000501) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 5 }, { my_string_fiel=
d =3D "test", my_integer_field =3D 999 }</div><div class=3D"gmail_signature=
">NUMBER OF DIFF HUNKS =3D &nbsp;1</div><div class=3D"gmail_signature">Snap=
shot recorded successfully for session test</div><div class=3D"gmail_signat=
ure">4735</div><div class=3D"gmail_signature">[07:09:43.279031320] (+?.????=
?????) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 5 }, { my_string_field=
 =3D "test", my_integer_field =3D 0 }</div><div class=3D"gmail_signature">[=
07:09:43.549945106] (+0.000000517) 07f8cf84a38f tracetest:first_tp: { cpu_i=
d =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }</div><d=
iv class=3D"gmail_signature">NUMBER OF DIFF HUNKS =3D &nbsp;12</div><div cl=
ass=3D"gmail_signature">Snapshot recorded successfully for session test</di=
v><div class=3D"gmail_signature">4437</div><div class=3D"gmail_signature">[=
07:09:43.335916076] (+?.?????????) 07f8cf84a38f ust_baddr_statedump:soinfo:=
 { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000, sopath =3D "[vdso]", size =
=3D 0, mtime =3D -1 }</div><div class=3D"gmail_signature">[07:09:43.6542290=
30] (+0.000000436) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 5 }, { my_=
string_field =3D "test", my_integer_field =3D 999 }</div><div class=3D"gmai=
l_signature">NUMBER OF DIFF HUNKS =3D &nbsp;3</div><div class=3D"gmail_sign=
ature">Snapshot recorded successfully for session test</div><div class=3D"g=
mail_signature">4746</div><div class=3D"gmail_signature">[07:09:43.33591607=
6] (+?.?????????) 07f8cf84a38f ust_baddr_statedump:soinfo: { cpu_id =3D 2 }=
, { baddr =3D 0x7FFFAD1FE000, sopath =3D "[vdso]", size =3D 0, mtime =3D -1=
 }</div><div class=3D"gmail_signature">[07:09:43.747509349] (+0.000000502) =
07f8cf84a38f tracetest:first_tp: { cpu_id =3D 6 }, { my_string_field =3D "t=
est", my_integer_field =3D 999 }</div><div class=3D"gmail_signature">NUMBER=
 OF DIFF HUNKS =3D &nbsp;11</div><div class=3D"gmail_signature">Snapshot re=
corded successfully for session test</div><div class=3D"gmail_signature">57=
57</div><div class=3D"gmail_signature">[07:09:43.335916076] (+?.?????????) =
07f8cf84a38f ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7F=
FFAD1FE000, sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }</div><div class=
=3D"gmail_signature">[07:09:43.814938128] (+0.000001371) 07f8cf84a38f trace=
test:first_tp: { cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_f=
ield =3D 999 }</div><div class=3D"gmail_signature">NUMBER OF DIFF HUNKS =3D=
 &nbsp;1</div><div class=3D"gmail_signature">Snapshot recorded successfully=
 for session test</div><div class=3D"gmail_signature">6066</div><div class=
=3D"gmail_signature">[07:09:43.335916076] (+?.?????????) 07f8cf84a38f ust_b=
addr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000, sopath=
 =3D "[vdso]", size =3D 0, mtime =3D -1 }</div><div class=3D"gmail_signatur=
e">[07:09:43.919112586] (+0.000000990) 07f8cf84a38f tracetest:first_tp: { c=
pu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }</di=
v><div class=3D"gmail_signature">NUMBER OF DIFF HUNKS =3D &nbsp;11</div><di=
v class=3D"gmail_signature">Snapshot recorded successfully for session test=
</div><div class=3D"gmail_signature">6077</div><div class=3D"gmail_signatur=
e">[07:09:43.335916076] (+?.?????????) 07f8cf84a38f ust_baddr_statedump:soi=
nfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000, sopath =3D "[vdso]", siz=
e =3D 0, mtime =3D -1 }</div><div class=3D"gmail_signature">[07:09:44.00423=
4933] (+0.000001213) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 6 }, { m=
y_string_field =3D "test", my_integer_field =3D 999 }</div><div class=3D"gm=
ail_signature">NUMBER OF DIFF HUNKS =3D &nbsp;2</div><div class=3D"gmail_si=
gnature">Waiting for data availability</div><div class=3D"gmail_signature">=
Tracing stopped for session test</div><div class=3D"gmail_signature">Sessio=
n test destroyed</div><div class=3D"gmail_signature">----------------------=
-----------------------------------------</div><div class=3D"gmail_signatur=
e"><br></div><div class=3D"gmail_signature">Regards</div><div class=3D"gmai=
l_signature"><br></div><div class=3D"gmail_signature">Anders Wallin</div></=
div></div></div><br>_______________________________________________<br>lttn=
g-dev mailing list<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/c=
gi-bin/mailman/listinfo/lttng-dev<br></blockquote><div><br><br></div><div><=
br></div><div>-- <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<b=
r>EfficiOS Inc.<br>http://www.efficios.com<span name=3D"x"></span><br></div=
></div></body></html>
------=_Part_13956_180714991.1416074394665--


--===============0869957179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0869957179==--
