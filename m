From: Anders Wallin <wallinux@gmail.com>
Subject: Re: snapshot issue with 2.5
Date: Thu, 13 Nov 2014 10:39:33 +0100
Message-ID: <CAF2baFcKwwciQDr+Wdpcs3_EJV969_aPUA_UtPXGo7=CMxWKvw__21317.7417791032$1415871642$gmane$org@mail.gmail.com>
References: <CAF2baFd5vRuGKa7MVpqHvkCHia5fDN19cvq8qdedqJreNU6-vQ@mail.gmail.com>
 <CA+jJMxvXfVT8w+hokMyFgTSqN=JH3nQUudJR+8MUJtQmTEgZZQ@mail.gmail.com>
 <5463E904.9080102@efficios.com>
 <CAF2baFesZ0Ke5qcWt9eGzWTyPuyAW_PM=ZZ+g9baEUNRwK5cGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0063189868=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <wallinux@gmail.com>) id 1XoqsM-00043i-OD
 for lttng-dev@lists.lttng.org; Thu, 13 Nov 2014 04:39:45 -0500
Received: by mail-qc0-f169.google.com with SMTP id i17so11005943qcy.28
 for <lttng-dev@lists.lttng.org>; Thu, 13 Nov 2014 01:39:33 -0800 (PST)
In-Reply-To: <CAF2baFesZ0Ke5qcWt9eGzWTyPuyAW_PM=ZZ+g9baEUNRwK5cGA@mail.gmail.com>
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

--===============0063189868==
Content-Type: multipart/alternative; boundary=001a113a4c682aa02a0507ba4aac

--001a113a4c682aa02a0507ba4aac
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Anders Wallin

On Thu, Nov 13, 2014 at 8:43 AM, Anders Wallin <wallinux@gmail.com> wrote:

> On Thu, Nov 13, 2014 at 12:11 AM, Julien Desfossez <
> jdesfossez@efficios.com> wrote:
>
>> Hi,
>>
>> On 14-11-12 05:30 PM, J=C3=A9r=C3=A9mie Galarneau wrote:
>> > On Wed, Nov 12, 2014 at 7:39 AM, Anders Wallin <wallinux@gmail.com>
>> wrote:
>> >> Hi,
>> >>
>> >> using userspace snapshot mode in 2.5 seems to broken.
>> >>
>> >> I have small stupid application(tracetest) generating 1000 events
>> >>
>> >> Running the script (the below is simplified version of the script)
>> >>
>> ------------------------------------------------------------------------=
----------
>> >> #!/bin/bash
>> >> LTTNG=3D'lttng -n'
>> >> lttng-sessiond --no-kernel &
>> >
>> > You should use the "-d" flag to launch the sessiond as a daemon. Using
>> > "&" might cause the "create" command to launch a second session daemon
>> > since the first one would not have had the time to open create its
>> > command sockets.
>> >
>> >>
>> >> $LTTNG create test --snapshot
>> >> $LTTNG enable-channel -u --subbuf-size 64k --num-subbuf 16 --overwrit=
e
>> ch1
>> >> $LTTNG enable-event -u -c ch1 "*"
>> >> $LTTNG start
>> >> $LTTNG list ch1
>> >>
>> >> mkdir -p snapshot/
>> >>
>> >> for i in $(seq 1 $LOOPS); do
>> >>     ./tracetest
>> >>     $LTTNG snapshot record -m 1G
>> >>
>> >>     # print no of events and first and last event
>> >>     last=3D$(ls -1drt $HOME/lttng-traces/$SESSION*/* | tail -1)
>> >>     babeltrace $last > snapshot/$i.bt
>> >>     cat snapshot/$i.bt | wc -l
>> >>     cat snapshot/$i.bt | head -1
>> >>     cat snapshot/$i.bt | tail -1
>> >> done
>> >>
>> >> $LTTNG stop
>> >> $LTTNG destroy $SESSION
>> >>
>> ------------------------------------------------------------------------=
----------
>> >>
>> >> The result of the run looks like this;
>> >> ./test.run
>> >> Error: consumer err socket second poll error
>> >> Error: Health error occurred in thread_manage_consumer
>> >> PERROR - 13:36:59.685167 [23772/23781]: bind inet: Address already in
>> use
>> >> (in lttcomm_bind_inet_sock() at inet.c:109)
>> >> Warning: Another session daemon is using this JUL port. JUL support
>> will be
>> >> deactivated to prevent interfering with the tracing.
>> >>
>> >
>> > Is there a reason why you run two session daemons? I'm guessing this
>> > is related to my "& vs -d" comment above.
>> >
>> >> lttng (LTTng Trace Control) 2.5.2 - Fumisterie
>> >> BabelTrace Trace Viewer and Converter 1.2.4
>> >>         linux-vdso.so.1 =3D>  (0x00007fffba966000)
>> >>         liblttng-ctl.so.0 =3D>
>> /usr/lib/x86_64-linux-gnu/liblttng-ctl.so.0
>> >> (0x00007fbfe4b1d000)
>> >>         librt.so.1 =3D> /lib/x86_64-linux-gnu/librt.so.1
>> (0x00007fbfe4915000)
>> >>         libxml2.so.2 =3D> /usr/lib/x86_64-linux-gnu/libxml2.so.2
>> >> (0x00007fbfe45ae000)
>> >>         libpopt.so.0 =3D> /lib/x86_64-linux-gnu/libpopt.so.0
>> >> (0x00007fbfe43a2000)
>> >>         libpthread.so.0 =3D> /lib/x86_64-linux-gnu/libpthread.so.0
>> >> (0x00007fbfe4184000)
>> >>         libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6
>> (0x00007fbfe3dbd000)
>> >>         /lib64/ld-linux-x86-64.so.2 (0x00007fbfe4fac000)
>> >>         liburcu.so.2 =3D> /usr/lib/x86_64-linux-gnu/liburcu.so.2
>> >> (0x00007fbfe3bb6000)
>> >>         libdl.so.2 =3D> /lib/x86_64-linux-gnu/libdl.so.2
>> (0x00007fbfe39b2000)
>> >>         libz.so.1 =3D> /lib/x86_64-linux-gnu/libz.so.1
>> (0x00007fbfe3798000)
>> >>         liblzma.so.5 =3D> /lib/x86_64-linux-gnu/liblzma.so.5
>> >> (0x00007fbfe3576000)
>> >>         libm.so.6 =3D> /lib/x86_64-linux-gnu/libm.so.6
>> (0x00007fbfe3270000)
>> >>
>> >> Session test created.
>> >> Default snapshot output set to:
>> >> /home/awallin/lttng-traces/test-20141112-133700
>> >> Snapshot mode set. Every channel enabled for that session will be set
>> in
>> >> overwrite mode and mmap output.
>> >> UST channel ch1 enabled for session test
>> >> UST event * created in channel ch1
>> >> Tracing started for session test
>> >> Tracing session test: [active snapshot]
>> >>     Trace path:
>> >>     Live timer interval (usec): 4294967295
>> >>
>> >> =3D=3D=3D Domain: UST global =3D=3D=3D
>> >>
>> >> Channels:
>> >> -------------
>> >> - ch1: [enabled]
>> >>
>> >>     Attributes:
>> >>       overwrite mode: 1
>> >>       subbufers size: 4096
>> >>       number of subbufers: 16
>> >>       switch timer interval: 0
>> >>       read timer interval: 0
>> >>       trace file count: 0
>> >>       trace file size (bytes): 0
>> >>       output: mmap()
>> >>
>> >>     Events:
>> >>       * (type: tracepoint) [enabled]
>> >>
>> >> Snapshot recorded successfully for session test
>> >> 84
>> >> [13:37:00.852615950] (+?.?????????) arn-awallin-mint-l3
>> >> ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFFC6BC7=
000,
>> sopath
>> >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
>> >> [13:37:00.853798949] (+0.000000805) arn-awallin-mint-l3
>> tracetest:first_tp:
>> >> { cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D =
999 }
>> >> Snapshot recorded successfully for session test
>> >> 157
>> >> [13:37:00.853735195] (+?.?????????) arn-awallin-mint-l3
>> tracetest:first_tp:
>> >> { cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D =
927 }
>> >> [13:37:00.894839116] (+0.000000299) arn-awallin-mint-l3
>> tracetest:first_tp:
>> >> { cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D =
999 }
>> >> Snapshot recorded successfully for session test
>> >> 168
>> >> [13:37:00.853735195] (+?.?????????) arn-awallin-mint-l3
>> tracetest:first_tp:
>> >> { cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D =
927 }
>> >> [13:37:00.929447330] (+0.000000305) arn-awallin-mint-l3
>> tracetest:first_tp:
>> >> { cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D =
999 }
>> >> Snapshot recorded successfully for session test
>>
>> Something is wrong from here:
>> >> 168
>> >> [13:37:00.894411117] (+?.?????????) arn-awallin-mint-l3
>> >> ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFF6BF81=
000,
>> sopath
>> >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
>> >> [13:37:00.972035546] (+0.000000597) arn-awallin-mint-l3
>> tracetest:first_tp:
>> >> { cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D =
999 }
>> >> Snapshot recorded successfully for session test
>> >> 168
>> >> [13:37:00.894411117] (+?.?????????) arn-awallin-mint-l3
>> >> ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFF6BF81=
000,
>> sopath
>> >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
>> >> [13:37:01.014060940] (+0.000000341) arn-awallin-mint-l3
>> tracetest:first_tp:
>> >> { cpu_id =3D 7 }, { my_string_field =3D "test", my_integer_field =3D =
999 }
>> >> Snapshot recorded successfully for session test
>> >> 168
>> >> [13:37:00.894411117] (+?.?????????) arn-awallin-mint-l3
>> >> ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFF6BF81=
000,
>> sopath
>> >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
>> >> [13:37:01.052555877] (+0.000000872) arn-awallin-mint-l3
>> tracetest:first_tp:
>> >> { cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D =
999 }
>> ... to here.
>>
>> The beginning timestamp is the same, the number of events is the same,
>> but the end timestamp moves. We see also this pattern below.
>> I would be really interested to see the whole snapshots when it happens.
>> It seems like we are not be overwriting the beginning of the ring buffer
>> in some conditions. Could you send us your tracetest program and the
>> script so we can try to reproduce the problem ?
>>
>
> I will append it including a run with debug turned on and all the snapsho=
t
> files created
>
>
>>
>> >> Snapshot recorded successfully for session test
>> >> 168
>> >> [13:37:01.014035993] (+?.?????????) arn-awallin-mint-l3
>> tracetest:first_tp:
>> >> { cpu_id =3D 7 }, { my_string_field =3D "test", my_integer_field =3D =
927 }
>> >> [13:37:01.098620808] (+0.000001404) arn-awallin-mint-l3
>> tracetest:first_tp:
>> >> { cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D =
999 }
>> >> Snapshot recorded successfully for session test
>> >> 168
>> >> [13:37:01.097087388] (+?.?????????) arn-awallin-mint-l3
>> >> ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF4BFFE=
000,
>> sopath
>> >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
>> >> [13:37:01.129839830] (+0.000000533) arn-awallin-mint-l3
>> tracetest:first_tp:
>> >> { cpu_id =3D 7 }, { my_string_field =3D "test", my_integer_field =3D =
999 }
>> >> Snapshot recorded successfully for session test
>> >> 168
>> >> [13:37:01.097087388] (+?.?????????) arn-awallin-mint-l3
>> >> ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF4BFFE=
000,
>> sopath
>> >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
>> >> [13:37:01.129839830] (+0.000000533) arn-awallin-mint-l3
>> tracetest:first_tp:
>> >> { cpu_id =3D 7 }, { my_string_field =3D "test", my_integer_field =3D =
999 }
>> >> Snapshot recorded successfully for session test
>> >> 168
>> >> [13:37:01.097087388] (+?.?????????) arn-awallin-mint-l3
>> >> ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF4BFFE=
000,
>> sopath
>> >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
>> >> [13:37:01.172829105] (+0.000000575) arn-awallin-mint-l3
>> tracetest:first_tp:
>> >> { cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D =
999 }
>> >> Snapshot recorded successfully for session test
>> >> 168
>> >> [13:37:01.172021557] (+?.?????????) arn-awallin-mint-l3
>> >> ust_baddr_statedump:soinfo: { cpu_id =3D 7 }, { baddr =3D 0x7FFF653FE=
000,
>> sopath
>> >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
>> >> [13:37:01.220074165] (+0.000000553) arn-awallin-mint-l3
>> tracetest:first_tp:
>> >> { cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D =
999 }
>> >> Waiting for data availability
>> >> Tracing stopped for session test
>> >> Session test destroyed
>> >>
>> >> the result from the run on older versions of lttng creates bigger and
>> bigger
>> >> event traces until reaching max size.
>> We see this pattern here and the max size seems to be 168 events, was it
>> similar in your previous tests ?
>>
> If I'm running the same test on 2.4 or 2.3 the max number of events is
> much bigger, like ~10000
> (I don't have the exact number right now, I will rebuild and run the test
> again and get back
> with traces from that run)
>
For 2.4.2 the log looks like this:
./test.run ./tracetest

lttng (LTTng Trace Control) 2.4.2 - =C3=89poque Opaque
BabelTrace Trace Viewer and Converter 1.2.1
linux-vdso.so.1 =3D>  (0x00007fff775fe000)
liblttng-ctl.so.0 =3D> /usr/local/lib/liblttng-ctl.so.0 (0x00002b2b016e4000=
)
libpopt.so.0 =3D> /lib/x86_64-linux-gnu/libpopt.so.0 (0x00002b2b0190f000)
libpthread.so.0 =3D> /lib/x86_64-linux-gnu/libpthread.so.0
(0x00002b2b01b1b000)
libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6 (0x00002b2b01d39000)
librt.so.1 =3D> /lib/x86_64-linux-gnu/librt.so.1 (0x00002b2b020ff000)
liburcu.so.3 =3D> /usr/local/lib/liburcu.so.3 (0x00002b2b02307000)
/lib64/ld-linux-x86-64.so.2 (0x00002b2b014bf000)

Session test created.
Default snapshot output set to: //lttng-traces/test-20141113-093611
Snapshot mode set. Every channel enabled for that session will be set in
overwrite mode and mmap output.
UST channel ch1 enabled for session test
UST event * created in channel ch1
Tracing started for session test
Tracing session test: [active snapshot]
    Trace path:

=3D=3D=3D Domain: UST global =3D=3D=3D

Buffer type: per UID

Channels:
-------------
- ch1: [enabled]

    Attributes:
      overwrite mode: 1
      subbufers size: 4096
      number of subbufers: 16
      switch timer interval: 0
      read timer interval: 0
      output: mmap()

    Events:
      * (type: tracepoint) [enabled]

Snapshot recorded successfully for session test
1000
[09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 0 }
[09:36:11.985857254] (+0.000000501) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 999 }
Snapshot recorded successfully for session test
2000
[09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 0 }
[09:36:12.033066130] (+0.000001663) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 999 }
Snapshot recorded successfully for session test
3000
[09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 0 }
[09:36:12.086888121] (+0.000001273) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 999 }
Snapshot recorded successfully for session test
4000
[09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 0 }
[09:36:12.147378251] (+0.000001257) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 999 }
Snapshot recorded successfully for session test
5000
[09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 0 }
[09:36:12.225584696] (+0.000000528) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 999 }
Snapshot recorded successfully for session test
6000
[09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 0 }
[09:36:12.288311172] (+0.000000571) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 7 }, { my_string_field =3D "test", my_integer_field =3D 999 }
Snapshot recorded successfully for session test
7000
[09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 0 }
[09:36:12.375789307] (+0.000001238) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 999 }
Snapshot recorded successfully for session test
7000
[09:36:12.032314084] (+?.?????????) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 0 }
[09:36:12.460756779] (+0.000001248) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 999 }
Snapshot recorded successfully for session test
8000
[09:36:12.032314084] (+?.?????????) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 0 }
[09:36:12.540464090] (+0.000001292) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 7 }, { my_string_field =3D "test", my_integer_field =3D 999 }
Snapshot recorded successfully for session test
9000
[09:36:12.032314084] (+?.?????????) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 0 }
[09:36:12.621992931] (+0.000001298) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 999 }
Waiting for data availability
Tracing stopped for session test
Session test destroyed


>
>> >
>> > Unless I'm mistaken, the behavior of the snapshot mode has changed
>> > between 2.4 and 2.5.
>> >
>> > In the 2.4 series, consecutive snapshots could overlap; that is,
>> > events could be present in multiple snapshots. As of 2.5, an event is
>> > guaranteed to only appear in one snapshot as the events are considered
>> > as having been "consumed" at that point.
>>
>> Hum, no the behavior is still the same, consecutive snapshots can overla=
p.
>>
>> Could you tell us on which architecture you are experiencing the problem
>> and the number of CPUs ?
>>
> The traces appended is from my laptop running Ubuntu 14.04 with "8" cpu's
> model name      : Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz
> I have also run this on ARM with 16 cores and a powerpc
>
>>
>> Thanks,
>>
>> Julien
>>
>
>

--001a113a4c682aa02a0507ba4aac
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br clear=3D"all"><div><div=
 class=3D"gmail_signature">Anders Wallin</div></div>
<br><div class=3D"gmail_quote">On Thu, Nov 13, 2014 at 8:43 AM, Anders Wall=
in <span dir=3D"ltr">&lt;<a href=3D"mailto:wallinux@gmail.com" target=3D"_b=
lank">wallinux@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-lef=
t-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div dir=
=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div cl=
ass=3D"h5">On Thu, Nov 13, 2014 at 12:11 AM, Julien Desfossez <span dir=3D"=
ltr">&lt;<a href=3D"mailto:jdesfossez@efficios.com" target=3D"_blank">jdesf=
ossez@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-colo=
r:rgb(204,204,204);border-left-style:solid;padding-left:1ex">Hi,<br>
<div><div><br>
On 14-11-12 05:30 PM, J=C3=A9r=C3=A9mie Galarneau wrote:<br>
&gt; On Wed, Nov 12, 2014 at 7:39 AM, Anders Wallin &lt;<a href=3D"mailto:w=
allinux@gmail.com" target=3D"_blank">wallinux@gmail.com</a>&gt; wrote:<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; using userspace snapshot mode in 2.5 seems to broken.<br>
&gt;&gt;<br>
&gt;&gt; I have small stupid application(tracetest) generating 1000 events<=
br>
&gt;&gt;<br>
&gt;&gt; Running the script (the below is simplified version of the script)=
<br>
&gt;&gt; ------------------------------------------------------------------=
----------------<br>
&gt;&gt; #!/bin/bash<br>
&gt;&gt; LTTNG=3D&#39;lttng -n&#39;<br>
&gt;&gt; lttng-sessiond --no-kernel &amp;<br>
&gt;<br>
&gt; You should use the &quot;-d&quot; flag to launch the sessiond as a dae=
mon. Using<br>
&gt; &quot;&amp;&quot; might cause the &quot;create&quot; command to launch=
 a second session daemon<br>
&gt; since the first one would not have had the time to open create its<br>
&gt; command sockets.<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; $LTTNG create test --snapshot<br>
&gt;&gt; $LTTNG enable-channel -u --subbuf-size 64k --num-subbuf 16 --overw=
rite ch1<br>
&gt;&gt; $LTTNG enable-event -u -c ch1 &quot;*&quot;<br>
&gt;&gt; $LTTNG start<br>
&gt;&gt; $LTTNG list ch1<br>
&gt;&gt;<br>
&gt;&gt; mkdir -p snapshot/<br>
&gt;&gt;<br>
&gt;&gt; for i in $(seq 1 $LOOPS); do<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0./tracetest<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0$LTTNG snapshot record -m 1G<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0# print no of events and first and last event<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0last=3D$(ls -1drt $HOME/lttng-traces/$SESSION*/=
* | tail -1)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0babeltrace $last &gt; snapshot/$<a href=3D"http=
://i.bt" target=3D"_blank">i.bt</a><br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0cat snapshot/$<a href=3D"http://i.bt" target=3D=
"_blank">i.bt</a> | wc -l<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0cat snapshot/$<a href=3D"http://i.bt" target=3D=
"_blank">i.bt</a> | head -1<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0cat snapshot/$<a href=3D"http://i.bt" target=3D=
"_blank">i.bt</a> | tail -1<br>
&gt;&gt; done<br>
&gt;&gt;<br>
&gt;&gt; $LTTNG stop<br>
&gt;&gt; $LTTNG destroy $SESSION<br>
&gt;&gt; ------------------------------------------------------------------=
----------------<br>
&gt;&gt;<br>
&gt;&gt; The result of the run looks like this;<br>
&gt;&gt; ./test.run<br>
&gt;&gt; Error: consumer err socket second poll error<br>
&gt;&gt; Error: Health error occurred in thread_manage_consumer<br>
&gt;&gt; PERROR - 13:36:59.685167 [23772/23781]: bind inet: Address already=
 in use<br>
&gt;&gt; (in lttcomm_bind_inet_sock() at inet.c:109)<br>
&gt;&gt; Warning: Another session daemon is using this JUL port. JUL suppor=
t will be<br>
&gt;&gt; deactivated to prevent interfering with the tracing.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Is there a reason why you run two session daemons? I&#39;m guessing th=
is<br>
&gt; is related to my &quot;&amp; vs -d&quot; comment above.<br>
&gt;<br>
&gt;&gt; lttng (LTTng Trace Control) 2.5.2 - Fumisterie<br>
&gt;&gt; BabelTrace Trace Viewer and Converter 1.2.4<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0linux-vdso.so.1 =3D&gt;=C2=A0 (0x=
00007fffba966000)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0liblttng-ctl.so.0 =3D&gt; /usr/li=
b/x86_64-linux-gnu/liblttng-ctl.so.0<br>
&gt;&gt; (0x00007fbfe4b1d000)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0librt.so.1 =3D&gt; /lib/x86_64-li=
nux-gnu/librt.so.1 (0x00007fbfe4915000)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libxml2.so.2 =3D&gt; /usr/lib/x86=
_64-linux-gnu/libxml2.so.2<br>
&gt;&gt; (0x00007fbfe45ae000)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libpopt.so.0 =3D&gt; /lib/x86_64-=
linux-gnu/libpopt.so.0<br>
&gt;&gt; (0x00007fbfe43a2000)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libpthread.so.0 =3D&gt; /lib/x86_=
64-linux-gnu/libpthread.so.0<br>
&gt;&gt; (0x00007fbfe4184000)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libc.so.6 =3D&gt; /lib/x86_64-lin=
ux-gnu/libc.so.6 (0x00007fbfe3dbd000)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/lib64/ld-linux-x86-64.so.2 (0x00=
007fbfe4fac000)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0liburcu.so.2 =3D&gt; /usr/lib/x86=
_64-linux-gnu/liburcu.so.2<br>
&gt;&gt; (0x00007fbfe3bb6000)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libdl.so.2 =3D&gt; /lib/x86_64-li=
nux-gnu/libdl.so.2 (0x00007fbfe39b2000)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libz.so.1 =3D&gt; /lib/x86_64-lin=
ux-gnu/libz.so.1 (0x00007fbfe3798000)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0liblzma.so.5 =3D&gt; /lib/x86_64-=
linux-gnu/liblzma.so.5<br>
&gt;&gt; (0x00007fbfe3576000)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libm.so.6 =3D&gt; /lib/x86_64-lin=
ux-gnu/libm.so.6 (0x00007fbfe3270000)<br>
&gt;&gt;<br>
&gt;&gt; Session test created.<br>
&gt;&gt; Default snapshot output set to:<br>
&gt;&gt; /home/awallin/lttng-traces/test-20141112-133700<br>
&gt;&gt; Snapshot mode set. Every channel enabled for that session will be =
set in<br>
&gt;&gt; overwrite mode and mmap output.<br>
&gt;&gt; UST channel ch1 enabled for session test<br>
&gt;&gt; UST event * created in channel ch1<br>
&gt;&gt; Tracing started for session test<br>
&gt;&gt; Tracing session test: [active snapshot]<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0Trace path:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0Live timer interval (usec): 4294967295<br>
&gt;&gt;<br>
&gt;&gt; =3D=3D=3D Domain: UST global =3D=3D=3D<br>
&gt;&gt;<br>
&gt;&gt; Channels:<br>
&gt;&gt; -------------<br>
&gt;&gt; - ch1: [enabled]<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0Attributes:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0overwrite mode: 1<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0subbufers size: 4096<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0number of subbufers: 16<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0switch timer interval: 0<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0read timer interval: 0<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trace file count: 0<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trace file size (bytes): 0<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0output: mmap()<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0Events:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* (type: tracepoint) [enabled]<br>
&gt;&gt;<br>
&gt;&gt; Snapshot recorded successfully for session test<br>
&gt;&gt; 84<br>
&gt;&gt; [13:37:00.852615950] (+?.?????????) arn-awallin-mint-l3<br>
&gt;&gt; ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFFC6=
BC7000, sopath<br>
&gt;&gt; =3D &quot;[vdso]&quot;, size =3D 0, mtime =3D -1 }<br>
&gt;&gt; [13:37:00.853798949] (+0.000000805) arn-awallin-mint-l3 tracetest:=
first_tp:<br>
&gt;&gt; { cpu_id =3D 6 }, { my_string_field =3D &quot;test&quot;, my_integ=
er_field =3D 999 }<br>
&gt;&gt; Snapshot recorded successfully for session test<br>
&gt;&gt; 157<br>
&gt;&gt; [13:37:00.853735195] (+?.?????????) arn-awallin-mint-l3 tracetest:=
first_tp:<br>
&gt;&gt; { cpu_id =3D 6 }, { my_string_field =3D &quot;test&quot;, my_integ=
er_field =3D 927 }<br>
&gt;&gt; [13:37:00.894839116] (+0.000000299) arn-awallin-mint-l3 tracetest:=
first_tp:<br>
&gt;&gt; { cpu_id =3D 5 }, { my_string_field =3D &quot;test&quot;, my_integ=
er_field =3D 999 }<br>
&gt;&gt; Snapshot recorded successfully for session test<br>
&gt;&gt; 168<br>
&gt;&gt; [13:37:00.853735195] (+?.?????????) arn-awallin-mint-l3 tracetest:=
first_tp:<br>
&gt;&gt; { cpu_id =3D 6 }, { my_string_field =3D &quot;test&quot;, my_integ=
er_field =3D 927 }<br>
&gt;&gt; [13:37:00.929447330] (+0.000000305) arn-awallin-mint-l3 tracetest:=
first_tp:<br>
&gt;&gt; { cpu_id =3D 5 }, { my_string_field =3D &quot;test&quot;, my_integ=
er_field =3D 999 }<br>
&gt;&gt; Snapshot recorded successfully for session test<br>
<br>
</div></div>Something is wrong from here:<br>
<span>&gt;&gt; 168<br>
&gt;&gt; [13:37:00.894411117] (+?.?????????) arn-awallin-mint-l3<br>
&gt;&gt; ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFF6B=
F81000, sopath<br>
&gt;&gt; =3D &quot;[vdso]&quot;, size =3D 0, mtime =3D -1 }<br>
&gt;&gt; [13:37:00.972035546] (+0.000000597) arn-awallin-mint-l3 tracetest:=
first_tp:<br>
&gt;&gt; { cpu_id =3D 6 }, { my_string_field =3D &quot;test&quot;, my_integ=
er_field =3D 999 }<br>
&gt;&gt; Snapshot recorded successfully for session test<br>
&gt;&gt; 168<br>
&gt;&gt; [13:37:00.894411117] (+?.?????????) arn-awallin-mint-l3<br>
&gt;&gt; ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFF6B=
F81000, sopath<br>
&gt;&gt; =3D &quot;[vdso]&quot;, size =3D 0, mtime =3D -1 }<br>
&gt;&gt; [13:37:01.<a href=3D"tel:014060940" value=3D"+4614060940" target=
=3D"_blank">014060940</a>] (+0.000000341) arn-awallin-mint-l3 tracetest:fir=
st_tp:<br>
&gt;&gt; { cpu_id =3D 7 }, { my_string_field =3D &quot;test&quot;, my_integ=
er_field =3D 999 }<br>
&gt;&gt; Snapshot recorded successfully for session test<br>
&gt;&gt; 168<br>
&gt;&gt; [13:37:00.894411117] (+?.?????????) arn-awallin-mint-l3<br>
&gt;&gt; ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFF6B=
F81000, sopath<br>
&gt;&gt; =3D &quot;[vdso]&quot;, size =3D 0, mtime =3D -1 }<br>
&gt;&gt; [13:37:01.<a href=3D"tel:052555877" value=3D"+4652555877" target=
=3D"_blank">052555877</a>] (+0.000000872) arn-awallin-mint-l3 tracetest:fir=
st_tp:<br>
&gt;&gt; { cpu_id =3D 6 }, { my_string_field =3D &quot;test&quot;, my_integ=
er_field =3D 999 }<br>
</span>... to here.<br>
<br>
The beginning timestamp is the same, the number of events is the same,<br>
but the end timestamp moves. We see also this pattern below.<br>
I would be really interested to see the whole snapshots when it happens.<br=
>
It seems like we are not be overwriting the beginning of the ring buffer<br=
>
in some conditions. Could you send us your tracetest program and the<br>
script so we can try to reproduce the problem ?<br></blockquote><div>=C2=A0=
</div></div></div><div>I will append it including a run with debug turned o=
n and all the snapshot files created</div><div><div class=3D"h5"><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-styl=
e:solid;padding-left:1ex">
<div><div><br>
&gt;&gt; Snapshot recorded successfully for session test<br>
&gt;&gt; 168<br>
&gt;&gt; [13:37:01.<a href=3D"tel:014035993" value=3D"+4614035993" target=
=3D"_blank">014035993</a>] (+?.?????????) arn-awallin-mint-l3 tracetest:fir=
st_tp:<br>
&gt;&gt; { cpu_id =3D 7 }, { my_string_field =3D &quot;test&quot;, my_integ=
er_field =3D 927 }<br>
&gt;&gt; [13:37:01.098620808] (+0.000001404) arn-awallin-mint-l3 tracetest:=
first_tp:<br>
&gt;&gt; { cpu_id =3D 4 }, { my_string_field =3D &quot;test&quot;, my_integ=
er_field =3D 999 }<br>
&gt;&gt; Snapshot recorded successfully for session test<br>
&gt;&gt; 168<br>
&gt;&gt; [13:37:01.<a href=3D"tel:097087388" value=3D"+4697087388" target=
=3D"_blank">097087388</a>] (+?.?????????) arn-awallin-mint-l3<br>
&gt;&gt; ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF4B=
FFE000, sopath<br>
&gt;&gt; =3D &quot;[vdso]&quot;, size =3D 0, mtime =3D -1 }<br>
&gt;&gt; [13:37:01.129839830] (+0.000000533) arn-awallin-mint-l3 tracetest:=
first_tp:<br>
&gt;&gt; { cpu_id =3D 7 }, { my_string_field =3D &quot;test&quot;, my_integ=
er_field =3D 999 }<br>
&gt;&gt; Snapshot recorded successfully for session test<br>
&gt;&gt; 168<br>
&gt;&gt; [13:37:01.<a href=3D"tel:097087388" value=3D"+4697087388" target=
=3D"_blank">097087388</a>] (+?.?????????) arn-awallin-mint-l3<br>
&gt;&gt; ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF4B=
FFE000, sopath<br>
&gt;&gt; =3D &quot;[vdso]&quot;, size =3D 0, mtime =3D -1 }<br>
&gt;&gt; [13:37:01.129839830] (+0.000000533) arn-awallin-mint-l3 tracetest:=
first_tp:<br>
&gt;&gt; { cpu_id =3D 7 }, { my_string_field =3D &quot;test&quot;, my_integ=
er_field =3D 999 }<br>
&gt;&gt; Snapshot recorded successfully for session test<br>
&gt;&gt; 168<br>
&gt;&gt; [13:37:01.<a href=3D"tel:097087388" value=3D"+4697087388" target=
=3D"_blank">097087388</a>] (+?.?????????) arn-awallin-mint-l3<br>
&gt;&gt; ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF4B=
FFE000, sopath<br>
&gt;&gt; =3D &quot;[vdso]&quot;, size =3D 0, mtime =3D -1 }<br>
&gt;&gt; [13:37:01.172829105] (+0.000000575) arn-awallin-mint-l3 tracetest:=
first_tp:<br>
&gt;&gt; { cpu_id =3D 5 }, { my_string_field =3D &quot;test&quot;, my_integ=
er_field =3D 999 }<br>
&gt;&gt; Snapshot recorded successfully for session test<br>
&gt;&gt; 168<br>
&gt;&gt; [13:37:01.172021557] (+?.?????????) arn-awallin-mint-l3<br>
&gt;&gt; ust_baddr_statedump:soinfo: { cpu_id =3D 7 }, { baddr =3D 0x7FFF65=
3FE000, sopath<br>
&gt;&gt; =3D &quot;[vdso]&quot;, size =3D 0, mtime =3D -1 }<br>
&gt;&gt; [13:37:01.220074165] (+0.000000553) arn-awallin-mint-l3 tracetest:=
first_tp:<br>
&gt;&gt; { cpu_id =3D 6 }, { my_string_field =3D &quot;test&quot;, my_integ=
er_field =3D 999 }<br>
&gt;&gt; Waiting for data availability<br>
&gt;&gt; Tracing stopped for session test<br>
&gt;&gt; Session test destroyed<br>
&gt;&gt;<br>
&gt;&gt; the result from the run on older versions of lttng creates bigger =
and bigger<br>
&gt;&gt; event traces until reaching max size.<br>
</div></div>We see this pattern here and the max size seems to be 168 event=
s, was it<br>
similar in your previous tests ?<br></blockquote></div></div><div>If I&#39;=
m running the same test on 2.4 or 2.3 the max number of events is much bigg=
er, like ~10000=C2=A0</div><div>(I don&#39;t have the exact number right no=
w, I will rebuild and run the test again and get back=C2=A0</div><div>with =
traces from that run)=C2=A0</div></div></div></div></blockquote><div>For 2.=
4.2 the log looks like this:</div><div><div>./test.run ./tracetest</div><di=
v><br></div><div>lttng (LTTng Trace Control) 2.4.2 - =C3=89poque Opaque</di=
v><div>BabelTrace Trace Viewer and Converter 1.2.1</div><div><span class=3D=
"" style=3D"white-space:pre">	</span>linux-vdso.so.1 =3D&gt; =C2=A0(0x00007=
fff775fe000)</div><div><span class=3D"" style=3D"white-space:pre">	</span>l=
iblttng-ctl.so.0 =3D&gt; /usr/local/lib/liblttng-ctl.so.0 (0x00002b2b016e40=
00)</div><div><span class=3D"" style=3D"white-space:pre">	</span>libpopt.so=
.0 =3D&gt; /lib/x86_64-linux-gnu/libpopt.so.0 (0x00002b2b0190f000)</div><di=
v><span class=3D"" style=3D"white-space:pre">	</span>libpthread.so.0 =3D&gt=
; /lib/x86_64-linux-gnu/libpthread.so.0 (0x00002b2b01b1b000)</div><div><spa=
n class=3D"" style=3D"white-space:pre">	</span>libc.so.6 =3D&gt; /lib/x86_6=
4-linux-gnu/libc.so.6 (0x00002b2b01d39000)</div><div><span class=3D"" style=
=3D"white-space:pre">	</span>librt.so.1 =3D&gt; /lib/x86_64-linux-gnu/librt=
.so.1 (0x00002b2b020ff000)</div><div><span class=3D"" style=3D"white-space:=
pre">	</span>liburcu.so.3 =3D&gt; /usr/local/lib/liburcu.so.3 (0x00002b2b02=
307000)</div><div><span class=3D"" style=3D"white-space:pre">	</span>/lib64=
/ld-linux-x86-64.so.2 (0x00002b2b014bf000)</div><div><br></div><div>Session=
 test created.</div><div>Default snapshot output set to: //lttng-traces/tes=
t-20141113-093611</div><div>Snapshot mode set. Every channel enabled for th=
at session will be set in overwrite mode and mmap output.</div><div>UST cha=
nnel ch1 enabled for session test</div><div>UST event * created in channel =
ch1</div><div>Tracing started for session test</div><div>Tracing session te=
st: [active snapshot]</div><div>=C2=A0 =C2=A0 Trace path:=C2=A0</div><div><=
br></div><div>=3D=3D=3D Domain: UST global =3D=3D=3D</div><div><br></div><d=
iv>Buffer type: per UID</div><div><br></div><div>Channels:</div><div>------=
-------</div><div>- ch1: [enabled]</div><div><br></div><div>=C2=A0 =C2=A0 A=
ttributes:</div><div>=C2=A0 =C2=A0 =C2=A0 overwrite mode: 1</div><div>=C2=
=A0 =C2=A0 =C2=A0 subbufers size: 4096</div><div>=C2=A0 =C2=A0 =C2=A0 numbe=
r of subbufers: 16</div><div>=C2=A0 =C2=A0 =C2=A0 switch timer interval: 0<=
/div><div>=C2=A0 =C2=A0 =C2=A0 read timer interval: 0</div><div>=C2=A0 =C2=
=A0 =C2=A0 output: mmap()</div><div><br></div><div>=C2=A0 =C2=A0 Events:</d=
iv><div>=C2=A0 =C2=A0 =C2=A0 * (type: tracepoint) [enabled]</div><div><br><=
/div><div>Snapshot recorded successfully for session test</div><div>1000</d=
iv><div>[09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp=
: { cpu_id =3D 4 }, { my_string_field =3D &quot;test&quot;, my_integer_fiel=
d =3D 0 }</div><div>[09:36:11.985857254] (+0.000000501) 07f8cf84a38f tracet=
est:first_tp: { cpu_id =3D 4 }, { my_string_field =3D &quot;test&quot;, my_=
integer_field =3D 999 }</div><div>Snapshot recorded successfully for sessio=
n test</div><div>2000</div><div>[09:36:11.985319272] (+?.?????????) 07f8cf8=
4a38f tracetest:first_tp: { cpu_id =3D 4 }, { my_string_field =3D &quot;tes=
t&quot;, my_integer_field =3D 0 }</div><div>[09:36:12.033066130] (+0.000001=
663) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 5 }, { my_string_field =
=3D &quot;test&quot;, my_integer_field =3D 999 }</div><div>Snapshot recorde=
d successfully for session test</div><div>3000</div><div>[09:36:11.98531927=
2] (+?.?????????) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 4 }, { my_s=
tring_field =3D &quot;test&quot;, my_integer_field =3D 0 }</div><div>[09:36=
:12.086888121] (+0.000001273) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D=
 5 }, { my_string_field =3D &quot;test&quot;, my_integer_field =3D 999 }</d=
iv><div>Snapshot recorded successfully for session test</div><div>4000</div=
><div>[09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp: =
{ cpu_id =3D 4 }, { my_string_field =3D &quot;test&quot;, my_integer_field =
=3D 0 }</div><div>[09:36:12.147378251] (+0.000001257) 07f8cf84a38f tracetes=
t:first_tp: { cpu_id =3D 4 }, { my_string_field =3D &quot;test&quot;, my_in=
teger_field =3D 999 }</div><div>Snapshot recorded successfully for session =
test</div><div>5000</div><div>[09:36:11.985319272] (+?.?????????) 07f8cf84a=
38f tracetest:first_tp: { cpu_id =3D 4 }, { my_string_field =3D &quot;test&=
quot;, my_integer_field =3D 0 }</div><div>[09:36:12.225584696] (+0.00000052=
8) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 4 }, { my_string_field =3D=
 &quot;test&quot;, my_integer_field =3D 999 }</div><div>Snapshot recorded s=
uccessfully for session test</div><div>6000</div><div>[09:36:11.985319272] =
(+?.?????????) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 4 }, { my_stri=
ng_field =3D &quot;test&quot;, my_integer_field =3D 0 }</div><div>[09:36:12=
.288311172] (+0.000000571) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 7 =
}, { my_string_field =3D &quot;test&quot;, my_integer_field =3D 999 }</div>=
<div>Snapshot recorded successfully for session test</div><div>7000</div><d=
iv>[09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp: { c=
pu_id =3D 4 }, { my_string_field =3D &quot;test&quot;, my_integer_field =3D=
 0 }</div><div>[09:36:12.375789307] (+0.000001238) 07f8cf84a38f tracetest:f=
irst_tp: { cpu_id =3D 4 }, { my_string_field =3D &quot;test&quot;, my_integ=
er_field =3D 999 }</div><div>Snapshot recorded successfully for session tes=
t</div><div>7000</div><div>[09:36:12.032314084] (+?.?????????) 07f8cf84a38f=
 tracetest:first_tp: { cpu_id =3D 5 }, { my_string_field =3D &quot;test&quo=
t;, my_integer_field =3D 0 }</div><div>[09:36:12.460756779] (+0.000001248) =
07f8cf84a38f tracetest:first_tp: { cpu_id =3D 4 }, { my_string_field =3D &q=
uot;test&quot;, my_integer_field =3D 999 }</div><div>Snapshot recorded succ=
essfully for session test</div><div>8000</div><div>[09:36:12.032314084] (+?=
.?????????) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 5 }, { my_string_=
field =3D &quot;test&quot;, my_integer_field =3D 0 }</div><div>[09:36:12.54=
0464090] (+0.000001292) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 7 }, =
{ my_string_field =3D &quot;test&quot;, my_integer_field =3D 999 }</div><di=
v>Snapshot recorded successfully for session test</div><div>9000</div><div>=
[09:36:12.032314084] (+?.?????????) 07f8cf84a38f tracetest:first_tp: { cpu_=
id =3D 5 }, { my_string_field =3D &quot;test&quot;, my_integer_field =3D 0 =
}</div><div>[09:36:12.621992931] (+0.000001298) 07f8cf84a38f tracetest:firs=
t_tp: { cpu_id =3D 5 }, { my_string_field =3D &quot;test&quot;, my_integer_=
field =3D 999 }</div><div>Waiting for data availability</div><div>Tracing s=
topped for session test</div><div>Session test destroyed</div></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-s=
tyle:solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><d=
iv class=3D"gmail_quote"><span class=3D""><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:=
rgb(204,204,204);border-left-style:solid;padding-left:1ex">
<span><br>
&gt;<br>
&gt; Unless I&#39;m mistaken, the behavior of the snapshot mode has changed=
<br>
&gt; between 2.4 and 2.5.<br>
&gt;<br>
&gt; In the 2.4 series, consecutive snapshots could overlap; that is,<br>
&gt; events could be present in multiple snapshots. As of 2.5, an event is<=
br>
&gt; guaranteed to only appear in one snapshot as the events are considered=
<br>
&gt; as having been &quot;consumed&quot; at that point.<br>
<br>
</span>Hum, no the behavior is still the same, consecutive snapshots can ov=
erlap.<br>
<br>
Could you tell us on which architecture you are experiencing the problem<br=
>
and the number of CPUs ?<br></blockquote></span><div>The traces appended is=
 from my laptop running Ubuntu 14.04 with &quot;8&quot; cpu&#39;s</div><div=
>model name =C2=A0 =C2=A0 =C2=A0: Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz=
<br></div><div>I have also run this on ARM with 16 cores and a powerpc</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;=
padding-left:1ex">
<br>
Thanks,<br>
<br>
Julien<br>
</blockquote></div><br></div></div>
</blockquote></div><br></div></div>

--001a113a4c682aa02a0507ba4aac--


--===============0063189868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0063189868==--
