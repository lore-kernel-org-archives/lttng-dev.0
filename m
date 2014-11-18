From: Anders Wallin <wallinux@gmail.com>
Subject: Re: snapshot issue with 2.5
Date: Tue, 18 Nov 2014 16:49:25 +0100
Message-ID: <CAF2baFfRL=VDhcChuVMJoiKe4MjYBOp_VPH-oDOYo2z5vPs5zg__21125.7658120759$1416325834$gmane$org@mail.gmail.com>
References: <CAF2baFd5vRuGKa7MVpqHvkCHia5fDN19cvq8qdedqJreNU6-vQ@mail.gmail.com>
 <CA+jJMxvXfVT8w+hokMyFgTSqN=JH3nQUudJR+8MUJtQmTEgZZQ@mail.gmail.com>
 <5463E904.9080102@efficios.com>
 <CAF2baFesZ0Ke5qcWt9eGzWTyPuyAW_PM=ZZ+g9baEUNRwK5cGA@mail.gmail.com>
 <CAF2baFcKwwciQDr+Wdpcs3_EJV969_aPUA_UtPXGo7=CMxWKvw@mail.gmail.com>
 <CAF2baFfvY6NRNzNc3tkJygc=01ntwf-qa3GgXG_rT+fSw6E2MA@mail.gmail.com>
 <5464E028.10709@efficios.com>
 <CAF2baFfY-DYF4ZuiUPvdbNNqTwzh3-ujqecS5omraPhSSP=GLw@mail.gmail.com>
 <CAF2baFcMWfi6e9mdKGJSSUsum4KkCUstM-7vE+gkPrAQLFA1Dg@mail.gmail.com>
 <54665EDA.7000307@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0068272840=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <wallinux@gmail.com>) id 1Xql23-0000uJ-Mk
 for lttng-dev@lists.lttng.org; Tue, 18 Nov 2014 10:49:37 -0500
Received: by mail-wg0-f54.google.com with SMTP id y10so6484892wgg.13
 for <lttng-dev@lists.lttng.org>; Tue, 18 Nov 2014 07:49:26 -0800 (PST)
In-Reply-To: <54665EDA.7000307@efficios.com>
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

--===============0068272840==
Content-Type: multipart/alternative; boundary=e89a8f2351eb2a3fc80508240a2e

--e89a8f2351eb2a3fc80508240a2e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Bug filed;
https://bugs.lttng.org/issues/860

Anders Wallin

On Fri, Nov 14, 2014 at 8:58 PM, Julien Desfossez <jdesfossez@efficios.com>
wrote:

> Indeed, it's a problem, would you mind filling a bug report on
> https://bugs.lttng.org/projects/lttng-tools so we can keep track of this
> issue ?
>
> Thanks,
>
> Julien
>
> On 14-11-13 04:40 PM, Anders Wallin wrote:
> > Looks like the patch creates a design bug.
> > If you have one channel enabled the max snapshot size will be equal to
> > one buffer times the number of channels (seems to be 8??)
> > So max AND min size will always be the same and always much smaller the=
n
> > the content of the buffers
> > The size argument passed to snapshot record is never used (or if it's t=
o
> > small it will complain)
> >
> > A Q&D workaround to get "all" data out is to create a 2nd non-used
> > channel like this;
> >
> > : ${NO_OF_SUBBUF:=3D6}
> > : ${SUBBUF_SIZE:=3D4096}
> >
> > SESSION=3Dtest
> > CHANNEL1=3Dch1
> > CHANNEL2=3Dch2
> >
> > CH2_SUBBUF_SIZE=3D$(($SUBBUF_SIZE*$NO_OF_SUBBUF))
> > .....
> >
> > $LTTNG create $SESSION --snapshot
> > $LTTNG enable-channel -u --subbuf-size $SUBBUF_SIZE --num-subbuf
> > $NO_OF_SUBBUF --overwrite $CHANNEL1
> > $LTTNG enable-channel -u --subbuf-size $CH2_SUBBUF_SIZE --num-subbuf 2
> > --overwrite $CHANNEL2
> > $LTTNG enable-event -u -c $CHANNEL1 "*"
> > ....
> >
> > Then I found another issue about the content of the traces, but I will
> > file this under another topic
> >
> >
> > Anders Wallin
> >
> > On Thu, Nov 13, 2014 at 6:41 PM, Anders Wallin <wallinux@gmail.com
> > <mailto:wallinux@gmail.com>> wrote:
> >
> >     No, I get the same problem with or w/o setting the size
> >
> >     Anders Wallin
> >
> >     On Thu, Nov 13, 2014 at 5:45 PM, Julien Desfossez
> >     <jdesfossez@efficios.com <mailto:jdesfossez@efficios.com>> wrote:
> >
> >         Ok, so if you don't limit the size of the snapshot (remove the
> >         -m 1G) it
> >         works as expected ?
> >
> >         Julien
> >
> >         On 14-11-13 10:33 AM, Anders Wallin wrote:
> >         > bug is introduced in  68808f4e0bbb3adccff72ff9dab6ec9f3a9e686=
6
> >         >
> >         > Regards
> >         >
> >         > Anders
> >         >
> >         > Anders Wallin
> >         >
> >         > On Thu, Nov 13, 2014 at 10:39 AM, Anders Wallin <
> wallinux@gmail.com <mailto:wallinux@gmail.com>
> >         > <mailto:wallinux@gmail.com <mailto:wallinux@gmail.com>>>
> wrote:
> >         >
> >         >
> >         >
> >         >     Anders Wallin
> >         >
> >         >     On Thu, Nov 13, 2014 at 8:43 AM, Anders Wallin <
> wallinux@gmail.com <mailto:wallinux@gmail.com>
> >         >     <mailto:wallinux@gmail.com <mailto:wallinux@gmail.com>>>
> wrote:
> >         >
> >         >         On Thu, Nov 13, 2014 at 12:11 AM, Julien Desfossez
> >         >         <jdesfossez@efficios.com <mailto:
> jdesfossez@efficios.com>
> >         <mailto:jdesfossez@efficios.com
> >         <mailto:jdesfossez@efficios.com>>> wrote:
> >         >
> >         >             Hi,
> >         >
> >         >             On 14-11-12 05:30 PM, J=C3=A9r=C3=A9mie Galarneau=
 wrote:
> >         >             > On Wed, Nov 12, 2014 at 7:39 AM, Anders Wallin
> >         >             <wallinux@gmail.com <mailto:wallinux@gmail.com>
> >         <mailto:wallinux@gmail.com <mailto:wallinux@gmail.com>>> wrote:
> >         >             >> Hi,
> >         >             >>
> >         >             >> using userspace snapshot mode in 2.5 seems to
> >         broken.
> >         >             >>
> >         >             >> I have small stupid application(tracetest)
> >         generating
> >         >             1000 events
> >         >             >>
> >         >             >> Running the script (the below is simplified
> >         version of
> >         >             the script)
> >         >             >>
> >         >
> >
> -------------------------------------------------------------------------=
---------
> >         >             >> #!/bin/bash
> >         >             >> LTTNG=3D'lttng -n'
> >         >             >> lttng-sessiond --no-kernel &
> >         >             >
> >         >             > You should use the "-d" flag to launch the
> >         sessiond as a
> >         >             daemon. Using
> >         >             > "&" might cause the "create" command to launch =
a
> >         second
> >         >             session daemon
> >         >             > since the first one would not have had the time
> >         to open
> >         >             create its
> >         >             > command sockets.
> >         >             >
> >         >             >>
> >         >             >> $LTTNG create test --snapshot
> >         >             >> $LTTNG enable-channel -u --subbuf-size 64k
> >         --num-subbuf
> >         >             16 --overwrite ch1
> >         >             >> $LTTNG enable-event -u -c ch1 "*"
> >         >             >> $LTTNG start
> >         >             >> $LTTNG list ch1
> >         >             >>
> >         >             >> mkdir -p snapshot/
> >         >             >>
> >         >             >> for i in $(seq 1 $LOOPS); do
> >         >             >>     ./tracetest
> >         >             >>     $LTTNG snapshot record -m 1G
> >         >             >>
> >         >             >>     # print no of events and first and last
> event
> >         >             >>     last=3D$(ls -1drt
> >         $HOME/lttng-traces/$SESSION*/* | tail -1)
> >         >             >>     babeltrace $last > snapshot/$i.bt
> >         <http://i.bt> <http://i.bt>
> >         >             >>     cat snapshot/$i.bt <http://i.bt>
> >         <http://i.bt> | wc -l
> >         >             >>     cat snapshot/$i.bt <http://i.bt>
> >         <http://i.bt> | head -1
> >         >             >>     cat snapshot/$i.bt <http://i.bt>
> >         <http://i.bt> | tail -1
> >         >             >> done
> >         >             >>
> >         >             >> $LTTNG stop
> >         >             >> $LTTNG destroy $SESSION
> >         >             >>
> >         >
> >
> -------------------------------------------------------------------------=
---------
> >         >             >>
> >         >             >> The result of the run looks like this;
> >         >             >> ./test.run
> >         >             >> Error: consumer err socket second poll error
> >         >             >> Error: Health error occurred in
> >         thread_manage_consumer
> >         >             >> PERROR - 13:36:59.685167 [23772/23781]: bind
> inet:
> >         >             Address already in use
> >         >             >> (in lttcomm_bind_inet_sock() at inet.c:109)
> >         >             >> Warning: Another session daemon is using this
> >         JUL port.
> >         >             JUL support will be
> >         >             >> deactivated to prevent interfering with the
> >         tracing.
> >         >             >>
> >         >             >
> >         >             > Is there a reason why you run two session
> >         daemons? I'm
> >         >             guessing this
> >         >             > is related to my "& vs -d" comment above.
> >         >             >
> >         >             >> lttng (LTTng Trace Control) 2.5.2 - Fumisterie
> >         >             >> BabelTrace Trace Viewer and Converter 1.2.4
> >         >             >>         linux-vdso.so.1 =3D>  (0x00007fffba966=
000)
> >         >             >>         liblttng-ctl.so.0 =3D>
> >         >             /usr/lib/x86_64-linux-gnu/liblttng-ctl.so.0
> >         >             >> (0x00007fbfe4b1d000)
> >         >             >>         librt.so.1 =3D>
> >         /lib/x86_64-linux-gnu/librt.so.1
> >         >             (0x00007fbfe4915000)
> >         >             >>         libxml2.so.2 =3D>
> >         >             /usr/lib/x86_64-linux-gnu/libxml2.so.2
> >         >             >> (0x00007fbfe45ae000)
> >         >             >>         libpopt.so.0 =3D>
> >         /lib/x86_64-linux-gnu/libpopt.so.0
> >         >             >> (0x00007fbfe43a2000)
> >         >             >>         libpthread.so.0 =3D>
> >         >             /lib/x86_64-linux-gnu/libpthread.so.0
> >         >             >> (0x00007fbfe4184000)
> >         >             >>         libc.so.6 =3D>
> >         /lib/x86_64-linux-gnu/libc.so.6
> >         >             (0x00007fbfe3dbd000)
> >         >             >>         /lib64/ld-linux-x86-64.so.2
> >         (0x00007fbfe4fac000)
> >         >             >>         liburcu.so.2 =3D>
> >         >             /usr/lib/x86_64-linux-gnu/liburcu.so.2
> >         >             >> (0x00007fbfe3bb6000)
> >         >             >>         libdl.so.2 =3D>
> >         /lib/x86_64-linux-gnu/libdl.so.2
> >         >             (0x00007fbfe39b2000)
> >         >             >>         libz.so.1 =3D>
> >         /lib/x86_64-linux-gnu/libz.so.1
> >         >             (0x00007fbfe3798000)
> >         >             >>         liblzma.so.5 =3D>
> >         /lib/x86_64-linux-gnu/liblzma.so.5
> >         >             >> (0x00007fbfe3576000)
> >         >             >>         libm.so.6 =3D>
> >         /lib/x86_64-linux-gnu/libm.so.6
> >         >             (0x00007fbfe3270000)
> >         >             >>
> >         >             >> Session test created.
> >         >             >> Default snapshot output set to:
> >         >             >> /home/awallin/lttng-traces/test-20141112-13370=
0
> >         >             >> Snapshot mode set. Every channel enabled for
> >         that session
> >         >             will be set in
> >         >             >> overwrite mode and mmap output.
> >         >             >> UST channel ch1 enabled for session test
> >         >             >> UST event * created in channel ch1
> >         >             >> Tracing started for session test
> >         >             >> Tracing session test: [active snapshot]
> >         >             >>     Trace path:
> >         >             >>     Live timer interval (usec): 4294967295
> >         >             >>
> >         >             >> =3D=3D=3D Domain: UST global =3D=3D=3D
> >         >             >>
> >         >             >> Channels:
> >         >             >> -------------
> >         >             >> - ch1: [enabled]
> >         >             >>
> >         >             >>     Attributes:
> >         >             >>       overwrite mode: 1
> >         >             >>       subbufers size: 4096
> >         >             >>       number of subbufers: 16
> >         >             >>       switch timer interval: 0
> >         >             >>       read timer interval: 0
> >         >             >>       trace file count: 0
> >         >             >>       trace file size (bytes): 0
> >         >             >>       output: mmap()
> >         >             >>
> >         >             >>     Events:
> >         >             >>       * (type: tracepoint) [enabled]
> >         >             >>
> >         >             >> Snapshot recorded successfully for session tes=
t
> >         >             >> 84
> >         >             >> [13:37:00.852615950] (+?.?????????)
> >         arn-awallin-mint-l3
> >         >             >> ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, =
{
> >         baddr =3D
> >         >             0x7FFFC6BC7000, sopath
> >         >             >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
> >         >             >> [13:37:00.853798949] (+0.000000805)
> >         arn-awallin-mint-l3
> >         >             tracetest:first_tp:
> >         >             >> { cpu_id =3D 6 }, { my_string_field =3D "test"=
,
> >         >             my_integer_field =3D 999 }
> >         >             >> Snapshot recorded successfully for session tes=
t
> >         >             >> 157
> >         >             >> [13:37:00.853735195] (+?.?????????)
> >         arn-awallin-mint-l3
> >         >             tracetest:first_tp:
> >         >             >> { cpu_id =3D 6 }, { my_string_field =3D "test"=
,
> >         >             my_integer_field =3D 927 }
> >         >             >> [13:37:00.894839116] (+0.000000299)
> >         arn-awallin-mint-l3
> >         >             tracetest:first_tp:
> >         >             >> { cpu_id =3D 5 }, { my_string_field =3D "test"=
,
> >         >             my_integer_field =3D 999 }
> >         >             >> Snapshot recorded successfully for session tes=
t
> >         >             >> 168
> >         >             >> [13:37:00.853735195] (+?.?????????)
> >         arn-awallin-mint-l3
> >         >             tracetest:first_tp:
> >         >             >> { cpu_id =3D 6 }, { my_string_field =3D "test"=
,
> >         >             my_integer_field =3D 927 }
> >         >             >> [13:37:00.929447330] (+0.000000305)
> >         arn-awallin-mint-l3
> >         >             tracetest:first_tp:
> >         >             >> { cpu_id =3D 5 }, { my_string_field =3D "test"=
,
> >         >             my_integer_field =3D 999 }
> >         >             >> Snapshot recorded successfully for session tes=
t
> >         >
> >         >             Something is wrong from here:
> >         >             >> 168
> >         >             >> [13:37:00.894411117] (+?.?????????)
> >         arn-awallin-mint-l3
> >         >             >> ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, =
{
> >         baddr =3D 0x7FFF6BF81000, sopath
> >         >             >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
> >         >             >> [13:37:00.972035546] (+0.000000597)
> >         arn-awallin-mint-l3 tracetest:first_tp:
> >         >             >> { cpu_id =3D 6 }, { my_string_field =3D "test"=
,
> >         my_integer_field =3D 999 }
> >         >             >> Snapshot recorded successfully for session tes=
t
> >         >             >> 168
> >         >             >> [13:37:00.894411117] (+?.?????????)
> >         arn-awallin-mint-l3
> >         >             >> ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, =
{
> >         baddr =3D 0x7FFF6BF81000, sopath
> >         >             >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
> >         >             >> [13:37:01.014060940 <tel:014060940>
> >         <tel:014060940 <tel:014060940>>] (+0.000000341)
> >         >             arn-awallin-mint-l3 tracetest:first_tp:
> >         >             >> { cpu_id =3D 7 }, { my_string_field =3D "test"=
,
> my_integer_field =3D 999 }
> >         >             >> Snapshot recorded successfully for session tes=
t
> >         >             >> 168
> >         >             >> [13:37:00.894411117] (+?.?????????)
> arn-awallin-mint-l3
> >         >             >> ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, =
{
> baddr =3D 0x7FFF6BF81000, sopath
> >         >             >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
> >         >             >> [13:37:01.052555877 <tel:052555877>
> >         <tel:052555877 <tel:052555877>>] (+0.000000872)
> >         >             arn-awallin-mint-l3 tracetest:first_tp:
> >         >             >> { cpu_id =3D 6 }, { my_string_field =3D "test"=
,
> my_integer_field =3D 999 }
> >         >             ... to here.
> >         >
> >         >             The beginning timestamp is the same, the number o=
f
> events is
> >         >             the same,
> >         >             but the end timestamp moves. We see also this
> pattern below.
> >         >             I would be really interested to see the whole
> snapshots when
> >         >             it happens.
> >         >             It seems like we are not be overwriting the
> beginning of the
> >         >             ring buffer
> >         >             in some conditions. Could you send us your
> tracetest program
> >         >             and the
> >         >             script so we can try to reproduce the problem ?
> >         >
> >         >
> >         >         I will append it including a run with debug turned on
> and all
> >         >         the snapshot files created
> >         >
> >         >
> >         >
> >         >             >> Snapshot recorded successfully for session tes=
t
> >         >             >> 168
> >         >             >> [13:37:01.014035993 <tel:014035993>
> >         <tel:014035993 <tel:014035993>>] (+?.?????????)
> >         >             arn-awallin-mint-l3 tracetest:first_tp:
> >         >             >> { cpu_id =3D 7 }, { my_string_field =3D "test"=
,
> >         >             my_integer_field =3D 927 }
> >         >             >> [13:37:01.098620808] (+0.000001404)
> arn-awallin-mint-l3
> >         >             tracetest:first_tp:
> >         >             >> { cpu_id =3D 4 }, { my_string_field =3D "test"=
,
> >         >             my_integer_field =3D 999 }
> >         >             >> Snapshot recorded successfully for session tes=
t
> >         >             >> 168
> >         >             >> [13:37:01.097087388 <tel:097087388>
> >         <tel:097087388 <tel:097087388>>] (+?.?????????)
> >         >             arn-awallin-mint-l3
> >         >             >> ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, =
{
> baddr =3D
> >         >             0x7FFF4BFFE000, sopath
> >         >             >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
> >         >             >> [13:37:01.129839830] (+0.000000533)
> arn-awallin-mint-l3
> >         >             tracetest:first_tp:
> >         >             >> { cpu_id =3D 7 }, { my_string_field =3D "test"=
,
> >         >             my_integer_field =3D 999 }
> >         >             >> Snapshot recorded successfully for session tes=
t
> >         >             >> 168
> >         >             >> [13:37:01.097087388 <tel:097087388>
> >         <tel:097087388 <tel:097087388>>] (+?.?????????)
> >         >             arn-awallin-mint-l3
> >         >             >> ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, =
{
> baddr =3D
> >         >             0x7FFF4BFFE000, sopath
> >         >             >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
> >         >             >> [13:37:01.129839830] (+0.000000533)
> arn-awallin-mint-l3
> >         >             tracetest:first_tp:
> >         >             >> { cpu_id =3D 7 }, { my_string_field =3D "test"=
,
> >         >             my_integer_field =3D 999 }
> >         >             >> Snapshot recorded successfully for session tes=
t
> >         >             >> 168
> >         >             >> [13:37:01.097087388 <tel:097087388>
> >         <tel:097087388 <tel:097087388>>] (+?.?????????)
> >         >             arn-awallin-mint-l3
> >         >             >> ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, =
{
> >         baddr =3D
> >         >             0x7FFF4BFFE000, sopath
> >         >             >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
> >         >             >> [13:37:01.172829105] (+0.000000575)
> >         arn-awallin-mint-l3
> >         >             tracetest:first_tp:
> >         >             >> { cpu_id =3D 5 }, { my_string_field =3D "test"=
,
> >         >             my_integer_field =3D 999 }
> >         >             >> Snapshot recorded successfully for session tes=
t
> >         >             >> 168
> >         >             >> [13:37:01.172021557] (+?.?????????)
> >         arn-awallin-mint-l3
> >         >             >> ust_baddr_statedump:soinfo: { cpu_id =3D 7 }, =
{
> >         baddr =3D
> >         >             0x7FFF653FE000, sopath
> >         >             >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
> >         >             >> [13:37:01.220074165] (+0.000000553)
> >         arn-awallin-mint-l3
> >         >             tracetest:first_tp:
> >         >             >> { cpu_id =3D 6 }, { my_string_field =3D "test"=
,
> >         >             my_integer_field =3D 999 }
> >         >             >> Waiting for data availability
> >         >             >> Tracing stopped for session test
> >         >             >> Session test destroyed
> >         >             >>
> >         >             >> the result from the run on older versions of
> lttng
> >         >             creates bigger and bigger
> >         >             >> event traces until reaching max size.
> >         >             We see this pattern here and the max size seems t=
o
> >         be 168
> >         >             events, was it
> >         >             similar in your previous tests ?
> >         >
> >         >         If I'm running the same test on 2.4 or 2.3 the max
> >         number of
> >         >         events is much bigger, like ~10000
> >         >         (I don't have the exact number right now, I will
> >         rebuild and run
> >         >         the test again and get back
> >         >         with traces from that run)
> >         >
> >         >     For 2.4.2 the log looks like this:
> >         >     ./test.run ./tracetest
> >         >
> >         >     lttng (LTTng Trace Control) 2.4.2 - =C3=89poque Opaque
> >         >     BabelTrace Trace Viewer and Converter 1.2.1
> >         >     linux-vdso.so.1 =3D>  (0x00007fff775fe000)
> >         >     liblttng-ctl.so.0 =3D> /usr/local/lib/liblttng-ctl.so.0
> >         >     (0x00002b2b016e4000)
> >         >     libpopt.so.0 =3D> /lib/x86_64-linux-gnu/libpopt.so.0
> >         (0x00002b2b0190f000)
> >         >     libpthread.so.0 =3D> /lib/x86_64-linux-gnu/libpthread.so.=
0
> >         >     (0x00002b2b01b1b000)
> >         >     libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6
> >         (0x00002b2b01d39000)
> >         >     librt.so.1 =3D> /lib/x86_64-linux-gnu/librt.so.1
> >         (0x00002b2b020ff000)
> >         >     liburcu.so.3 =3D> /usr/local/lib/liburcu.so.3
> >         (0x00002b2b02307000)
> >         >     /lib64/ld-linux-x86-64.so.2 (0x00002b2b014bf000)
> >         >
> >         >     Session test created.
> >         >     Default snapshot output set to:
> >         //lttng-traces/test-20141113-093611
> >         >     Snapshot mode set. Every channel enabled for that session
> >         will be
> >         >     set in overwrite mode and mmap output.
> >         >     UST channel ch1 enabled for session test
> >         >     UST event * created in channel ch1
> >         >     Tracing started for session test
> >         >     Tracing session test: [active snapshot]
> >         >         Trace path:
> >         >
> >         >     =3D=3D=3D Domain: UST global =3D=3D=3D
> >         >
> >         >     Buffer type: per UID
> >         >
> >         >     Channels:
> >         >     -------------
> >         >     - ch1: [enabled]
> >         >
> >         >         Attributes:
> >         >           overwrite mode: 1
> >         >           subbufers size: 4096
> >         >           number of subbufers: 16
> >         >           switch timer interval: 0
> >         >           read timer interval: 0
> >         >           output: mmap()
> >         >
> >         >         Events:
> >         >           * (type: tracepoint) [enabled]
> >         >
> >         >     Snapshot recorded successfully for session test
> >         >     1000
> >         >     [09:36:11.985319272] (+?.?????????) 07f8cf84a38f
> >         tracetest:first_tp:
> >         >     { cpu_id =3D 4 }, { my_string_field =3D "test",
> >         my_integer_field =3D 0 }
> >         >     [09:36:11.985857254] (+0.000000501) 07f8cf84a38f
> >         tracetest:first_tp:
> >         >     { cpu_id =3D 4 }, { my_string_field =3D "test",
> >         my_integer_field =3D 999 }
> >         >     Snapshot recorded successfully for session test
> >         >     2000
> >         >     [09:36:11.985319272] (+?.?????????) 07f8cf84a38f
> >         tracetest:first_tp:
> >         >     { cpu_id =3D 4 }, { my_string_field =3D "test",
> >         my_integer_field =3D 0 }
> >         >     [09:36:12.033066130 <tel:033066130> <tel:033066130
> >         <tel:033066130>>] (+0.000001663) 07f8cf84a38f
> >         >     tracetest:first_tp: { cpu_id =3D 5 }, { my_string_field =
=3D
> "test",
> >         >     my_integer_field =3D 999 }
> >         >     Snapshot recorded successfully for session test
> >         >     3000
> >         >     [09:36:11.985319272] (+?.?????????) 07f8cf84a38f
> tracetest:first_tp:
> >         >     { cpu_id =3D 4 }, { my_string_field =3D "test",
> my_integer_field =3D 0 }
> >         >     [09:36:12.086888121 <tel:086888121> <tel:086888121
> >         <tel:086888121>>] (+0.000001273) 07f8cf84a38f
> >         >     tracetest:first_tp: { cpu_id =3D 5 }, { my_string_field =
=3D
> >         "test",
> >         >     my_integer_field =3D 999 }
> >         >     Snapshot recorded successfully for session test
> >         >     4000
> >         >     [09:36:11.985319272] (+?.?????????) 07f8cf84a38f
> >         tracetest:first_tp:
> >         >     { cpu_id =3D 4 }, { my_string_field =3D "test",
> >         my_integer_field =3D 0 }
> >         >     [09:36:12.147378251] (+0.000001257) 07f8cf84a38f
> >         tracetest:first_tp:
> >         >     { cpu_id =3D 4 }, { my_string_field =3D "test",
> >         my_integer_field =3D 999 }
> >         >     Snapshot recorded successfully for session test
> >         >     5000
> >         >     [09:36:11.985319272] (+?.?????????) 07f8cf84a38f
> >         tracetest:first_tp:
> >         >     { cpu_id =3D 4 }, { my_string_field =3D "test",
> >         my_integer_field =3D 0 }
> >         >     [09:36:12.225584696] (+0.000000528) 07f8cf84a38f
> >         tracetest:first_tp:
> >         >     { cpu_id =3D 4 }, { my_string_field =3D "test",
> >         my_integer_field =3D 999 }
> >         >     Snapshot recorded successfully for session test
> >         >     6000
> >         >     [09:36:11.985319272] (+?.?????????) 07f8cf84a38f
> >         tracetest:first_tp:
> >         >     { cpu_id =3D 4 }, { my_string_field =3D "test",
> >         my_integer_field =3D 0 }
> >         >     [09:36:12.288311172] (+0.000000571) 07f8cf84a38f
> >         tracetest:first_tp:
> >         >     { cpu_id =3D 7 }, { my_string_field =3D "test",
> >         my_integer_field =3D 999 }
> >         >     Snapshot recorded successfully for session test
> >         >     7000
> >         >     [09:36:11.985319272] (+?.?????????) 07f8cf84a38f
> >         tracetest:first_tp:
> >         >     { cpu_id =3D 4 }, { my_string_field =3D "test",
> >         my_integer_field =3D 0 }
> >         >     [09:36:12.375789307] (+0.000001238) 07f8cf84a38f
> >         tracetest:first_tp:
> >         >     { cpu_id =3D 4 }, { my_string_field =3D "test",
> >         my_integer_field =3D 999 }
> >         >     Snapshot recorded successfully for session test
> >         >     7000
> >         >     [09:36:12.032314084] (+?.?????????) 07f8cf84a38f
> >         tracetest:first_tp:
> >         >     { cpu_id =3D 5 }, { my_string_field =3D "test",
> >         my_integer_field =3D 0 }
> >         >     [09:36:12.460756779] (+0.000001248) 07f8cf84a38f
> >         tracetest:first_tp:
> >         >     { cpu_id =3D 4 }, { my_string_field =3D "test",
> >         my_integer_field =3D 999 }
> >         >     Snapshot recorded successfully for session test
> >         >     8000
> >         >     [09:36:12.032314084] (+?.?????????) 07f8cf84a38f
> >         tracetest:first_tp:
> >         >     { cpu_id =3D 5 }, { my_string_field =3D "test",
> >         my_integer_field =3D 0 }
> >         >     [09:36:12.540464090] (+0.000001292) 07f8cf84a38f
> >         tracetest:first_tp:
> >         >     { cpu_id =3D 7 }, { my_string_field =3D "test",
> >         my_integer_field =3D 999 }
> >         >     Snapshot recorded successfully for session test
> >         >     9000
> >         >     [09:36:12.032314084] (+?.?????????) 07f8cf84a38f
> >         tracetest:first_tp:
> >         >     { cpu_id =3D 5 }, { my_string_field =3D "test",
> >         my_integer_field =3D 0 }
> >         >     [09:36:12.621992931] (+0.000001298) 07f8cf84a38f
> >         tracetest:first_tp:
> >         >     { cpu_id =3D 5 }, { my_string_field =3D "test",
> >         my_integer_field =3D 999 }
> >         >     Waiting for data availability
> >         >     Tracing stopped for session test
> >         >     Session test destroyed
> >         >
> >         >
> >         >
> >         >             >
> >         >             > Unless I'm mistaken, the behavior of the
> >         snapshot mode has changed
> >         >             > between 2.4 and 2.5.
> >         >             >
> >         >             > In the 2.4 series, consecutive snapshots could
> >         overlap; that is,
> >         >             > events could be present in multiple snapshots.
> >         As of 2.5, an event is
> >         >             > guaranteed to only appear in one snapshot as th=
e
> >         events are considered
> >         >             > as having been "consumed" at that point.
> >         >
> >         >             Hum, no the behavior is still the same, consecuti=
ve
> >         >             snapshots can overlap.
> >         >
> >         >             Could you tell us on which architecture you are
> >         experiencing
> >         >             the problem
> >         >             and the number of CPUs ?
> >         >
> >         >         The traces appended is from my laptop running Ubuntu
> >         14.04 with
> >         >         "8" cpu's
> >         >         model name      : Intel(R) Core(TM) i7-2760QM CPU @
> >         2.40GHz
> >         >         I have also run this on ARM with 16 cores and a power=
pc
> >         >
> >         >
> >         >             Thanks,
> >         >
> >         >             Julien
> >         >
> >         >
> >         >
> >         >
> >
> >
> >
>

--e89a8f2351eb2a3fc80508240a2e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj5CdWcgZmlsZWQ7PC9kaXY+PGEgaHJlZj0iaHR0cHM6Ly9idWdz
Lmx0dG5nLm9yZy9pc3N1ZXMvODYwIj5odHRwczovL2J1Z3MubHR0bmcub3JnL2lzc3Vlcy84NjA8
L2E+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnIgY2xlYXI9ImFsbCI+PGRpdj48ZGl2
IGNsYXNzPSJnbWFpbF9zaWduYXR1cmUiPkFuZGVycyBXYWxsaW48L2Rpdj48L2Rpdj4NCjxicj48
ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gRnJpLCBOb3YgMTQsIDIwMTQgYXQgODo1OCBQTSwg
SnVsaWVuIERlc2Zvc3NleiA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpqZGVz
Zm9zc2V6QGVmZmljaW9zLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmpkZXNmb3NzZXpAZWZmaWNpb3Mu
Y29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtw
YWRkaW5nLWxlZnQ6MWV4Ij5JbmRlZWQsIGl0JiMzOTtzIGEgcHJvYmxlbSwgd291bGQgeW91IG1p
bmQgZmlsbGluZyBhIGJ1ZyByZXBvcnQgb248YnI+DQo8YSBocmVmPSJodHRwczovL2J1Z3MubHR0
bmcub3JnL3Byb2plY3RzL2x0dG5nLXRvb2xzIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9idWdz
Lmx0dG5nLm9yZy9wcm9qZWN0cy9sdHRuZy10b29sczwvYT4gc28gd2UgY2FuIGtlZXAgdHJhY2sg
b2YgdGhpczxicj4NCmlzc3VlID88YnI+DQo8YnI+DQpUaGFua3MsPGJyPg0KPGJyPg0KSnVsaWVu
PGJyPg0KPGRpdj48ZGl2IGNsYXNzPSJoNSI+PGJyPg0KT24gMTQtMTEtMTMgMDQ6NDAgUE0sIEFu
ZGVycyBXYWxsaW4gd3JvdGU6PGJyPg0KJmd0OyBMb29rcyBsaWtlIHRoZSBwYXRjaCBjcmVhdGVz
IGEgZGVzaWduIGJ1Zy48YnI+DQomZ3Q7IElmIHlvdSBoYXZlIG9uZSBjaGFubmVsIGVuYWJsZWQg
dGhlIG1heCBzbmFwc2hvdCBzaXplIHdpbGwgYmUgZXF1YWwgdG88YnI+DQomZ3Q7IG9uZSBidWZm
ZXIgdGltZXMgdGhlIG51bWJlciBvZiBjaGFubmVscyAoc2VlbXMgdG8gYmUgOD8/KTxicj4NCiZn
dDsgU28gbWF4IEFORCBtaW4gc2l6ZSB3aWxsIGFsd2F5cyBiZSB0aGUgc2FtZSBhbmQgYWx3YXlz
IG11Y2ggc21hbGxlciB0aGVuPGJyPg0KJmd0OyB0aGUgY29udGVudCBvZiB0aGUgYnVmZmVyczxi
cj4NCiZndDsgVGhlIHNpemUgYXJndW1lbnQgcGFzc2VkIHRvIHNuYXBzaG90IHJlY29yZCBpcyBu
ZXZlciB1c2VkIChvciBpZiBpdCYjMzk7cyB0bzxicj4NCiZndDsgc21hbGwgaXQgd2lsbCBjb21w
bGFpbik8YnI+DQomZ3Q7PGJyPg0KJmd0OyBBIFEmYW1wO0Qgd29ya2Fyb3VuZCB0byBnZXQgJnF1
b3Q7YWxsJnF1b3Q7IGRhdGEgb3V0IGlzIHRvIGNyZWF0ZSBhIDJuZCBub24tdXNlZDxicj4NCiZn
dDsgY2hhbm5lbCBsaWtlIHRoaXM7PGJyPg0KJmd0Ozxicj4NCiZndDsgOiAke05PX09GX1NVQkJV
Rjo9Nn08YnI+DQomZ3Q7IDogJHtTVUJCVUZfU0laRTo9NDA5Nn08YnI+DQomZ3Q7PGJyPg0KJmd0
OyBTRVNTSU9OPXRlc3Q8YnI+DQomZ3Q7IENIQU5ORUwxPWNoMTxicj4NCiZndDsgQ0hBTk5FTDI9
Y2gyPGJyPg0KJmd0Ozxicj4NCiZndDsgQ0gyX1NVQkJVRl9TSVpFPSQoKCRTVUJCVUZfU0laRSok
Tk9fT0ZfU1VCQlVGKSk8YnI+DQomZ3Q7IC4uLi4uPGJyPg0KJmd0Ozxicj4NCiZndDsgJExUVE5H
IGNyZWF0ZSAkU0VTU0lPTiAtLXNuYXBzaG90PGJyPg0KJmd0OyAkTFRUTkcgZW5hYmxlLWNoYW5u
ZWwgLXUgLS1zdWJidWYtc2l6ZSAkU1VCQlVGX1NJWkUgLS1udW0tc3ViYnVmPGJyPg0KJmd0OyAk
Tk9fT0ZfU1VCQlVGIC0tb3ZlcndyaXRlICRDSEFOTkVMMTxicj4NCiZndDsgJExUVE5HIGVuYWJs
ZS1jaGFubmVsIC11IC0tc3ViYnVmLXNpemUgJENIMl9TVUJCVUZfU0laRSAtLW51bS1zdWJidWYg
Mjxicj4NCiZndDsgLS1vdmVyd3JpdGUgJENIQU5ORUwyPGJyPg0KJmd0OyAkTFRUTkcgZW5hYmxl
LWV2ZW50IC11IC1jICRDSEFOTkVMMSAmcXVvdDsqJnF1b3Q7PGJyPg0KJmd0OyAuLi4uPGJyPg0K
Jmd0Ozxicj4NCiZndDsgVGhlbiBJIGZvdW5kIGFub3RoZXIgaXNzdWUgYWJvdXQgdGhlIGNvbnRl
bnQgb2YgdGhlIHRyYWNlcywgYnV0IEkgd2lsbDxicj4NCiZndDsgZmlsZSB0aGlzIHVuZGVyIGFu
b3RoZXIgdG9waWM8YnI+DQomZ3Q7PGJyPg0KJmd0Ozxicj4NCiZndDsgQW5kZXJzIFdhbGxpbjxi
cj4NCiZndDs8YnI+DQomZ3Q7IE9uIFRodSwgTm92IDEzLCAyMDE0IGF0IDY6NDEgUE0sIEFuZGVy
cyBXYWxsaW4gJmx0OzxhIGhyZWY9Im1haWx0bzp3YWxsaW51eEBnbWFpbC5jb20iPndhbGxpbnV4
QGdtYWlsLmNvbTwvYT48YnI+DQo8L2Rpdj48L2Rpdj48c3BhbiBjbGFzcz0iIj4mZ3Q7ICZsdDtt
YWlsdG86PGEgaHJlZj0ibWFpbHRvOndhbGxpbnV4QGdtYWlsLmNvbSI+d2FsbGludXhAZ21haWwu
Y29tPC9hPiZndDsmZ3Q7IHdyb3RlOjxicj4NCiZndDs8YnI+DQomZ3Q7wqAgwqAgwqBObywgSSBn
ZXQgdGhlIHNhbWUgcHJvYmxlbSB3aXRoIG9yIHcvbyBzZXR0aW5nIHRoZSBzaXplPGJyPg0KJmd0
Ozxicj4NCiZndDvCoCDCoCDCoEFuZGVycyBXYWxsaW48YnI+DQomZ3Q7PGJyPg0KJmd0O8KgIMKg
IMKgT24gVGh1LCBOb3YgMTMsIDIwMTQgYXQgNTo0NSBQTSwgSnVsaWVuIERlc2Zvc3Nlejxicj4N
Cjwvc3Bhbj48c3BhbiBjbGFzcz0iIj4mZ3Q7wqAgwqAgwqAmbHQ7PGEgaHJlZj0ibWFpbHRvOmpk
ZXNmb3NzZXpAZWZmaWNpb3MuY29tIj5qZGVzZm9zc2V6QGVmZmljaW9zLmNvbTwvYT4gJmx0O21h
aWx0bzo8YSBocmVmPSJtYWlsdG86amRlc2Zvc3NlekBlZmZpY2lvcy5jb20iPmpkZXNmb3NzZXpA
ZWZmaWNpb3MuY29tPC9hPiZndDsmZ3Q7IHdyb3RlOjxicj4NCiZndDs8YnI+DQomZ3Q7wqAgwqAg
wqAgwqAgwqBPaywgc28gaWYgeW91IGRvbiYjMzk7dCBsaW1pdCB0aGUgc2l6ZSBvZiB0aGUgc25h
cHNob3QgKHJlbW92ZSB0aGU8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAtbSAxRykgaXQ8YnI+DQom
Z3Q7wqAgwqAgwqAgwqAgwqB3b3JrcyBhcyBleHBlY3RlZCA/PGJyPg0KJmd0Ozxicj4NCiZndDvC
oCDCoCDCoCDCoCDCoEp1bGllbjxicj4NCiZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBPbiAx
NC0xMS0xMyAxMDozMyBBTSwgQW5kZXJzIFdhbGxpbiB3cm90ZTo8YnI+DQomZ3Q7wqAgwqAgwqAg
wqAgwqAmZ3Q7IGJ1ZyBpcyBpbnRyb2R1Y2VkIGluwqAgNjg4MDhmNGUwYmJiM2FkY2NmZjcyZmY5
ZGFiNmVjOWYzYTllNjg2Njxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAg
wqAgwqAgwqAgwqAmZ3Q7IFJlZ2FyZHM8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7PGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgJmd0OyBBbmRlcnM8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7
PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0OyBBbmRlcnMgV2FsbGluPGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDsgT24gVGh1LCBOb3YgMTMs
IDIwMTQgYXQgMTA6MzkgQU0sIEFuZGVycyBXYWxsaW4gJmx0OzxhIGhyZWY9Im1haWx0bzp3YWxs
aW51eEBnbWFpbC5jb20iPndhbGxpbnV4QGdtYWlsLmNvbTwvYT4gJmx0O21haWx0bzo8YSBocmVm
PSJtYWlsdG86d2FsbGludXhAZ21haWwuY29tIj53YWxsaW51eEBnbWFpbC5jb208L2E+Jmd0Ozxi
cj4NCjwvc3Bhbj48c3BhbiBjbGFzcz0iIj4mZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7ICZsdDttYWls
dG86PGEgaHJlZj0ibWFpbHRvOndhbGxpbnV4QGdtYWlsLmNvbSI+d2FsbGludXhAZ21haWwuY29t
PC9hPiAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzp3YWxsaW51eEBnbWFpbC5jb20iPndhbGxp
bnV4QGdtYWlsLmNvbTwvYT4mZ3Q7Jmd0OyZndDsgd3JvdGU6PGJyPg0KJmd0O8KgIMKgIMKgIMKg
IMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAg
wqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgQW5kZXJzIFdhbGxpbjxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAg
wqAgwqBPbiBUaHUsIE5vdiAxMywgMjAxNCBhdCA4OjQzIEFNLCBBbmRlcnMgV2FsbGluICZsdDs8
YSBocmVmPSJtYWlsdG86d2FsbGludXhAZ21haWwuY29tIj53YWxsaW51eEBnbWFpbC5jb208L2E+
ICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOndhbGxpbnV4QGdtYWlsLmNvbSI+d2FsbGludXhA
Z21haWwuY29tPC9hPiZndDs8YnI+DQo8L3NwYW4+PHNwYW4gY2xhc3M9IiI+Jmd0O8KgIMKgIMKg
IMKgIMKgJmd0O8KgIMKgIMKgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86d2FsbGludXhAZ21h
aWwuY29tIj53YWxsaW51eEBnbWFpbC5jb208L2E+ICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRv
OndhbGxpbnV4QGdtYWlsLmNvbSI+d2FsbGludXhAZ21haWwuY29tPC9hPiZndDsmZ3Q7Jmd0OyB3
cm90ZTo8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
Jmd0O8KgIMKgIMKgIMKgIMKgT24gVGh1LCBOb3YgMTMsIDIwMTQgYXQgMTI6MTEgQU0sIEp1bGll
biBEZXNmb3NzZXo8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAmbHQ7
PGEgaHJlZj0ibWFpbHRvOmpkZXNmb3NzZXpAZWZmaWNpb3MuY29tIj5qZGVzZm9zc2V6QGVmZmlj
aW9zLmNvbTwvYT4gJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86amRlc2Zvc3NlekBlZmZpY2lv
cy5jb20iPmpkZXNmb3NzZXpAZWZmaWNpb3MuY29tPC9hPiZndDs8YnI+DQo8L3NwYW4+Jmd0O8Kg
IMKgIMKgIMKgIMKgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86amRlc2Zvc3NlekBlZmZpY2lv
cy5jb20iPmpkZXNmb3NzZXpAZWZmaWNpb3MuY29tPC9hPjxicj4NCjxzcGFuIGNsYXNzPSIiPiZn
dDvCoCDCoCDCoCDCoCDCoCZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmpkZXNmb3NzZXpAZWZm
aWNpb3MuY29tIj5qZGVzZm9zc2V6QGVmZmljaW9zLmNvbTwvYT4mZ3Q7Jmd0OyZndDsgd3JvdGU6
PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoEhpLDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDs8YnI+DQom
Z3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBPbiAxNC0xMS0xMiAwNToz
MCBQTSwgSsOpcsOpbWllIEdhbGFybmVhdSB3cm90ZTo8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7IE9uIFdlZCwgTm92IDEyLCAyMDE0IGF0IDc6Mzkg
QU0sIEFuZGVycyBXYWxsaW48YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAmbHQ7PGEgaHJlZj0ibWFpbHRvOndhbGxpbnV4QGdtYWlsLmNvbSI+d2FsbGludXhA
Z21haWwuY29tPC9hPiAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzp3YWxsaW51eEBnbWFpbC5j
b20iPndhbGxpbnV4QGdtYWlsLmNvbTwvYT4mZ3Q7PGJyPg0KPC9zcGFuPjxkaXY+PGRpdiBjbGFz
cz0iaDUiPiZndDvCoCDCoCDCoCDCoCDCoCZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOndhbGxp
bnV4QGdtYWlsLmNvbSI+d2FsbGludXhAZ21haWwuY29tPC9hPiAmbHQ7bWFpbHRvOjxhIGhyZWY9
Im1haWx0bzp3YWxsaW51eEBnbWFpbC5jb20iPndhbGxpbnV4QGdtYWlsLmNvbTwvYT4mZ3Q7Jmd0
OyZndDsgd3JvdGU6PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgJmd0OyZndDsgSGksPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgJmd0OyZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqAmZ3Q7Jmd0OyB1c2luZyB1c2Vyc3BhY2Ugc25hcHNob3QgbW9kZSBpbiAyLjUgc2VlbXMg
dG88YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBicm9rZW4uPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0OyBJIGhhdmUgc21hbGwgc3R1cGlkIGFwcGxp
Y2F0aW9uKHRyYWNldGVzdCk8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBnZW5lcmF0aW5nPGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgMTAwMCBldmVudHM8YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0Ozxicj4N
CiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7IFJ1bm5p
bmcgdGhlIHNjcmlwdCAodGhlIGJlbG93IGlzIHNpbXBsaWZpZWQ8YnI+DQomZ3Q7wqAgwqAgwqAg
wqAgwqB2ZXJzaW9uIG9mPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgdGhlIHNjcmlwdCk8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAmZ3Q7Jmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAg
wqAgwqAgwqAgwqAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7ICMhL2Jpbi9iYXNoPGJyPg0KJmd0
O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDsgTFRUTkc9JiMz
OTtsdHRuZyAtbiYjMzk7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgJmd0OyZndDsgbHR0bmctc2Vzc2lvbmQgLS1uby1rZXJuZWwgJmFtcDs8YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyBZb3Ugc2hvdWxkIHVzZSB0aGUg
JnF1b3Q7LWQmcXVvdDsgZmxhZyB0byBsYXVuY2ggdGhlPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
c2Vzc2lvbmQgYXMgYTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoGRhZW1vbi4gVXNpbmc8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAmZ3Q7ICZxdW90OyZhbXA7JnF1b3Q7IG1pZ2h0IGNhdXNlIHRoZSAmcXVvdDtjcmVh
dGUmcXVvdDsgY29tbWFuZCB0byBsYXVuY2ggYTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoHNlY29u
ZDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoHNlc3Npb24g
ZGFlbW9uPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0
OyBzaW5jZSB0aGUgZmlyc3Qgb25lIHdvdWxkIG5vdCBoYXZlIGhhZCB0aGUgdGltZTxicj4NCiZn
dDvCoCDCoCDCoCDCoCDCoHRvIG9wZW48YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqBjcmVhdGUgaXRzPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgJmd0OyBjb21tYW5kIHNvY2tldHMuPGJyPg0KJmd0O8KgIMKgIMKgIMKg
IMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDsgJExUVE5HIGNyZWF0ZSB0ZXN0IC0tc25hcHNo
b3Q8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0
OyAkTFRUTkcgZW5hYmxlLWNoYW5uZWwgLXUgLS1zdWJidWYtc2l6ZSA2NGs8YnI+DQomZ3Q7wqAg
wqAgwqAgwqAgwqAtLW51bS1zdWJidWY8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAxNiAtLW92ZXJ3cml0ZSBjaDE8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0OyAkTFRUTkcgZW5hYmxlLWV2ZW50IC11IC1j
IGNoMSAmcXVvdDsqJnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgJmd0OyZndDsgJExUVE5HIHN0YXJ0PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDsgJExUVE5HIGxpc3QgY2gxPGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDs8YnI+DQomZ3Q7wqAg
wqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0OyBta2RpciAtcCBzbmFw
c2hvdC88YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7
Jmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsm
Z3Q7IGZvciBpIGluICQoc2VxIDEgJExPT1BTKTsgZG88YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgLi90cmFjZXRlc3Q8YnI+DQom
Z3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKg
JExUVE5HIHNuYXBzaG90IHJlY29yZCAtbSAxRzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDvCoCDCoCDCoCMgcHJpbnQgbm8gb2YgZXZlbnRzIGFu
ZCBmaXJzdCBhbmQgbGFzdCBldmVudDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqBsYXN0PSQobHMgLTFkcnQ8YnI+DQomZ3Q7wqAg
wqAgwqAgwqAgwqAkSE9NRS9sdHRuZy10cmFjZXMvJFNFU1NJT04qLyogfCB0YWlsIC0xKTxicj4N
CiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7wqAgwqAg
wqBiYWJlbHRyYWNlICRsYXN0ICZndDsgc25hcHNob3QvJDxhIGhyZWY9Imh0dHA6Ly9pLmJ0IiB0
YXJnZXQ9Il9ibGFuayI+aS5idDwvYT48YnI+DQo8L2Rpdj48L2Rpdj4mZ3Q7wqAgwqAgwqAgwqAg
wqAmbHQ7PGEgaHJlZj0iaHR0cDovL2kuYnQiIHRhcmdldD0iX2JsYW5rIj5odHRwOi8vaS5idDwv
YT4mZ3Q7ICZsdDs8YSBocmVmPSJodHRwOi8vaS5idCIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly9p
LmJ0PC9hPiZndDs8YnI+DQo8ZGl2PjxkaXYgY2xhc3M9Img1Ij4mZ3Q7wqAgwqAgwqAgwqAgwqAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgY2F0IHNuYXBzaG90LyQ8YSBo
cmVmPSJodHRwOi8vaS5idCIgdGFyZ2V0PSJfYmxhbmsiPmkuYnQ8L2E+ICZsdDs8YSBocmVmPSJo
dHRwOi8vaS5idCIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly9pLmJ0PC9hPiZndDs8YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAmbHQ7PGEgaHJlZj0iaHR0cDovL2kuYnQiIHRhcmdldD0iX2JsYW5rIj5o
dHRwOi8vaS5idDwvYT4mZ3Q7IHwgd2MgLWw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgY2F0IHNuYXBzaG90LyQ8YSBocmVmPSJo
dHRwOi8vaS5idCIgdGFyZ2V0PSJfYmxhbmsiPmkuYnQ8L2E+ICZsdDs8YSBocmVmPSJodHRwOi8v
aS5idCIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly9pLmJ0PC9hPiZndDs8YnI+DQomZ3Q7wqAgwqAg
wqAgwqAgwqAmbHQ7PGEgaHJlZj0iaHR0cDovL2kuYnQiIHRhcmdldD0iX2JsYW5rIj5odHRwOi8v
aS5idDwvYT4mZ3Q7IHwgaGVhZCAtMTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqBjYXQgc25hcHNob3QvJDxhIGhyZWY9Imh0dHA6
Ly9pLmJ0IiB0YXJnZXQ9Il9ibGFuayI+aS5idDwvYT4gJmx0OzxhIGhyZWY9Imh0dHA6Ly9pLmJ0
IiB0YXJnZXQ9Il9ibGFuayI+aHR0cDovL2kuYnQ8L2E+Jmd0Ozxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoCZsdDs8YSBocmVmPSJodHRwOi8vaS5idCIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly9pLmJ0
PC9hPiZndDsgfCB0YWlsIC0xPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgJmd0OyZndDsgZG9uZTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoCZndDsmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgJmd0OyZndDsgJExUVE5HIHN0b3A8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0OyAkTFRUTkcgZGVzdHJveSAkU0VTU0lPTjxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7PGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgJmd0OyZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAmZ3Q7Jmd0OyBUaGUgcmVzdWx0IG9mIHRoZSBydW4gbG9va3MgbGlrZSB0aGlzOzxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7IC4v
dGVzdC5ydW48YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAm
Z3Q7Jmd0OyBFcnJvcjogY29uc3VtZXIgZXJyIHNvY2tldCBzZWNvbmQgcG9sbCBlcnJvcjxicj4N
CiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7IEVycm9y
OiBIZWFsdGggZXJyb3Igb2NjdXJyZWQgaW48YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqB0aHJlYWRf
bWFuYWdlX2NvbnN1bWVyPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgJmd0OyZndDsgUEVSUk9SIC0gMTM6MzY6NTkuNjg1MTY3IFsyMzc3Mi8yMzc4MV06IGJp
bmQgaW5ldDo8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBB
ZGRyZXNzIGFscmVhZHkgaW4gdXNlPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgJmd0OyZndDsgKGluIGx0dGNvbW1fYmluZF9pbmV0X3NvY2soKSBhdCBpbmV0
LmM6MTA5KTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZn
dDsmZ3Q7IFdhcm5pbmc6IEFub3RoZXIgc2Vzc2lvbiBkYWVtb24gaXMgdXNpbmcgdGhpczxicj4N
CiZndDvCoCDCoCDCoCDCoCDCoEpVTCBwb3J0Ljxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoEpVTCBzdXBwb3J0IHdpbGwgYmU8YnI+DQomZ3Q7wqAgwqAgwqAg
wqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0OyBkZWFjdGl2YXRlZCB0byBwcmV2
ZW50IGludGVyZmVyaW5nIHdpdGggdGhlPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgdHJhY2luZy48
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0Ozxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDs8YnI+DQom
Z3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7IElzIHRoZXJlIGEg
cmVhc29uIHdoeSB5b3UgcnVuIHR3byBzZXNzaW9uPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgZGFl
bW9ucz8gSSYjMzk7bTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoGd1ZXNzaW5nIHRoaXM8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAmZ3Q7IGlzIHJlbGF0ZWQgdG8gbXkgJnF1b3Q7JmFtcDsgdnMgLWQmcXVvdDsgY29t
bWVudCBhYm92ZS48YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0
OyZndDsgbHR0bmcgKExUVG5nIFRyYWNlIENvbnRyb2wpIDIuNS4yIC0gRnVtaXN0ZXJpZTxicj4N
CiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7IEJhYmVs
VHJhY2UgVHJhY2UgVmlld2VyIGFuZCBDb252ZXJ0ZXIgMS4yLjQ8YnI+DQomZ3Q7wqAgwqAgwqAg
wqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgIMKgIMKgbGludXgt
dmRzby5zby4xID0mZ3Q7wqAgKDB4MDAwMDdmZmZiYTk2NjAwMCk8YnI+DQomZ3Q7wqAgwqAgwqAg
wqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgIMKgIMKgbGlibHR0
bmctY3RsLnNvLjAgPSZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAvdXNyL2xpYi94ODZfNjQtbGludXgtZ251L2xpYmx0dG5nLWN0bC5zby4wPGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDsgKDB4MDAw
MDdmYmZlNGIxZDAwMCk8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgIMKgIMKgbGlicnQuc28uMSA9Jmd0Ozxicj4NCiZndDvCoCDC
oCDCoCDCoCDCoC9saWIveDg2XzY0LWxpbnV4LWdudS9saWJydC5zby4xPGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgKDB4MDAwMDdmYmZlNDkxNTAwMCk8YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0O8KgIMKg
IMKgIMKgIMKgbGlieG1sMi5zby4yID0mZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgL3Vzci9saWIveDg2XzY0LWxpbnV4LWdudS9saWJ4bWwyLnNvLjI8
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0OyAo
MHgwMDAwN2ZiZmU0NWFlMDAwKTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqAgwqAgwqBsaWJwb3B0LnNvLjAgPSZndDs8YnI+DQom
Z3Q7wqAgwqAgwqAgwqAgwqAvbGliL3g4Nl82NC1saW51eC1nbnUvbGlicG9wdC5zby4wPGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDsgKDB4MDAw
MDdmYmZlNDNhMjAwMCk8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgIMKgIMKgbGlicHRocmVhZC5zby4wID0mZ3Q7PGJyPg0KJmd0
O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgL2xpYi94ODZfNjQtbGludXgt
Z251L2xpYnB0aHJlYWQuc28uMDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCZndDsmZ3Q7ICgweDAwMDA3ZmJmZTQxODQwMDApPGJyPg0KJmd0O8KgIMKgIMKg
IMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDvCoCDCoCDCoCDCoCDCoGxpYmMu
c28uNiA9Jmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoC9saWIveDg2XzY0LWxpbnV4LWdudS9s
aWJjLnNvLjY8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAo
MHgwMDAwN2ZiZmUzZGJkMDAwKTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqAgwqAgwqAvbGliNjQvbGQtbGludXgteDg2LTY0LnNv
LjI8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAoMHgwMDAwN2ZiZmU0ZmFjMDAwKTxicj4NCiZndDvC
oCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqAgwqAg
wqBsaWJ1cmN1LnNvLjIgPSZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAvdXNyL2xpYi94ODZfNjQtbGludXgtZ251L2xpYnVyY3Uuc28uMjxicj4NCiZn
dDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7ICgweDAwMDA3
ZmJmZTNiYjYwMDApPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgJmd0OyZndDvCoCDCoCDCoCDCoCDCoGxpYmRsLnNvLjIgPSZndDs8YnI+DQomZ3Q7wqAgwqAg
wqAgwqAgwqAvbGliL3g4Nl82NC1saW51eC1nbnUvbGliZGwuc28uMjxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCgweDAwMDA3ZmJmZTM5YjIwMDApPGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDvCoCDCoCDC
oCDCoCDCoGxpYnouc28uMSA9Jmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoC9saWIveDg2XzY0
LWxpbnV4LWdudS9saWJ6LnNvLjE8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAoMHgwMDAwN2ZiZmUzNzk4MDAwKTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqAgwqAgwqBsaWJsem1hLnNvLjUg
PSZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAvbGliL3g4Nl82NC1saW51eC1nbnUvbGlibHpt
YS5zby41PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0
OyZndDsgKDB4MDAwMDdmYmZlMzU3NjAwMCk8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgIMKgIMKgbGlibS5zby42ID0mZ3Q7PGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgL2xpYi94ODZfNjQtbGludXgtZ251L2xpYm0uc28uNjxicj4N
CiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCgweDAwMDA3ZmJmZTMy
NzAwMDApPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0
OyZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7
Jmd0OyBTZXNzaW9uIHRlc3QgY3JlYXRlZC48YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0OyBEZWZhdWx0IHNuYXBzaG90IG91dHB1dCBzZXQgdG86
PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDsg
L2hvbWUvYXdhbGxpbi9sdHRuZy10cmFjZXMvdGVzdC0yMDE0MTExMi0xMzM3MDA8YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0OyBTbmFwc2hvdCBt
b2RlIHNldC4gRXZlcnkgY2hhbm5lbCBlbmFibGVkIGZvcjxicj4NCiZndDvCoCDCoCDCoCDCoCDC
oHRoYXQgc2Vzc2lvbjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoHdpbGwgYmUgc2V0IGluPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgJmd0OyZndDsgb3ZlcndyaXRlIG1vZGUgYW5kIG1tYXAgb3V0cHV0Ljxicj4NCiZn
dDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7IFVTVCBjaGFu
bmVsIGNoMSBlbmFibGVkIGZvciBzZXNzaW9uIHRlc3Q8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0OyBVU1QgZXZlbnQgKiBjcmVhdGVkIGluIGNo
YW5uZWwgY2gxPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
Jmd0OyZndDsgVHJhY2luZyBzdGFydGVkIGZvciBzZXNzaW9uIHRlc3Q8YnI+DQomZ3Q7wqAgwqAg
wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0OyBUcmFjaW5nIHNlc3Npb24g
dGVzdDogW2FjdGl2ZSBzbmFwc2hvdF08YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgVHJhY2UgcGF0aDo8YnI+DQomZ3Q7wqAgwqAg
wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgTGl2ZSB0aW1l
ciBpbnRlcnZhbCAodXNlYyk6IDQyOTQ5NjcyOTU8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7ID09PSBEb21haW46IFVTVCBnbG9iYWwgPT09PGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDs8YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0OyBDaGFu
bmVsczo8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7
Jmd0OyAtLS0tLS0tLS0tLS0tPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgJmd0OyZndDsgLSBjaDE6IFtlbmFibGVkXTxicj4NCiZndDvCoCDCoCDCoCDCoCDC
oCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDvCoCDCoCDCoEF0dHJpYnV0ZXM6PGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDvCoCDCoCDC
oCDCoG92ZXJ3cml0ZSBtb2RlOiAxPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgJmd0OyZndDvCoCDCoCDCoCDCoHN1YmJ1ZmVycyBzaXplOiA0MDk2PGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDvCoCDCoCDC
oCDCoG51bWJlciBvZiBzdWJidWZlcnM6IDE2PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDvCoCDCoCDCoCDCoHN3aXRjaCB0aW1lciBpbnRlcnZh
bDogMDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsm
Z3Q7wqAgwqAgwqAgwqByZWFkIHRpbWVyIGludGVydmFsOiAwPGJyPg0KJmd0O8KgIMKgIMKgIMKg
IMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDvCoCDCoCDCoCDCoHRyYWNlIGZpbGUg
Y291bnQ6IDA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAm
Z3Q7Jmd0O8KgIMKgIMKgIMKgdHJhY2UgZmlsZSBzaXplIChieXRlcyk6IDA8YnI+DQomZ3Q7wqAg
wqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgIMKgb3V0
cHV0OiBtbWFwKCk8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAmZ3Q7Jmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCZndDsmZ3Q7wqAgwqAgwqBFdmVudHM6PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgJmd0OyZndDvCoCDCoCDCoCDCoCogKHR5cGU6IHRyYWNlcG9pbnQpIFtl
bmFibGVkXTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZn
dDsmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0
OyZndDsgU25hcHNob3QgcmVjb3JkZWQgc3VjY2Vzc2Z1bGx5IGZvciBzZXNzaW9uIHRlc3Q8YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0OyA4NDxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7IFsx
MzozNzowMC44NTI2MTU5NTBdICgrPy4/Pz8/Pz8/Pz8pPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
YXJuLWF3YWxsaW4tbWludC1sMzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCZndDsmZ3Q7IHVzdF9iYWRkcl9zdGF0ZWR1bXA6c29pbmZvOiB7IGNwdV9pZCA9
IDQgfSwgezxicj4NCiZndDvCoCDCoCDCoCDCoCDCoGJhZGRyID08YnI+DQomZ3Q7wqAgwqAgwqAg
wqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAweDdGRkZDNkJDNzAwMCwgc29wYXRoPGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDsgPSAmcXVv
dDtbdmRzb10mcXVvdDssIHNpemUgPSAwLCBtdGltZSA9IC0xIH08YnI+DQomZ3Q7wqAgwqAgwqAg
wqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0OyBbMTM6Mzc6MDAuODUzNzk4OTQ5
XSAoKzAuMDAwMDAwODA1KTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoGFybi1hd2FsbGluLW1pbnQt
bDM8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqB0cmFjZXRl
c3Q6Zmlyc3RfdHA6PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgJmd0OyZndDsgeyBjcHVfaWQgPSA2IH0sIHsgbXlfc3RyaW5nX2ZpZWxkID0gJnF1b3Q7dGVz
dCZxdW90Oyw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBt
eV9pbnRlZ2VyX2ZpZWxkID0gOTk5IH08YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0OyBTbmFwc2hvdCByZWNvcmRlZCBzdWNjZXNzZnVsbHkgZm9y
IHNlc3Npb24gdGVzdDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCZndDsmZ3Q7IDE1Nzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCZndDsmZ3Q7IFsxMzozNzowMC44NTM3MzUxOTVdICgrPy4/Pz8/Pz8/Pz8pPGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgYXJuLWF3YWxsaW4tbWludC1sMzxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoHRyYWNldGVzdDpmaXJzdF90cDo8YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0OyB7IGNwdV9pZCA9
IDYgfSwgeyBteV9zdHJpbmdfZmllbGQgPSAmcXVvdDt0ZXN0JnF1b3Q7LDxicj4NCiZndDvCoCDC
oCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoG15X2ludGVnZXJfZmllbGQgPSA5Mjcg
fTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7
IFsxMzozNzowMC44OTQ4MzkxMTZdICgrMC4wMDAwMDAyOTkpPGJyPg0KJmd0O8KgIMKgIMKgIMKg
IMKgYXJuLWF3YWxsaW4tbWludC1sMzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoHRyYWNldGVzdDpmaXJzdF90cDo8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0OyB7IGNwdV9pZCA9IDUgfSwgeyBteV9zdHJp
bmdfZmllbGQgPSAmcXVvdDt0ZXN0JnF1b3Q7LDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoG15X2ludGVnZXJfZmllbGQgPSA5OTkgfTxicj4NCiZndDvCoCDC
oCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7IFNuYXBzaG90IHJlY29y
ZGVkIHN1Y2Nlc3NmdWxseSBmb3Igc2Vzc2lvbiB0ZXN0PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDsgMTY4PGJyPg0KJmd0O8KgIMKgIMKgIMKg
IMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDsgWzEzOjM3OjAwLjg1MzczNTE5NV0g
KCs/Lj8/Pz8/Pz8/Pyk8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBhcm4tYXdhbGxpbi1taW50LWwz
PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgdHJhY2V0ZXN0
OmZpcnN0X3RwOjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCZndDsmZ3Q7IHsgY3B1X2lkID0gNiB9LCB7IG15X3N0cmluZ19maWVsZCA9ICZxdW90O3Rlc3Qm
cXVvdDssPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgbXlf
aW50ZWdlcl9maWVsZCA9IDkyNyB9PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgJmd0OyZndDsgWzEzOjM3OjAwLjkyOTQ0NzMzMF0gKCswLjAwMDAwMDMwNSk8
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBhcm4tYXdhbGxpbi1taW50LWwzPGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgdHJhY2V0ZXN0OmZpcnN0X3RwOjxicj4N
CiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7IHsgY3B1
X2lkID0gNSB9LCB7IG15X3N0cmluZ19maWVsZCA9ICZxdW90O3Rlc3QmcXVvdDssPGJyPg0KJmd0
O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgbXlfaW50ZWdlcl9maWVsZCA9
IDk5OSB9PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0
OyZndDsgU25hcHNob3QgcmVjb3JkZWQgc3VjY2Vzc2Z1bGx5IGZvciBzZXNzaW9uIHRlc3Q8YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgU29tZXRoaW5nIGlzIHdyb25nIGZyb20gaGVyZTo8YnI+DQomZ3Q7wqAg
wqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0OyAxNjg8YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0OyBbMTM6Mzc6MDAu
ODk0NDExMTE3XSAoKz8uPz8/Pz8/Pz8/KTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoGFybi1hd2Fs
bGluLW1pbnQtbDM8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAmZ3Q7Jmd0OyB1c3RfYmFkZHJfc3RhdGVkdW1wOnNvaW5mbzogeyBjcHVfaWQgPSA0IH0sIHs8
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBiYWRkciA9IDB4N0ZGRjZCRjgxMDAwLCBzb3BhdGg8YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0OyA9ICZx
dW90O1t2ZHNvXSZxdW90Oywgc2l6ZSA9IDAsIG10aW1lID0gLTEgfTxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7IFsxMzozNzowMC45NzIwMzU1
NDZdICgrMC4wMDAwMDA1OTcpPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgYXJuLWF3YWxsaW4tbWlu
dC1sMyB0cmFjZXRlc3Q6Zmlyc3RfdHA6PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgJmd0OyZndDsgeyBjcHVfaWQgPSA2IH0sIHsgbXlfc3RyaW5nX2ZpZWxk
ID0gJnF1b3Q7dGVzdCZxdW90Oyw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBteV9pbnRlZ2VyX2Zp
ZWxkID0gOTk5IH08YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAmZ3Q7Jmd0OyBTbmFwc2hvdCByZWNvcmRlZCBzdWNjZXNzZnVsbHkgZm9yIHNlc3Npb24gdGVz
dDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7
IDE2ODxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsm
Z3Q7IFsxMzozNzowMC44OTQ0MTExMTddICgrPy4/Pz8/Pz8/Pz8pPGJyPg0KJmd0O8KgIMKgIMKg
IMKgIMKgYXJuLWF3YWxsaW4tbWludC1sMzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7IHVzdF9iYWRkcl9zdGF0ZWR1bXA6c29pbmZvOiB7IGNw
dV9pZCA9IDQgfSwgezxicj4NCiZndDvCoCDCoCDCoCDCoCDCoGJhZGRyID0gMHg3RkZGNkJGODEw
MDAsIHNvcGF0aDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCZndDsmZ3Q7ID0gJnF1b3Q7W3Zkc29dJnF1b3Q7LCBzaXplID0gMCwgbXRpbWUgPSAtMSB9PGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDsgWzEz
OjM3OjAxLjAxNDA2MDk0MCAmbHQ7dGVsOjAxNDA2MDk0MCZndDs8YnI+DQo8L2Rpdj48L2Rpdj4m
Z3Q7wqAgwqAgwqAgwqAgwqAmbHQ7dGVsOjxhIGhyZWY9InRlbDowMTQwNjA5NDAiIHZhbHVlPSIr
NDYxNDA2MDk0MCI+MDE0MDYwOTQwPC9hPiAmbHQ7dGVsOjxhIGhyZWY9InRlbDowMTQwNjA5NDAi
IHZhbHVlPSIrNDYxNDA2MDk0MCI+MDE0MDYwOTQwPC9hPiZndDsmZ3Q7XSAoKzAuMDAwMDAwMzQx
KTxicj4NCjxzcGFuIGNsYXNzPSIiPiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoGFybi1hd2FsbGluLW1pbnQtbDMgdHJhY2V0ZXN0OmZpcnN0X3RwOjxicj4NCiZndDvC
oCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7IHsgY3B1X2lkID0g
NyB9LCB7IG15X3N0cmluZ19maWVsZCA9ICZxdW90O3Rlc3QmcXVvdDssIG15X2ludGVnZXJfZmll
bGQgPSA5OTkgfTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCZndDsmZ3Q7IFNuYXBzaG90IHJlY29yZGVkIHN1Y2Nlc3NmdWxseSBmb3Igc2Vzc2lvbiB0ZXN0
PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDsg
MTY4PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZn
dDsgWzEzOjM3OjAwLjg5NDQxMTExN10gKCs/Lj8/Pz8/Pz8/PykgYXJuLWF3YWxsaW4tbWludC1s
Mzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7
IHVzdF9iYWRkcl9zdGF0ZWR1bXA6c29pbmZvOiB7IGNwdV9pZCA9IDQgfSwgeyBiYWRkciA9IDB4
N0ZGRjZCRjgxMDAwLCBzb3BhdGg8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAmZ3Q7Jmd0OyA9ICZxdW90O1t2ZHNvXSZxdW90Oywgc2l6ZSA9IDAsIG10aW1l
ID0gLTEgfTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZn
dDsmZ3Q7IFsxMzozNzowMS4wNTI1NTU4NzcgJmx0O3RlbDowNTI1NTU4NzcmZ3Q7PGJyPg0KPC9z
cGFuPiZndDvCoCDCoCDCoCDCoCDCoCZsdDt0ZWw6PGEgaHJlZj0idGVsOjA1MjU1NTg3NyIgdmFs
dWU9Iis0NjUyNTU1ODc3Ij4wNTI1NTU4Nzc8L2E+ICZsdDt0ZWw6PGEgaHJlZj0idGVsOjA1MjU1
NTg3NyIgdmFsdWU9Iis0NjUyNTU1ODc3Ij4wNTI1NTU4Nzc8L2E+Jmd0OyZndDtdICgrMC4wMDAw
MDA4NzIpPGJyPg0KPHNwYW4gY2xhc3M9IiI+Jmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgYXJuLWF3YWxsaW4tbWludC1sMyB0cmFjZXRlc3Q6Zmlyc3RfdHA6PGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDsgeyBjcHVf
aWQgPSA2IH0sIHsgbXlfc3RyaW5nX2ZpZWxkID0gJnF1b3Q7dGVzdCZxdW90OywgbXlfaW50ZWdl
cl9maWVsZCA9IDk5OSB9PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgLi4uIHRvIGhlcmUuPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0Ozxicj4NCiZndDvC
oCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoFRoZSBiZWdpbm5pbmcgdGltZXN0
YW1wIGlzIHRoZSBzYW1lLCB0aGUgbnVtYmVyIG9mIGV2ZW50cyBpczxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoHRoZSBzYW1lLDxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoGJ1dCB0aGUgZW5kIHRpbWVzdGFtcCBtb3Zl
cy4gV2Ugc2VlIGFsc28gdGhpcyBwYXR0ZXJuIGJlbG93Ljxicj4NCiZndDvCoCDCoCDCoCDCoCDC
oCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoEkgd291bGQgYmUgcmVhbGx5IGludGVyZXN0ZWQgdG8g
c2VlIHRoZSB3aG9sZSBzbmFwc2hvdHMgd2hlbjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoGl0IGhhcHBlbnMuPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgSXQgc2VlbXMgbGlrZSB3ZSBhcmUgbm90IGJlIG92ZXJ3cml0
aW5nIHRoZSBiZWdpbm5pbmcgb2YgdGhlPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgcmluZyBidWZmZXI8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqBpbiBzb21lIGNvbmRpdGlvbnMuIENvdWxkIHlvdSBzZW5kIHVzIHlv
dXIgdHJhY2V0ZXN0IHByb2dyYW08YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqBhbmQgdGhlPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgc2NyaXB0IHNvIHdlIGNhbiB0cnkgdG8gcmVwcm9kdWNlIHRoZSBwcm9ibGVtID88
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0Ozxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoEkgd2lsbCBhcHBlbmQgaXQg
aW5jbHVkaW5nIGEgcnVuIHdpdGggZGVidWcgdHVybmVkIG9uIGFuZCBhbGw8YnI+DQomZ3Q7wqAg
wqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqB0aGUgc25hcHNob3QgZmlsZXMgY3JlYXRlZDxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7PGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7IFNuYXBzaG90IHJlY29yZGVkIHN1Y2Nlc3NmdWxseSBm
b3Igc2Vzc2lvbiB0ZXN0PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgJmd0OyZndDsgMTY4PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgJmd0OyZndDsgWzEzOjM3OjAxLjxhIGhyZWY9InRlbDowMTQwMzU5OTMiIHZhbHVl
PSIrNDYxNDAzNTk5MyI+MDE0MDM1OTkzPC9hPiAmbHQ7dGVsOjxhIGhyZWY9InRlbDowMTQwMzU5
OTMiIHZhbHVlPSIrNDYxNDAzNTk5MyI+MDE0MDM1OTkzPC9hPiZndDs8YnI+DQo8L3NwYW4+Jmd0
O8KgIMKgIMKgIMKgIMKgJmx0O3RlbDo8YSBocmVmPSJ0ZWw6MDE0MDM1OTkzIiB2YWx1ZT0iKzQ2
MTQwMzU5OTMiPjAxNDAzNTk5MzwvYT4gJmx0O3RlbDo8YSBocmVmPSJ0ZWw6MDE0MDM1OTkzIiB2
YWx1ZT0iKzQ2MTQwMzU5OTMiPjAxNDAzNTk5MzwvYT4mZ3Q7Jmd0O10gKCs/Lj8/Pz8/Pz8/Pyk8
YnI+DQo8c3BhbiBjbGFzcz0iIj4mZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqBhcm4tYXdhbGxpbi1taW50LWwzIHRyYWNldGVzdDpmaXJzdF90cDo8YnI+DQomZ3Q7wqAg
wqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0OyB7IGNwdV9pZCA9IDcg
fSwgeyBteV9zdHJpbmdfZmllbGQgPSAmcXVvdDt0ZXN0JnF1b3Q7LDxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoG15X2ludGVnZXJfZmllbGQgPSA5MjcgfTxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7IFsx
MzozNzowMS4wOTg2MjA4MDhdICgrMC4wMDAwMDE0MDQpIGFybi1hd2FsbGluLW1pbnQtbDM8YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqB0cmFjZXRlc3Q6Zmly
c3RfdHA6PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0
OyZndDsgeyBjcHVfaWQgPSA0IH0sIHsgbXlfc3RyaW5nX2ZpZWxkID0gJnF1b3Q7dGVzdCZxdW90
Oyw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBteV9pbnRl
Z2VyX2ZpZWxkID0gOTk5IH08YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAmZ3Q7Jmd0OyBTbmFwc2hvdCByZWNvcmRlZCBzdWNjZXNzZnVsbHkgZm9yIHNlc3Np
b24gdGVzdDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZn
dDsmZ3Q7IDE2ODxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCZndDsmZ3Q7IFsxMzozNzowMS4wOTcwODczODggJmx0O3RlbDowOTcwODczODgmZ3Q7PGJyPg0K
PC9zcGFuPiZndDvCoCDCoCDCoCDCoCDCoCZsdDt0ZWw6PGEgaHJlZj0idGVsOjA5NzA4NzM4OCIg
dmFsdWU9Iis0Njk3MDg3Mzg4Ij4wOTcwODczODg8L2E+ICZsdDt0ZWw6PGEgaHJlZj0idGVsOjA5
NzA4NzM4OCIgdmFsdWU9Iis0Njk3MDg3Mzg4Ij4wOTcwODczODg8L2E+Jmd0OyZndDtdICgrPy4/
Pz8/Pz8/Pz8pPGJyPg0KPHNwYW4gY2xhc3M9IiI+Jmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgYXJuLWF3YWxsaW4tbWludC1sMzxicj4NCiZndDvCoCDCoCDCoCDCoCDC
oCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7IHVzdF9iYWRkcl9zdGF0ZWR1bXA6c29p
bmZvOiB7IGNwdV9pZCA9IDYgfSwgeyBiYWRkciA9PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgMHg3RkZGNEJGRkUwMDAsIHNvcGF0aDxicj4NCiZndDvCoCDC
oCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7ID0gJnF1b3Q7W3Zkc29d
JnF1b3Q7LCBzaXplID0gMCwgbXRpbWUgPSAtMSB9PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDsgWzEzOjM3OjAxLjEyOTgzOTgzMF0gKCswLjAw
MDAwMDUzMykgYXJuLWF3YWxsaW4tbWludC1sMzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoHRyYWNldGVzdDpmaXJzdF90cDo8YnI+DQomZ3Q7wqAgwqAgwqAg
wqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0OyB7IGNwdV9pZCA9IDcgfSwgeyBt
eV9zdHJpbmdfZmllbGQgPSAmcXVvdDt0ZXN0JnF1b3Q7LDxicj4NCiZndDvCoCDCoCDCoCDCoCDC
oCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoG15X2ludGVnZXJfZmllbGQgPSA5OTkgfTxicj4NCiZn
dDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7IFNuYXBzaG90
IHJlY29yZGVkIHN1Y2Nlc3NmdWxseSBmb3Igc2Vzc2lvbiB0ZXN0PGJyPg0KJmd0O8KgIMKgIMKg
IMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDsgMTY4PGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDsgWzEzOjM3OjAxLjA5NzA4
NzM4OCAmbHQ7dGVsOjA5NzA4NzM4OCZndDs8YnI+DQo8L3NwYW4+Jmd0O8KgIMKgIMKgIMKgIMKg
Jmx0O3RlbDo8YSBocmVmPSJ0ZWw6MDk3MDg3Mzg4IiB2YWx1ZT0iKzQ2OTcwODczODgiPjA5NzA4
NzM4ODwvYT4gJmx0O3RlbDo8YSBocmVmPSJ0ZWw6MDk3MDg3Mzg4IiB2YWx1ZT0iKzQ2OTcwODcz
ODgiPjA5NzA4NzM4ODwvYT4mZ3Q7Jmd0O10gKCs/Lj8/Pz8/Pz8/Pyk8YnI+DQo8c3BhbiBjbGFz
cz0iIj4mZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBhcm4tYXdhbGxp
bi1taW50LWwzPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
Jmd0OyZndDsgdXN0X2JhZGRyX3N0YXRlZHVtcDpzb2luZm86IHsgY3B1X2lkID0gNiB9LCB7IGJh
ZGRyID08YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAweDdG
RkY0QkZGRTAwMCwgc29wYXRoPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgJmd0OyZndDsgPSAmcXVvdDtbdmRzb10mcXVvdDssIHNpemUgPSAwLCBtdGltZSA9
IC0xIH08YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7
Jmd0OyBbMTM6Mzc6MDEuMTI5ODM5ODMwXSAoKzAuMDAwMDAwNTMzKSBhcm4tYXdhbGxpbi1taW50
LWwzPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgdHJhY2V0
ZXN0OmZpcnN0X3RwOjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCZndDsmZ3Q7IHsgY3B1X2lkID0gNyB9LCB7IG15X3N0cmluZ19maWVsZCA9ICZxdW90O3Rl
c3QmcXVvdDssPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
bXlfaW50ZWdlcl9maWVsZCA9IDk5OSB9PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgJmd0OyZndDsgU25hcHNob3QgcmVjb3JkZWQgc3VjY2Vzc2Z1bGx5IGZv
ciBzZXNzaW9uIHRlc3Q8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqAmZ3Q7Jmd0OyAxNjg8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAmZ3Q7Jmd0OyBbMTM6Mzc6MDEuMDk3MDg3Mzg4ICZsdDt0ZWw6MDk3MDg3Mzg4Jmd0
Ozxicj4NCjwvc3Bhbj4mZ3Q7wqAgwqAgwqAgwqAgwqAmbHQ7dGVsOjA5NzA4NzM4OCAmbHQ7dGVs
OjA5NzA4NzM4OCZndDsmZ3Q7XSAoKz8uPz8/Pz8/Pz8/KTxicj4NCjxkaXY+PGRpdiBjbGFzcz0i
aDUiPiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoGFybi1hd2FsbGlu
LW1pbnQtbDM8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAm
Z3Q7Jmd0OyB1c3RfYmFkZHJfc3RhdGVkdW1wOnNvaW5mbzogeyBjcHVfaWQgPSA2IH0sIHs8YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqBiYWRkciA9PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgMHg3RkZGNEJGRkUwMDAsIHNvcGF0aDxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7ID0gJnF1b3Q7W3Zkc29dJnF1
b3Q7LCBzaXplID0gMCwgbXRpbWUgPSAtMSB9PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDsgWzEzOjM3OjAxLjE3MjgyOTEwNV0gKCswLjAwMDAw
MDU3NSk8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBhcm4tYXdhbGxpbi1taW50LWwzPGJyPg0KJmd0
O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgdHJhY2V0ZXN0OmZpcnN0X3Rw
Ojxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7
IHsgY3B1X2lkID0gNSB9LCB7IG15X3N0cmluZ19maWVsZCA9ICZxdW90O3Rlc3QmcXVvdDssPGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgbXlfaW50ZWdlcl9m
aWVsZCA9IDk5OSB9PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgJmd0OyZndDsgU25hcHNob3QgcmVjb3JkZWQgc3VjY2Vzc2Z1bGx5IGZvciBzZXNzaW9uIHRl
c3Q8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0
OyAxNjg8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7
Jmd0OyBbMTM6Mzc6MDEuMTcyMDIxNTU3XSAoKz8uPz8/Pz8/Pz8/KTxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoGFybi1hd2FsbGluLW1pbnQtbDM8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0OyB1c3RfYmFkZHJfc3RhdGVkdW1wOnNvaW5mbzogeyBj
cHVfaWQgPSA3IH0sIHs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBiYWRkciA9PGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgMHg3RkZGNjUzRkUwMDAsIHNvcGF0
aDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7
ID0gJnF1b3Q7W3Zkc29dJnF1b3Q7LCBzaXplID0gMCwgbXRpbWUgPSAtMSB9PGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDsgWzEzOjM3OjAxLjIy
MDA3NDE2NV0gKCswLjAwMDAwMDU1Myk8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBhcm4tYXdhbGxp
bi1taW50LWwzPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
dHJhY2V0ZXN0OmZpcnN0X3RwOjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCZndDsmZ3Q7IHsgY3B1X2lkID0gNiB9LCB7IG15X3N0cmluZ19maWVsZCA9ICZx
dW90O3Rlc3QmcXVvdDssPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgbXlfaW50ZWdlcl9maWVsZCA9IDk5OSB9PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyZndDsgV2FpdGluZyBmb3IgZGF0YSBhdmFpbGFiaWxp
dHk8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0
OyBUcmFjaW5nIHN0b3BwZWQgZm9yIHNlc3Npb24gdGVzdDxicj4NCiZndDvCoCDCoCDCoCDCoCDC
oCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7IFNlc3Npb24gdGVzdCBkZXN0cm95ZWQ8
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7Jmd0Ozxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsmZ3Q7IHRo
ZSByZXN1bHQgZnJvbSB0aGUgcnVuIG9uIG9sZGVyIHZlcnNpb25zIG9mIGx0dG5nPGJyPg0KJmd0
O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgY3JlYXRlcyBiaWdnZXIgYW5k
IGJpZ2dlcjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZn
dDsmZ3Q7IGV2ZW50IHRyYWNlcyB1bnRpbCByZWFjaGluZyBtYXggc2l6ZS48YnI+DQomZ3Q7wqAg
wqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBXZSBzZWUgdGhpcyBwYXR0ZXJuIGhl
cmUgYW5kIHRoZSBtYXggc2l6ZSBzZWVtcyB0bzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoGJlIDE2
ODxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoGV2ZW50cywg
d2FzIGl0PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgc2lt
aWxhciBpbiB5b3VyIHByZXZpb3VzIHRlc3RzID88YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7
PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgSWYgSSYjMzk7bSBydW5u
aW5nIHRoZSBzYW1lIHRlc3Qgb24gMi40IG9yIDIuMyB0aGUgbWF4PGJyPg0KJmd0O8KgIMKgIMKg
IMKgIMKgbnVtYmVyIG9mPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKg
ZXZlbnRzIGlzIG11Y2ggYmlnZ2VyLCBsaWtlIH4xMDAwMDxicj4NCiZndDvCoCDCoCDCoCDCoCDC
oCZndDvCoCDCoCDCoCDCoCDCoChJIGRvbiYjMzk7dCBoYXZlIHRoZSBleGFjdCBudW1iZXIgcmln
aHQgbm93LCBJIHdpbGw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqByZWJ1aWxkIGFuZCBydW48YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqB0aGUgdGVzdCBhZ2FpbiBhbmQg
Z2V0IGJhY2s8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqB3aXRoIHRy
YWNlcyBmcm9tIHRoYXQgcnVuKTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDs8YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqBGb3IgMi40LjIgdGhlIGxvZyBsb29rcyBsaWtlIHRo
aXM6PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgLi90ZXN0LnJ1biAuL3RyYWNl
dGVzdDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAm
Z3Q7wqAgwqAgwqBsdHRuZyAoTFRUbmcgVHJhY2UgQ29udHJvbCkgMi40LjIgLSDDiXBvcXVlIE9w
YXF1ZTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoEJhYmVsVHJhY2UgVHJhY2Ug
Vmlld2VyIGFuZCBDb252ZXJ0ZXIgMS4yLjE8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAg
wqAgwqBsaW51eC12ZHNvLnNvLjEgPSZndDvCoCAoMHgwMDAwN2ZmZjc3NWZlMDAwKTxicj4NCiZn
dDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoGxpYmx0dG5nLWN0bC5zby4wID0mZ3Q7IC91c3Iv
bG9jYWwvbGliL2xpYmx0dG5nLWN0bC5zby4wPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8Kg
IMKgIMKgKDB4MDAwMDJiMmIwMTZlNDAwMCk8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAg
wqAgwqBsaWJwb3B0LnNvLjAgPSZndDsgL2xpYi94ODZfNjQtbGludXgtZ251L2xpYnBvcHQuc28u
MDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCgweDAwMDAyYjJiMDE5MGYwMDApPGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgbGlicHRocmVhZC5zby4wID0mZ3Q7IC9saWIveDg2XzY0
LWxpbnV4LWdudS9saWJwdGhyZWFkLnNvLjA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAg
wqAgwqAoMHgwMDAwMmIyYjAxYjFiMDAwKTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDC
oCDCoGxpYmMuc28uNiA9Jmd0OyAvbGliL3g4Nl82NC1saW51eC1nbnUvbGliYy5zby42PGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgKDB4MDAwMDJiMmIwMWQzOTAwMCk8YnI+DQomZ3Q7wqAgwqAgwqAg
wqAgwqAmZ3Q7wqAgwqAgwqBsaWJydC5zby4xID0mZ3Q7IC9saWIveDg2XzY0LWxpbnV4LWdudS9s
aWJydC5zby4xPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgKDB4MDAwMDJiMmIwMjBmZjAwMCk8YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqBsaWJ1cmN1LnNvLjMgPSZndDsgL3Vzci9s
b2NhbC9saWIvbGlidXJjdS5zby4zPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgKDB4MDAwMDJiMmIw
MjMwNzAwMCk8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAvbGliNjQvbGQtbGlu
dXgteDg2LTY0LnNvLjIgKDB4MDAwMDJiMmIwMTRiZjAwMCk8YnI+DQomZ3Q7wqAgwqAgwqAgwqAg
wqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgU2Vzc2lvbiB0ZXN0IGNy
ZWF0ZWQuPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgRGVmYXVsdCBzbmFwc2hv
dCBvdXRwdXQgc2V0IHRvOjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoC8vbHR0bmctdHJhY2VzL3Rl
c3QtMjAxNDExMTMtMDkzNjExPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgU25h
cHNob3QgbW9kZSBzZXQuIEV2ZXJ5IGNoYW5uZWwgZW5hYmxlZCBmb3IgdGhhdCBzZXNzaW9uPGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgd2lsbCBiZTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvC
oCDCoCDCoHNldCBpbiBvdmVyd3JpdGUgbW9kZSBhbmQgbW1hcCBvdXRwdXQuPGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgVVNUIGNoYW5uZWwgY2gxIGVuYWJsZWQgZm9yIHNlc3Np
b24gdGVzdDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoFVTVCBldmVudCAqIGNy
ZWF0ZWQgaW4gY2hhbm5lbCBjaDE8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqBU
cmFjaW5nIHN0YXJ0ZWQgZm9yIHNlc3Npb24gdGVzdDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZn
dDvCoCDCoCDCoFRyYWNpbmcgc2Vzc2lvbiB0ZXN0OiBbYWN0aXZlIHNuYXBzaG90XTxicj4NCiZn
dDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoFRyYWNlIHBhdGg6PGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoD09PSBE
b21haW46IFVTVCBnbG9iYWwgPT09PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0Ozxicj4NCiZn
dDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoEJ1ZmZlciB0eXBlOiBwZXIgVUlEPGJyPg0KJmd0
O8KgIMKgIMKgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoENo
YW5uZWxzOjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoC0tLS0tLS0tLS0tLS08
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAtIGNoMTogW2VuYWJsZWRdPGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDC
oCDCoCDCoEF0dHJpYnV0ZXM6PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKg
IMKgIMKgb3ZlcndyaXRlIG1vZGU6IDE8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAg
wqAgwqAgwqAgwqBzdWJidWZlcnMgc2l6ZTogNDA5Njxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZn
dDvCoCDCoCDCoCDCoCDCoCDCoG51bWJlciBvZiBzdWJidWZlcnM6IDE2PGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgc3dpdGNoIHRpbWVyIGludGVydmFsOiAwPGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgcmVhZCB0aW1lciBpbnRl
cnZhbDogMDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoG91dHB1
dDogbW1hcCgpPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoCZndDvCoCDCoCDCoCDCoCDCoEV2ZW50czo8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAqICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF08YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgU25h
cHNob3QgcmVjb3JkZWQgc3VjY2Vzc2Z1bGx5IGZvciBzZXNzaW9uIHRlc3Q8YnI+DQomZ3Q7wqAg
wqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAxMDAwPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8Kg
IMKgIMKgWzA5OjM2OjExLjk4NTMxOTI3Ml0gKCs/Lj8/Pz8/Pz8/PykgMDdmOGNmODRhMzhmPGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgdHJhY2V0ZXN0OmZpcnN0X3RwOjxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoCZndDvCoCDCoCDCoHsgY3B1X2lkID0gNCB9LCB7IG15X3N0cmluZ19maWVsZCA9ICZx
dW90O3Rlc3QmcXVvdDssPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgbXlfaW50ZWdlcl9maWVsZCA9
IDAgfTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoFswOTozNjoxMS45ODU4NTcy
NTRdICgrMC4wMDAwMDA1MDEpIDA3ZjhjZjg0YTM4Zjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoHRy
YWNldGVzdDpmaXJzdF90cDo8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqB7IGNw
dV9pZCA9IDQgfSwgeyBteV9zdHJpbmdfZmllbGQgPSAmcXVvdDt0ZXN0JnF1b3Q7LDxicj4NCiZn
dDvCoCDCoCDCoCDCoCDCoG15X2ludGVnZXJfZmllbGQgPSA5OTkgfTxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoCZndDvCoCDCoCDCoFNuYXBzaG90IHJlY29yZGVkIHN1Y2Nlc3NmdWxseSBmb3Igc2Vz
c2lvbiB0ZXN0PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgMjAwMDxicj4NCiZn
dDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoFswOTozNjoxMS45ODUzMTkyNzJdICgrPy4/Pz8/
Pz8/Pz8pIDA3ZjhjZjg0YTM4Zjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoHRyYWNldGVzdDpmaXJz
dF90cDo8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqB7IGNwdV9pZCA9IDQgfSwg
eyBteV9zdHJpbmdfZmllbGQgPSAmcXVvdDt0ZXN0JnF1b3Q7LDxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoG15X2ludGVnZXJfZmllbGQgPSAwIH08YnI+DQo8L2Rpdj48L2Rpdj4mZ3Q7wqAgwqAgwqAg
wqAgwqAmZ3Q7wqAgwqAgwqBbMDk6MzY6MTIuMDMzMDY2MTMwICZsdDt0ZWw6MDMzMDY2MTMwJmd0
OyAmbHQ7dGVsOjAzMzA2NjEzMDxicj4NCjxzcGFuIGNsYXNzPSIiPiZndDvCoCDCoCDCoCDCoCDC
oCZsdDt0ZWw6MDMzMDY2MTMwJmd0OyZndDtdICgrMC4wMDAwMDE2NjMpIDA3ZjhjZjg0YTM4Zjxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoHRyYWNldGVzdDpmaXJzdF90cDogeyBj
cHVfaWQgPSA1IH0sIHsgbXlfc3RyaW5nX2ZpZWxkID0gJnF1b3Q7dGVzdCZxdW90Oyw8YnI+DQom
Z3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqBteV9pbnRlZ2VyX2ZpZWxkID0gOTk5IH08YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqBTbmFwc2hvdCByZWNvcmRlZCBzdWNjZXNz
ZnVsbHkgZm9yIHNlc3Npb24gdGVzdDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDC
oDMwMDA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqBbMDk6MzY6MTEuOTg1MzE5
MjcyXSAoKz8uPz8/Pz8/Pz8/KSAwN2Y4Y2Y4NGEzOGYgdHJhY2V0ZXN0OmZpcnN0X3RwOjxicj4N
CiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoHsgY3B1X2lkID0gNCB9LCB7IG15X3N0cmlu
Z19maWVsZCA9ICZxdW90O3Rlc3QmcXVvdDssIG15X2ludGVnZXJfZmllbGQgPSAwIH08YnI+DQo8
L3NwYW4+Jmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgWzA5OjM2OjEyLjA4Njg4ODEyMSAm
bHQ7dGVsOjA4Njg4ODEyMSZndDsgJmx0O3RlbDowODY4ODgxMjE8YnI+DQo8ZGl2IGNsYXNzPSJI
T0VuWmIiPjxkaXYgY2xhc3M9Img1Ij4mZ3Q7wqAgwqAgwqAgwqAgwqAmbHQ7dGVsOjA4Njg4ODEy
MSZndDsmZ3Q7XSAoKzAuMDAwMDAxMjczKSAwN2Y4Y2Y4NGEzOGY8YnI+DQomZ3Q7wqAgwqAgwqAg
wqAgwqAmZ3Q7wqAgwqAgwqB0cmFjZXRlc3Q6Zmlyc3RfdHA6IHsgY3B1X2lkID0gNSB9LCB7IG15
X3N0cmluZ19maWVsZCA9PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJnF1b3Q7dGVzdCZxdW90Oyw8
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqBteV9pbnRlZ2VyX2ZpZWxkID0gOTk5
IH08YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqBTbmFwc2hvdCByZWNvcmRlZCBz
dWNjZXNzZnVsbHkgZm9yIHNlc3Npb24gdGVzdDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvC
oCDCoCDCoDQwMDA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqBbMDk6MzY6MTEu
OTg1MzE5MjcyXSAoKz8uPz8/Pz8/Pz8/KSAwN2Y4Y2Y4NGEzOGY8YnI+DQomZ3Q7wqAgwqAgwqAg
wqAgwqB0cmFjZXRlc3Q6Zmlyc3RfdHA6PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKg
IMKgeyBjcHVfaWQgPSA0IH0sIHsgbXlfc3RyaW5nX2ZpZWxkID0gJnF1b3Q7dGVzdCZxdW90Oyw8
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBteV9pbnRlZ2VyX2ZpZWxkID0gMCB9PGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgWzA5OjM2OjEyLjE0NzM3ODI1MV0gKCswLjAwMDAwMTI1
NykgMDdmOGNmODRhMzhmPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgdHJhY2V0ZXN0OmZpcnN0X3Rw
Ojxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoHsgY3B1X2lkID0gNCB9LCB7IG15
X3N0cmluZ19maWVsZCA9ICZxdW90O3Rlc3QmcXVvdDssPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
bXlfaW50ZWdlcl9maWVsZCA9IDk5OSB9PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKg
IMKgU25hcHNob3QgcmVjb3JkZWQgc3VjY2Vzc2Z1bGx5IGZvciBzZXNzaW9uIHRlc3Q8YnI+DQom
Z3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqA1MDAwPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
Jmd0O8KgIMKgIMKgWzA5OjM2OjExLjk4NTMxOTI3Ml0gKCs/Lj8/Pz8/Pz8/PykgMDdmOGNmODRh
MzhmPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgdHJhY2V0ZXN0OmZpcnN0X3RwOjxicj4NCiZndDvC
oCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoHsgY3B1X2lkID0gNCB9LCB7IG15X3N0cmluZ19maWVs
ZCA9ICZxdW90O3Rlc3QmcXVvdDssPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgbXlfaW50ZWdlcl9m
aWVsZCA9IDAgfTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoFswOTozNjoxMi4y
MjU1ODQ2OTZdICgrMC4wMDAwMDA1MjgpIDA3ZjhjZjg0YTM4Zjxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoHRyYWNldGVzdDpmaXJzdF90cDo8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAg
wqB7IGNwdV9pZCA9IDQgfSwgeyBteV9zdHJpbmdfZmllbGQgPSAmcXVvdDt0ZXN0JnF1b3Q7LDxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoG15X2ludGVnZXJfZmllbGQgPSA5OTkgfTxicj4NCiZndDvC
oCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoFNuYXBzaG90IHJlY29yZGVkIHN1Y2Nlc3NmdWxseSBm
b3Igc2Vzc2lvbiB0ZXN0PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgNjAwMDxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoFswOTozNjoxMS45ODUzMTkyNzJdICgr
Py4/Pz8/Pz8/Pz8pIDA3ZjhjZjg0YTM4Zjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoHRyYWNldGVz
dDpmaXJzdF90cDo8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqB7IGNwdV9pZCA9
IDQgfSwgeyBteV9zdHJpbmdfZmllbGQgPSAmcXVvdDt0ZXN0JnF1b3Q7LDxicj4NCiZndDvCoCDC
oCDCoCDCoCDCoG15X2ludGVnZXJfZmllbGQgPSAwIH08YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAm
Z3Q7wqAgwqAgwqBbMDk6MzY6MTIuMjg4MzExMTcyXSAoKzAuMDAwMDAwNTcxKSAwN2Y4Y2Y4NGEz
OGY8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqB0cmFjZXRlc3Q6Zmlyc3RfdHA6PGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgeyBjcHVfaWQgPSA3IH0sIHsgbXlfc3RyaW5nX2ZpZWxk
ID0gJnF1b3Q7dGVzdCZxdW90Oyw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBteV9pbnRlZ2VyX2Zp
ZWxkID0gOTk5IH08YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqBTbmFwc2hvdCBy
ZWNvcmRlZCBzdWNjZXNzZnVsbHkgZm9yIHNlc3Npb24gdGVzdDxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoCZndDvCoCDCoCDCoDcwMDA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqBb
MDk6MzY6MTEuOTg1MzE5MjcyXSAoKz8uPz8/Pz8/Pz8/KSAwN2Y4Y2Y4NGEzOGY8YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqB0cmFjZXRlc3Q6Zmlyc3RfdHA6PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
Jmd0O8KgIMKgIMKgeyBjcHVfaWQgPSA0IH0sIHsgbXlfc3RyaW5nX2ZpZWxkID0gJnF1b3Q7dGVz
dCZxdW90Oyw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBteV9pbnRlZ2VyX2ZpZWxkID0gMCB9PGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgWzA5OjM2OjEyLjM3NTc4OTMwN10gKCsw
LjAwMDAwMTIzOCkgMDdmOGNmODRhMzhmPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgdHJhY2V0ZXN0
OmZpcnN0X3RwOjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoHsgY3B1X2lkID0g
NCB9LCB7IG15X3N0cmluZ19maWVsZCA9ICZxdW90O3Rlc3QmcXVvdDssPGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgbXlfaW50ZWdlcl9maWVsZCA9IDk5OSB9PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
Jmd0O8KgIMKgIMKgU25hcHNob3QgcmVjb3JkZWQgc3VjY2Vzc2Z1bGx5IGZvciBzZXNzaW9uIHRl
c3Q8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqA3MDAwPGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgJmd0O8KgIMKgIMKgWzA5OjM2OjEyLjAzMjMxNDA4NF0gKCs/Lj8/Pz8/Pz8/Pykg
MDdmOGNmODRhMzhmPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgdHJhY2V0ZXN0OmZpcnN0X3RwOjxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoHsgY3B1X2lkID0gNSB9LCB7IG15X3N0
cmluZ19maWVsZCA9ICZxdW90O3Rlc3QmcXVvdDssPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgbXlf
aW50ZWdlcl9maWVsZCA9IDAgfTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoFsw
OTozNjoxMi40NjA3NTY3NzldICgrMC4wMDAwMDEyNDgpIDA3ZjhjZjg0YTM4Zjxicj4NCiZndDvC
oCDCoCDCoCDCoCDCoHRyYWNldGVzdDpmaXJzdF90cDo8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAm
Z3Q7wqAgwqAgwqB7IGNwdV9pZCA9IDQgfSwgeyBteV9zdHJpbmdfZmllbGQgPSAmcXVvdDt0ZXN0
JnF1b3Q7LDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoG15X2ludGVnZXJfZmllbGQgPSA5OTkgfTxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoFNuYXBzaG90IHJlY29yZGVkIHN1Y2Nl
c3NmdWxseSBmb3Igc2Vzc2lvbiB0ZXN0PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKg
IMKgODAwMDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoFswOTozNjoxMi4wMzIz
MTQwODRdICgrPy4/Pz8/Pz8/Pz8pIDA3ZjhjZjg0YTM4Zjxicj4NCiZndDvCoCDCoCDCoCDCoCDC
oHRyYWNldGVzdDpmaXJzdF90cDo8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqB7
IGNwdV9pZCA9IDUgfSwgeyBteV9zdHJpbmdfZmllbGQgPSAmcXVvdDt0ZXN0JnF1b3Q7LDxicj4N
CiZndDvCoCDCoCDCoCDCoCDCoG15X2ludGVnZXJfZmllbGQgPSAwIH08YnI+DQomZ3Q7wqAgwqAg
wqAgwqAgwqAmZ3Q7wqAgwqAgwqBbMDk6MzY6MTIuNTQwNDY0MDkwXSAoKzAuMDAwMDAxMjkyKSAw
N2Y4Y2Y4NGEzOGY8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqB0cmFjZXRlc3Q6Zmlyc3RfdHA6PGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgeyBjcHVfaWQgPSA3IH0sIHsgbXlfc3Ry
aW5nX2ZpZWxkID0gJnF1b3Q7dGVzdCZxdW90Oyw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBteV9p
bnRlZ2VyX2ZpZWxkID0gOTk5IH08YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqBT
bmFwc2hvdCByZWNvcmRlZCBzdWNjZXNzZnVsbHkgZm9yIHNlc3Npb24gdGVzdDxicj4NCiZndDvC
oCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoDkwMDA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7
wqAgwqAgwqBbMDk6MzY6MTIuMDMyMzE0MDg0XSAoKz8uPz8/Pz8/Pz8/KSAwN2Y4Y2Y4NGEzOGY8
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqB0cmFjZXRlc3Q6Zmlyc3RfdHA6PGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgJmd0O8KgIMKgIMKgeyBjcHVfaWQgPSA1IH0sIHsgbXlfc3RyaW5nX2ZpZWxkID0g
JnF1b3Q7dGVzdCZxdW90Oyw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBteV9pbnRlZ2VyX2ZpZWxk
ID0gMCB9PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgWzA5OjM2OjEyLjYyMTk5
MjkzMV0gKCswLjAwMDAwMTI5OCkgMDdmOGNmODRhMzhmPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
dHJhY2V0ZXN0OmZpcnN0X3RwOjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoHsg
Y3B1X2lkID0gNSB9LCB7IG15X3N0cmluZ19maWVsZCA9ICZxdW90O3Rlc3QmcXVvdDssPGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgbXlfaW50ZWdlcl9maWVsZCA9IDk5OSB9PGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgJmd0O8KgIMKgIMKgV2FpdGluZyBmb3IgZGF0YSBhdmFpbGFiaWxpdHk8YnI+DQom
Z3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqBUcmFjaW5nIHN0b3BwZWQgZm9yIHNlc3Npb24g
dGVzdDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoFNlc3Npb24gdGVzdCBkZXN0
cm95ZWQ8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
Jmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgJmd0OyBVbmxlc3MgSSYjMzk7bSBtaXN0YWtlbiwgdGhlIGJlaGF2
aW9yIG9mIHRoZTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoHNuYXBzaG90IG1vZGUgaGFzIGNoYW5n
ZWQ8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7IGJl
dHdlZW4gMi40IGFuZCAyLjUuPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCZndDsgSW4gdGhlIDIuNCBzZXJpZXMsIGNvbnNlY3V0aXZlIHNuYXBzaG90cyBjb3VsZDxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoG92ZXJsYXA7IHRoYXQgaXMsPGJyPg0KJmd0O8KgIMKgIMKg
IMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyBldmVudHMgY291bGQgYmUgcHJlc2Vu
dCBpbiBtdWx0aXBsZSBzbmFwc2hvdHMuPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgQXMgb2YgMi41
LCBhbiBldmVudCBpczxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCZndDsgZ3VhcmFudGVlZCB0byBvbmx5IGFwcGVhciBpbiBvbmUgc25hcHNob3QgYXMgdGhl
PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgZXZlbnRzIGFyZSBjb25zaWRlcmVkPGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyBhcyBoYXZpbmcgYmVlbiAm
cXVvdDtjb25zdW1lZCZxdW90OyBhdCB0aGF0IHBvaW50Ljxicj4NCiZndDvCoCDCoCDCoCDCoCDC
oCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBIdW0s
IG5vIHRoZSBiZWhhdmlvciBpcyBzdGlsbCB0aGUgc2FtZSwgY29uc2VjdXRpdmU8YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBzbmFwc2hvdHMgY2FuIG92ZXJs
YXAuPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoENvdWxkIHlvdSB0ZWxsIHVzIG9uIHdoaWNoIGFyY2hpdGVj
dHVyZSB5b3UgYXJlPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgZXhwZXJpZW5jaW5nPGJyPg0KJmd0
O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgdGhlIHByb2JsZW08YnI+DQom
Z3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBhbmQgdGhlIG51bWJlciBv
ZiBDUFVzID88YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKg
IMKgJmd0O8KgIMKgIMKgIMKgIMKgVGhlIHRyYWNlcyBhcHBlbmRlZCBpcyBmcm9tIG15IGxhcHRv
cCBydW5uaW5nIFVidW50dTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoDE0LjA0IHdpdGg8YnI+DQom
Z3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAmcXVvdDs4JnF1b3Q7IGNwdSYjMzk7
czxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoG1vZGVsIG5hbWXCoCDC
oCDCoCA6IEludGVsKFIpIENvcmUoVE0pIGk3LTI3NjBRTSBDUFUgQDxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoDIuNDBHSHo8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqBJ
IGhhdmUgYWxzbyBydW4gdGhpcyBvbiBBUk0gd2l0aCAxNiBjb3JlcyBhbmQgYSBwb3dlcnBjPGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDs8YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBUaGFua3MsPGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoEp1bGllbjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCZndDs8YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJmd0Ozxicj4NCiZndDvC
oCDCoCDCoCDCoCDCoCZndDs8YnI+DQomZ3Q7PGJyPg0KJmd0Ozxicj4NCiZndDs8YnI+DQo8L2Rp
dj48L2Rpdj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjwvZGl2PjwvZGl2Pg0K
--e89a8f2351eb2a3fc80508240a2e--


--===============0068272840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0068272840==--
