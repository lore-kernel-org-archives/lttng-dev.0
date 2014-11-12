From: Anders Wallin <wallinux@gmail.com>
Subject: snapshot issue with 2.5
Date: Wed, 12 Nov 2014 13:39:41 +0100
Message-ID: <CAF2baFd5vRuGKa7MVpqHvkCHia5fDN19cvq8qdedqJreNU6-vQ__19388.0263636403$1415796036$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0922614046=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <wallinux@gmail.com>) id 1XoXD9-0005uJ-BN
 for lttng-dev@lists.lttng.org; Wed, 12 Nov 2014 07:39:49 -0500
Received: by mail-qc0-f177.google.com with SMTP id l6so9222105qcy.36
 for <lttng-dev@lists.lttng.org>; Wed, 12 Nov 2014 04:39:41 -0800 (PST)
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

--===============0922614046==
Content-Type: multipart/alternative; boundary=001a11c118088db4870507a8b071

--001a11c118088db4870507a8b071
Content-Type: text/plain; charset=UTF-8

Hi,

using userspace snapshot mode in 2.5 seems to broken.

I have small stupid application(tracetest) generating 1000 events

Running the script (the below is simplified version of the script)
----------------------------------------------------------------------------------
#!/bin/bash
LTTNG='lttng -n'
lttng-sessiond --no-kernel &

$LTTNG create test --snapshot
$LTTNG enable-channel -u --subbuf-size 64k --num-subbuf 16 --overwrite ch1
$LTTNG enable-event -u -c ch1 "*"
$LTTNG start
$LTTNG list ch1

mkdir -p snapshot/

for i in $(seq 1 $LOOPS); do
    ./tracetest
    $LTTNG snapshot record -m 1G

    # print no of events and first and last event
    last=$(ls -1drt $HOME/lttng-traces/$SESSION*/* | tail -1)
    babeltrace $last > snapshot/$i.bt
    cat snapshot/$i.bt | wc -l
    cat snapshot/$i.bt | head -1
    cat snapshot/$i.bt | tail -1
done

$LTTNG stop
$LTTNG destroy $SESSION
----------------------------------------------------------------------------------

The result of the run looks like this;
./test.run

Error: consumer err socket second poll error
Error: Health error occurred in thread_manage_consumer
PERROR - 13:36:59.685167 [23772/23781]: bind inet: Address already in use
(in lttcomm_bind_inet_sock() at inet.c:109)
Warning: Another session daemon is using this JUL port. JUL support will be
deactivated to prevent interfering with the tracing.

lttng (LTTng Trace Control) 2.5.2 - Fumisterie
BabelTrace Trace Viewer and Converter 1.2.4
        linux-vdso.so.1 =>  (0x00007fffba966000)
        liblttng-ctl.so.0 => /usr/lib/x86_64-linux-gnu/liblttng-ctl.so.0
(0x00007fbfe4b1d000)
        librt.so.1 => /lib/x86_64-linux-gnu/librt.so.1 (0x00007fbfe4915000)
        libxml2.so.2 => /usr/lib/x86_64-linux-gnu/libxml2.so.2
(0x00007fbfe45ae000)
        libpopt.so.0 => /lib/x86_64-linux-gnu/libpopt.so.0
(0x00007fbfe43a2000)
        libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0
(0x00007fbfe4184000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fbfe3dbd000)
        /lib64/ld-linux-x86-64.so.2 (0x00007fbfe4fac000)
        liburcu.so.2 => /usr/lib/x86_64-linux-gnu/liburcu.so.2
(0x00007fbfe3bb6000)
        libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007fbfe39b2000)
        libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007fbfe3798000)
        liblzma.so.5 => /lib/x86_64-linux-gnu/liblzma.so.5
(0x00007fbfe3576000)
        libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007fbfe3270000)

Session test created.
Default snapshot output set to:
/home/awallin/lttng-traces/test-20141112-133700
Snapshot mode set. Every channel enabled for that session will be set in
overwrite mode and mmap output.
UST channel ch1 enabled for session test
UST event * created in channel ch1
Tracing started for session test
Tracing session test: [active snapshot]
    Trace path:
    Live timer interval (usec): 4294967295

=== Domain: UST global ===

Channels:
-------------
- ch1: [enabled]

    Attributes:
      overwrite mode: 1
      subbufers size: 4096
      number of subbufers: 16
      switch timer interval: 0
      read timer interval: 0
      trace file count: 0
      trace file size (bytes): 0
      output: mmap()

    Events:
      * (type: tracepoint) [enabled]

Snapshot recorded successfully for session test
84
[13:37:00.852615950] (+?.?????????) arn-awallin-mint-l3
ust_baddr_statedump:soinfo: { cpu_id = 4 }, { baddr = 0x7FFFC6BC7000,
sopath = "[vdso]", size = 0, mtime = -1 }
[13:37:00.853798949] (+0.000000805) arn-awallin-mint-l3 tracetest:first_tp:
{ cpu_id = 6 }, { my_string_field = "test", my_integer_field = 999 }
Snapshot recorded successfully for session test
157
[13:37:00.853735195] (+?.?????????) arn-awallin-mint-l3 tracetest:first_tp:
{ cpu_id = 6 }, { my_string_field = "test", my_integer_field = 927 }
[13:37:00.894839116] (+0.000000299) arn-awallin-mint-l3 tracetest:first_tp:
{ cpu_id = 5 }, { my_string_field = "test", my_integer_field = 999 }
Snapshot recorded successfully for session test
168
[13:37:00.853735195] (+?.?????????) arn-awallin-mint-l3 tracetest:first_tp:
{ cpu_id = 6 }, { my_string_field = "test", my_integer_field = 927 }
[13:37:00.929447330] (+0.000000305) arn-awallin-mint-l3 tracetest:first_tp:
{ cpu_id = 5 }, { my_string_field = "test", my_integer_field = 999 }
Snapshot recorded successfully for session test
168
[13:37:00.894411117] (+?.?????????) arn-awallin-mint-l3
ust_baddr_statedump:soinfo: { cpu_id = 4 }, { baddr = 0x7FFF6BF81000,
sopath = "[vdso]", size = 0, mtime = -1 }
[13:37:00.972035546] (+0.000000597) arn-awallin-mint-l3 tracetest:first_tp:
{ cpu_id = 6 }, { my_string_field = "test", my_integer_field = 999 }
Snapshot recorded successfully for session test
168
[13:37:00.894411117] (+?.?????????) arn-awallin-mint-l3
ust_baddr_statedump:soinfo: { cpu_id = 4 }, { baddr = 0x7FFF6BF81000,
sopath = "[vdso]", size = 0, mtime = -1 }
[13:37:01.014060940] (+0.000000341) arn-awallin-mint-l3 tracetest:first_tp:
{ cpu_id = 7 }, { my_string_field = "test", my_integer_field = 999 }
Snapshot recorded successfully for session test
168
[13:37:00.894411117] (+?.?????????) arn-awallin-mint-l3
ust_baddr_statedump:soinfo: { cpu_id = 4 }, { baddr = 0x7FFF6BF81000,
sopath = "[vdso]", size = 0, mtime = -1 }
[13:37:01.052555877] (+0.000000872) arn-awallin-mint-l3 tracetest:first_tp:
{ cpu_id = 6 }, { my_string_field = "test", my_integer_field = 999 }
Snapshot recorded successfully for session test
168
[13:37:01.014035993] (+?.?????????) arn-awallin-mint-l3 tracetest:first_tp:
{ cpu_id = 7 }, { my_string_field = "test", my_integer_field = 927 }
[13:37:01.098620808] (+0.000001404) arn-awallin-mint-l3 tracetest:first_tp:
{ cpu_id = 4 }, { my_string_field = "test", my_integer_field = 999 }
Snapshot recorded successfully for session test
168
[13:37:01.097087388] (+?.?????????) arn-awallin-mint-l3
ust_baddr_statedump:soinfo: { cpu_id = 6 }, { baddr = 0x7FFF4BFFE000,
sopath = "[vdso]", size = 0, mtime = -1 }
[13:37:01.129839830] (+0.000000533) arn-awallin-mint-l3 tracetest:first_tp:
{ cpu_id = 7 }, { my_string_field = "test", my_integer_field = 999 }
Snapshot recorded successfully for session test
168
[13:37:01.097087388] (+?.?????????) arn-awallin-mint-l3
ust_baddr_statedump:soinfo: { cpu_id = 6 }, { baddr = 0x7FFF4BFFE000,
sopath = "[vdso]", size = 0, mtime = -1 }
[13:37:01.129839830] (+0.000000533) arn-awallin-mint-l3 tracetest:first_tp:
{ cpu_id = 7 }, { my_string_field = "test", my_integer_field = 999 }
Snapshot recorded successfully for session test
168
[13:37:01.097087388] (+?.?????????) arn-awallin-mint-l3
ust_baddr_statedump:soinfo: { cpu_id = 6 }, { baddr = 0x7FFF4BFFE000,
sopath = "[vdso]", size = 0, mtime = -1 }
[13:37:01.172829105] (+0.000000575) arn-awallin-mint-l3 tracetest:first_tp:
{ cpu_id = 5 }, { my_string_field = "test", my_integer_field = 999 }
Snapshot recorded successfully for session test
168
[13:37:01.172021557] (+?.?????????) arn-awallin-mint-l3
ust_baddr_statedump:soinfo: { cpu_id = 7 }, { baddr = 0x7FFF653FE000,
sopath = "[vdso]", size = 0, mtime = -1 }
[13:37:01.220074165] (+0.000000553) arn-awallin-mint-l3 tracetest:first_tp:
{ cpu_id = 6 }, { my_string_field = "test", my_integer_field = 999 }
Waiting for data availability
Tracing stopped for session test
Session test destroyed

the result from the run on older versions of lttng creates bigger and
bigger event traces until reaching max size.

I have tested this on different architectures, with different buffer sizes
and number of buffer

Regards
Anders Wallin

--001a11c118088db4870507a8b071
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>using userspace snapshot mode in 2.=
5 seems to broken.</div><div><br></div><div>I have small stupid application=
(tracetest) generating 1000 events=C2=A0</div><div><br></div><div>Running t=
he script (the below is simplified version of the script)</div><div><div><d=
iv>------------------------------------------------------------------------=
----------</div></div><div>#!/bin/bash<br></div><div>LTTNG=3D&#39;lttng -n&=
#39;</div><div>lttng-sessiond --no-kernel &amp;<br></div><div><br></div><di=
v>$LTTNG create test --snapshot<br></div><div>$LTTNG enable-channel -u --su=
bbuf-size 64k --num-subbuf 16 --overwrite ch1</div><div>$LTTNG enable-event=
 -u -c ch1 &quot;*&quot;</div><div>$LTTNG start</div><div>$LTTNG list ch1</=
div><div><br></div><div>mkdir -p snapshot/</div><div><br></div><div>for i i=
n $(seq 1 $LOOPS); do</div><div>=C2=A0 =C2=A0 ./tracetest<br></div><div>=C2=
=A0 =C2=A0 $LTTNG snapshot record -m 1G<br></div><div><br></div><div>=C2=A0=
 =C2=A0 # print no of events and first and last event</div><div>=C2=A0 =C2=
=A0 last=3D$(ls -1drt $HOME/lttng-traces/$SESSION*/* | tail -1)</div><div>=
=C2=A0 =C2=A0 babeltrace $last &gt; snapshot/$<a href=3D"http://i.bt">i.bt<=
/a></div><div>=C2=A0 =C2=A0 cat snapshot/$<a href=3D"http://i.bt">i.bt</a> =
| wc -l</div><div>=C2=A0 =C2=A0 cat snapshot/$<a href=3D"http://i.bt">i.bt<=
/a> | head -1</div><div>=C2=A0 =C2=A0 cat snapshot/$<a href=3D"http://i.bt"=
>i.bt</a> | tail -1</div><div>done</div><div><br></div><div>$LTTNG stop</di=
v><div>$LTTNG destroy $SESSION</div></div><div>----------------------------=
------------------------------------------------------</div><div><br></div>=
<div>The result of the run looks like this;</div><div><div>./test.run =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0</div><div>Error: consumer err socket second poll error=
</div><div>Error: Health error occurred in thread_manage_consumer</div><div=
>PERROR - 13:36:59.685167 [23772/23781]: bind inet: Address already in use =
(in lttcomm_bind_inet_sock() at inet.c:109)</div><div>Warning: Another sess=
ion daemon is using this JUL port. JUL support will be deactivated to preve=
nt interfering with the tracing.</div><div><br></div><div>lttng (LTTng Trac=
e Control) 2.5.2 - Fumisterie</div><div>BabelTrace Trace Viewer and Convert=
er 1.2.4</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 linux-vdso.so.1 =3D&gt; =C2=
=A0(0x00007fffba966000)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 liblttng-ctl.=
so.0 =3D&gt; /usr/lib/x86_64-linux-gnu/liblttng-ctl.so.0 (0x00007fbfe4b1d00=
0)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 librt.so.1 =3D&gt; /lib/x86_64-lin=
ux-gnu/librt.so.1 (0x00007fbfe4915000)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 libxml2.so.2 =3D&gt; /usr/lib/x86_64-linux-gnu/libxml2.so.2 (0x00007fbf=
e45ae000)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 libpopt.so.0 =3D&gt; /lib/x=
86_64-linux-gnu/libpopt.so.0 (0x00007fbfe43a2000)</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 libpthread.so.0 =3D&gt; /lib/x86_64-linux-gnu/libpthread.so.0=
 (0x00007fbfe4184000)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 libc.so.6 =3D&g=
t; /lib/x86_64-linux-gnu/libc.so.6 (0x00007fbfe3dbd000)</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /lib64/ld-linux-x86-64.so.2 (0x00007fbfe4fac000)</div>=
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 liburcu.so.2 =3D&gt; /usr/lib/x86_64-linux=
-gnu/liburcu.so.2 (0x00007fbfe3bb6000)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 libdl.so.2 =3D&gt; /lib/x86_64-linux-gnu/libdl.so.2 (0x00007fbfe39b2000=
)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 libz.so.1 =3D&gt; /lib/x86_64-linux=
-gnu/libz.so.1 (0x00007fbfe3798000)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 l=
iblzma.so.5 =3D&gt; /lib/x86_64-linux-gnu/liblzma.so.5 (0x00007fbfe3576000)=
</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 libm.so.6 =3D&gt; /lib/x86_64-linux-=
gnu/libm.so.6 (0x00007fbfe3270000)</div><div><br></div><div>Session test cr=
eated.</div><div>Default snapshot output set to: /home/awallin/lttng-traces=
/test-20141112-133700</div><div>Snapshot mode set. Every channel enabled fo=
r that session will be set in overwrite mode and mmap output.</div><div>UST=
 channel ch1 enabled for session test</div><div>UST event * created in chan=
nel ch1</div><div>Tracing started for session test</div><div>Tracing sessio=
n test: [active snapshot]</div><div>=C2=A0 =C2=A0 Trace path:=C2=A0</div><d=
iv>=C2=A0 =C2=A0 Live timer interval (usec): 4294967295</div><div><br></div=
><div>=3D=3D=3D Domain: UST global =3D=3D=3D</div></div><div><br></div><div=
><div>Channels:</div><div>-------------</div><div>- ch1: [enabled]</div><di=
v><br></div><div>=C2=A0 =C2=A0 Attributes:</div><div>=C2=A0 =C2=A0 =C2=A0 o=
verwrite mode: 1</div><div>=C2=A0 =C2=A0 =C2=A0 subbufers size: 4096</div><=
div>=C2=A0 =C2=A0 =C2=A0 number of subbufers: 16</div><div>=C2=A0 =C2=A0 =
=C2=A0 switch timer interval: 0</div><div>=C2=A0 =C2=A0 =C2=A0 read timer i=
nterval: 0</div><div>=C2=A0 =C2=A0 =C2=A0 trace file count: 0</div><div>=C2=
=A0 =C2=A0 =C2=A0 trace file size (bytes): 0</div><div>=C2=A0 =C2=A0 =C2=A0=
 output: mmap()</div><div><br></div><div>=C2=A0 =C2=A0 Events:</div><div>=
=C2=A0 =C2=A0 =C2=A0 * (type: tracepoint) [enabled]</div><div><br></div><di=
v>Snapshot recorded successfully for session test</div><div>84</div><div>[1=
3:37:00.852615950] (+?.?????????) arn-awallin-mint-l3 ust_baddr_statedump:s=
oinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFFC6BC7000, sopath =3D &quot;[vdso=
]&quot;, size =3D 0, mtime =3D -1 }</div><div>[13:37:00.853798949] (+0.0000=
00805) arn-awallin-mint-l3 tracetest:first_tp: { cpu_id =3D 6 }, { my_strin=
g_field =3D &quot;test&quot;, my_integer_field =3D 999 }</div><div>Snapshot=
 recorded successfully for session test</div><div>157</div><div>[13:37:00.8=
53735195] (+?.?????????) arn-awallin-mint-l3 tracetest:first_tp: { cpu_id =
=3D 6 }, { my_string_field =3D &quot;test&quot;, my_integer_field =3D 927 }=
</div><div>[13:37:00.894839116] (+0.000000299) arn-awallin-mint-l3 tracetes=
t:first_tp: { cpu_id =3D 5 }, { my_string_field =3D &quot;test&quot;, my_in=
teger_field =3D 999 }</div><div>Snapshot recorded successfully for session =
test</div><div>168</div><div>[13:37:00.853735195] (+?.?????????) arn-awalli=
n-mint-l3 tracetest:first_tp: { cpu_id =3D 6 }, { my_string_field =3D &quot=
;test&quot;, my_integer_field =3D 927 }</div><div>[13:37:00.929447330] (+0.=
000000305) arn-awallin-mint-l3 tracetest:first_tp: { cpu_id =3D 5 }, { my_s=
tring_field =3D &quot;test&quot;, my_integer_field =3D 999 }</div><div>Snap=
shot recorded successfully for session test</div><div>168</div><div>[13:37:=
00.894411117] (+?.?????????) arn-awallin-mint-l3 ust_baddr_statedump:soinfo=
: { cpu_id =3D 4 }, { baddr =3D 0x7FFF6BF81000, sopath =3D &quot;[vdso]&quo=
t;, size =3D 0, mtime =3D -1 }</div><div>[13:37:00.972035546] (+0.000000597=
) arn-awallin-mint-l3 tracetest:first_tp: { cpu_id =3D 6 }, { my_string_fie=
ld =3D &quot;test&quot;, my_integer_field =3D 999 }</div><div>Snapshot reco=
rded successfully for session test</div><div>168</div><div>[13:37:00.894411=
117] (+?.?????????) arn-awallin-mint-l3 ust_baddr_statedump:soinfo: { cpu_i=
d =3D 4 }, { baddr =3D 0x7FFF6BF81000, sopath =3D &quot;[vdso]&quot;, size =
=3D 0, mtime =3D -1 }</div><div>[13:37:01.014060940] (+0.000000341) arn-awa=
llin-mint-l3 tracetest:first_tp: { cpu_id =3D 7 }, { my_string_field =3D &q=
uot;test&quot;, my_integer_field =3D 999 }</div><div>Snapshot recorded succ=
essfully for session test</div><div>168</div><div>[13:37:00.894411117] (+?.=
?????????) arn-awallin-mint-l3 ust_baddr_statedump:soinfo: { cpu_id =3D 4 }=
, { baddr =3D 0x7FFF6BF81000, sopath =3D &quot;[vdso]&quot;, size =3D 0, mt=
ime =3D -1 }</div><div>[13:37:01.052555877] (+0.000000872) arn-awallin-mint=
-l3 tracetest:first_tp: { cpu_id =3D 6 }, { my_string_field =3D &quot;test&=
quot;, my_integer_field =3D 999 }</div><div>Snapshot recorded successfully =
for session test</div><div>168</div><div>[13:37:01.014035993] (+?.?????????=
) arn-awallin-mint-l3 tracetest:first_tp: { cpu_id =3D 7 }, { my_string_fie=
ld =3D &quot;test&quot;, my_integer_field =3D 927 }</div><div>[13:37:01.098=
620808] (+0.000001404) arn-awallin-mint-l3 tracetest:first_tp: { cpu_id =3D=
 4 }, { my_string_field =3D &quot;test&quot;, my_integer_field =3D 999 }</d=
iv><div>Snapshot recorded successfully for session test</div><div>168</div>=
<div>[13:37:01.097087388] (+?.?????????) arn-awallin-mint-l3 ust_baddr_stat=
edump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF4BFFE000, sopath =3D &quo=
t;[vdso]&quot;, size =3D 0, mtime =3D -1 }</div><div>[13:37:01.129839830] (=
+0.000000533) arn-awallin-mint-l3 tracetest:first_tp: { cpu_id =3D 7 }, { m=
y_string_field =3D &quot;test&quot;, my_integer_field =3D 999 }</div><div>S=
napshot recorded successfully for session test</div><div><div>168</div><div=
>[13:37:01.097087388] (+?.?????????) arn-awallin-mint-l3 ust_baddr_statedum=
p:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF4BFFE000, sopath =3D &quot;[v=
dso]&quot;, size =3D 0, mtime =3D -1 }</div><div>[13:37:01.129839830] (+0.0=
00000533) arn-awallin-mint-l3 tracetest:first_tp: { cpu_id =3D 7 }, { my_st=
ring_field =3D &quot;test&quot;, my_integer_field =3D 999 }</div><div>Snaps=
hot recorded successfully for session test</div><div>168</div><div>[13:37:0=
1.097087388] (+?.?????????) arn-awallin-mint-l3 ust_baddr_statedump:soinfo:=
 { cpu_id =3D 6 }, { baddr =3D 0x7FFF4BFFE000, sopath =3D &quot;[vdso]&quot=
;, size =3D 0, mtime =3D -1 }</div><div>[13:37:01.172829105] (+0.000000575)=
 arn-awallin-mint-l3 tracetest:first_tp: { cpu_id =3D 5 }, { my_string_fiel=
d =3D &quot;test&quot;, my_integer_field =3D 999 }</div><div>Snapshot recor=
ded successfully for session test</div><div>168</div><div>[13:37:01.1720215=
57] (+?.?????????) arn-awallin-mint-l3 ust_baddr_statedump:soinfo: { cpu_id=
 =3D 7 }, { baddr =3D 0x7FFF653FE000, sopath =3D &quot;[vdso]&quot;, size =
=3D 0, mtime =3D -1 }</div><div>[13:37:01.220074165] (+0.000000553) arn-awa=
llin-mint-l3 tracetest:first_tp: { cpu_id =3D 6 }, { my_string_field =3D &q=
uot;test&quot;, my_integer_field =3D 999 }</div><div>Waiting for data avail=
ability</div><div>Tracing stopped for session test</div><div>Session test d=
estroyed</div></div></div><div><br></div><div>the result from the run on ol=
der versions of lttng creates bigger and bigger event traces until reaching=
 max size.<br></div><div><br></div><div>I have tested this on different arc=
hitectures, with different buffer sizes and number of buffer<br></div><div>=
<br></div><div>Regards<br clear=3D"all"><div><div class=3D"gmail_signature"=
>Anders Wallin</div></div>
</div></div>

--001a11c118088db4870507a8b071--


--===============0922614046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0922614046==--
