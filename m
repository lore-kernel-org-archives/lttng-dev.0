From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: snapshot data corrupted after the output buffer is
 filled
Date: Mon, 17 Nov 2014 11:45:14 +0000 (UTC)
Message-ID: <2137471544.14585.1416224714944.JavaMail.zimbra__9519.11794622919$1416224774$gmane$org@efficios.com>
References: <CAF2baFfMNzRQnx-FC7kFRr5m4NpZBEcEohnwf50uOs2vv9=GBw@mail.gmail.com>
 <734976879.13957.1416074394667.JavaMail.zimbra@efficios.com>
 <CAF2baFcfh8h769xaxLQpW4=9nmWRBcmi7tP79mW=w1DyqJm9Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0906234386=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XqKkC-00009I-9Y
 for lttng-dev@lists.lttng.org; Mon, 17 Nov 2014 06:45:23 -0500
In-Reply-To: <CAF2baFcfh8h769xaxLQpW4=9nmWRBcmi7tP79mW=w1DyqJm9Hw@mail.gmail.com>
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

--===============0906234386==
Content-Type: multipart/alternative;
	boundary="----=_Part_14584_1358994827.1416224714942"

------=_Part_14584_1358994827.1416224714942
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Anders,=20

Yes, please file a feature request against Babeltrace on=20
the bug tracker pointing the this email thread and=20
describing the feature.=20

Thanks!=20

Mathieu=20

----- Original Message -----

> From: "Anders Wallin" <wallinux@gmail.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Monday, November 17, 2014 10:45:37 AM
> Subject: Re: [lttng-dev] snapshot data corrupted after the output buffer =
is
> filled

> Thx Mathieu,

> if I'm running my test on one cpu (taskset -c 1 ./test.run) it works as
> expected and described by you.
> The babeltrace flag would be a good solution! Do you want me to file a
> bug/enhancement on this?

> Regards

> Anders Wallin

> On Sat, Nov 15, 2014 at 6:59 PM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com > wrote:

> > > From: "Anders Wallin" < wallinux@gmail.com >
> >=20
>=20
> > > To: lttng-dev@lists.lttng.org
> >=20
>=20
> > > Sent: Friday, November 14, 2014 8:28:18 AM
> >=20
>=20
> > > Subject: [lttng-dev] snapshot data corrupted after the output buffer =
is
> > > filled
> >=20
>=20

> > > Hi,
> >=20
>=20

> > > it looks like snapshot events became faulty after the output max size=
 is
> > > reached.
> >=20
>=20
> > > The next snapshot get mixed events from different buffers. I have tes=
ted
> > > it
> > > on 2.3, 2.4 and 2.5
> >=20
>=20
> > > and it's in all of them, but it hits earlier in 2.5 due to the proble=
m
> > > reported in
> >=20
>=20
> > > http://lists.lttng.org/pipermail/lttng-dev/2014-November/023773.html
> >=20
>=20

> > > There should never be more then 2 HUNKS in a diff between 2 consecuti=
ve
> > > snapshots, here I got
> >=20
>=20
> > > 11 as the worst case.
> >=20
>=20

> > Hi Anders,
>=20

> > This is not a bug, rather just per-cpu buffering at work.It does have s=
ome
>=20
> > rather non-obvious consequences in terms of snapshot event flow.
>=20

> > To understand this, we need to keep in mind that LTTng does everything
>=20
> > in per-cpu buffers, and that overwrite of oldest events in buffer full
> > conditions
>=20
> > happens per-cpu.
>=20

> > The use-case you show below really makes sense when you start to consid=
er
>=20
> > on which CPU (and thus per-cpu buffer) the application is running.
> > Initially,
>=20
> > the first app runs on CPU 6. As long as the following applications run =
on
>=20
> > other cpus, we keep the same first event. Then when enough events are
>=20
> > written in cpu 6 buffer to overwrite the first event, we see a first ev=
ent
> > change.
>=20
> > Then, depending on the scheduling of applications, older parts of per-c=
pu
>=20
> > buffers are overwritten, and others are not (if there are less events i=
n
> > those
>=20
> > buffer). This means some per-cpu buffers will have events going further
> > back
>=20
> > in time compared to other higher-throughput CPUs.
>=20

> > This is why you see more than 2 hunks in your diff. Babeltrace merges t=
hose
>=20
> > per-cpu buffers back into a single text output, and the fact that some
> > events
>=20
> > have been overwritten for a time-range for high-throughput buffers, but=
 not
>=20
> > for low-throughput buffers, make it appear as if events are missing in =
the
>=20
> > stream if your model is a single system-wide buffer, but the missing ev=
ents
>=20
> > make sense if you see it as a merge of per-cpu buffers.
>=20

> > Our current behavior is to gather all available data when taking a
> > snapshot,
>=20
> > and babeltrace behavior is to show all events available in the streams.=
 We
>=20
> > could perhaps consider a different babeltrace behavior (a flag) that wo=
uld
>=20
> > allow it to only show the events for the intersection of time range of =
all
>=20
> > streams, based on the packet header timestamp begin/end. This would
>=20
> > take care of hiding events that happen in low-throughput streams when
>=20
> > there is no intersection with snapshotted high-throughput streams.
>=20

> > And perhaps this should be the default ?
>=20

> > Thanks!
>=20

> > Mathieu
>=20

> > > TESTCASE;
> >=20
>=20

> > > tracetest code:
> >=20
>=20
> > > ---------------------------------------------------------------
> >=20
>=20
> > > #include <stdio.h>
> >=20
>=20
> > > #include "tracetest-tp.h"
> >=20
>=20

> > > int main(int argc, char* argv[])
> >=20
>=20
> > > {
> >=20
>=20
> > > int i;
> >=20
>=20
> > > for (i =3D 0; i < 1000; i++) {
> >=20
>=20
> > > tracepoint(tracetest, first_tp, i, "test");
> >=20
>=20
> > > }
> >=20
>=20
> > > return 0;
> >=20
>=20
> > > }
> >=20
>=20
> > > ---------------------------------------------------------------
> >=20
>=20

> > > test script:
> >=20
>=20
> > > ---------------------------------------------------------------
> >=20
>=20
> > > #!/bin/bash
> >=20
>=20
> > > : ${NO_OF_SUBBUF:=3D6}
> >=20
>=20
> > > : ${SUBBUF_SIZE:=3D4096}
> >=20
>=20
> > > : ${KERNEL_TRACE:=3DNO}
> >=20
>=20
> > > : ${LOOPS:=3D10}
> >=20
>=20

> > > SESSION=3Dtest
> >=20
>=20
> > > CHANNEL1=3Dch1
> >=20
>=20
> > > CHANNEL2=3Dch2
> >=20
>=20

> > > CH2_SUBBUF_SIZE=3D$(($SUBBUF_SIZE*$NO_OF_SUBBUF))
> >=20
>=20

> > > LTTNG=3D'lttng -n'
> >=20
>=20
> > > killall lttng-consumerd > /dev/null 2>&1
> >=20
>=20
> > > killall lttng-sessiond > /dev/null 2>&1
> >=20
>=20
> > > if [ -z $DEBUG ]; then
> >=20
>=20
> > > lttng-sessiond --no-kernel -d
> >=20
>=20
> > > else
> >=20
>=20
> > > lttng-sessiond -v --no-kernel --verbose-consumer -b
> >=20
>=20
> > > fi
> >=20
>=20
> > > sleep 1
> >=20
>=20

> > > if [ ! -z $DEBUG ]; then
> >=20
>=20
> > > export LTTNG_UST_DEBUG=3D1
> >=20
>=20
> > > fi
> >=20
>=20

> > > rm -rf $HOME/lttng-traces
> >=20
>=20
> > > rm snapshot/*.bt
> >=20
>=20

> > > $LTTNG --version
> >=20
>=20

> > > $LTTNG create $SESSION --snapshot
> >=20
>=20
> > > $LTTNG enable-channel -u --subbuf-size $SUBBUF_SIZE --num-subbuf
> > > $NO_OF_SUBBUF --overwrite $CHANNEL1
> >=20
>=20
> > > $LTTNG enable-channel -u --subbuf-size $CH2_SUBBUF_SIZE --num-subbuf =
2
> > > --overwrite $CHANNEL2
> >=20
>=20
> > > $LTTNG enable-event -u -c $CHANNEL1 "*"
> >=20
>=20
> > > $LTTNG start
> >=20
>=20
> > > $LTTNG list $SESSION
> >=20
>=20

> > > mkdir -p snapshot/
> >=20
>=20

> > > h=3D1
> >=20
>=20
> > > for i in $(seq 1 $LOOPS); do
> >=20
>=20
> > > $APP
> >=20
>=20
> > > $LTTNG snapshot record
> >=20
>=20
> > > # print no of events and first and last event
> >=20
>=20
> > > last=3D$(ls -1drt $HOME/lttng-traces/$SESSION*/* | tail -1)
> >=20
>=20
> > > babeltrace $last > snapshot/$ i.bt
> >=20
>=20
> > > cat snapshot/$ i.bt | wc -l
> >=20
>=20
> > > cat snapshot/$ i.bt | head -1
> >=20
>=20
> > > cat snapshot/$ i.bt | tail -1
> >=20
>=20
> > > diff -u snapshot/$ i.bt snapshot/$ h.bt > snapshot/$i_$h.diff
> >=20
>=20
> > > cat snapshot/$i_$h.diff | grep "@@" | wc -l | xargs echo "NUMBER OF D=
IFF
> > > HUNKS =3D "
> >=20
>=20
> > > h=3D$i
> >=20
>=20
> > > done
> >=20
>=20

> > > $LTTNG stop
> >=20
>=20
> > > $LTTNG destroy $SESSION
> >=20
>=20

> > > ---------------------------------------------------------------
> >=20
>=20

> > > result from run (removed some output lines for readability)
> >=20
>=20
> > > ---------------------------------------------------------------
> >=20
>=20
> > > lttng (LTTng Trace Control) 2.4.2 - =C3=89poque Opaque
> >=20
>=20
> > > Snapshot mode set. Every channel enabled for that session will be set=
 in
> > > overwrite mode and mmap output.
> >=20
>=20
> > > Warning: The number of subbuffers (6) is rounded to the next power of=
 2
> > > (8)
> >=20
>=20
> > > UST channel ch1 enabled for session test
> >=20
>=20
> > > Warning: The subbuf size (24576) is rounded to the next power of 2
> > > (32768)
> >=20
>=20
> > > UST channel ch2 enabled for session test
> >=20
>=20
> > > UST event * created in channel ch1
> >=20
>=20
> > > Tracing started for session test
> >=20
>=20
> > > Tracing session test: [active snapshot]
> >=20
>=20
> > > Trace path:
> >=20
>=20

> > > =3D=3D=3D Domain: UST global =3D=3D=3D
> >=20
>=20

> > > Buffer type: per UID
> >=20
>=20

> > > Channels:
> >=20
>=20
> > > -------------
> >=20
>=20
> > > - ch1: [enabled]
> >=20
>=20

> > > Attributes:
> >=20
>=20
> > > overwrite mode: 1
> >=20
>=20
> > > subbufers size: 4096
> >=20
>=20
> > > number of subbufers: 8
> >=20
>=20
> > > switch timer interval: 0
> >=20
>=20
> > > read timer interval: 0
> >=20
>=20
> > > output: mmap()
> >=20
>=20

> > > Events:
> >=20
>=20
> > > * (type: tracepoint) [enabled]
> >=20
>=20
> > > - ch2: [enabled]
> >=20
>=20

> > > Attributes:
> >=20
>=20
> > > overwrite mode: 1
> >=20
>=20
> > > subbufers size: 32768
> >=20
>=20
> > > number of subbufers: 2
> >=20
>=20
> > > switch timer interval: 0
> >=20
>=20
> > > read timer interval: 0
> >=20
>=20
> > > output: mmap()
> >=20
>=20

> > > Events:
> >=20
>=20
> > > None
> >=20
>=20

> > > Snapshot recorded successfully for session test
> >=20
>=20
> > > 1011
> >=20
>=20
> > > [07:09:43.278933559] (+?.?????????) 07f8cf84a38f
> > > ust_baddr_statedump:soinfo:
> > > { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000, sopath =3D "[vdso]", si=
ze =3D 0,
> > > mtime
> > > =3D -1 }
> >=20
>=20
> > > [07:09:43.279975100] (+0.000000975) 07f8cf84a38f tracetest:first_tp: =
{
> > > cpu_id
> > > =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> >=20
>=20
> > > NUMBER OF DIFF HUNKS =3D 0
> >=20
>=20
> > > Snapshot recorded successfully for session test
> >=20
>=20
> > > 2022
> >=20
>=20
> > > [07:09:43.278933559] (+?.?????????) 07f8cf84a38f
> > > ust_baddr_statedump:soinfo:
> > > { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000, sopath =3D "[vdso]", si=
ze =3D 0,
> > > mtime
> > > =3D -1 }
> >=20
>=20
> > > [07:09:43.337703508] (+0.000001238) 07f8cf84a38f tracetest:first_tp: =
{
> > > cpu_id
> > > =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> >=20
>=20
> > > NUMBER OF DIFF HUNKS =3D 1
> >=20
>=20
> > > Snapshot recorded successfully for session test
> >=20
>=20
> > > 3033
> >=20
>=20
> > > [07:09:43.278933559] (+?.?????????) 07f8cf84a38f
> > > ust_baddr_statedump:soinfo:
> > > { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000, sopath =3D "[vdso]", si=
ze =3D 0,
> > > mtime
> > > =3D -1 }
> >=20
>=20
> > > [07:09:43.432827051] (+0.000000308) 07f8cf84a38f tracetest:first_tp: =
{
> > > cpu_id
> > > =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> >=20
>=20
> > > NUMBER OF DIFF HUNKS =3D 1
> >=20
>=20
> > > Snapshot recorded successfully for session test
> >=20
>=20
> > > 4044
> >=20
>=20
> > > [07:09:43.278933559] (+?.?????????) 07f8cf84a38f
> > > ust_baddr_statedump:soinfo:
> > > { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000, sopath =3D "[vdso]", si=
ze =3D 0,
> > > mtime
> > > =3D -1 }
> >=20
>=20
> > > [07:09:43.475784825] (+0.000000501) 07f8cf84a38f tracetest:first_tp: =
{
> > > cpu_id
> > > =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> >=20
>=20
> > > NUMBER OF DIFF HUNKS =3D 1
> >=20
>=20
> > > Snapshot recorded successfully for session test
> >=20
>=20
> > > 4735
> >=20
>=20
> > > [07:09:43.279031320] (+?.?????????) 07f8cf84a38f tracetest:first_tp: =
{
> > > cpu_id
> > > =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 0 }
> >=20
>=20
> > > [07:09:43.549945106] (+0.000000517) 07f8cf84a38f tracetest:first_tp: =
{
> > > cpu_id
> > > =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> >=20
>=20
> > > NUMBER OF DIFF HUNKS =3D 12
> >=20
>=20
> > > Snapshot recorded successfully for session test
> >=20
>=20
> > > 4437
> >=20
>=20
> > > [07:09:43.335916076] (+?.?????????) 07f8cf84a38f
> > > ust_baddr_statedump:soinfo:
> > > { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000, sopath =3D "[vdso]", si=
ze =3D 0,
> > > mtime
> > > =3D -1 }
> >=20
>=20
> > > [07:09:43.654229030] (+0.000000436) 07f8cf84a38f tracetest:first_tp: =
{
> > > cpu_id
> > > =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> >=20
>=20
> > > NUMBER OF DIFF HUNKS =3D 3
> >=20
>=20
> > > Snapshot recorded successfully for session test
> >=20
>=20
> > > 4746
> >=20
>=20
> > > [07:09:43.335916076] (+?.?????????) 07f8cf84a38f
> > > ust_baddr_statedump:soinfo:
> > > { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000, sopath =3D "[vdso]", si=
ze =3D 0,
> > > mtime
> > > =3D -1 }
> >=20
>=20
> > > [07:09:43.747509349] (+0.000000502) 07f8cf84a38f tracetest:first_tp: =
{
> > > cpu_id
> > > =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> >=20
>=20
> > > NUMBER OF DIFF HUNKS =3D 11
> >=20
>=20
> > > Snapshot recorded successfully for session test
> >=20
>=20
> > > 5757
> >=20
>=20
> > > [07:09:43.335916076] (+?.?????????) 07f8cf84a38f
> > > ust_baddr_statedump:soinfo:
> > > { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000, sopath =3D "[vdso]", si=
ze =3D 0,
> > > mtime
> > > =3D -1 }
> >=20
>=20
> > > [07:09:43.814938128] (+0.000001371) 07f8cf84a38f tracetest:first_tp: =
{
> > > cpu_id
> > > =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> >=20
>=20
> > > NUMBER OF DIFF HUNKS =3D 1
> >=20
>=20
> > > Snapshot recorded successfully for session test
> >=20
>=20
> > > 6066
> >=20
>=20
> > > [07:09:43.335916076] (+?.?????????) 07f8cf84a38f
> > > ust_baddr_statedump:soinfo:
> > > { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000, sopath =3D "[vdso]", si=
ze =3D 0,
> > > mtime
> > > =3D -1 }
> >=20
>=20
> > > [07:09:43.919112586] (+0.000000990) 07f8cf84a38f tracetest:first_tp: =
{
> > > cpu_id
> > > =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> >=20
>=20
> > > NUMBER OF DIFF HUNKS =3D 11
> >=20
>=20
> > > Snapshot recorded successfully for session test
> >=20
>=20
> > > 6077
> >=20
>=20
> > > [07:09:43.335916076] (+?.?????????) 07f8cf84a38f
> > > ust_baddr_statedump:soinfo:
> > > { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000, sopath =3D "[vdso]", si=
ze =3D 0,
> > > mtime
> > > =3D -1 }
> >=20
>=20
> > > [07:09:44.004234933] (+0.000001213) 07f8cf84a38f tracetest:first_tp: =
{
> > > cpu_id
> > > =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> >=20
>=20
> > > NUMBER OF DIFF HUNKS =3D 2
> >=20
>=20
> > > Waiting for data availability
> >=20
>=20
> > > Tracing stopped for session test
> >=20
>=20
> > > Session test destroyed
> >=20
>=20
> > > ---------------------------------------------------------------
> >=20
>=20

> > > Regards
> >=20
>=20

> > > Anders Wallin
> >=20
>=20

> > > _______________________________________________
> >=20
>=20
> > > lttng-dev mailing list
> >=20
>=20
> > > lttng-dev@lists.lttng.org
> >=20
>=20
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >=20
>=20

> > --
>=20
> > Mathieu Desnoyers
>=20
> > EfficiOS Inc.
>=20
> > http://www.efficios.com
>=20

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_14584_1358994827.1416224714942
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>Hi Anders,<br></div><div><br></d=
iv><div>Yes, please file a feature request against Babeltrace on<br></div><=
div>the bug tracker pointing the this email thread and<br></div><div>descri=
bing the feature.<br></div><div><br></div><div>Thanks!<br></div><div><br></=
div><div>Mathieu<br></div><div><br></div><div><br></div><hr id=3D"zwchr"><b=
lockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-le=
ft:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none=
;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"Ande=
rs Wallin" &lt;wallinux@gmail.com&gt;<br><b>To: </b>"Mathieu Desnoyers" &lt=
;mathieu.desnoyers@efficios.com&gt;<br><b>Cc: </b>lttng-dev@lists.lttng.org=
<br><b>Sent: </b>Monday, November 17, 2014 10:45:37 AM<br><b>Subject: </b>R=
e: [lttng-dev] snapshot data corrupted after the output buffer is filled<br=
><div><br></div><div dir=3D"ltr">Thx Mathieu,<div><br></div><div>if I'm run=
ning my test on one cpu (taskset -c 1 ./test.run) it works as expected and =
described by you.</div><div>The babeltrace flag would be a good solution! D=
o you want me to file a bug/enhancement on this?&nbsp;</div><div><br></div>=
<div>Regards</div><div><br></div><div><br></div></div><div class=3D"gmail_e=
xtra"><br clear=3D"all"><div><div class=3D"gmail_signature">Anders Wallin</=
div></div>
<br><div class=3D"gmail_quote">On Sat, Nov 15, 2014 at 6:59 PM, Mathieu Des=
noyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.c=
om" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><div><div style=3D"font-family:times new =
roman,new york,times,serif;font-size:12pt;color:#000000"><hr><blockquote st=
yle=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color=
:#000;font-weight:normal;font-style:normal;text-decoration:none;font-family=
:Helvetica,Arial,sans-serif;font-size:12pt"><b>From: </b>"Anders Wallin" &l=
t;<a href=3D"mailto:wallinux@gmail.com" target=3D"_blank">wallinux@gmail.co=
m</a>&gt;<br><b>To: </b><a href=3D"mailto:lttng-dev@lists.lttng.org" target=
=3D"_blank">lttng-dev@lists.lttng.org</a><br><b>Sent: </b>Friday, November =
14, 2014 8:28:18 AM<br><b>Subject: </b>[lttng-dev] snapshot data corrupted =
after the output buffer is&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;f=
illed<span class=3D""><br><div><br></div><div dir=3D"ltr"><div>Hi,</div><di=
v><br></div><div>it looks like snapshot events became faulty after the outp=
ut max size is reached.</div><div>The next snapshot get mixed events from d=
ifferent buffers. I have tested it on 2.3, 2.4 and 2.5</div><div>and it's i=
n all of them, but it hits earlier in 2.5 due to the &nbsp;problem reported=
 in</div><div><a href=3D"http://lists.lttng.org/pipermail/lttng-dev/2014-No=
vember/023773.html" target=3D"_blank">http://lists.lttng.org/pipermail/lttn=
g-dev/2014-November/023773.html</a><br></div><div><br></div><div>There shou=
ld never be more then 2 HUNKS in a diff between 2 consecutive snapshots, he=
re I got&nbsp;</div><div>11 as the worst case.</div></div></span></blockquo=
te><div>Hi Anders,<br></div><div><br></div><div>This is not a bug, rather j=
ust per-cpu buffering at work.It does have some<br></div><div>rather non-ob=
vious consequences in terms of snapshot event flow.<br></div><div><br></div=
><div>To understand this, we need to keep in mind that LTTng does everythin=
g<br></div><div>in per-cpu buffers, and that overwrite of oldest events in =
buffer full conditions<br></div><div>happens per-cpu.<br></div><div><br></d=
iv><div>The use-case you show below really makes sense when you start to co=
nsider<br></div><div>on which CPU (and thus per-cpu buffer) the application=
 is running. Initially,<br></div><div>the first app runs on CPU 6. As long =
as the following applications run on<br></div><div>other cpus, we keep the =
same first event. Then when enough events are<br></div><div>written in cpu =
6 buffer to overwrite the first event, we see a first event change.<br></di=
v><div>Then, depending on the scheduling of applications, older parts of pe=
r-cpu<br></div><div>buffers are overwritten, and others are not (if there a=
re less events in those<br></div><div>buffer). This means some per-cpu buff=
ers will have events going further back<br></div><div>in time compared to o=
ther higher-throughput CPUs.<br></div><div><br></div><div>This is why you s=
ee more than 2 hunks in your diff. Babeltrace merges those<br></div><div>pe=
r-cpu buffers back into a single text output, and the fact that some events=
<br></div><div>have been overwritten for a time-range for high-throughput b=
uffers, but not<br></div><div>for low-throughput buffers, make it appear as=
 if events are missing in the<br></div><div>stream if your model is a singl=
e system-wide buffer, but the missing events<br></div><div>make sense if yo=
u see it as a merge of per-cpu buffers.<br></div><div><br></div><div>Our cu=
rrent behavior is to gather all available data when taking a snapshot,<br><=
/div><div>and babeltrace behavior is to show all events available in the st=
reams. We<br></div><div>could perhaps consider a different babeltrace behav=
ior (a flag) that would<br></div><div>allow it to only show the events for =
the intersection of time range of all<br></div><div>streams, based on the p=
acket header timestamp begin/end. This would<br></div><div>take care of hid=
ing events that happen in low-throughput streams when<br></div><div>there i=
s no intersection with snapshotted high-throughput streams.<br></div><div><=
br></div><div>And perhaps this should be the default ?<br></div><div><br></=
div><div>Thanks!<br></div><div><br></div><div>Mathieu<br></div><div><br></d=
iv><blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;paddi=
ng-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration=
:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div><div clas=
s=3D"h5"><div dir=3D"ltr"><div><br></div><div>TESTCASE;</div><div><br></div=
><div>tracetest code:</div><div>-------------------------------------------=
--------------------</div><div>#include &lt;stdio.h&gt;</div><div>#include =
"tracetest-tp.h"</div><div><br></div><div>int main(int argc, char* argv[])<=
/div><div>{</div><div>&nbsp; &nbsp; &nbsp; &nbsp; int i;</div><div>&nbsp; &=
nbsp; &nbsp; &nbsp; for (i =3D 0; i &lt; 1000; i++) {</div><div>&nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; tracepoint(tracetest, first_tp=
, i, "test");</div><div>&nbsp; &nbsp; &nbsp; &nbsp; }</div><div>&nbsp; &nbs=
p; &nbsp; &nbsp; return 0;</div><div>}</div><div>--------------------------=
-------------------------------------</div><div><br></div><div>test script:=
</div><div>---------------------------------------------------------------<=
/div><div>#!/bin/bash&nbsp;</div><div>: ${NO_OF_SUBBUF:=3D6}</div><div>: ${=
SUBBUF_SIZE:=3D4096}</div><div>: ${KERNEL_TRACE:=3DNO}</div><div>: ${LOOPS:=
=3D10}</div><div><br></div><div>SESSION=3Dtest</div><div>CHANNEL1=3Dch1</di=
v><div>CHANNEL2=3Dch2</div><div><br></div><div>CH2_SUBBUF_SIZE=3D$(($SUBBUF=
_SIZE*$NO_OF_SUBBUF))</div><div><br></div><div><br></div><div>LTTNG=3D'lttn=
g -n'</div><div>killall lttng-consumerd &gt; /dev/null 2&gt;&amp;1</div><di=
v>killall lttng-sessiond &gt; /dev/null 2&gt;&amp;1</div><div>if [ -z $DEBU=
G ]; then</div><div>&nbsp; &nbsp; lttng-sessiond --no-kernel -d</div><div>e=
lse</div><div>&nbsp; &nbsp; lttng-sessiond -v --no-kernel --verbose-consume=
r -b</div><div>fi</div><div>sleep 1</div><div><br></div><div>if [ ! -z $DEB=
UG ]; then</div><div>&nbsp; &nbsp; export LTTNG_UST_DEBUG=3D1</div><div>fi<=
/div><div><br></div><div>rm -rf $HOME/lttng-traces</div><div>rm snapshot/*.=
bt</div><div><br></div><div>$LTTNG --version</div><div><br></div><div>$LTTN=
G create $SESSION --snapshot</div><div>$LTTNG enable-channel -u --subbuf-si=
ze $SUBBUF_SIZE --num-subbuf $NO_OF_SUBBUF --overwrite $CHANNEL1</div><div>=
$LTTNG enable-channel -u --subbuf-size $CH2_SUBBUF_SIZE --num-subbuf 2 --ov=
erwrite $CHANNEL2</div><div>$LTTNG enable-event -u -c $CHANNEL1 "*"</div><d=
iv>$LTTNG start</div><div>$LTTNG list $SESSION</div><div><br></div><div>mkd=
ir -p snapshot/</div><div><br></div><div>h=3D1</div><div>for i in $(seq 1 $=
LOOPS); do</div><div>&nbsp; &nbsp; $APP</div><div>&nbsp; &nbsp; $LTTNG snap=
shot record</div><div>&nbsp; &nbsp; # print no of events and first and last=
 event &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp;</div><div>&nbsp; &nbsp; last=3D$(ls -1drt $HOME/lttng-traces/$S=
ESSION*/* | tail -1)</div><div>&nbsp; &nbsp; babeltrace $last &gt; snapshot=
/$<a href=3D"http://i.bt" target=3D"_blank">i.bt</a><br></div><div>&nbsp; &=
nbsp; cat snapshot/$<a href=3D"http://i.bt" target=3D"_blank">i.bt</a> | wc=
 -l</div><div>&nbsp; &nbsp; cat snapshot/$<a href=3D"http://i.bt" target=3D=
"_blank">i.bt</a> | head -1</div><div>&nbsp; &nbsp; cat snapshot/$<a href=
=3D"http://i.bt" target=3D"_blank">i.bt</a> | tail -1</div><div>&nbsp; &nbs=
p; diff -u snapshot/$<a href=3D"http://i.bt" target=3D"_blank">i.bt</a> sna=
pshot/$<a href=3D"http://h.bt" target=3D"_blank">h.bt</a> &gt; snapshot/$i_=
$h.diff</div><div>&nbsp; &nbsp; cat snapshot/$i_$h.diff | grep "@@" | wc -l=
 | xargs echo "NUMBER OF DIFF HUNKS =3D "</div><div>&nbsp; &nbsp; h=3D$i</d=
iv><div>done</div><div><br></div><div><div><div>$LTTNG stop</div><div>$LTTN=
G destroy $SESSION</div><div><br></div><div>-------------------------------=
--------------------------------</div><div><br></div><div>result from run (=
removed some output lines for readability)</div><div>----------------------=
-----------------------------------------</div><div>lttng (LTTng Trace Cont=
rol) 2.4.2 - =C3=89poque Opaque</div><div>Snapshot mode set. Every channel =
enabled for that session will be set in overwrite mode and mmap output.</di=
v><div>Warning: The number of subbuffers (6) is rounded to the next power o=
f 2 (8)</div><div>UST channel ch1 enabled for session test</div><div>Warnin=
g: The subbuf size (24576) is rounded to the next power of 2 (32768)</div><=
div>UST channel ch2 enabled for session test</div><div>UST event * created =
in channel ch1</div><div>Tracing started for session test</div><div>Tracing=
 session test: [active snapshot]</div><div>&nbsp; &nbsp; Trace path:&nbsp;<=
/div><div><br></div><div>=3D=3D=3D Domain: UST global =3D=3D=3D</div><div><=
br></div><div>Buffer type: per UID</div><div><br></div><div>Channels:</div>=
<div>-------------</div><div>- ch1: [enabled]</div><div><br></div><div>&nbs=
p; &nbsp; Attributes:</div><div>&nbsp; &nbsp; &nbsp; overwrite mode: 1</div=
><div>&nbsp; &nbsp; &nbsp; subbufers size: 4096</div><div>&nbsp; &nbsp; &nb=
sp; number of subbufers: 8</div><div>&nbsp; &nbsp; &nbsp; switch timer inte=
rval: 0</div><div>&nbsp; &nbsp; &nbsp; read timer interval: 0</div><div>&nb=
sp; &nbsp; &nbsp; output: mmap()</div><div><br></div><div>&nbsp; &nbsp; Eve=
nts:</div><div>&nbsp; &nbsp; &nbsp; * (type: tracepoint) [enabled]</div><di=
v>- ch2: [enabled]</div><div><br></div><div>&nbsp; &nbsp; Attributes:</div>=
<div>&nbsp; &nbsp; &nbsp; overwrite mode: 1</div><div>&nbsp; &nbsp; &nbsp; =
subbufers size: 32768</div><div>&nbsp; &nbsp; &nbsp; number of subbufers: 2=
</div><div>&nbsp; &nbsp; &nbsp; switch timer interval: 0</div><div>&nbsp; &=
nbsp; &nbsp; read timer interval: 0</div><div>&nbsp; &nbsp; &nbsp; output: =
mmap()</div><div><br></div><div>&nbsp; &nbsp; Events:</div><div>&nbsp; &nbs=
p; &nbsp; None</div><div><br></div><div>Snapshot recorded successfully for =
session test</div><div>1011</div><div>[07:09:43.278933559] (+?.?????????) 0=
7f8cf84a38f ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FF=
F645EE000, sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }</div><div>[07:09=
:43.279975100] (+0.000000975) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D=
 5 }, { my_string_field =3D "test", my_integer_field =3D 999 }</div><div>NU=
MBER OF DIFF HUNKS =3D &nbsp;0</div><div>Snapshot recorded successfully for=
 session test</div><div>2022</div><div>[07:09:43.278933559] (+?.?????????) =
07f8cf84a38f ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7F=
FF645EE000, sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }</div><div>[07:0=
9:43.337703508] (+0.000001238) 07f8cf84a38f tracetest:first_tp: { cpu_id =
=3D 4 }, { my_string_field =3D "test", my_integer_field =3D 999 }</div><div=
>NUMBER OF DIFF HUNKS =3D &nbsp;1</div><div>Snapshot recorded successfully =
for session test</div><div>3033</div><div>[07:09:43.278933559] (+?.????????=
?) 07f8cf84a38f ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0=
x7FFF645EE000, sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }</div><div>[0=
7:09:43.432827051] (+0.000000308) 07f8cf84a38f tracetest:first_tp: { cpu_id=
 =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }</div><di=
v>NUMBER OF DIFF HUNKS =3D &nbsp;1</div><div>Snapshot recorded successfully=
 for session test</div><div>4044</div><div>[07:09:43.278933559] (+?.???????=
??) 07f8cf84a38f ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D =
0x7FFF645EE000, sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }</div><div>[=
07:09:43.475784825] (+0.000000501) 07f8cf84a38f tracetest:first_tp: { cpu_i=
d =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 999 }</div><d=
iv>NUMBER OF DIFF HUNKS =3D &nbsp;1</div><div>Snapshot recorded successfull=
y for session test</div><div>4735</div><div>[07:09:43.279031320] (+?.??????=
???) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 5 }, { my_string_field =
=3D "test", my_integer_field =3D 0 }</div><div>[07:09:43.549945106] (+0.000=
000517) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 6 }, { my_string_fiel=
d =3D "test", my_integer_field =3D 999 }</div><div>NUMBER OF DIFF HUNKS =3D=
 &nbsp;12</div><div>Snapshot recorded successfully for session test</div><d=
iv>4437</div><div>[07:09:43.335916076] (+?.?????????) 07f8cf84a38f ust_badd=
r_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000, sopath =
=3D "[vdso]", size =3D 0, mtime =3D -1 }</div><div>[07:09:43.654229030] (+0=
.000000436) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 5 }, { my_string_=
field =3D "test", my_integer_field =3D 999 }</div><div>NUMBER OF DIFF HUNKS=
 =3D &nbsp;3</div><div>Snapshot recorded successfully for session test</div=
><div>4746</div><div>[07:09:43.335916076] (+?.?????????) 07f8cf84a38f ust_b=
addr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000, sopath=
 =3D "[vdso]", size =3D 0, mtime =3D -1 }</div><div>[07:09:43.747509349] (+=
0.000000502) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 6 }, { my_string=
_field =3D "test", my_integer_field =3D 999 }</div><div>NUMBER OF DIFF HUNK=
S =3D &nbsp;11</div><div>Snapshot recorded successfully for session test</d=
iv><div>5757</div><div>[07:09:43.335916076] (+?.?????????) 07f8cf84a38f ust=
_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000, sopa=
th =3D "[vdso]", size =3D 0, mtime =3D -1 }</div><div>[07:09:43.814938128] =
(+0.000001371) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 4 }, { my_stri=
ng_field =3D "test", my_integer_field =3D 999 }</div><div>NUMBER OF DIFF HU=
NKS =3D &nbsp;1</div><div>Snapshot recorded successfully for session test</=
div><div>6066</div><div>[07:09:43.335916076] (+?.?????????) 07f8cf84a38f us=
t_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000, sop=
ath =3D "[vdso]", size =3D 0, mtime =3D -1 }</div><div>[07:09:43.919112586]=
 (+0.000000990) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 6 }, { my_str=
ing_field =3D "test", my_integer_field =3D 999 }</div><div>NUMBER OF DIFF H=
UNKS =3D &nbsp;11</div><div>Snapshot recorded successfully for session test=
</div><div>6077</div><div>[07:09:43.335916076] (+?.?????????) 07f8cf84a38f =
ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000, s=
opath =3D "[vdso]", size =3D 0, mtime =3D -1 }</div><div>[07:09:44.00423493=
3] (+0.000001213) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 6 }, { my_s=
tring_field =3D "test", my_integer_field =3D 999 }</div><div>NUMBER OF DIFF=
 HUNKS =3D &nbsp;2</div><div>Waiting for data availability</div><div>Tracin=
g stopped for session test</div><div>Session test destroyed</div><div>-----=
----------------------------------------------------------</div><div><br></=
div><div>Regards</div><div><br></div><div>Anders Wallin</div></div></div></=
div><br></div></div><span class=3D"">______________________________________=
_________<br>lttng-dev mailing list<br><a href=3D"mailto:lttng-dev@lists.lt=
tng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><br><a href=3D"http=
://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">ht=
tp://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br></span></blo=
ckquote><span class=3D"HOEnZb"><span style=3D"color: #888888;" data-mce-sty=
le=3D"color: #888888;" color=3D"#888888"><div><br><div><br></div></div><div=
><br></div><div>-- <br></div><div><span></span>Mathieu Desnoyers<br>EfficiO=
S Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.=
efficios.com</a><span></span><br></div></span></span></div></div></blockquo=
te></div><br></div>
</blockquote><div><br><br></div><div><br></div><div>-- <br></div><div><span=
 name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficio=
s.com<span name=3D"x"></span><br></div></div></body></html>
------=_Part_14584_1358994827.1416224714942--


--===============0906234386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0906234386==--
