From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: snapshot data corrupted after the output buffer is
 filled
Date: Fri, 14 Nov 2014 14:59:57 -0500
Message-ID: <54665F3D.90707__29055.3753999577$1415995255$gmane$org@efficios.com>
References: <CAF2baFfMNzRQnx-FC7kFRr5m4NpZBEcEohnwf50uOs2vv9=GBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([85.12.144.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1XpN2J-0006Js-MS
 for lttng-dev@lists.lttng.org; Fri, 14 Nov 2014 15:00:08 -0500
In-Reply-To: <CAF2baFfMNzRQnx-FC7kFRr5m4NpZBEcEohnwf50uOs2vv9=GBw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anders Wallin <wallinux@gmail.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

That's indeed really bad, would you mind filling a bug report on
https://bugs.lttng.org/projects/lttng-tools so we can keep track of this
issue ?

Thanks,

Julien

On 14-11-14 02:28 AM, Anders Wallin wrote:
> Hi,
> =

> it looks like snapshot events became faulty after the output max size is
> reached.
> The next snapshot get mixed events from different buffers. I have tested
> it on 2.3, 2.4 and 2.5
> and it's in all of them, but it hits earlier in 2.5 due to the  problem
> reported in
> http://lists.lttng.org/pipermail/lttng-dev/2014-November/023773.html
> =

> There should never be more then 2 HUNKS in a diff between 2 consecutive
> snapshots, here I got =

> 11 as the worst case.
> =

> TESTCASE;
> =

> tracetest code:
> ---------------------------------------------------------------
> #include <stdio.h>
> #include "tracetest-tp.h"
> =

> int main(int argc, char* argv[])
> {
>         int i;
>         for (i =3D 0; i < 1000; i++) {
>                 tracepoint(tracetest, first_tp, i, "test");
>         }
>         return 0;
> }
> ---------------------------------------------------------------
> =

> test script:
> ---------------------------------------------------------------
> #!/bin/bash =

> : ${NO_OF_SUBBUF:=3D6}
> : ${SUBBUF_SIZE:=3D4096}
> : ${KERNEL_TRACE:=3DNO}
> : ${LOOPS:=3D10}
> =

> SESSION=3Dtest
> CHANNEL1=3Dch1
> CHANNEL2=3Dch2
> =

> CH2_SUBBUF_SIZE=3D$(($SUBBUF_SIZE*$NO_OF_SUBBUF))
> =

> =

> LTTNG=3D'lttng -n'
> killall lttng-consumerd > /dev/null 2>&1
> killall lttng-sessiond > /dev/null 2>&1
> if [ -z $DEBUG ]; then
>     lttng-sessiond --no-kernel -d
> else
>     lttng-sessiond -v --no-kernel --verbose-consumer -b
> fi
> sleep 1
> =

> if [ ! -z $DEBUG ]; then
>     export LTTNG_UST_DEBUG=3D1
> fi
> =

> rm -rf $HOME/lttng-traces
> rm snapshot/*.bt
> =

> $LTTNG --version
> =

> $LTTNG create $SESSION --snapshot
> $LTTNG enable-channel -u --subbuf-size $SUBBUF_SIZE --num-subbuf
> $NO_OF_SUBBUF --overwrite $CHANNEL1
> $LTTNG enable-channel -u --subbuf-size $CH2_SUBBUF_SIZE --num-subbuf 2
> --overwrite $CHANNEL2
> $LTTNG enable-event -u -c $CHANNEL1 "*"
> $LTTNG start
> $LTTNG list $SESSION
> =

> mkdir -p snapshot/
> =

> h=3D1
> for i in $(seq 1 $LOOPS); do
>     $APP
>     $LTTNG snapshot record
>     # print no of events and first and last event                      =

>                                                                        =

>                                    =

>     last=3D$(ls -1drt $HOME/lttng-traces/$SESSION*/* | tail -1)
>     babeltrace $last > snapshot/$i.bt <http://i.bt>
>     cat snapshot/$i.bt <http://i.bt> | wc -l
>     cat snapshot/$i.bt <http://i.bt> | head -1
>     cat snapshot/$i.bt <http://i.bt> | tail -1
>     diff -u snapshot/$i.bt <http://i.bt> snapshot/$h.bt <http://h.bt> >
> snapshot/$i_$h.diff
>     cat snapshot/$i_$h.diff | grep "@@" | wc -l | xargs echo "NUMBER OF
> DIFF HUNKS =3D "
>     h=3D$i
> done
> =

> $LTTNG stop
> $LTTNG destroy $SESSION
> =

> ---------------------------------------------------------------
> =

> result from run (removed some output lines for readability)
> ---------------------------------------------------------------
> lttng (LTTng Trace Control) 2.4.2 - =C9poque Opaque
> Snapshot mode set. Every channel enabled for that session will be set in
> overwrite mode and mmap output.
> Warning: The number of subbuffers (6) is rounded to the next power of 2 (=
8)
> UST channel ch1 enabled for session test
> Warning: The subbuf size (24576) is rounded to the next power of 2 (32768)
> UST channel ch2 enabled for session test
> UST event * created in channel ch1
> Tracing started for session test
> Tracing session test: [active snapshot]
>     Trace path: =

> =

> =3D=3D=3D Domain: UST global =3D=3D=3D
> =

> Buffer type: per UID
> =

> Channels:
> -------------
> - ch1: [enabled]
> =

>     Attributes:
>       overwrite mode: 1
>       subbufers size: 4096
>       number of subbufers: 8
>       switch timer interval: 0
>       read timer interval: 0
>       output: mmap()
> =

>     Events:
>       * (type: tracepoint) [enabled]
> - ch2: [enabled]
> =

>     Attributes:
>       overwrite mode: 1
>       subbufers size: 32768
>       number of subbufers: 2
>       switch timer interval: 0
>       read timer interval: 0
>       output: mmap()
> =

>     Events:
>       None
> =

> Snapshot recorded successfully for session test
> 1011
> [07:09:43.278933559] (+?.?????????) 07f8cf84a38f
> ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000,
> sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
> [07:09:43.279975100] (+0.000000975) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> NUMBER OF DIFF HUNKS =3D  0
> Snapshot recorded successfully for session test
> 2022
> [07:09:43.278933559] (+?.?????????) 07f8cf84a38f
> ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000,
> sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
> [07:09:43.337703508] (+0.000001238) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> NUMBER OF DIFF HUNKS =3D  1
> Snapshot recorded successfully for session test
> 3033
> [07:09:43.278933559] (+?.?????????) 07f8cf84a38f
> ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000,
> sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
> [07:09:43.432827051] (+0.000000308) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> NUMBER OF DIFF HUNKS =3D  1
> Snapshot recorded successfully for session test
> 4044
> [07:09:43.278933559] (+?.?????????) 07f8cf84a38f
> ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000,
> sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
> [07:09:43.475784825] (+0.000000501) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> NUMBER OF DIFF HUNKS =3D  1
> Snapshot recorded successfully for session test
> 4735
> [07:09:43.279031320] (+?.?????????) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 0 }
> [07:09:43.549945106] (+0.000000517) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> NUMBER OF DIFF HUNKS =3D  12
> Snapshot recorded successfully for session test
> 4437
> [07:09:43.335916076] (+?.?????????) 07f8cf84a38f
> ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000,
> sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
> [07:09:43.654229030] (+0.000000436) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> NUMBER OF DIFF HUNKS =3D  3
> Snapshot recorded successfully for session test
> 4746
> [07:09:43.335916076] (+?.?????????) 07f8cf84a38f
> ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000,
> sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
> [07:09:43.747509349] (+0.000000502) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> NUMBER OF DIFF HUNKS =3D  11
> Snapshot recorded successfully for session test
> 5757
> [07:09:43.335916076] (+?.?????????) 07f8cf84a38f
> ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000,
> sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
> [07:09:43.814938128] (+0.000001371) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> NUMBER OF DIFF HUNKS =3D  1
> Snapshot recorded successfully for session test
> 6066
> [07:09:43.335916076] (+?.?????????) 07f8cf84a38f
> ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000,
> sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
> [07:09:43.919112586] (+0.000000990) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> NUMBER OF DIFF HUNKS =3D  11
> Snapshot recorded successfully for session test
> 6077
> [07:09:43.335916076] (+?.?????????) 07f8cf84a38f
> ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000,
> sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
> [07:09:44.004234933] (+0.000001213) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> NUMBER OF DIFF HUNKS =3D  2
> Waiting for data availability
> Tracing stopped for session test
> Session test destroyed
> ---------------------------------------------------------------
> =

> Regards
> =

> Anders Wallin
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =
