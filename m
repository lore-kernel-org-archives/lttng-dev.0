From: Anders Wallin <wallinux@gmail.com>
Subject: Re: snapshot data corrupted after the output buffer is
	filled
Date: Wed, 19 Nov 2014 11:31:56 +0100
Message-ID: <CAF2baFfbjbLAnUoor6WEMv0ZF9Cumf6NnAKm4MMCY4=B5x8w1w__2904.13425905189$1416393175$gmane$org@mail.gmail.com>
References: <CAF2baFfMNzRQnx-FC7kFRr5m4NpZBEcEohnwf50uOs2vv9=GBw@mail.gmail.com>
 <734976879.13957.1416074394667.JavaMail.zimbra@efficios.com>
 <CAF2baFcfh8h769xaxLQpW4=9nmWRBcmi7tP79mW=w1DyqJm9Hw@mail.gmail.com>
 <2137471544.14585.1416224714944.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0071348347=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <wallinux@gmail.com>) id 1Xr2YM-0006rx-AW
 for lttng-dev@lists.lttng.org; Wed, 19 Nov 2014 05:32:05 -0500
Received: by mail-qg0-f45.google.com with SMTP id f51so165315qge.4
 for <lttng-dev@lists.lttng.org>; Wed, 19 Nov 2014 02:31:57 -0800 (PST)
In-Reply-To: <2137471544.14585.1416224714944.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0071348347==
Content-Type: multipart/alternative; boundary=001a11c2ebf2977402050833b800

--001a11c2ebf2977402050833b800
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Filed as https://bugs.lttng.org/issues/862



Anders Wallin

On Mon, Nov 17, 2014 at 12:45 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> Hi Anders,
>
> Yes, please file a feature request against Babeltrace on
> the bug tracker pointing the this email thread and
> describing the feature.
>
> Thanks!
>
> Mathieu
>
>
> ------------------------------
>
> *From: *"Anders Wallin" <wallinux@gmail.com>
> *To: *"Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> *Cc: *lttng-dev@lists.lttng.org
> *Sent: *Monday, November 17, 2014 10:45:37 AM
> *Subject: *Re: [lttng-dev] snapshot data corrupted after the output
> buffer is filled
>
>
> Thx Mathieu,
>
> if I'm running my test on one cpu (taskset -c 1 ./test.run) it works as
> expected and described by you.
> The babeltrace flag would be a good solution! Do you want me to file a
> bug/enhancement on this?
>
> Regards
>
>
>
> Anders Wallin
>
> On Sat, Nov 15, 2014 at 6:59 PM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com> wrote:
>
>> ------------------------------
>>
>> *From: *"Anders Wallin" <wallinux@gmail.com>
>> *To: *lttng-dev@lists.lttng.org
>> *Sent: *Friday, November 14, 2014 8:28:18 AM
>> *Subject: *[lttng-dev] snapshot data corrupted after the output buffer
>> is        filled
>>
>> Hi,
>>
>> it looks like snapshot events became faulty after the output max size is
>> reached.
>> The next snapshot get mixed events from different buffers. I have tested
>> it on 2.3, 2.4 and 2.5
>> and it's in all of them, but it hits earlier in 2.5 due to the  problem
>> reported in
>> http://lists.lttng.org/pipermail/lttng-dev/2014-November/023773.html
>>
>> There should never be more then 2 HUNKS in a diff between 2 consecutive
>> snapshots, here I got
>> 11 as the worst case.
>>
>> Hi Anders,
>>
>> This is not a bug, rather just per-cpu buffering at work.It does have so=
me
>> rather non-obvious consequences in terms of snapshot event flow.
>>
>> To understand this, we need to keep in mind that LTTng does everything
>> in per-cpu buffers, and that overwrite of oldest events in buffer full
>> conditions
>> happens per-cpu.
>>
>> The use-case you show below really makes sense when you start to conside=
r
>> on which CPU (and thus per-cpu buffer) the application is running.
>> Initially,
>> the first app runs on CPU 6. As long as the following applications run o=
n
>> other cpus, we keep the same first event. Then when enough events are
>> written in cpu 6 buffer to overwrite the first event, we see a first
>> event change.
>> Then, depending on the scheduling of applications, older parts of per-cp=
u
>> buffers are overwritten, and others are not (if there are less events in
>> those
>> buffer). This means some per-cpu buffers will have events going further
>> back
>> in time compared to other higher-throughput CPUs.
>>
>> This is why you see more than 2 hunks in your diff. Babeltrace merges
>> those
>> per-cpu buffers back into a single text output, and the fact that some
>> events
>> have been overwritten for a time-range for high-throughput buffers, but
>> not
>> for low-throughput buffers, make it appear as if events are missing in t=
he
>> stream if your model is a single system-wide buffer, but the missing
>> events
>> make sense if you see it as a merge of per-cpu buffers.
>>
>> Our current behavior is to gather all available data when taking a
>> snapshot,
>> and babeltrace behavior is to show all events available in the streams. =
We
>> could perhaps consider a different babeltrace behavior (a flag) that wou=
ld
>> allow it to only show the events for the intersection of time range of a=
ll
>> streams, based on the packet header timestamp begin/end. This would
>> take care of hiding events that happen in low-throughput streams when
>> there is no intersection with snapshotted high-throughput streams.
>>
>> And perhaps this should be the default ?
>>
>> Thanks!
>>
>> Mathieu
>>
>>
>> TESTCASE;
>>
>> tracetest code:
>> ---------------------------------------------------------------
>> #include <stdio.h>
>> #include "tracetest-tp.h"
>>
>> int main(int argc, char* argv[])
>> {
>>         int i;
>>         for (i =3D 0; i < 1000; i++) {
>>                 tracepoint(tracetest, first_tp, i, "test");
>>         }
>>         return 0;
>> }
>> ---------------------------------------------------------------
>>
>> test script:
>> ---------------------------------------------------------------
>> #!/bin/bash
>> : ${NO_OF_SUBBUF:=3D6}
>> : ${SUBBUF_SIZE:=3D4096}
>> : ${KERNEL_TRACE:=3DNO}
>> : ${LOOPS:=3D10}
>>
>> SESSION=3Dtest
>> CHANNEL1=3Dch1
>> CHANNEL2=3Dch2
>>
>> CH2_SUBBUF_SIZE=3D$(($SUBBUF_SIZE*$NO_OF_SUBBUF))
>>
>>
>> LTTNG=3D'lttng -n'
>> killall lttng-consumerd > /dev/null 2>&1
>> killall lttng-sessiond > /dev/null 2>&1
>> if [ -z $DEBUG ]; then
>>     lttng-sessiond --no-kernel -d
>> else
>>     lttng-sessiond -v --no-kernel --verbose-consumer -b
>> fi
>> sleep 1
>>
>> if [ ! -z $DEBUG ]; then
>>     export LTTNG_UST_DEBUG=3D1
>> fi
>>
>> rm -rf $HOME/lttng-traces
>> rm snapshot/*.bt
>>
>> $LTTNG --version
>>
>> $LTTNG create $SESSION --snapshot
>> $LTTNG enable-channel -u --subbuf-size $SUBBUF_SIZE --num-subbuf
>> $NO_OF_SUBBUF --overwrite $CHANNEL1
>> $LTTNG enable-channel -u --subbuf-size $CH2_SUBBUF_SIZE --num-subbuf 2
>> --overwrite $CHANNEL2
>> $LTTNG enable-event -u -c $CHANNEL1 "*"
>> $LTTNG start
>> $LTTNG list $SESSION
>>
>> mkdir -p snapshot/
>>
>> h=3D1
>> for i in $(seq 1 $LOOPS); do
>>     $APP
>>     $LTTNG snapshot record
>>     # print no of events and first and last event
>>
>>
>>     last=3D$(ls -1drt $HOME/lttng-traces/$SESSION*/* | tail -1)
>>     babeltrace $last > snapshot/$i.bt
>>     cat snapshot/$i.bt | wc -l
>>     cat snapshot/$i.bt | head -1
>>     cat snapshot/$i.bt | tail -1
>>     diff -u snapshot/$i.bt snapshot/$h.bt > snapshot/$i_$h.diff
>>     cat snapshot/$i_$h.diff | grep "@@" | wc -l | xargs echo "NUMBER OF
>> DIFF HUNKS =3D "
>>     h=3D$i
>> done
>>
>> $LTTNG stop
>> $LTTNG destroy $SESSION
>>
>> ---------------------------------------------------------------
>>
>> result from run (removed some output lines for readability)
>> ---------------------------------------------------------------
>> lttng (LTTng Trace Control) 2.4.2 - =C3=89poque Opaque
>> Snapshot mode set. Every channel enabled for that session will be set in
>> overwrite mode and mmap output.
>> Warning: The number of subbuffers (6) is rounded to the next power of 2
>> (8)
>> UST channel ch1 enabled for session test
>> Warning: The subbuf size (24576) is rounded to the next power of 2 (3276=
8)
>> UST channel ch2 enabled for session test
>> UST event * created in channel ch1
>> Tracing started for session test
>> Tracing session test: [active snapshot]
>>     Trace path:
>>
>> =3D=3D=3D Domain: UST global =3D=3D=3D
>>
>> Buffer type: per UID
>>
>> Channels:
>> -------------
>> - ch1: [enabled]
>>
>>     Attributes:
>>       overwrite mode: 1
>>       subbufers size: 4096
>>       number of subbufers: 8
>>       switch timer interval: 0
>>       read timer interval: 0
>>       output: mmap()
>>
>>     Events:
>>       * (type: tracepoint) [enabled]
>> - ch2: [enabled]
>>
>>     Attributes:
>>       overwrite mode: 1
>>       subbufers size: 32768
>>       number of subbufers: 2
>>       switch timer interval: 0
>>       read timer interval: 0
>>       output: mmap()
>>
>>     Events:
>>       None
>>
>> Snapshot recorded successfully for session test
>> 1011
>> [07:09:43.278933559] (+?.?????????) 07f8cf84a38f
>> ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000=
,
>> sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
>> [07:09:43.279975100] (+0.000000975) 07f8cf84a38f tracetest:first_tp: {
>> cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 999 }
>> NUMBER OF DIFF HUNKS =3D  0
>> Snapshot recorded successfully for session test
>> 2022
>> [07:09:43.278933559] (+?.?????????) 07f8cf84a38f
>> ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000=
,
>> sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
>> [07:09:43.337703508] (+0.000001238) 07f8cf84a38f tracetest:first_tp: {
>> cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 999 }
>> NUMBER OF DIFF HUNKS =3D  1
>> Snapshot recorded successfully for session test
>> 3033
>> [07:09:43.278933559] (+?.?????????) 07f8cf84a38f
>> ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000=
,
>> sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
>> [07:09:43.432827051] (+0.000000308) 07f8cf84a38f tracetest:first_tp: {
>> cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
>> NUMBER OF DIFF HUNKS =3D  1
>> Snapshot recorded successfully for session test
>> 4044
>> [07:09:43.278933559] (+?.?????????) 07f8cf84a38f
>> ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000=
,
>> sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
>> [07:09:43.475784825] (+0.000000501) 07f8cf84a38f tracetest:first_tp: {
>> cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 999 }
>> NUMBER OF DIFF HUNKS =3D  1
>> Snapshot recorded successfully for session test
>> 4735
>> [07:09:43.279031320] (+?.?????????) 07f8cf84a38f tracetest:first_tp: {
>> cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 0 }
>> [07:09:43.549945106] (+0.000000517) 07f8cf84a38f tracetest:first_tp: {
>> cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
>> NUMBER OF DIFF HUNKS =3D  12
>> Snapshot recorded successfully for session test
>> 4437
>> [07:09:43.335916076] (+?.?????????) 07f8cf84a38f
>> ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000=
,
>> sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
>> [07:09:43.654229030] (+0.000000436) 07f8cf84a38f tracetest:first_tp: {
>> cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 999 }
>> NUMBER OF DIFF HUNKS =3D  3
>> Snapshot recorded successfully for session test
>> 4746
>> [07:09:43.335916076] (+?.?????????) 07f8cf84a38f
>> ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000=
,
>> sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
>> [07:09:43.747509349] (+0.000000502) 07f8cf84a38f tracetest:first_tp: {
>> cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
>> NUMBER OF DIFF HUNKS =3D  11
>> Snapshot recorded successfully for session test
>> 5757
>> [07:09:43.335916076] (+?.?????????) 07f8cf84a38f
>> ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000=
,
>> sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
>> [07:09:43.814938128] (+0.000001371) 07f8cf84a38f tracetest:first_tp: {
>> cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 999 }
>> NUMBER OF DIFF HUNKS =3D  1
>> Snapshot recorded successfully for session test
>> 6066
>> [07:09:43.335916076] (+?.?????????) 07f8cf84a38f
>> ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000=
,
>> sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
>> [07:09:43.919112586] (+0.000000990) 07f8cf84a38f tracetest:first_tp: {
>> cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
>> NUMBER OF DIFF HUNKS =3D  11
>> Snapshot recorded successfully for session test
>> 6077
>> [07:09:43.335916076] (+?.?????????) 07f8cf84a38f
>> ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000=
,
>> sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
>> [07:09:44.004234933] (+0.000001213) 07f8cf84a38f tracetest:first_tp: {
>> cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
>> NUMBER OF DIFF HUNKS =3D  2
>> Waiting for data availability
>> Tracing stopped for session test
>> Session test destroyed
>> ---------------------------------------------------------------
>>
>> Regards
>>
>> Anders Wallin
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>>
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>
>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--001a11c2ebf2977402050833b800
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Filed as=C2=A0<a href=3D"https://bugs.lttng.org/issues/862=
">https://bugs.lttng.org/issues/862</a><div><br></div><div><br></div></div>=
<div class=3D"gmail_extra"><br clear=3D"all"><div><div class=3D"gmail_signa=
ture">Anders Wallin</div></div>
<br><div class=3D"gmail_quote">On Mon, Nov 17, 2014 at 12:45 PM, Mathieu De=
snoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.=
com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><div><div style=3D"font-family:times new=
 roman,new york,times,serif;font-size:12pt;color:#000000"><div>Hi Anders,<b=
r></div><div><br></div><div>Yes, please file a feature request against Babe=
ltrace on<br></div><div>the bug tracker pointing the this email thread and<=
br></div><div>describing the feature.<br></div><div><br></div><div>Thanks!<=
br></div><div><br></div><div>Mathieu<br></div><div><br></div><div><br></div=
><hr><blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;pad=
ding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decorati=
on:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><b>From: </b=
>&quot;Anders Wallin&quot; &lt;<a href=3D"mailto:wallinux@gmail.com" target=
=3D"_blank">wallinux@gmail.com</a>&gt;<br><b>To: </b>&quot;Mathieu Desnoyer=
s&quot; &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_bl=
ank">mathieu.desnoyers@efficios.com</a>&gt;<br><b>Cc: </b><a href=3D"mailto=
:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>=
<br><b>Sent: </b>Monday, November 17, 2014 10:45:37 AM<br><b>Subject: </b>R=
e: [lttng-dev] snapshot data corrupted after the output buffer is filled<di=
v><div class=3D"h5"><br><div><br></div><div dir=3D"ltr">Thx Mathieu,<div><b=
r></div><div>if I&#39;m running my test on one cpu (taskset -c 1 ./test.run=
) it works as expected and described by you.</div><div>The babeltrace flag =
would be a good solution! Do you want me to file a bug/enhancement on this?=
=C2=A0</div><div><br></div><div>Regards</div><div><br></div><div><br></div>=
</div><div class=3D"gmail_extra"><br clear=3D"all"><div><div>Anders Wallin<=
/div></div>
<br><div class=3D"gmail_quote">On Sat, Nov 15, 2014 at 6:59 PM, Mathieu Des=
noyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.c=
om" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><div><div style=3D"font-family:times new =
roman,new york,times,serif;font-size:12pt;color:#000000"><hr><blockquote st=
yle=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color=
:#000;font-weight:normal;font-style:normal;text-decoration:none;font-family=
:Helvetica,Arial,sans-serif;font-size:12pt"><b>From: </b>&quot;Anders Walli=
n&quot; &lt;<a href=3D"mailto:wallinux@gmail.com" target=3D"_blank">wallinu=
x@gmail.com</a>&gt;<br><b>To: </b><a href=3D"mailto:lttng-dev@lists.lttng.o=
rg" target=3D"_blank">lttng-dev@lists.lttng.org</a><br><b>Sent: </b>Friday,=
 November 14, 2014 8:28:18 AM<br><b>Subject: </b>[lttng-dev] snapshot data =
corrupted after the output buffer is=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0filled<span><br><div><br></div><div dir=3D"ltr"><div>Hi,</div><div=
><br></div><div>it looks like snapshot events became faulty after the outpu=
t max size is reached.</div><div>The next snapshot get mixed events from di=
fferent buffers. I have tested it on 2.3, 2.4 and 2.5</div><div>and it&#39;=
s in all of them, but it hits earlier in 2.5 due to the =C2=A0problem repor=
ted in</div><div><a href=3D"http://lists.lttng.org/pipermail/lttng-dev/2014=
-November/023773.html" target=3D"_blank">http://lists.lttng.org/pipermail/l=
ttng-dev/2014-November/023773.html</a><br></div><div><br></div><div>There s=
hould never be more then 2 HUNKS in a diff between 2 consecutive snapshots,=
 here I got=C2=A0</div><div>11 as the worst case.</div></div></span></block=
quote><div>Hi Anders,<br></div><div><br></div><div>This is not a bug, rathe=
r just per-cpu buffering at work.It does have some<br></div><div>rather non=
-obvious consequences in terms of snapshot event flow.<br></div><div><br></=
div><div>To understand this, we need to keep in mind that LTTng does everyt=
hing<br></div><div>in per-cpu buffers, and that overwrite of oldest events =
in buffer full conditions<br></div><div>happens per-cpu.<br></div><div><br>=
</div><div>The use-case you show below really makes sense when you start to=
 consider<br></div><div>on which CPU (and thus per-cpu buffer) the applicat=
ion is running. Initially,<br></div><div>the first app runs on CPU 6. As lo=
ng as the following applications run on<br></div><div>other cpus, we keep t=
he same first event. Then when enough events are<br></div><div>written in c=
pu 6 buffer to overwrite the first event, we see a first event change.<br><=
/div><div>Then, depending on the scheduling of applications, older parts of=
 per-cpu<br></div><div>buffers are overwritten, and others are not (if ther=
e are less events in those<br></div><div>buffer). This means some per-cpu b=
uffers will have events going further back<br></div><div>in time compared t=
o other higher-throughput CPUs.<br></div><div><br></div><div>This is why yo=
u see more than 2 hunks in your diff. Babeltrace merges those<br></div><div=
>per-cpu buffers back into a single text output, and the fact that some eve=
nts<br></div><div>have been overwritten for a time-range for high-throughpu=
t buffers, but not<br></div><div>for low-throughput buffers, make it appear=
 as if events are missing in the<br></div><div>stream if your model is a si=
ngle system-wide buffer, but the missing events<br></div><div>make sense if=
 you see it as a merge of per-cpu buffers.<br></div><div><br></div><div>Our=
 current behavior is to gather all available data when taking a snapshot,<b=
r></div><div>and babeltrace behavior is to show all events available in the=
 streams. We<br></div><div>could perhaps consider a different babeltrace be=
havior (a flag) that would<br></div><div>allow it to only show the events f=
or the intersection of time range of all<br></div><div>streams, based on th=
e packet header timestamp begin/end. This would<br></div><div>take care of =
hiding events that happen in low-throughput streams when<br></div><div>ther=
e is no intersection with snapshotted high-throughput streams.<br></div><di=
v><br></div><div>And perhaps this should be the default ?<br></div><div><br=
></div><div>Thanks!<br></div><div><br></div><div>Mathieu<br></div><div><br>=
</div><blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;pa=
dding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decorat=
ion:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div><div><=
div dir=3D"ltr"><div><br></div><div>TESTCASE;</div><div><br></div><div>trac=
etest code:</div><div>-----------------------------------------------------=
----------</div><div>#include &lt;stdio.h&gt;</div><div>#include &quot;trac=
etest-tp.h&quot;</div><div><br></div><div>int main(int argc, char* argv[])<=
/div><div>{</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; 1000; i++) {</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tracepoint(tracetest, first_t=
p, i, &quot;test&quot;);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;</div><div>}</div><div>---------------=
------------------------------------------------</div><div><br></div><div>t=
est script:</div><div>-----------------------------------------------------=
----------</div><div>#!/bin/bash=C2=A0</div><div>: ${NO_OF_SUBBUF:=3D6}</di=
v><div>: ${SUBBUF_SIZE:=3D4096}</div><div>: ${KERNEL_TRACE:=3DNO}</div><div=
>: ${LOOPS:=3D10}</div><div><br></div><div>SESSION=3Dtest</div><div>CHANNEL=
1=3Dch1</div><div>CHANNEL2=3Dch2</div><div><br></div><div>CH2_SUBBUF_SIZE=
=3D$(($SUBBUF_SIZE*$NO_OF_SUBBUF))</div><div><br></div><div><br></div><div>=
LTTNG=3D&#39;lttng -n&#39;</div><div>killall lttng-consumerd &gt; /dev/null=
 2&gt;&amp;1</div><div>killall lttng-sessiond &gt; /dev/null 2&gt;&amp;1</d=
iv><div>if [ -z $DEBUG ]; then</div><div>=C2=A0 =C2=A0 lttng-sessiond --no-=
kernel -d</div><div>else</div><div>=C2=A0 =C2=A0 lttng-sessiond -v --no-ker=
nel --verbose-consumer -b</div><div>fi</div><div>sleep 1</div><div><br></di=
v><div>if [ ! -z $DEBUG ]; then</div><div>=C2=A0 =C2=A0 export LTTNG_UST_DE=
BUG=3D1</div><div>fi</div><div><br></div><div>rm -rf $HOME/lttng-traces</di=
v><div>rm snapshot/*.bt</div><div><br></div><div>$LTTNG --version</div><div=
><br></div><div>$LTTNG create $SESSION --snapshot</div><div>$LTTNG enable-c=
hannel -u --subbuf-size $SUBBUF_SIZE --num-subbuf $NO_OF_SUBBUF --overwrite=
 $CHANNEL1</div><div>$LTTNG enable-channel -u --subbuf-size $CH2_SUBBUF_SIZ=
E --num-subbuf 2 --overwrite $CHANNEL2</div><div>$LTTNG enable-event -u -c =
$CHANNEL1 &quot;*&quot;</div><div>$LTTNG start</div><div>$LTTNG list $SESSI=
ON</div><div><br></div><div>mkdir -p snapshot/</div><div><br></div><div>h=
=3D1</div><div>for i in $(seq 1 $LOOPS); do</div><div>=C2=A0 =C2=A0 $APP</d=
iv><div>=C2=A0 =C2=A0 $LTTNG snapshot record</div><div>=C2=A0 =C2=A0 # prin=
t no of events and first and last event =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</div><div>=C2=A0 =C2=
=A0 last=3D$(ls -1drt $HOME/lttng-traces/$SESSION*/* | tail -1)</div><div>=
=C2=A0 =C2=A0 babeltrace $last &gt; snapshot/$<a href=3D"http://i.bt" targe=
t=3D"_blank">i.bt</a><br></div><div>=C2=A0 =C2=A0 cat snapshot/$<a href=3D"=
http://i.bt" target=3D"_blank">i.bt</a> | wc -l</div><div>=C2=A0 =C2=A0 cat=
 snapshot/$<a href=3D"http://i.bt" target=3D"_blank">i.bt</a> | head -1</di=
v><div>=C2=A0 =C2=A0 cat snapshot/$<a href=3D"http://i.bt" target=3D"_blank=
">i.bt</a> | tail -1</div><div>=C2=A0 =C2=A0 diff -u snapshot/$<a href=3D"h=
ttp://i.bt" target=3D"_blank">i.bt</a> snapshot/$<a href=3D"http://h.bt" ta=
rget=3D"_blank">h.bt</a> &gt; snapshot/$i_$h.diff</div><div>=C2=A0 =C2=A0 c=
at snapshot/$i_$h.diff | grep &quot;@@&quot; | wc -l | xargs echo &quot;NUM=
BER OF DIFF HUNKS =3D &quot;</div><div>=C2=A0 =C2=A0 h=3D$i</div><div>done<=
/div><div><br></div><div><div><div>$LTTNG stop</div><div>$LTTNG destroy $SE=
SSION</div><div><br></div><div>--------------------------------------------=
-------------------</div><div><br></div><div>result from run (removed some =
output lines for readability)</div><div>-----------------------------------=
----------------------------</div><div>lttng (LTTng Trace Control) 2.4.2 - =
=C3=89poque Opaque</div><div>Snapshot mode set. Every channel enabled for t=
hat session will be set in overwrite mode and mmap output.</div><div>Warnin=
g: The number of subbuffers (6) is rounded to the next power of 2 (8)</div>=
<div>UST channel ch1 enabled for session test</div><div>Warning: The subbuf=
 size (24576) is rounded to the next power of 2 (32768)</div><div>UST chann=
el ch2 enabled for session test</div><div>UST event * created in channel ch=
1</div><div>Tracing started for session test</div><div>Tracing session test=
: [active snapshot]</div><div>=C2=A0 =C2=A0 Trace path:=C2=A0</div><div><br=
></div><div>=3D=3D=3D Domain: UST global =3D=3D=3D</div><div><br></div><div=
>Buffer type: per UID</div><div><br></div><div>Channels:</div><div>--------=
-----</div><div>- ch1: [enabled]</div><div><br></div><div>=C2=A0 =C2=A0 Att=
ributes:</div><div>=C2=A0 =C2=A0 =C2=A0 overwrite mode: 1</div><div>=C2=A0 =
=C2=A0 =C2=A0 subbufers size: 4096</div><div>=C2=A0 =C2=A0 =C2=A0 number of=
 subbufers: 8</div><div>=C2=A0 =C2=A0 =C2=A0 switch timer interval: 0</div>=
<div>=C2=A0 =C2=A0 =C2=A0 read timer interval: 0</div><div>=C2=A0 =C2=A0 =
=C2=A0 output: mmap()</div><div><br></div><div>=C2=A0 =C2=A0 Events:</div><=
div>=C2=A0 =C2=A0 =C2=A0 * (type: tracepoint) [enabled]</div><div>- ch2: [e=
nabled]</div><div><br></div><div>=C2=A0 =C2=A0 Attributes:</div><div>=C2=A0=
 =C2=A0 =C2=A0 overwrite mode: 1</div><div>=C2=A0 =C2=A0 =C2=A0 subbufers s=
ize: 32768</div><div>=C2=A0 =C2=A0 =C2=A0 number of subbufers: 2</div><div>=
=C2=A0 =C2=A0 =C2=A0 switch timer interval: 0</div><div>=C2=A0 =C2=A0 =C2=
=A0 read timer interval: 0</div><div>=C2=A0 =C2=A0 =C2=A0 output: mmap()</d=
iv><div><br></div><div>=C2=A0 =C2=A0 Events:</div><div>=C2=A0 =C2=A0 =C2=A0=
 None</div><div><br></div><div>Snapshot recorded successfully for session t=
est</div><div>1011</div><div>[07:09:43.278933559] (+?.?????????) 07f8cf84a3=
8f ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000=
, sopath =3D &quot;[vdso]&quot;, size =3D 0, mtime =3D -1 }</div><div>[07:0=
9:43.279975100] (+0.000000975) 07f8cf84a38f tracetest:first_tp: { cpu_id =
=3D 5 }, { my_string_field =3D &quot;test&quot;, my_integer_field =3D 999 }=
</div><div>NUMBER OF DIFF HUNKS =3D =C2=A00</div><div>Snapshot recorded suc=
cessfully for session test</div><div>2022</div><div>[07:09:43.278933559] (+=
?.?????????) 07f8cf84a38f ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { b=
addr =3D 0x7FFF645EE000, sopath =3D &quot;[vdso]&quot;, size =3D 0, mtime =
=3D -1 }</div><div>[07:09:43.337703508] (+0.000001238) 07f8cf84a38f tracete=
st:first_tp: { cpu_id =3D 4 }, { my_string_field =3D &quot;test&quot;, my_i=
nteger_field =3D 999 }</div><div>NUMBER OF DIFF HUNKS =3D =C2=A01</div><div=
>Snapshot recorded successfully for session test</div><div>3033</div><div>[=
07:09:43.278933559] (+?.?????????) 07f8cf84a38f ust_baddr_statedump:soinfo:=
 { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000, sopath =3D &quot;[vdso]&quot=
;, size =3D 0, mtime =3D -1 }</div><div>[07:09:43.432827051] (+0.000000308)=
 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 6 }, { my_string_field =3D &=
quot;test&quot;, my_integer_field =3D 999 }</div><div>NUMBER OF DIFF HUNKS =
=3D =C2=A01</div><div>Snapshot recorded successfully for session test</div>=
<div>4044</div><div>[07:09:43.278933559] (+?.?????????) 07f8cf84a38f ust_ba=
ddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000, sopath =
=3D &quot;[vdso]&quot;, size =3D 0, mtime =3D -1 }</div><div>[07:09:43.4757=
84825] (+0.000000501) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 5 }, { =
my_string_field =3D &quot;test&quot;, my_integer_field =3D 999 }</div><div>=
NUMBER OF DIFF HUNKS =3D =C2=A01</div><div>Snapshot recorded successfully f=
or session test</div><div>4735</div><div>[07:09:43.279031320] (+?.?????????=
) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 5 }, { my_string_field =3D =
&quot;test&quot;, my_integer_field =3D 0 }</div><div>[07:09:43.549945106] (=
+0.000000517) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 6 }, { my_strin=
g_field =3D &quot;test&quot;, my_integer_field =3D 999 }</div><div>NUMBER O=
F DIFF HUNKS =3D =C2=A012</div><div>Snapshot recorded successfully for sess=
ion test</div><div>4437</div><div>[07:09:43.335916076] (+?.?????????) 07f8c=
f84a38f ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1=
FE000, sopath =3D &quot;[vdso]&quot;, size =3D 0, mtime =3D -1 }</div><div>=
[07:09:43.654229030] (+0.000000436) 07f8cf84a38f tracetest:first_tp: { cpu_=
id =3D 5 }, { my_string_field =3D &quot;test&quot;, my_integer_field =3D 99=
9 }</div><div>NUMBER OF DIFF HUNKS =3D =C2=A03</div><div>Snapshot recorded =
successfully for session test</div><div>4746</div><div>[07:09:43.335916076]=
 (+?.?????????) 07f8cf84a38f ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, =
{ baddr =3D 0x7FFFAD1FE000, sopath =3D &quot;[vdso]&quot;, size =3D 0, mtim=
e =3D -1 }</div><div>[07:09:43.747509349] (+0.000000502) 07f8cf84a38f trace=
test:first_tp: { cpu_id =3D 6 }, { my_string_field =3D &quot;test&quot;, my=
_integer_field =3D 999 }</div><div>NUMBER OF DIFF HUNKS =3D =C2=A011</div><=
div>Snapshot recorded successfully for session test</div><div>5757</div><di=
v>[07:09:43.335916076] (+?.?????????) 07f8cf84a38f ust_baddr_statedump:soin=
fo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000, sopath =3D &quot;[vdso]&q=
uot;, size =3D 0, mtime =3D -1 }</div><div>[07:09:43.814938128] (+0.0000013=
71) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 4 }, { my_string_field =
=3D &quot;test&quot;, my_integer_field =3D 999 }</div><div>NUMBER OF DIFF H=
UNKS =3D =C2=A01</div><div>Snapshot recorded successfully for session test<=
/div><div>6066</div><div>[07:09:43.335916076] (+?.?????????) 07f8cf84a38f u=
st_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000, so=
path =3D &quot;[vdso]&quot;, size =3D 0, mtime =3D -1 }</div><div>[07:09:43=
.919112586] (+0.000000990) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 6 =
}, { my_string_field =3D &quot;test&quot;, my_integer_field =3D 999 }</div>=
<div>NUMBER OF DIFF HUNKS =3D =C2=A011</div><div>Snapshot recorded successf=
ully for session test</div><div>6077</div><div>[07:09:43.335916076] (+?.???=
??????) 07f8cf84a38f ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =
=3D 0x7FFFAD1FE000, sopath =3D &quot;[vdso]&quot;, size =3D 0, mtime =3D -1=
 }</div><div>[07:09:44.004234933] (+0.000001213) 07f8cf84a38f tracetest:fir=
st_tp: { cpu_id =3D 6 }, { my_string_field =3D &quot;test&quot;, my_integer=
_field =3D 999 }</div><div>NUMBER OF DIFF HUNKS =3D =C2=A02</div><div>Waiti=
ng for data availability</div><div>Tracing stopped for session test</div><d=
iv>Session test destroyed</div><div>---------------------------------------=
------------------------</div><div><br></div><div>Regards</div><div><br></d=
iv><div>Anders Wallin</div></div></div></div><br></div></div><span>________=
_______________________________________<br>lttng-dev mailing list<br><a hre=
f=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lt=
tng.org</a><br><a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo=
/lttng-dev</a><br></span></blockquote><span><span style=3D"color:#888888" c=
olor=3D"#888888"><div><br><div><br></div></div><div><br></div><div>-- <br><=
/div><div><span></span>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"htt=
p://www.efficios.com" target=3D"_blank">http://www.efficios.com</a><span></=
span><br></div></span></span></div></div></blockquote></div><br></div>
</div></div></blockquote><div><div class=3D"h5"><div><br><br></div><div><br=
></div><div>-- <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br>=
EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http=
://www.efficios.com</a><span name=3D"x"></span><br></div></div></div></div>=
</div></blockquote></div><br></div>

--001a11c2ebf2977402050833b800--


--===============0071348347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0071348347==--
