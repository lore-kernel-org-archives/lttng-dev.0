From: Anders Wallin <wallinux@gmail.com>
Subject: Re: snapshot issue with 2.5
Date: Thu, 13 Nov 2014 18:41:58 +0100
Message-ID: <CAF2baFfY-DYF4ZuiUPvdbNNqTwzh3-ujqecS5omraPhSSP=GLw__29983.2865516239$1415900588$gmane$org@mail.gmail.com>
References: <CAF2baFd5vRuGKa7MVpqHvkCHia5fDN19cvq8qdedqJreNU6-vQ@mail.gmail.com>
 <CA+jJMxvXfVT8w+hokMyFgTSqN=JH3nQUudJR+8MUJtQmTEgZZQ@mail.gmail.com>
 <5463E904.9080102@efficios.com>
 <CAF2baFesZ0Ke5qcWt9eGzWTyPuyAW_PM=ZZ+g9baEUNRwK5cGA@mail.gmail.com>
 <CAF2baFcKwwciQDr+Wdpcs3_EJV969_aPUA_UtPXGo7=CMxWKvw@mail.gmail.com>
 <CAF2baFfvY6NRNzNc3tkJygc=01ntwf-qa3GgXG_rT+fSw6E2MA@mail.gmail.com>
 <5464E028.10709@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1007803062=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <wallinux@gmail.com>) id 1XoyPE-0006hL-Iz
 for lttng-dev@lists.lttng.org; Thu, 13 Nov 2014 12:42:09 -0500
Received: by mail-wi0-f170.google.com with SMTP id r20so2672010wiv.3
 for <lttng-dev@lists.lttng.org>; Thu, 13 Nov 2014 09:41:58 -0800 (PST)
In-Reply-To: <5464E028.10709@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1007803062==
Content-Type: multipart/alternative; boundary=f46d04426bbc711c440507c10710

--f46d04426bbc711c440507c10710
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

No, I get the same problem with or w/o setting the size

Anders Wallin

On Thu, Nov 13, 2014 at 5:45 PM, Julien Desfossez <jdesfossez@efficios.com>
wrote:

> Ok, so if you don't limit the size of the snapshot (remove the -m 1G) it
> works as expected ?
>
> Julien
>
> On 14-11-13 10:33 AM, Anders Wallin wrote:
> > bug is introduced in  68808f4e0bbb3adccff72ff9dab6ec9f3a9e6866
> >
> > Regards
> >
> > Anders
> >
> > Anders Wallin
> >
> > On Thu, Nov 13, 2014 at 10:39 AM, Anders Wallin <wallinux@gmail.com
> > <mailto:wallinux@gmail.com>> wrote:
> >
> >
> >
> >     Anders Wallin
> >
> >     On Thu, Nov 13, 2014 at 8:43 AM, Anders Wallin <wallinux@gmail.com
> >     <mailto:wallinux@gmail.com>> wrote:
> >
> >         On Thu, Nov 13, 2014 at 12:11 AM, Julien Desfossez
> >         <jdesfossez@efficios.com <mailto:jdesfossez@efficios.com>>
> wrote:
> >
> >             Hi,
> >
> >             On 14-11-12 05:30 PM, J=C3=A9r=C3=A9mie Galarneau wrote:
> >             > On Wed, Nov 12, 2014 at 7:39 AM, Anders Wallin
> >             <wallinux@gmail.com <mailto:wallinux@gmail.com>> wrote:
> >             >> Hi,
> >             >>
> >             >> using userspace snapshot mode in 2.5 seems to broken.
> >             >>
> >             >> I have small stupid application(tracetest) generating
> >             1000 events
> >             >>
> >             >> Running the script (the below is simplified version of
> >             the script)
> >             >>
> >
>  ------------------------------------------------------------------------=
----------
> >             >> #!/bin/bash
> >             >> LTTNG=3D'lttng -n'
> >             >> lttng-sessiond --no-kernel &
> >             >
> >             > You should use the "-d" flag to launch the sessiond as a
> >             daemon. Using
> >             > "&" might cause the "create" command to launch a second
> >             session daemon
> >             > since the first one would not have had the time to open
> >             create its
> >             > command sockets.
> >             >
> >             >>
> >             >> $LTTNG create test --snapshot
> >             >> $LTTNG enable-channel -u --subbuf-size 64k --num-subbuf
> >             16 --overwrite ch1
> >             >> $LTTNG enable-event -u -c ch1 "*"
> >             >> $LTTNG start
> >             >> $LTTNG list ch1
> >             >>
> >             >> mkdir -p snapshot/
> >             >>
> >             >> for i in $(seq 1 $LOOPS); do
> >             >>     ./tracetest
> >             >>     $LTTNG snapshot record -m 1G
> >             >>
> >             >>     # print no of events and first and last event
> >             >>     last=3D$(ls -1drt $HOME/lttng-traces/$SESSION*/* | t=
ail
> -1)
> >             >>     babeltrace $last > snapshot/$i.bt <http://i.bt>
> >             >>     cat snapshot/$i.bt <http://i.bt> | wc -l
> >             >>     cat snapshot/$i.bt <http://i.bt> | head -1
> >             >>     cat snapshot/$i.bt <http://i.bt> | tail -1
> >             >> done
> >             >>
> >             >> $LTTNG stop
> >             >> $LTTNG destroy $SESSION
> >             >>
> >
>  ------------------------------------------------------------------------=
----------
> >             >>
> >             >> The result of the run looks like this;
> >             >> ./test.run
> >             >> Error: consumer err socket second poll error
> >             >> Error: Health error occurred in thread_manage_consumer
> >             >> PERROR - 13:36:59.685167 [23772/23781]: bind inet:
> >             Address already in use
> >             >> (in lttcomm_bind_inet_sock() at inet.c:109)
> >             >> Warning: Another session daemon is using this JUL port.
> >             JUL support will be
> >             >> deactivated to prevent interfering with the tracing.
> >             >>
> >             >
> >             > Is there a reason why you run two session daemons? I'm
> >             guessing this
> >             > is related to my "& vs -d" comment above.
> >             >
> >             >> lttng (LTTng Trace Control) 2.5.2 - Fumisterie
> >             >> BabelTrace Trace Viewer and Converter 1.2.4
> >             >>         linux-vdso.so.1 =3D>  (0x00007fffba966000)
> >             >>         liblttng-ctl.so.0 =3D>
> >             /usr/lib/x86_64-linux-gnu/liblttng-ctl.so.0
> >             >> (0x00007fbfe4b1d000)
> >             >>         librt.so.1 =3D> /lib/x86_64-linux-gnu/librt.so.1
> >             (0x00007fbfe4915000)
> >             >>         libxml2.so.2 =3D>
> >             /usr/lib/x86_64-linux-gnu/libxml2.so.2
> >             >> (0x00007fbfe45ae000)
> >             >>         libpopt.so.0 =3D> /lib/x86_64-linux-gnu/libpopt.=
so.0
> >             >> (0x00007fbfe43a2000)
> >             >>         libpthread.so.0 =3D>
> >             /lib/x86_64-linux-gnu/libpthread.so.0
> >             >> (0x00007fbfe4184000)
> >             >>         libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6
> >             (0x00007fbfe3dbd000)
> >             >>         /lib64/ld-linux-x86-64.so.2 (0x00007fbfe4fac000)
> >             >>         liburcu.so.2 =3D>
> >             /usr/lib/x86_64-linux-gnu/liburcu.so.2
> >             >> (0x00007fbfe3bb6000)
> >             >>         libdl.so.2 =3D> /lib/x86_64-linux-gnu/libdl.so.2
> >             (0x00007fbfe39b2000)
> >             >>         libz.so.1 =3D> /lib/x86_64-linux-gnu/libz.so.1
> >             (0x00007fbfe3798000)
> >             >>         liblzma.so.5 =3D> /lib/x86_64-linux-gnu/liblzma.=
so.5
> >             >> (0x00007fbfe3576000)
> >             >>         libm.so.6 =3D> /lib/x86_64-linux-gnu/libm.so.6
> >             (0x00007fbfe3270000)
> >             >>
> >             >> Session test created.
> >             >> Default snapshot output set to:
> >             >> /home/awallin/lttng-traces/test-20141112-133700
> >             >> Snapshot mode set. Every channel enabled for that sessio=
n
> >             will be set in
> >             >> overwrite mode and mmap output.
> >             >> UST channel ch1 enabled for session test
> >             >> UST event * created in channel ch1
> >             >> Tracing started for session test
> >             >> Tracing session test: [active snapshot]
> >             >>     Trace path:
> >             >>     Live timer interval (usec): 4294967295
> >             >>
> >             >> =3D=3D=3D Domain: UST global =3D=3D=3D
> >             >>
> >             >> Channels:
> >             >> -------------
> >             >> - ch1: [enabled]
> >             >>
> >             >>     Attributes:
> >             >>       overwrite mode: 1
> >             >>       subbufers size: 4096
> >             >>       number of subbufers: 16
> >             >>       switch timer interval: 0
> >             >>       read timer interval: 0
> >             >>       trace file count: 0
> >             >>       trace file size (bytes): 0
> >             >>       output: mmap()
> >             >>
> >             >>     Events:
> >             >>       * (type: tracepoint) [enabled]
> >             >>
> >             >> Snapshot recorded successfully for session test
> >             >> 84
> >             >> [13:37:00.852615950] (+?.?????????) arn-awallin-mint-l3
> >             >> ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =
=3D
> >             0x7FFFC6BC7000, sopath
> >             >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
> >             >> [13:37:00.853798949] (+0.000000805) arn-awallin-mint-l3
> >             tracetest:first_tp:
> >             >> { cpu_id =3D 6 }, { my_string_field =3D "test",
> >             my_integer_field =3D 999 }
> >             >> Snapshot recorded successfully for session test
> >             >> 157
> >             >> [13:37:00.853735195] (+?.?????????) arn-awallin-mint-l3
> >             tracetest:first_tp:
> >             >> { cpu_id =3D 6 }, { my_string_field =3D "test",
> >             my_integer_field =3D 927 }
> >             >> [13:37:00.894839116] (+0.000000299) arn-awallin-mint-l3
> >             tracetest:first_tp:
> >             >> { cpu_id =3D 5 }, { my_string_field =3D "test",
> >             my_integer_field =3D 999 }
> >             >> Snapshot recorded successfully for session test
> >             >> 168
> >             >> [13:37:00.853735195] (+?.?????????) arn-awallin-mint-l3
> >             tracetest:first_tp:
> >             >> { cpu_id =3D 6 }, { my_string_field =3D "test",
> >             my_integer_field =3D 927 }
> >             >> [13:37:00.929447330] (+0.000000305) arn-awallin-mint-l3
> >             tracetest:first_tp:
> >             >> { cpu_id =3D 5 }, { my_string_field =3D "test",
> >             my_integer_field =3D 999 }
> >             >> Snapshot recorded successfully for session test
> >
> >             Something is wrong from here:
> >             >> 168
> >             >> [13:37:00.894411117] (+?.?????????) arn-awallin-mint-l3
> >             >> ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =
=3D
> 0x7FFF6BF81000, sopath
> >             >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
> >             >> [13:37:00.972035546] (+0.000000597) arn-awallin-mint-l3
> tracetest:first_tp:
> >             >> { cpu_id =3D 6 }, { my_string_field =3D "test",
> my_integer_field =3D 999 }
> >             >> Snapshot recorded successfully for session test
> >             >> 168
> >             >> [13:37:00.894411117] (+?.?????????) arn-awallin-mint-l3
> >             >> ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =
=3D
> 0x7FFF6BF81000, sopath
> >             >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
> >             >> [13:37:01.014060940 <tel:014060940>] (+0.000000341)
> >             arn-awallin-mint-l3 tracetest:first_tp:
> >             >> { cpu_id =3D 7 }, { my_string_field =3D "test",
> my_integer_field =3D 999 }
> >             >> Snapshot recorded successfully for session test
> >             >> 168
> >             >> [13:37:00.894411117] (+?.?????????) arn-awallin-mint-l3
> >             >> ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =
=3D
> 0x7FFF6BF81000, sopath
> >             >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
> >             >> [13:37:01.052555877 <tel:052555877>] (+0.000000872)
> >             arn-awallin-mint-l3 tracetest:first_tp:
> >             >> { cpu_id =3D 6 }, { my_string_field =3D "test",
> my_integer_field =3D 999 }
> >             ... to here.
> >
> >             The beginning timestamp is the same, the number of events i=
s
> >             the same,
> >             but the end timestamp moves. We see also this pattern below=
.
> >             I would be really interested to see the whole snapshots whe=
n
> >             it happens.
> >             It seems like we are not be overwriting the beginning of th=
e
> >             ring buffer
> >             in some conditions. Could you send us your tracetest progra=
m
> >             and the
> >             script so we can try to reproduce the problem ?
> >
> >
> >         I will append it including a run with debug turned on and all
> >         the snapshot files created
> >
> >
> >
> >             >> Snapshot recorded successfully for session test
> >             >> 168
> >             >> [13:37:01.014035993 <tel:014035993>] (+?.?????????)
> >             arn-awallin-mint-l3 tracetest:first_tp:
> >             >> { cpu_id =3D 7 }, { my_string_field =3D "test",
> >             my_integer_field =3D 927 }
> >             >> [13:37:01.098620808] (+0.000001404) arn-awallin-mint-l3
> >             tracetest:first_tp:
> >             >> { cpu_id =3D 4 }, { my_string_field =3D "test",
> >             my_integer_field =3D 999 }
> >             >> Snapshot recorded successfully for session test
> >             >> 168
> >             >> [13:37:01.097087388 <tel:097087388>] (+?.?????????)
> >             arn-awallin-mint-l3
> >             >> ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =
=3D
> >             0x7FFF4BFFE000, sopath
> >             >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
> >             >> [13:37:01.129839830] (+0.000000533) arn-awallin-mint-l3
> >             tracetest:first_tp:
> >             >> { cpu_id =3D 7 }, { my_string_field =3D "test",
> >             my_integer_field =3D 999 }
> >             >> Snapshot recorded successfully for session test
> >             >> 168
> >             >> [13:37:01.097087388 <tel:097087388>] (+?.?????????)
> >             arn-awallin-mint-l3
> >             >> ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =
=3D
> >             0x7FFF4BFFE000, sopath
> >             >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
> >             >> [13:37:01.129839830] (+0.000000533) arn-awallin-mint-l3
> >             tracetest:first_tp:
> >             >> { cpu_id =3D 7 }, { my_string_field =3D "test",
> >             my_integer_field =3D 999 }
> >             >> Snapshot recorded successfully for session test
> >             >> 168
> >             >> [13:37:01.097087388 <tel:097087388>] (+?.?????????)
> >             arn-awallin-mint-l3
> >             >> ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =
=3D
> >             0x7FFF4BFFE000, sopath
> >             >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
> >             >> [13:37:01.172829105] (+0.000000575) arn-awallin-mint-l3
> >             tracetest:first_tp:
> >             >> { cpu_id =3D 5 }, { my_string_field =3D "test",
> >             my_integer_field =3D 999 }
> >             >> Snapshot recorded successfully for session test
> >             >> 168
> >             >> [13:37:01.172021557] (+?.?????????) arn-awallin-mint-l3
> >             >> ust_baddr_statedump:soinfo: { cpu_id =3D 7 }, { baddr =
=3D
> >             0x7FFF653FE000, sopath
> >             >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
> >             >> [13:37:01.220074165] (+0.000000553) arn-awallin-mint-l3
> >             tracetest:first_tp:
> >             >> { cpu_id =3D 6 }, { my_string_field =3D "test",
> >             my_integer_field =3D 999 }
> >             >> Waiting for data availability
> >             >> Tracing stopped for session test
> >             >> Session test destroyed
> >             >>
> >             >> the result from the run on older versions of lttng
> >             creates bigger and bigger
> >             >> event traces until reaching max size.
> >             We see this pattern here and the max size seems to be 168
> >             events, was it
> >             similar in your previous tests ?
> >
> >         If I'm running the same test on 2.4 or 2.3 the max number of
> >         events is much bigger, like ~10000
> >         (I don't have the exact number right now, I will rebuild and ru=
n
> >         the test again and get back
> >         with traces from that run)
> >
> >     For 2.4.2 the log looks like this:
> >     ./test.run ./tracetest
> >
> >     lttng (LTTng Trace Control) 2.4.2 - =C3=89poque Opaque
> >     BabelTrace Trace Viewer and Converter 1.2.1
> >     linux-vdso.so.1 =3D>  (0x00007fff775fe000)
> >     liblttng-ctl.so.0 =3D> /usr/local/lib/liblttng-ctl.so.0
> >     (0x00002b2b016e4000)
> >     libpopt.so.0 =3D> /lib/x86_64-linux-gnu/libpopt.so.0
> (0x00002b2b0190f000)
> >     libpthread.so.0 =3D> /lib/x86_64-linux-gnu/libpthread.so.0
> >     (0x00002b2b01b1b000)
> >     libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6 (0x00002b2b01d39000)
> >     librt.so.1 =3D> /lib/x86_64-linux-gnu/librt.so.1 (0x00002b2b020ff00=
0)
> >     liburcu.so.3 =3D> /usr/local/lib/liburcu.so.3 (0x00002b2b02307000)
> >     /lib64/ld-linux-x86-64.so.2 (0x00002b2b014bf000)
> >
> >     Session test created.
> >     Default snapshot output set to: //lttng-traces/test-20141113-093611
> >     Snapshot mode set. Every channel enabled for that session will be
> >     set in overwrite mode and mmap output.
> >     UST channel ch1 enabled for session test
> >     UST event * created in channel ch1
> >     Tracing started for session test
> >     Tracing session test: [active snapshot]
> >         Trace path:
> >
> >     =3D=3D=3D Domain: UST global =3D=3D=3D
> >
> >     Buffer type: per UID
> >
> >     Channels:
> >     -------------
> >     - ch1: [enabled]
> >
> >         Attributes:
> >           overwrite mode: 1
> >           subbufers size: 4096
> >           number of subbufers: 16
> >           switch timer interval: 0
> >           read timer interval: 0
> >           output: mmap()
> >
> >         Events:
> >           * (type: tracepoint) [enabled]
> >
> >     Snapshot recorded successfully for session test
> >     1000
> >     [09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp=
:
> >     { cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =
=3D 0 }
> >     [09:36:11.985857254] (+0.000000501) 07f8cf84a38f tracetest:first_tp=
:
> >     { cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =
=3D 999 }
> >     Snapshot recorded successfully for session test
> >     2000
> >     [09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp=
:
> >     { cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =
=3D 0 }
> >     [09:36:12.033066130 <tel:033066130>] (+0.000001663) 07f8cf84a38f
> >     tracetest:first_tp: { cpu_id =3D 5 }, { my_string_field =3D "test",
> >     my_integer_field =3D 999 }
> >     Snapshot recorded successfully for session test
> >     3000
> >     [09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp=
:
> >     { cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =
=3D 0 }
> >     [09:36:12.086888121 <tel:086888121>] (+0.000001273) 07f8cf84a38f
> >     tracetest:first_tp: { cpu_id =3D 5 }, { my_string_field =3D "test",
> >     my_integer_field =3D 999 }
> >     Snapshot recorded successfully for session test
> >     4000
> >     [09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp=
:
> >     { cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =
=3D 0 }
> >     [09:36:12.147378251] (+0.000001257) 07f8cf84a38f tracetest:first_tp=
:
> >     { cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =
=3D 999 }
> >     Snapshot recorded successfully for session test
> >     5000
> >     [09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp=
:
> >     { cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =
=3D 0 }
> >     [09:36:12.225584696] (+0.000000528) 07f8cf84a38f tracetest:first_tp=
:
> >     { cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =
=3D 999 }
> >     Snapshot recorded successfully for session test
> >     6000
> >     [09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp=
:
> >     { cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =
=3D 0 }
> >     [09:36:12.288311172] (+0.000000571) 07f8cf84a38f tracetest:first_tp=
:
> >     { cpu_id =3D 7 }, { my_string_field =3D "test", my_integer_field =
=3D 999 }
> >     Snapshot recorded successfully for session test
> >     7000
> >     [09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp=
:
> >     { cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =
=3D 0 }
> >     [09:36:12.375789307] (+0.000001238) 07f8cf84a38f tracetest:first_tp=
:
> >     { cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =
=3D 999 }
> >     Snapshot recorded successfully for session test
> >     7000
> >     [09:36:12.032314084] (+?.?????????) 07f8cf84a38f tracetest:first_tp=
:
> >     { cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =
=3D 0 }
> >     [09:36:12.460756779] (+0.000001248) 07f8cf84a38f tracetest:first_tp=
:
> >     { cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =
=3D 999 }
> >     Snapshot recorded successfully for session test
> >     8000
> >     [09:36:12.032314084] (+?.?????????) 07f8cf84a38f tracetest:first_tp=
:
> >     { cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =
=3D 0 }
> >     [09:36:12.540464090] (+0.000001292) 07f8cf84a38f tracetest:first_tp=
:
> >     { cpu_id =3D 7 }, { my_string_field =3D "test", my_integer_field =
=3D 999 }
> >     Snapshot recorded successfully for session test
> >     9000
> >     [09:36:12.032314084] (+?.?????????) 07f8cf84a38f tracetest:first_tp=
:
> >     { cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =
=3D 0 }
> >     [09:36:12.621992931] (+0.000001298) 07f8cf84a38f tracetest:first_tp=
:
> >     { cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =
=3D 999 }
> >     Waiting for data availability
> >     Tracing stopped for session test
> >     Session test destroyed
> >
> >
> >
> >             >
> >             > Unless I'm mistaken, the behavior of the snapshot mode ha=
s
> changed
> >             > between 2.4 and 2.5.
> >             >
> >             > In the 2.4 series, consecutive snapshots could overlap;
> that is,
> >             > events could be present in multiple snapshots. As of 2.5,
> an event is
> >             > guaranteed to only appear in one snapshot as the events
> are considered
> >             > as having been "consumed" at that point.
> >
> >             Hum, no the behavior is still the same, consecutive
> >             snapshots can overlap.
> >
> >             Could you tell us on which architecture you are experiencin=
g
> >             the problem
> >             and the number of CPUs ?
> >
> >         The traces appended is from my laptop running Ubuntu 14.04 with
> >         "8" cpu's
> >         model name      : Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz
> >         I have also run this on ARM with 16 cores and a powerpc
> >
> >
> >             Thanks,
> >
> >             Julien
> >
> >
> >
> >
>

--f46d04426bbc711c440507c10710
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">No, I get the same problem with or w/o setting the size<di=
v class=3D"gmail_extra"><br clear=3D"all"><div><div class=3D"gmail_signatur=
e">Anders Wallin</div></div>
<br><div class=3D"gmail_quote">On Thu, Nov 13, 2014 at 5:45 PM, Julien Desf=
ossez <span dir=3D"ltr">&lt;<a href=3D"mailto:jdesfossez@efficios.com" targ=
et=3D"_blank">jdesfossez@efficios.com</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">Ok, so if you don&#39;t limit the size of the snapshot (=
remove the -m 1G) it<br>
works as expected ?<br>
<br>
Julien<br>
<span class=3D""><br>
On 14-11-13 10:33 AM, Anders Wallin wrote:<br>
&gt; bug is introduced in=C2=A0 68808f4e0bbb3adccff72ff9dab6ec9f3a9e6866<br=
>
&gt;<br>
&gt; Regards<br>
&gt;<br>
&gt; Anders<br>
&gt;<br>
&gt; Anders Wallin<br>
&gt;<br>
&gt; On Thu, Nov 13, 2014 at 10:39 AM, Anders Wallin &lt;<a href=3D"mailto:=
wallinux@gmail.com">wallinux@gmail.com</a><br>
</span><span class=3D"">&gt; &lt;mailto:<a href=3D"mailto:wallinux@gmail.co=
m">wallinux@gmail.com</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Anders Wallin<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On Thu, Nov 13, 2014 at 8:43 AM, Anders Wallin &lt;=
<a href=3D"mailto:wallinux@gmail.com">wallinux@gmail.com</a><br>
</span><span class=3D"">&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailt=
o:wallinux@gmail.com">wallinux@gmail.com</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0On Thu, Nov 13, 2014 at 12:11 AM, Jul=
ien Desfossez<br>
</span><span class=3D"">&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=
=3D"mailto:jdesfossez@efficios.com">jdesfossez@efficios.com</a> &lt;mailto:=
<a href=3D"mailto:jdesfossez@efficios.com">jdesfossez@efficios.com</a>&gt;&=
gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Hi,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0On 14-11-12 05:30 PM, J=
=C3=A9r=C3=A9mie Galarneau wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; On Wed, Nov 12, 20=
14 at 7:39 AM, Anders Wallin<br>
</span><div><div class=3D"h5">&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&lt;<a href=3D"mailto:wallinux@gmail.com">wallinux@gmail.com</a> &lt=
;mailto:<a href=3D"mailto:wallinux@gmail.com">wallinux@gmail.com</a>&gt;&gt=
; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; using userspac=
e snapshot mode in 2.5 seems to broken.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; I have small s=
tupid application(tracetest) generating<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01000 events<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Running the sc=
ript (the below is simplified version of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the script)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-----------------------=
-----------------------------------------------------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; #!/bin/bash<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; LTTNG=3D&#39;l=
ttng -n&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; lttng-sessiond=
 --no-kernel &amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; You should use the=
 &quot;-d&quot; flag to launch the sessiond as a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0daemon. Using<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &quot;&amp;&quot; =
might cause the &quot;create&quot; command to launch a second<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0session daemon<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; since the first on=
e would not have had the time to open<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0create its<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; command sockets.<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; $LTTNG create =
test --snapshot<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; $LTTNG enable-=
channel -u --subbuf-size 64k --num-subbuf<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A016 --overwrite ch1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; $LTTNG enable-=
event -u -c ch1 &quot;*&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; $LTTNG start<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; $LTTNG list ch=
1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; mkdir -p snaps=
hot/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; for i in $(seq=
 1 $LOOPS); do<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0./tracetest<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0$LTTNG snapshot record -m 1G<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0# print no of events and first and last event<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0last=3D$(ls -1drt $HOME/lttng-traces/$SESSION*/* | tail -1)<br>
</div></div>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=
=A0 =C2=A0 =C2=A0babeltrace $last &gt; snapshot/$<a href=3D"http://i.bt" ta=
rget=3D"_blank">i.bt</a> &lt;<a href=3D"http://i.bt" target=3D"_blank">http=
://i.bt</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0cat snapshot/$<a href=3D"http://i.bt" target=3D"_blank">i.bt</a> &lt;=
<a href=3D"http://i.bt" target=3D"_blank">http://i.bt</a>&gt; | wc -l<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0cat snapshot/$<a href=3D"http://i.bt" target=3D"_blank">i.bt</a> &lt;=
<a href=3D"http://i.bt" target=3D"_blank">http://i.bt</a>&gt; | head -1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0cat snapshot/$<a href=3D"http://i.bt" target=3D"_blank">i.bt</a> &lt;=
<a href=3D"http://i.bt" target=3D"_blank">http://i.bt</a>&gt; | tail -1<br>
<div><div class=3D"h5">&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&gt;&gt; done<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; $LTTNG stop<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; $LTTNG destroy=
 $SESSION<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-----------------------=
-----------------------------------------------------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; The result of =
the run looks like this;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; ./test.run<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Error: consume=
r err socket second poll error<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Error: Health =
error occurred in thread_manage_consumer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; PERROR - 13:36=
:59.685167 [23772/23781]: bind inet:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Address already in use<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; (in lttcomm_bi=
nd_inet_sock() at inet.c:109)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Warning: Anoth=
er session daemon is using this JUL port.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0JUL support will be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; deactivated to=
 prevent interfering with the tracing.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Is there a reason =
why you run two session daemons? I&#39;m<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0guessing this<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; is related to my &=
quot;&amp; vs -d&quot; comment above.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; lttng (LTTng T=
race Control) 2.5.2 - Fumisterie<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; BabelTrace Tra=
ce Viewer and Converter 1.2.4<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0linux-vdso.so.1 =3D&gt;=C2=A0 (0x00007fffba966000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0liblttng-ctl.so.0 =3D&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/usr/lib/x86_64-linux-g=
nu/liblttng-ctl.so.0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; (0x00007fbfe4b=
1d000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0librt.so.1 =3D&gt; /lib/x86_64-linux-gnu/librt.so.1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x00007fbfe4915000)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0libxml2.so.2 =3D&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/usr/lib/x86_64-linux-g=
nu/libxml2.so.2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; (0x00007fbfe45=
ae000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0libpopt.so.0 =3D&gt; /lib/x86_64-linux-gnu/libpopt.so.0=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; (0x00007fbfe43=
a2000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0libpthread.so.0 =3D&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/lib/x86_64-linux-gnu/l=
ibpthread.so.0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; (0x00007fbfe41=
84000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0libc.so.6 =3D&gt; /lib/x86_64-linux-gnu/libc.so.6<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x00007fbfe3dbd000)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/lib64/ld-linux-x86-64.so.2 (0x00007fbfe4fac000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0liburcu.so.2 =3D&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/usr/lib/x86_64-linux-g=
nu/liburcu.so.2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; (0x00007fbfe3b=
b6000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0libdl.so.2 =3D&gt; /lib/x86_64-linux-gnu/libdl.so.2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x00007fbfe39b2000)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0libz.so.1 =3D&gt; /lib/x86_64-linux-gnu/libz.so.1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x00007fbfe3798000)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0liblzma.so.5 =3D&gt; /lib/x86_64-linux-gnu/liblzma.so.5=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; (0x00007fbfe35=
76000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0libm.so.6 =3D&gt; /lib/x86_64-linux-gnu/libm.so.6<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x00007fbfe3270000)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Session test c=
reated.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Default snapsh=
ot output set to:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; /home/awallin/=
lttng-traces/test-20141112-133700<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Snapshot mode =
set. Every channel enabled for that session<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0will be set in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; overwrite mode=
 and mmap output.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; UST channel ch=
1 enabled for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; UST event * cr=
eated in channel ch1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Tracing starte=
d for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Tracing sessio=
n test: [active snapshot]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0Trace path:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0Live timer interval (usec): 4294967295<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; =3D=3D=3D Doma=
in: UST global =3D=3D=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Channels:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; -------------<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; - ch1: [enable=
d]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0Attributes:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0overwrite mode: 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0subbufers size: 4096<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0number of subbufers: 16<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0switch timer interval: 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0read timer interval: 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0trace file count: 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0trace file size (bytes): 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0output: mmap()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0Events:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0* (type: tracepoint) [enabled]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Snapshot recor=
ded successfully for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; 84<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; [13:37:00.8526=
15950] (+?.?????????) arn-awallin-mint-l3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; ust_baddr_stat=
edump:soinfo: { cpu_id =3D 4 }, { baddr =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x7FFFC6BC7000, sopath<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; =3D &quot;[vds=
o]&quot;, size =3D 0, mtime =3D -1 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; [13:37:00.8537=
98949] (+0.000000805) arn-awallin-mint-l3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tracetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; { cpu_id =3D 6=
 }, { my_string_field =3D &quot;test&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0my_integer_field =3D 99=
9 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Snapshot recor=
ded successfully for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; 157<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; [13:37:00.8537=
35195] (+?.?????????) arn-awallin-mint-l3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tracetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; { cpu_id =3D 6=
 }, { my_string_field =3D &quot;test&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0my_integer_field =3D 92=
7 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; [13:37:00.8948=
39116] (+0.000000299) arn-awallin-mint-l3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tracetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; { cpu_id =3D 5=
 }, { my_string_field =3D &quot;test&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0my_integer_field =3D 99=
9 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Snapshot recor=
ded successfully for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; 168<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; [13:37:00.8537=
35195] (+?.?????????) arn-awallin-mint-l3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tracetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; { cpu_id =3D 6=
 }, { my_string_field =3D &quot;test&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0my_integer_field =3D 92=
7 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; [13:37:00.9294=
47330] (+0.000000305) arn-awallin-mint-l3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tracetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; { cpu_id =3D 5=
 }, { my_string_field =3D &quot;test&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0my_integer_field =3D 99=
9 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Snapshot recor=
ded successfully for session test<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Something is wrong from=
 here:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; 168<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; [13:37:00.8944=
11117] (+?.?????????) arn-awallin-mint-l3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; ust_baddr_stat=
edump:soinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFF6BF81000, sopath<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; =3D &quot;[vds=
o]&quot;, size =3D 0, mtime =3D -1 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; [13:37:00.9720=
35546] (+0.000000597) arn-awallin-mint-l3 tracetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; { cpu_id =3D 6=
 }, { my_string_field =3D &quot;test&quot;, my_integer_field =3D 999 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Snapshot recor=
ded successfully for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; 168<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; [13:37:00.8944=
11117] (+?.?????????) arn-awallin-mint-l3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; ust_baddr_stat=
edump:soinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFF6BF81000, sopath<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; =3D &quot;[vds=
o]&quot;, size =3D 0, mtime =3D -1 }<br>
</div></div>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; [1=
3:37:01.<a href=3D"tel:014060940" value=3D"+4614060940">014060940</a> &lt;t=
el:<a href=3D"tel:014060940" value=3D"+4614060940">014060940</a>&gt;] (+0.0=
00000341)<br>
<span class=3D"">&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arn-aw=
allin-mint-l3 tracetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; { cpu_id =3D 7=
 }, { my_string_field =3D &quot;test&quot;, my_integer_field =3D 999 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Snapshot recor=
ded successfully for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; 168<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; [13:37:00.8944=
11117] (+?.?????????) arn-awallin-mint-l3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; ust_baddr_stat=
edump:soinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFF6BF81000, sopath<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; =3D &quot;[vds=
o]&quot;, size =3D 0, mtime =3D -1 }<br>
</span>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; [13:37:=
01.<a href=3D"tel:052555877" value=3D"+4652555877">052555877</a> &lt;tel:<a=
 href=3D"tel:052555877" value=3D"+4652555877">052555877</a>&gt;] (+0.000000=
872)<br>
<span class=3D"">&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arn-aw=
allin-mint-l3 tracetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; { cpu_id =3D 6=
 }, { my_string_field =3D &quot;test&quot;, my_integer_field =3D 999 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0... to here.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The beginning timestamp=
 is the same, the number of events is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the same,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0but the end timestamp m=
oves. We see also this pattern below.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I would be really inter=
ested to see the whole snapshots when<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0it happens.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0It seems like we are no=
t be overwriting the beginning of the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ring buffer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in some conditions. Cou=
ld you send us your tracetest program<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0script so we can try to=
 reproduce the problem ?<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I will append it including a run with=
 debug turned on and all<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the snapshot files created<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Snapshot recor=
ded successfully for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; 168<br>
</span>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; [13:37:=
01.<a href=3D"tel:014035993" value=3D"+4614035993">014035993</a> &lt;tel:<a=
 href=3D"tel:014035993" value=3D"+4614035993">014035993</a>&gt;] (+?.??????=
???)<br>
<span class=3D"">&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arn-aw=
allin-mint-l3 tracetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; { cpu_id =3D 7=
 }, { my_string_field =3D &quot;test&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0my_integer_field =3D 92=
7 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; [13:37:01.0986=
20808] (+0.000001404) arn-awallin-mint-l3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tracetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; { cpu_id =3D 4=
 }, { my_string_field =3D &quot;test&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0my_integer_field =3D 99=
9 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Snapshot recor=
ded successfully for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; 168<br>
</span>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; [13:37:=
01.<a href=3D"tel:097087388" value=3D"+4697087388">097087388</a> &lt;tel:<a=
 href=3D"tel:097087388" value=3D"+4697087388">097087388</a>&gt;] (+?.??????=
???)<br>
<span class=3D"">&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arn-aw=
allin-mint-l3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; ust_baddr_stat=
edump:soinfo: { cpu_id =3D 6 }, { baddr =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x7FFF4BFFE000, sopath<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; =3D &quot;[vds=
o]&quot;, size =3D 0, mtime =3D -1 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; [13:37:01.1298=
39830] (+0.000000533) arn-awallin-mint-l3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tracetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; { cpu_id =3D 7=
 }, { my_string_field =3D &quot;test&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0my_integer_field =3D 99=
9 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Snapshot recor=
ded successfully for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; 168<br>
</span>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; [13:37:=
01.<a href=3D"tel:097087388" value=3D"+4697087388">097087388</a> &lt;tel:<a=
 href=3D"tel:097087388" value=3D"+4697087388">097087388</a>&gt;] (+?.??????=
???)<br>
<span class=3D"">&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arn-aw=
allin-mint-l3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; ust_baddr_stat=
edump:soinfo: { cpu_id =3D 6 }, { baddr =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x7FFF4BFFE000, sopath<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; =3D &quot;[vds=
o]&quot;, size =3D 0, mtime =3D -1 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; [13:37:01.1298=
39830] (+0.000000533) arn-awallin-mint-l3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tracetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; { cpu_id =3D 7=
 }, { my_string_field =3D &quot;test&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0my_integer_field =3D 99=
9 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Snapshot recor=
ded successfully for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; 168<br>
</span>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; [13:37:=
01.<a href=3D"tel:097087388" value=3D"+4697087388">097087388</a> &lt;tel:<a=
 href=3D"tel:097087388" value=3D"+4697087388">097087388</a>&gt;] (+?.??????=
???)<br>
<div><div class=3D"h5">&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
arn-awallin-mint-l3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; ust_baddr_stat=
edump:soinfo: { cpu_id =3D 6 }, { baddr =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x7FFF4BFFE000, sopath<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; =3D &quot;[vds=
o]&quot;, size =3D 0, mtime =3D -1 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; [13:37:01.1728=
29105] (+0.000000575) arn-awallin-mint-l3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tracetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; { cpu_id =3D 5=
 }, { my_string_field =3D &quot;test&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0my_integer_field =3D 99=
9 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Snapshot recor=
ded successfully for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; 168<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; [13:37:01.1720=
21557] (+?.?????????) arn-awallin-mint-l3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; ust_baddr_stat=
edump:soinfo: { cpu_id =3D 7 }, { baddr =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x7FFF653FE000, sopath<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; =3D &quot;[vds=
o]&quot;, size =3D 0, mtime =3D -1 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; [13:37:01.2200=
74165] (+0.000000553) arn-awallin-mint-l3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tracetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; { cpu_id =3D 6=
 }, { my_string_field =3D &quot;test&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0my_integer_field =3D 99=
9 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Waiting for da=
ta availability<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Tracing stoppe=
d for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Session test d=
estroyed<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; the result fro=
m the run on older versions of lttng<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0creates bigger and bigg=
er<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; event traces u=
ntil reaching max size.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0We see this pattern her=
e and the max size seems to be 168<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0events, was it<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0similar in your previou=
s tests ?<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0If I&#39;m running the same test on 2=
.4 or 2.3 the max number of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0events is much bigger, like ~10000<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(I don&#39;t have the exact number ri=
ght now, I will rebuild and run<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the test again and get back<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with traces from that run)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0For 2.4.2 the log looks like this:<br>
&gt;=C2=A0 =C2=A0 =C2=A0./test.run ./tracetest<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0lttng (LTTng Trace Control) 2.4.2 - =C3=89poque Opa=
que<br>
&gt;=C2=A0 =C2=A0 =C2=A0BabelTrace Trace Viewer and Converter 1.2.1<br>
&gt;=C2=A0 =C2=A0 =C2=A0linux-vdso.so.1 =3D&gt;=C2=A0 (0x00007fff775fe000)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0liblttng-ctl.so.0 =3D&gt; /usr/local/lib/liblttng-c=
tl.so.0<br>
&gt;=C2=A0 =C2=A0 =C2=A0(0x00002b2b016e4000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0libpopt.so.0 =3D&gt; /lib/x86_64-linux-gnu/libpopt.=
so.0 (0x00002b2b0190f000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0libpthread.so.0 =3D&gt; /lib/x86_64-linux-gnu/libpt=
hread.so.0<br>
&gt;=C2=A0 =C2=A0 =C2=A0(0x00002b2b01b1b000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0libc.so.6 =3D&gt; /lib/x86_64-linux-gnu/libc.so.6 (=
0x00002b2b01d39000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0librt.so.1 =3D&gt; /lib/x86_64-linux-gnu/librt.so.1=
 (0x00002b2b020ff000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0liburcu.so.3 =3D&gt; /usr/local/lib/liburcu.so.3 (0=
x00002b2b02307000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0/lib64/ld-linux-x86-64.so.2 (0x00002b2b014bf000)<br=
>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Session test created.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Default snapshot output set to: //lttng-traces/test=
-20141113-093611<br>
&gt;=C2=A0 =C2=A0 =C2=A0Snapshot mode set. Every channel enabled for that s=
ession will be<br>
&gt;=C2=A0 =C2=A0 =C2=A0set in overwrite mode and mmap output.<br>
&gt;=C2=A0 =C2=A0 =C2=A0UST channel ch1 enabled for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A0UST event * created in channel ch1<br>
&gt;=C2=A0 =C2=A0 =C2=A0Tracing started for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A0Tracing session test: [active snapshot]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Trace path:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=3D=3D=3D Domain: UST global =3D=3D=3D<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Buffer type: per UID<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Channels:<br>
&gt;=C2=A0 =C2=A0 =C2=A0-------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0- ch1: [enabled]<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Attributes:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0overwrite mode: 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0subbufers size: 4096<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0number of subbufers: 16<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch timer interval: 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0read timer interval: 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0output: mmap()<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Events:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* (type: tracepoint) [enabled]=
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Snapshot recorded successfully for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A01000<br>
&gt;=C2=A0 =C2=A0 =C2=A0[09:36:11.985319272] (+?.?????????) 07f8cf84a38f tr=
acetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0{ cpu_id =3D 4 }, { my_string_field =3D &quot;test&=
quot;, my_integer_field =3D 0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0[09:36:11.985857254] (+0.000000501) 07f8cf84a38f tr=
acetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0{ cpu_id =3D 4 }, { my_string_field =3D &quot;test&=
quot;, my_integer_field =3D 999 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0Snapshot recorded successfully for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A02000<br>
&gt;=C2=A0 =C2=A0 =C2=A0[09:36:11.985319272] (+?.?????????) 07f8cf84a38f tr=
acetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0{ cpu_id =3D 4 }, { my_string_field =3D &quot;test&=
quot;, my_integer_field =3D 0 }<br>
</div></div>&gt;=C2=A0 =C2=A0 =C2=A0[09:36:12.033066130 &lt;tel:033066130&g=
t;] (+0.000001663) 07f8cf84a38f<br>
<span class=3D"">&gt;=C2=A0 =C2=A0 =C2=A0tracetest:first_tp: { cpu_id =3D 5=
 }, { my_string_field =3D &quot;test&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0my_integer_field =3D 999 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0Snapshot recorded successfully for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A03000<br>
&gt;=C2=A0 =C2=A0 =C2=A0[09:36:11.985319272] (+?.?????????) 07f8cf84a38f tr=
acetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0{ cpu_id =3D 4 }, { my_string_field =3D &quot;test&=
quot;, my_integer_field =3D 0 }<br>
</span>&gt;=C2=A0 =C2=A0 =C2=A0[09:36:12.086888121 &lt;tel:086888121&gt;] (=
+0.000001273) 07f8cf84a38f<br>
<div class=3D"HOEnZb"><div class=3D"h5">&gt;=C2=A0 =C2=A0 =C2=A0tracetest:f=
irst_tp: { cpu_id =3D 5 }, { my_string_field =3D &quot;test&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0my_integer_field =3D 999 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0Snapshot recorded successfully for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A04000<br>
&gt;=C2=A0 =C2=A0 =C2=A0[09:36:11.985319272] (+?.?????????) 07f8cf84a38f tr=
acetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0{ cpu_id =3D 4 }, { my_string_field =3D &quot;test&=
quot;, my_integer_field =3D 0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0[09:36:12.147378251] (+0.000001257) 07f8cf84a38f tr=
acetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0{ cpu_id =3D 4 }, { my_string_field =3D &quot;test&=
quot;, my_integer_field =3D 999 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0Snapshot recorded successfully for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A05000<br>
&gt;=C2=A0 =C2=A0 =C2=A0[09:36:11.985319272] (+?.?????????) 07f8cf84a38f tr=
acetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0{ cpu_id =3D 4 }, { my_string_field =3D &quot;test&=
quot;, my_integer_field =3D 0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0[09:36:12.225584696] (+0.000000528) 07f8cf84a38f tr=
acetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0{ cpu_id =3D 4 }, { my_string_field =3D &quot;test&=
quot;, my_integer_field =3D 999 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0Snapshot recorded successfully for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A06000<br>
&gt;=C2=A0 =C2=A0 =C2=A0[09:36:11.985319272] (+?.?????????) 07f8cf84a38f tr=
acetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0{ cpu_id =3D 4 }, { my_string_field =3D &quot;test&=
quot;, my_integer_field =3D 0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0[09:36:12.288311172] (+0.000000571) 07f8cf84a38f tr=
acetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0{ cpu_id =3D 7 }, { my_string_field =3D &quot;test&=
quot;, my_integer_field =3D 999 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0Snapshot recorded successfully for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A07000<br>
&gt;=C2=A0 =C2=A0 =C2=A0[09:36:11.985319272] (+?.?????????) 07f8cf84a38f tr=
acetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0{ cpu_id =3D 4 }, { my_string_field =3D &quot;test&=
quot;, my_integer_field =3D 0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0[09:36:12.375789307] (+0.000001238) 07f8cf84a38f tr=
acetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0{ cpu_id =3D 4 }, { my_string_field =3D &quot;test&=
quot;, my_integer_field =3D 999 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0Snapshot recorded successfully for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A07000<br>
&gt;=C2=A0 =C2=A0 =C2=A0[09:36:12.032314084] (+?.?????????) 07f8cf84a38f tr=
acetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0{ cpu_id =3D 5 }, { my_string_field =3D &quot;test&=
quot;, my_integer_field =3D 0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0[09:36:12.460756779] (+0.000001248) 07f8cf84a38f tr=
acetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0{ cpu_id =3D 4 }, { my_string_field =3D &quot;test&=
quot;, my_integer_field =3D 999 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0Snapshot recorded successfully for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A08000<br>
&gt;=C2=A0 =C2=A0 =C2=A0[09:36:12.032314084] (+?.?????????) 07f8cf84a38f tr=
acetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0{ cpu_id =3D 5 }, { my_string_field =3D &quot;test&=
quot;, my_integer_field =3D 0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0[09:36:12.540464090] (+0.000001292) 07f8cf84a38f tr=
acetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0{ cpu_id =3D 7 }, { my_string_field =3D &quot;test&=
quot;, my_integer_field =3D 999 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0Snapshot recorded successfully for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A09000<br>
&gt;=C2=A0 =C2=A0 =C2=A0[09:36:12.032314084] (+?.?????????) 07f8cf84a38f tr=
acetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0{ cpu_id =3D 5 }, { my_string_field =3D &quot;test&=
quot;, my_integer_field =3D 0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0[09:36:12.621992931] (+0.000001298) 07f8cf84a38f tr=
acetest:first_tp:<br>
&gt;=C2=A0 =C2=A0 =C2=A0{ cpu_id =3D 5 }, { my_string_field =3D &quot;test&=
quot;, my_integer_field =3D 999 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0Waiting for data availability<br>
&gt;=C2=A0 =C2=A0 =C2=A0Tracing stopped for session test<br>
&gt;=C2=A0 =C2=A0 =C2=A0Session test destroyed<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Unless I&#39;m mis=
taken, the behavior of the snapshot mode has changed<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; between 2.4 and 2.=
5.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; In the 2.4 series,=
 consecutive snapshots could overlap; that is,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; events could be pr=
esent in multiple snapshots. As of 2.5, an event is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; guaranteed to only=
 appear in one snapshot as the events are considered<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; as having been &qu=
ot;consumed&quot; at that point.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Hum, no the behavior is=
 still the same, consecutive<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0snapshots can overlap.<=
br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Could you tell us on wh=
ich architecture you are experiencing<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the problem<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and the number of CPUs =
?<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The traces appended is from my laptop=
 running Ubuntu 14.04 with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;8&quot; cpu&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0model name=C2=A0 =C2=A0 =C2=A0 : Inte=
l(R) Core(TM) i7-2760QM CPU @ 2.40GHz<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I have also run this on ARM with 16 c=
ores and a powerpc<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Thanks,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Julien<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
</div></div></blockquote></div><br></div></div>

--f46d04426bbc711c440507c10710--


--===============1007803062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1007803062==--
