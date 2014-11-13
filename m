From: Anders Wallin <wallinux@gmail.com>
Subject: Re: snapshot issue with 2.5
Date: Thu, 13 Nov 2014 16:33:41 +0100
Message-ID: <CAF2baFfvY6NRNzNc3tkJygc=01ntwf-qa3GgXG_rT+fSw6E2MA__37649.4480450221$1415892892$gmane$org@mail.gmail.com>
References: <CAF2baFd5vRuGKa7MVpqHvkCHia5fDN19cvq8qdedqJreNU6-vQ@mail.gmail.com>
 <CA+jJMxvXfVT8w+hokMyFgTSqN=JH3nQUudJR+8MUJtQmTEgZZQ@mail.gmail.com>
 <5463E904.9080102@efficios.com>
 <CAF2baFesZ0Ke5qcWt9eGzWTyPuyAW_PM=ZZ+g9baEUNRwK5cGA@mail.gmail.com>
 <CAF2baFcKwwciQDr+Wdpcs3_EJV969_aPUA_UtPXGo7=CMxWKvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0935692835=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <wallinux@gmail.com>) id 1XowP5-000624-Lz
 for lttng-dev@lists.lttng.org; Thu, 13 Nov 2014 10:33:53 -0500
Received: by mail-wi0-f174.google.com with SMTP id h11so618132wiw.7
 for <lttng-dev@lists.lttng.org>; Thu, 13 Nov 2014 07:33:42 -0800 (PST)
In-Reply-To: <CAF2baFcKwwciQDr+Wdpcs3_EJV969_aPUA_UtPXGo7=CMxWKvw@mail.gmail.com>
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

--===============0935692835==
Content-Type: multipart/alternative; boundary=089e0149345eb0df0c0507bf3c71

--089e0149345eb0df0c0507bf3c71
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

bug is introduced in  68808f4e0bbb3adccff72ff9dab6ec9f3a9e6866

Regards

Anders

Anders Wallin

On Thu, Nov 13, 2014 at 10:39 AM, Anders Wallin <wallinux@gmail.com> wrote:

>
>
> Anders Wallin
>
> On Thu, Nov 13, 2014 at 8:43 AM, Anders Wallin <wallinux@gmail.com> wrote=
:
>
>> On Thu, Nov 13, 2014 at 12:11 AM, Julien Desfossez <
>> jdesfossez@efficios.com> wrote:
>>
>>> Hi,
>>>
>>> On 14-11-12 05:30 PM, J=C3=A9r=C3=A9mie Galarneau wrote:
>>> > On Wed, Nov 12, 2014 at 7:39 AM, Anders Wallin <wallinux@gmail.com>
>>> wrote:
>>> >> Hi,
>>> >>
>>> >> using userspace snapshot mode in 2.5 seems to broken.
>>> >>
>>> >> I have small stupid application(tracetest) generating 1000 events
>>> >>
>>> >> Running the script (the below is simplified version of the script)
>>> >>
>>> -----------------------------------------------------------------------=
-----------
>>> >> #!/bin/bash
>>> >> LTTNG=3D'lttng -n'
>>> >> lttng-sessiond --no-kernel &
>>> >
>>> > You should use the "-d" flag to launch the sessiond as a daemon. Usin=
g
>>> > "&" might cause the "create" command to launch a second session daemo=
n
>>> > since the first one would not have had the time to open create its
>>> > command sockets.
>>> >
>>> >>
>>> >> $LTTNG create test --snapshot
>>> >> $LTTNG enable-channel -u --subbuf-size 64k --num-subbuf 16
>>> --overwrite ch1
>>> >> $LTTNG enable-event -u -c ch1 "*"
>>> >> $LTTNG start
>>> >> $LTTNG list ch1
>>> >>
>>> >> mkdir -p snapshot/
>>> >>
>>> >> for i in $(seq 1 $LOOPS); do
>>> >>     ./tracetest
>>> >>     $LTTNG snapshot record -m 1G
>>> >>
>>> >>     # print no of events and first and last event
>>> >>     last=3D$(ls -1drt $HOME/lttng-traces/$SESSION*/* | tail -1)
>>> >>     babeltrace $last > snapshot/$i.bt
>>> >>     cat snapshot/$i.bt | wc -l
>>> >>     cat snapshot/$i.bt | head -1
>>> >>     cat snapshot/$i.bt | tail -1
>>> >> done
>>> >>
>>> >> $LTTNG stop
>>> >> $LTTNG destroy $SESSION
>>> >>
>>> -----------------------------------------------------------------------=
-----------
>>> >>
>>> >> The result of the run looks like this;
>>> >> ./test.run
>>> >> Error: consumer err socket second poll error
>>> >> Error: Health error occurred in thread_manage_consumer
>>> >> PERROR - 13:36:59.685167 [23772/23781]: bind inet: Address already i=
n
>>> use
>>> >> (in lttcomm_bind_inet_sock() at inet.c:109)
>>> >> Warning: Another session daemon is using this JUL port. JUL support
>>> will be
>>> >> deactivated to prevent interfering with the tracing.
>>> >>
>>> >
>>> > Is there a reason why you run two session daemons? I'm guessing this
>>> > is related to my "& vs -d" comment above.
>>> >
>>> >> lttng (LTTng Trace Control) 2.5.2 - Fumisterie
>>> >> BabelTrace Trace Viewer and Converter 1.2.4
>>> >>         linux-vdso.so.1 =3D>  (0x00007fffba966000)
>>> >>         liblttng-ctl.so.0 =3D>
>>> /usr/lib/x86_64-linux-gnu/liblttng-ctl.so.0
>>> >> (0x00007fbfe4b1d000)
>>> >>         librt.so.1 =3D> /lib/x86_64-linux-gnu/librt.so.1
>>> (0x00007fbfe4915000)
>>> >>         libxml2.so.2 =3D> /usr/lib/x86_64-linux-gnu/libxml2.so.2
>>> >> (0x00007fbfe45ae000)
>>> >>         libpopt.so.0 =3D> /lib/x86_64-linux-gnu/libpopt.so.0
>>> >> (0x00007fbfe43a2000)
>>> >>         libpthread.so.0 =3D> /lib/x86_64-linux-gnu/libpthread.so.0
>>> >> (0x00007fbfe4184000)
>>> >>         libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6
>>> (0x00007fbfe3dbd000)
>>> >>         /lib64/ld-linux-x86-64.so.2 (0x00007fbfe4fac000)
>>> >>         liburcu.so.2 =3D> /usr/lib/x86_64-linux-gnu/liburcu.so.2
>>> >> (0x00007fbfe3bb6000)
>>> >>         libdl.so.2 =3D> /lib/x86_64-linux-gnu/libdl.so.2
>>> (0x00007fbfe39b2000)
>>> >>         libz.so.1 =3D> /lib/x86_64-linux-gnu/libz.so.1
>>> (0x00007fbfe3798000)
>>> >>         liblzma.so.5 =3D> /lib/x86_64-linux-gnu/liblzma.so.5
>>> >> (0x00007fbfe3576000)
>>> >>         libm.so.6 =3D> /lib/x86_64-linux-gnu/libm.so.6
>>> (0x00007fbfe3270000)
>>> >>
>>> >> Session test created.
>>> >> Default snapshot output set to:
>>> >> /home/awallin/lttng-traces/test-20141112-133700
>>> >> Snapshot mode set. Every channel enabled for that session will be se=
t
>>> in
>>> >> overwrite mode and mmap output.
>>> >> UST channel ch1 enabled for session test
>>> >> UST event * created in channel ch1
>>> >> Tracing started for session test
>>> >> Tracing session test: [active snapshot]
>>> >>     Trace path:
>>> >>     Live timer interval (usec): 4294967295
>>> >>
>>> >> =3D=3D=3D Domain: UST global =3D=3D=3D
>>> >>
>>> >> Channels:
>>> >> -------------
>>> >> - ch1: [enabled]
>>> >>
>>> >>     Attributes:
>>> >>       overwrite mode: 1
>>> >>       subbufers size: 4096
>>> >>       number of subbufers: 16
>>> >>       switch timer interval: 0
>>> >>       read timer interval: 0
>>> >>       trace file count: 0
>>> >>       trace file size (bytes): 0
>>> >>       output: mmap()
>>> >>
>>> >>     Events:
>>> >>       * (type: tracepoint) [enabled]
>>> >>
>>> >> Snapshot recorded successfully for session test
>>> >> 84
>>> >> [13:37:00.852615950] (+?.?????????) arn-awallin-mint-l3
>>> >> ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFFC6BC=
7000,
>>> sopath
>>> >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
>>> >> [13:37:00.853798949] (+0.000000805) arn-awallin-mint-l3
>>> tracetest:first_tp:
>>> >> { cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D=
 999 }
>>> >> Snapshot recorded successfully for session test
>>> >> 157
>>> >> [13:37:00.853735195] (+?.?????????) arn-awallin-mint-l3
>>> tracetest:first_tp:
>>> >> { cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D=
 927 }
>>> >> [13:37:00.894839116] (+0.000000299) arn-awallin-mint-l3
>>> tracetest:first_tp:
>>> >> { cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D=
 999 }
>>> >> Snapshot recorded successfully for session test
>>> >> 168
>>> >> [13:37:00.853735195] (+?.?????????) arn-awallin-mint-l3
>>> tracetest:first_tp:
>>> >> { cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D=
 927 }
>>> >> [13:37:00.929447330] (+0.000000305) arn-awallin-mint-l3
>>> tracetest:first_tp:
>>> >> { cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D=
 999 }
>>> >> Snapshot recorded successfully for session test
>>>
>>> Something is wrong from here:
>>> >> 168
>>> >> [13:37:00.894411117] (+?.?????????) arn-awallin-mint-l3
>>> >> ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFF6BF8=
1000,
>>> sopath
>>> >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
>>> >> [13:37:00.972035546] (+0.000000597) arn-awallin-mint-l3
>>> tracetest:first_tp:
>>> >> { cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D=
 999 }
>>> >> Snapshot recorded successfully for session test
>>> >> 168
>>> >> [13:37:00.894411117] (+?.?????????) arn-awallin-mint-l3
>>> >> ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFF6BF8=
1000,
>>> sopath
>>> >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
>>> >> [13:37:01.014060940] (+0.000000341) arn-awallin-mint-l3
>>> tracetest:first_tp:
>>> >> { cpu_id =3D 7 }, { my_string_field =3D "test", my_integer_field =3D=
 999 }
>>> >> Snapshot recorded successfully for session test
>>> >> 168
>>> >> [13:37:00.894411117] (+?.?????????) arn-awallin-mint-l3
>>> >> ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFF6BF8=
1000,
>>> sopath
>>> >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
>>> >> [13:37:01.052555877] (+0.000000872) arn-awallin-mint-l3
>>> tracetest:first_tp:
>>> >> { cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D=
 999 }
>>> ... to here.
>>>
>>> The beginning timestamp is the same, the number of events is the same,
>>> but the end timestamp moves. We see also this pattern below.
>>> I would be really interested to see the whole snapshots when it happens=
.
>>> It seems like we are not be overwriting the beginning of the ring buffe=
r
>>> in some conditions. Could you send us your tracetest program and the
>>> script so we can try to reproduce the problem ?
>>>
>>
>> I will append it including a run with debug turned on and all the
>> snapshot files created
>>
>>
>>>
>>> >> Snapshot recorded successfully for session test
>>> >> 168
>>> >> [13:37:01.014035993] (+?.?????????) arn-awallin-mint-l3
>>> tracetest:first_tp:
>>> >> { cpu_id =3D 7 }, { my_string_field =3D "test", my_integer_field =3D=
 927 }
>>> >> [13:37:01.098620808] (+0.000001404) arn-awallin-mint-l3
>>> tracetest:first_tp:
>>> >> { cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D=
 999 }
>>> >> Snapshot recorded successfully for session test
>>> >> 168
>>> >> [13:37:01.097087388] (+?.?????????) arn-awallin-mint-l3
>>> >> ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF4BFF=
E000,
>>> sopath
>>> >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
>>> >> [13:37:01.129839830] (+0.000000533) arn-awallin-mint-l3
>>> tracetest:first_tp:
>>> >> { cpu_id =3D 7 }, { my_string_field =3D "test", my_integer_field =3D=
 999 }
>>> >> Snapshot recorded successfully for session test
>>> >> 168
>>> >> [13:37:01.097087388] (+?.?????????) arn-awallin-mint-l3
>>> >> ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF4BFF=
E000,
>>> sopath
>>> >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
>>> >> [13:37:01.129839830] (+0.000000533) arn-awallin-mint-l3
>>> tracetest:first_tp:
>>> >> { cpu_id =3D 7 }, { my_string_field =3D "test", my_integer_field =3D=
 999 }
>>> >> Snapshot recorded successfully for session test
>>> >> 168
>>> >> [13:37:01.097087388] (+?.?????????) arn-awallin-mint-l3
>>> >> ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF4BFF=
E000,
>>> sopath
>>> >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
>>> >> [13:37:01.172829105] (+0.000000575) arn-awallin-mint-l3
>>> tracetest:first_tp:
>>> >> { cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D=
 999 }
>>> >> Snapshot recorded successfully for session test
>>> >> 168
>>> >> [13:37:01.172021557] (+?.?????????) arn-awallin-mint-l3
>>> >> ust_baddr_statedump:soinfo: { cpu_id =3D 7 }, { baddr =3D 0x7FFF653F=
E000,
>>> sopath
>>> >> =3D "[vdso]", size =3D 0, mtime =3D -1 }
>>> >> [13:37:01.220074165] (+0.000000553) arn-awallin-mint-l3
>>> tracetest:first_tp:
>>> >> { cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D=
 999 }
>>> >> Waiting for data availability
>>> >> Tracing stopped for session test
>>> >> Session test destroyed
>>> >>
>>> >> the result from the run on older versions of lttng creates bigger an=
d
>>> bigger
>>> >> event traces until reaching max size.
>>> We see this pattern here and the max size seems to be 168 events, was i=
t
>>> similar in your previous tests ?
>>>
>> If I'm running the same test on 2.4 or 2.3 the max number of events is
>> much bigger, like ~10000
>> (I don't have the exact number right now, I will rebuild and run the tes=
t
>> again and get back
>> with traces from that run)
>>
> For 2.4.2 the log looks like this:
> ./test.run ./tracetest
>
> lttng (LTTng Trace Control) 2.4.2 - =C3=89poque Opaque
> BabelTrace Trace Viewer and Converter 1.2.1
> linux-vdso.so.1 =3D>  (0x00007fff775fe000)
> liblttng-ctl.so.0 =3D> /usr/local/lib/liblttng-ctl.so.0 (0x00002b2b016e40=
00)
> libpopt.so.0 =3D> /lib/x86_64-linux-gnu/libpopt.so.0 (0x00002b2b0190f000)
> libpthread.so.0 =3D> /lib/x86_64-linux-gnu/libpthread.so.0
> (0x00002b2b01b1b000)
> libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6 (0x00002b2b01d39000)
> librt.so.1 =3D> /lib/x86_64-linux-gnu/librt.so.1 (0x00002b2b020ff000)
> liburcu.so.3 =3D> /usr/local/lib/liburcu.so.3 (0x00002b2b02307000)
> /lib64/ld-linux-x86-64.so.2 (0x00002b2b014bf000)
>
> Session test created.
> Default snapshot output set to: //lttng-traces/test-20141113-093611
> Snapshot mode set. Every channel enabled for that session will be set in
> overwrite mode and mmap output.
> UST channel ch1 enabled for session test
> UST event * created in channel ch1
> Tracing started for session test
> Tracing session test: [active snapshot]
>     Trace path:
>
> =3D=3D=3D Domain: UST global =3D=3D=3D
>
> Buffer type: per UID
>
> Channels:
> -------------
> - ch1: [enabled]
>
>     Attributes:
>       overwrite mode: 1
>       subbufers size: 4096
>       number of subbufers: 16
>       switch timer interval: 0
>       read timer interval: 0
>       output: mmap()
>
>     Events:
>       * (type: tracepoint) [enabled]
>
> Snapshot recorded successfully for session test
> 1000
> [09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 0 }
> [09:36:11.985857254] (+0.000000501) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> Snapshot recorded successfully for session test
> 2000
> [09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 0 }
> [09:36:12.033066130] (+0.000001663) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> Snapshot recorded successfully for session test
> 3000
> [09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 0 }
> [09:36:12.086888121] (+0.000001273) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> Snapshot recorded successfully for session test
> 4000
> [09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 0 }
> [09:36:12.147378251] (+0.000001257) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> Snapshot recorded successfully for session test
> 5000
> [09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 0 }
> [09:36:12.225584696] (+0.000000528) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> Snapshot recorded successfully for session test
> 6000
> [09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 0 }
> [09:36:12.288311172] (+0.000000571) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 7 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> Snapshot recorded successfully for session test
> 7000
> [09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 0 }
> [09:36:12.375789307] (+0.000001238) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> Snapshot recorded successfully for session test
> 7000
> [09:36:12.032314084] (+?.?????????) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 0 }
> [09:36:12.460756779] (+0.000001248) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> Snapshot recorded successfully for session test
> 8000
> [09:36:12.032314084] (+?.?????????) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 0 }
> [09:36:12.540464090] (+0.000001292) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 7 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> Snapshot recorded successfully for session test
> 9000
> [09:36:12.032314084] (+?.?????????) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 0 }
> [09:36:12.621992931] (+0.000001298) 07f8cf84a38f tracetest:first_tp: {
> cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 999 }
> Waiting for data availability
> Tracing stopped for session test
> Session test destroyed
>
>
>>
>>> >
>>> > Unless I'm mistaken, the behavior of the snapshot mode has changed
>>> > between 2.4 and 2.5.
>>> >
>>> > In the 2.4 series, consecutive snapshots could overlap; that is,
>>> > events could be present in multiple snapshots. As of 2.5, an event is
>>> > guaranteed to only appear in one snapshot as the events are considere=
d
>>> > as having been "consumed" at that point.
>>>
>>> Hum, no the behavior is still the same, consecutive snapshots can
>>> overlap.
>>>
>>> Could you tell us on which architecture you are experiencing the proble=
m
>>> and the number of CPUs ?
>>>
>> The traces appended is from my laptop running Ubuntu 14.04 with "8" cpu'=
s
>> model name      : Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz
>> I have also run this on ARM with 16 cores and a powerpc
>>
>>>
>>> Thanks,
>>>
>>> Julien
>>>
>>
>>
>

--089e0149345eb0df0c0507bf3c71
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">bug is introduced in =C2=A068808f4e0bbb3adccff72ff9dab6ec9=
f3a9e6866<div><br></div><div>Regards</div><div><br></div><div>Anders</div><=
/div><div class=3D"gmail_extra"><br clear=3D"all"><div><div class=3D"gmail_=
signature">Anders Wallin</div></div>
<br><div class=3D"gmail_quote">On Thu, Nov 13, 2014 at 10:39 AM, Anders Wal=
lin <span dir=3D"ltr">&lt;<a href=3D"mailto:wallinux@gmail.com" target=3D"_=
blank">wallinux@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><div dir=3D"ltr"><br><div class=3D"gmail_extra"><br clear=3D"all"><d=
iv><div>Anders Wallin</div></div>
<br><div class=3D"gmail_quote"><div><div class=3D"h5">On Thu, Nov 13, 2014 =
at 8:43 AM, Anders Wallin <span dir=3D"ltr">&lt;<a href=3D"mailto:wallinux@=
gmail.com" target=3D"_blank">wallinux@gmail.com</a>&gt;</span> wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;pad=
ding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gm=
ail_quote"><div><div>On Thu, Nov 13, 2014 at 12:11 AM, Julien Desfossez <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:jdesfossez@efficios.com" target=3D"_bl=
ank">jdesfossez@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border=
-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">Hi,<=
br>
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
n and all the snapshot files created</div><div><div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-w=
idth:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding=
-left:1ex">
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
traces from that run)=C2=A0</div></div></div></div></blockquote></div></div=
><div>For 2.4.2 the log looks like this:</div><div><div>./test.run ./tracet=
est</div><div><br></div><div>lttng (LTTng Trace Control) 2.4.2 - =C3=89poqu=
e Opaque</div><div>BabelTrace Trace Viewer and Converter 1.2.1</div><div><s=
pan style=3D"white-space:pre-wrap">	</span>linux-vdso.so.1 =3D&gt; =C2=A0(0=
x00007fff775fe000)</div><div><span style=3D"white-space:pre-wrap">	</span>l=
iblttng-ctl.so.0 =3D&gt; /usr/local/lib/liblttng-ctl.so.0 (0x00002b2b016e40=
00)</div><div><span style=3D"white-space:pre-wrap">	</span>libpopt.so.0 =3D=
&gt; /lib/x86_64-linux-gnu/libpopt.so.0 (0x00002b2b0190f000)</div><div><spa=
n style=3D"white-space:pre-wrap">	</span>libpthread.so.0 =3D&gt; /lib/x86_6=
4-linux-gnu/libpthread.so.0 (0x00002b2b01b1b000)</div><div><span style=3D"w=
hite-space:pre-wrap">	</span>libc.so.6 =3D&gt; /lib/x86_64-linux-gnu/libc.s=
o.6 (0x00002b2b01d39000)</div><div><span style=3D"white-space:pre-wrap">	</=
span>librt.so.1 =3D&gt; /lib/x86_64-linux-gnu/librt.so.1 (0x00002b2b020ff00=
0)</div><div><span style=3D"white-space:pre-wrap">	</span>liburcu.so.3 =3D&=
gt; /usr/local/lib/liburcu.so.3 (0x00002b2b02307000)</div><div><span style=
=3D"white-space:pre-wrap">	</span>/lib64/ld-linux-x86-64.so.2 (0x00002b2b01=
4bf000)</div><div><br></div><div>Session test created.</div><div>Default sn=
apshot output set to: //lttng-traces/test-20141113-093611</div><span class=
=3D""><div>Snapshot mode set. Every channel enabled for that session will b=
e set in overwrite mode and mmap output.</div><div>UST channel ch1 enabled =
for session test</div><div>UST event * created in channel ch1</div><div>Tra=
cing started for session test</div><div>Tracing session test: [active snaps=
hot]</div><div>=C2=A0 =C2=A0 Trace path:=C2=A0</div><div><br></div></span><=
span class=3D""><div>=3D=3D=3D Domain: UST global =3D=3D=3D</div><div><br><=
/div></span><div>Buffer type: per UID</div><span class=3D""><div><br></div>=
<div>Channels:</div><div>-------------</div><div>- ch1: [enabled]</div><div=
><br></div><div>=C2=A0 =C2=A0 Attributes:</div><div>=C2=A0 =C2=A0 =C2=A0 ov=
erwrite mode: 1</div><div>=C2=A0 =C2=A0 =C2=A0 subbufers size: 4096</div><d=
iv>=C2=A0 =C2=A0 =C2=A0 number of subbufers: 16</div><div>=C2=A0 =C2=A0 =C2=
=A0 switch timer interval: 0</div><div>=C2=A0 =C2=A0 =C2=A0 read timer inte=
rval: 0</div></span><span class=3D""><div>=C2=A0 =C2=A0 =C2=A0 output: mmap=
()</div><div><br></div><div>=C2=A0 =C2=A0 Events:</div><div>=C2=A0 =C2=A0 =
=C2=A0 * (type: tracepoint) [enabled]</div><div><br></div><div>Snapshot rec=
orded successfully for session test</div></span><div>1000</div><div>[09:36:=
11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D =
4 }, { my_string_field =3D &quot;test&quot;, my_integer_field =3D 0 }</div>=
<div>[09:36:11.985857254] (+0.000000501) 07f8cf84a38f tracetest:first_tp: {=
 cpu_id =3D 4 }, { my_string_field =3D &quot;test&quot;, my_integer_field =
=3D 999 }</div><span class=3D""><div>Snapshot recorded successfully for ses=
sion test</div></span><div>2000</div><div>[09:36:11.985319272] (+?.????????=
?) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 4 }, { my_string_field =3D=
 &quot;test&quot;, my_integer_field =3D 0 }</div><div>[09:36:12.<a href=3D"=
tel:033066130" value=3D"+4633066130" target=3D"_blank">033066130</a>] (+0.0=
00001663) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 5 }, { my_string_fi=
eld =3D &quot;test&quot;, my_integer_field =3D 999 }</div><span class=3D"">=
<div>Snapshot recorded successfully for session test</div></span><div>3000<=
/div><div>[09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_=
tp: { cpu_id =3D 4 }, { my_string_field =3D &quot;test&quot;, my_integer_fi=
eld =3D 0 }</div><div>[09:36:12.<a href=3D"tel:086888121" value=3D"+4686888=
121" target=3D"_blank">086888121</a>] (+0.000001273) 07f8cf84a38f tracetest=
:first_tp: { cpu_id =3D 5 }, { my_string_field =3D &quot;test&quot;, my_int=
eger_field =3D 999 }</div><span class=3D""><div>Snapshot recorded successfu=
lly for session test</div></span><div>4000</div><div>[09:36:11.985319272] (=
+?.?????????) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 4 }, { my_strin=
g_field =3D &quot;test&quot;, my_integer_field =3D 0 }</div><div>[09:36:12.=
147378251] (+0.000001257) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 4 }=
, { my_string_field =3D &quot;test&quot;, my_integer_field =3D 999 }</div><=
span class=3D""><div>Snapshot recorded successfully for session test</div><=
/span><div>5000</div><div>[09:36:11.985319272] (+?.?????????) 07f8cf84a38f =
tracetest:first_tp: { cpu_id =3D 4 }, { my_string_field =3D &quot;test&quot=
;, my_integer_field =3D 0 }</div><div>[09:36:12.225584696] (+0.000000528) 0=
7f8cf84a38f tracetest:first_tp: { cpu_id =3D 4 }, { my_string_field =3D &qu=
ot;test&quot;, my_integer_field =3D 999 }</div><span class=3D""><div>Snapsh=
ot recorded successfully for session test</div></span><div>6000</div><div>[=
09:36:11.985319272] (+?.?????????) 07f8cf84a38f tracetest:first_tp: { cpu_i=
d =3D 4 }, { my_string_field =3D &quot;test&quot;, my_integer_field =3D 0 }=
</div><div>[09:36:12.288311172] (+0.000000571) 07f8cf84a38f tracetest:first=
_tp: { cpu_id =3D 7 }, { my_string_field =3D &quot;test&quot;, my_integer_f=
ield =3D 999 }</div><span class=3D""><div>Snapshot recorded successfully fo=
r session test</div></span><div>7000</div><div>[09:36:11.985319272] (+?.???=
??????) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 4 }, { my_string_fiel=
d =3D &quot;test&quot;, my_integer_field =3D 0 }</div><div>[09:36:12.375789=
307] (+0.000001238) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 4 }, { my=
_string_field =3D &quot;test&quot;, my_integer_field =3D 999 }</div><span c=
lass=3D""><div>Snapshot recorded successfully for session test</div></span>=
<div>7000</div><div>[09:36:12.032314084] (+?.?????????) 07f8cf84a38f tracet=
est:first_tp: { cpu_id =3D 5 }, { my_string_field =3D &quot;test&quot;, my_=
integer_field =3D 0 }</div><div>[09:36:12.460756779] (+0.000001248) 07f8cf8=
4a38f tracetest:first_tp: { cpu_id =3D 4 }, { my_string_field =3D &quot;tes=
t&quot;, my_integer_field =3D 999 }</div><span class=3D""><div>Snapshot rec=
orded successfully for session test</div></span><div>8000</div><div>[09:36:=
12.032314084] (+?.?????????) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D =
5 }, { my_string_field =3D &quot;test&quot;, my_integer_field =3D 0 }</div>=
<div>[09:36:12.540464090] (+0.000001292) 07f8cf84a38f tracetest:first_tp: {=
 cpu_id =3D 7 }, { my_string_field =3D &quot;test&quot;, my_integer_field =
=3D 999 }</div><span class=3D""><div>Snapshot recorded successfully for ses=
sion test</div></span><div>9000</div><div>[09:36:12.032314084] (+?.????????=
?) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 5 }, { my_string_field =3D=
 &quot;test&quot;, my_integer_field =3D 0 }</div><div>[09:36:12.621992931] =
(+0.000001298) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 5 }, { my_stri=
ng_field =3D &quot;test&quot;, my_integer_field =3D 999 }</div><span class=
=3D""><div>Waiting for data availability</div><div>Tracing stopped for sess=
ion test</div><div>Session test destroyed</div></span></div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid=
;padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=
=3D"gmail_quote"><span><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bo=
rder-left-style:solid;padding-left:1ex">
<span><br>
&gt;<span class=3D""><br>
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
</span></span><span class=3D"">Hum, no the behavior is still the same, cons=
ecutive snapshots can overlap.<br>
<br>
Could you tell us on which architecture you are experiencing the problem<br=
>
and the number of CPUs ?<br></span></blockquote></span><span class=3D""><di=
v>The traces appended is from my laptop running Ubuntu 14.04 with &quot;8&q=
uot; cpu&#39;s</div><div>model name =C2=A0 =C2=A0 =C2=A0: Intel(R) Core(TM)=
 i7-2760QM CPU @ 2.40GHz<br></div><div>I have also run this on ARM with 16 =
cores and a powerpc</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);=
border-left-style:solid;padding-left:1ex">
<br>
Thanks,<br>
<br>
Julien<br>
</blockquote></span></div><br></div></div>
</blockquote></div><br></div></div>
</blockquote></div><br></div>

--089e0149345eb0df0c0507bf3c71--


--===============0935692835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0935692835==--
