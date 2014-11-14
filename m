From: Anders Wallin <wallinux@gmail.com>
Subject: snapshot data corrupted after the output buffer is
	filled
Date: Fri, 14 Nov 2014 08:28:18 +0100
Message-ID: <CAF2baFfMNzRQnx-FC7kFRr5m4NpZBEcEohnwf50uOs2vv9=GBw__6.99150045893049$1415950147$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0230692917=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <wallinux@gmail.com>) id 1XpBIu-0002Ux-2b
 for lttng-dev@lists.lttng.org; Fri, 14 Nov 2014 02:28:26 -0500
Received: by mail-wi0-f181.google.com with SMTP id n3so1768137wiv.8
 for <lttng-dev@lists.lttng.org>; Thu, 13 Nov 2014 23:28:18 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0230692917==
Content-Type: multipart/alternative; boundary=f46d04426bbc9dc9610507cc924b

--f46d04426bbc9dc9610507cc924b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

it looks like snapshot events became faulty after the output max size is
reached.
The next snapshot get mixed events from different buffers. I have tested it
on 2.3, 2.4 and 2.5
and it's in all of them, but it hits earlier in 2.5 due to the  problem
reported in
http://lists.lttng.org/pipermail/lttng-dev/2014-November/023773.html

There should never be more then 2 HUNKS in a diff between 2 consecutive
snapshots, here I got
11 as the worst case.

TESTCASE;

tracetest code:
---------------------------------------------------------------
#include <stdio.h>
#include "tracetest-tp.h"

int main(int argc, char* argv[])
{
        int i;
        for (i =3D 0; i < 1000; i++) {
                tracepoint(tracetest, first_tp, i, "test");
        }
        return 0;
}
---------------------------------------------------------------

test script:
---------------------------------------------------------------
#!/bin/bash
: ${NO_OF_SUBBUF:=3D6}
: ${SUBBUF_SIZE:=3D4096}
: ${KERNEL_TRACE:=3DNO}
: ${LOOPS:=3D10}

SESSION=3Dtest
CHANNEL1=3Dch1
CHANNEL2=3Dch2

CH2_SUBBUF_SIZE=3D$(($SUBBUF_SIZE*$NO_OF_SUBBUF))


LTTNG=3D'lttng -n'
killall lttng-consumerd > /dev/null 2>&1
killall lttng-sessiond > /dev/null 2>&1
if [ -z $DEBUG ]; then
    lttng-sessiond --no-kernel -d
else
    lttng-sessiond -v --no-kernel --verbose-consumer -b
fi
sleep 1

if [ ! -z $DEBUG ]; then
    export LTTNG_UST_DEBUG=3D1
fi

rm -rf $HOME/lttng-traces
rm snapshot/*.bt

$LTTNG --version

$LTTNG create $SESSION --snapshot
$LTTNG enable-channel -u --subbuf-size $SUBBUF_SIZE --num-subbuf
$NO_OF_SUBBUF --overwrite $CHANNEL1
$LTTNG enable-channel -u --subbuf-size $CH2_SUBBUF_SIZE --num-subbuf 2
--overwrite $CHANNEL2
$LTTNG enable-event -u -c $CHANNEL1 "*"
$LTTNG start
$LTTNG list $SESSION

mkdir -p snapshot/

h=3D1
for i in $(seq 1 $LOOPS); do
    $APP
    $LTTNG snapshot record
    # print no of events and first and last event


    last=3D$(ls -1drt $HOME/lttng-traces/$SESSION*/* | tail -1)
    babeltrace $last > snapshot/$i.bt
    cat snapshot/$i.bt | wc -l
    cat snapshot/$i.bt | head -1
    cat snapshot/$i.bt | tail -1
    diff -u snapshot/$i.bt snapshot/$h.bt > snapshot/$i_$h.diff
    cat snapshot/$i_$h.diff | grep "@@" | wc -l | xargs echo "NUMBER OF
DIFF HUNKS =3D "
    h=3D$i
done

$LTTNG stop
$LTTNG destroy $SESSION

---------------------------------------------------------------

result from run (removed some output lines for readability)
---------------------------------------------------------------
lttng (LTTng Trace Control) 2.4.2 - =C3=89poque Opaque
Snapshot mode set. Every channel enabled for that session will be set in
overwrite mode and mmap output.
Warning: The number of subbuffers (6) is rounded to the next power of 2 (8)
UST channel ch1 enabled for session test
Warning: The subbuf size (24576) is rounded to the next power of 2 (32768)
UST channel ch2 enabled for session test
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
      number of subbufers: 8
      switch timer interval: 0
      read timer interval: 0
      output: mmap()

    Events:
      * (type: tracepoint) [enabled]
- ch2: [enabled]

    Attributes:
      overwrite mode: 1
      subbufers size: 32768
      number of subbufers: 2
      switch timer interval: 0
      read timer interval: 0
      output: mmap()

    Events:
      None

Snapshot recorded successfully for session test
1011
[07:09:43.278933559] (+?.?????????) 07f8cf84a38f
ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000,
sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
[07:09:43.279975100] (+0.000000975) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 999 }
NUMBER OF DIFF HUNKS =3D  0
Snapshot recorded successfully for session test
2022
[07:09:43.278933559] (+?.?????????) 07f8cf84a38f
ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000,
sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
[07:09:43.337703508] (+0.000001238) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 999 }
NUMBER OF DIFF HUNKS =3D  1
Snapshot recorded successfully for session test
3033
[07:09:43.278933559] (+?.?????????) 07f8cf84a38f
ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000,
sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
[07:09:43.432827051] (+0.000000308) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
NUMBER OF DIFF HUNKS =3D  1
Snapshot recorded successfully for session test
4044
[07:09:43.278933559] (+?.?????????) 07f8cf84a38f
ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000,
sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
[07:09:43.475784825] (+0.000000501) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 999 }
NUMBER OF DIFF HUNKS =3D  1
Snapshot recorded successfully for session test
4735
[07:09:43.279031320] (+?.?????????) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 0 }
[07:09:43.549945106] (+0.000000517) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
NUMBER OF DIFF HUNKS =3D  12
Snapshot recorded successfully for session test
4437
[07:09:43.335916076] (+?.?????????) 07f8cf84a38f
ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000,
sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
[07:09:43.654229030] (+0.000000436) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 999 }
NUMBER OF DIFF HUNKS =3D  3
Snapshot recorded successfully for session test
4746
[07:09:43.335916076] (+?.?????????) 07f8cf84a38f
ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000,
sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
[07:09:43.747509349] (+0.000000502) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
NUMBER OF DIFF HUNKS =3D  11
Snapshot recorded successfully for session test
5757
[07:09:43.335916076] (+?.?????????) 07f8cf84a38f
ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000,
sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
[07:09:43.814938128] (+0.000001371) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 999 }
NUMBER OF DIFF HUNKS =3D  1
Snapshot recorded successfully for session test
6066
[07:09:43.335916076] (+?.?????????) 07f8cf84a38f
ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000,
sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
[07:09:43.919112586] (+0.000000990) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
NUMBER OF DIFF HUNKS =3D  11
Snapshot recorded successfully for session test
6077
[07:09:43.335916076] (+?.?????????) 07f8cf84a38f
ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =3D 0x7FFFAD1FE000,
sopath =3D "[vdso]", size =3D 0, mtime =3D -1 }
[07:09:44.004234933] (+0.000001213) 07f8cf84a38f tracetest:first_tp: {
cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 999 }
NUMBER OF DIFF HUNKS =3D  2
Waiting for data availability
Tracing stopped for session test
Session test destroyed
---------------------------------------------------------------

Regards

Anders Wallin

--f46d04426bbc9dc9610507cc924b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>it looks like snapshot e=
vents became faulty after the output max size is reached.</div><div>The nex=
t snapshot get mixed events from different buffers. I have tested it on 2.3=
, 2.4 and 2.5</div><div>and it&#39;s in all of them, but it hits earlier in=
 2.5 due to the =C2=A0problem reported in</div><div><a href=3D"http://lists=
.lttng.org/pipermail/lttng-dev/2014-November/023773.html">http://lists.lttn=
g.org/pipermail/lttng-dev/2014-November/023773.html</a></div><div><br></div=
><div>There should never be more then 2 HUNKS in a diff between 2 consecuti=
ve snapshots, here I got=C2=A0</div><div>11 as the worst case.</div><div><b=
r></div><div>TESTCASE;</div><div><br></div><div>tracetest code:</div><div>-=
--------------------------------------------------------------</div><div>#i=
nclude &lt;stdio.h&gt;</div><div>#include &quot;tracetest-tp.h&quot;</div><=
div><br></div><div>int main(int argc, char* argv[])</div><div>{</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 fo=
r (i =3D 0; i &lt; 1000; i++) {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 tracepoint(tracetest, first_tp, i, &quot;test&quot=
;);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return 0;</div><div>}</div><div>------------------------------------=
---------------------------</div><div><br></div><div>test script:</div><div=
>---------------------------------------------------------------</div><div>=
#!/bin/bash=C2=A0</div><div>: ${NO_OF_SUBBUF:=3D6}</div><div>: ${SUBBUF_SIZ=
E:=3D4096}</div><div>: ${KERNEL_TRACE:=3DNO}</div><div>: ${LOOPS:=3D10}</di=
v><div><br></div><div>SESSION=3Dtest</div><div>CHANNEL1=3Dch1</div><div>CHA=
NNEL2=3Dch2</div><div><br></div><div>CH2_SUBBUF_SIZE=3D$(($SUBBUF_SIZE*$NO_=
OF_SUBBUF))</div><div><br></div><div><br></div><div>LTTNG=3D&#39;lttng -n&#=
39;</div><div>killall lttng-consumerd &gt; /dev/null 2&gt;&amp;1</div><div>=
killall lttng-sessiond &gt; /dev/null 2&gt;&amp;1</div><div>if [ -z $DEBUG =
]; then</div><div>=C2=A0 =C2=A0 lttng-sessiond --no-kernel -d</div><div>els=
e</div><div>=C2=A0 =C2=A0 lttng-sessiond -v --no-kernel --verbose-consumer =
-b</div><div>fi</div><div>sleep 1</div><div><br></div><div>if [ ! -z $DEBUG=
 ]; then</div><div>=C2=A0 =C2=A0 export LTTNG_UST_DEBUG=3D1</div><div>fi</d=
iv><div><br></div><div>rm -rf $HOME/lttng-traces</div><div>rm snapshot/*.bt=
</div><div><br></div><div>$LTTNG --version</div><div><br></div><div>$LTTNG =
create $SESSION --snapshot</div><div>$LTTNG enable-channel -u --subbuf-size=
 $SUBBUF_SIZE --num-subbuf $NO_OF_SUBBUF --overwrite $CHANNEL1</div><div>$L=
TTNG enable-channel -u --subbuf-size $CH2_SUBBUF_SIZE --num-subbuf 2 --over=
write $CHANNEL2</div><div>$LTTNG enable-event -u -c $CHANNEL1 &quot;*&quot;=
</div><div>$LTTNG start</div><div>$LTTNG list $SESSION</div><div><br></div>=
<div>mkdir -p snapshot/</div><div><br></div><div>h=3D1</div><div>for i in $=
(seq 1 $LOOPS); do</div><div>=C2=A0 =C2=A0 $APP</div><div>=C2=A0 =C2=A0 $LT=
TNG snapshot record</div><div>=C2=A0 =C2=A0 # print no of events and first =
and last event =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0</div><div>=C2=A0 =C2=A0 last=3D$(ls -1drt $HOME=
/lttng-traces/$SESSION*/* | tail -1)</div><div>=C2=A0 =C2=A0 babeltrace $la=
st &gt; snapshot/$<a href=3D"http://i.bt">i.bt</a></div><div>=C2=A0 =C2=A0 =
cat snapshot/$<a href=3D"http://i.bt">i.bt</a> | wc -l</div><div>=C2=A0 =C2=
=A0 cat snapshot/$<a href=3D"http://i.bt">i.bt</a> | head -1</div><div>=C2=
=A0 =C2=A0 cat snapshot/$<a href=3D"http://i.bt">i.bt</a> | tail -1</div><d=
iv>=C2=A0 =C2=A0 diff -u snapshot/$<a href=3D"http://i.bt">i.bt</a> snapsho=
t/$<a href=3D"http://h.bt">h.bt</a> &gt; snapshot/$i_$h.diff</div><div>=C2=
=A0 =C2=A0 cat snapshot/$i_$h.diff | grep &quot;@@&quot; | wc -l | xargs ec=
ho &quot;NUMBER OF DIFF HUNKS =3D &quot;</div><div>=C2=A0 =C2=A0 h=3D$i</di=
v><div>done</div><div><br></div><div><div class=3D"gmail_signature"><div cl=
ass=3D"gmail_signature">$LTTNG stop</div><div class=3D"gmail_signature">$LT=
TNG destroy $SESSION</div><div class=3D"gmail_signature"><br></div><div cla=
ss=3D"gmail_signature">----------------------------------------------------=
-----------</div><div class=3D"gmail_signature"><br></div><div class=3D"gma=
il_signature">result from run (removed some output lines for readability)</=
div><div class=3D"gmail_signature">----------------------------------------=
-----------------------</div><div class=3D"gmail_signature">lttng (LTTng Tr=
ace Control) 2.4.2 - =C3=89poque Opaque</div><div class=3D"gmail_signature"=
>Snapshot mode set. Every channel enabled for that session will be set in o=
verwrite mode and mmap output.</div><div class=3D"gmail_signature">Warning:=
 The number of subbuffers (6) is rounded to the next power of 2 (8)</div><d=
iv class=3D"gmail_signature">UST channel ch1 enabled for session test</div>=
<div class=3D"gmail_signature">Warning: The subbuf size (24576) is rounded =
to the next power of 2 (32768)</div><div class=3D"gmail_signature">UST chan=
nel ch2 enabled for session test</div><div class=3D"gmail_signature">UST ev=
ent * created in channel ch1</div><div class=3D"gmail_signature">Tracing st=
arted for session test</div><div class=3D"gmail_signature">Tracing session =
test: [active snapshot]</div><div class=3D"gmail_signature">=C2=A0 =C2=A0 T=
race path:=C2=A0</div><div class=3D"gmail_signature"><br></div><div class=
=3D"gmail_signature">=3D=3D=3D Domain: UST global =3D=3D=3D</div><div class=
=3D"gmail_signature"><br></div><div class=3D"gmail_signature">Buffer type: =
per UID</div><div class=3D"gmail_signature"><br></div><div class=3D"gmail_s=
ignature">Channels:</div><div class=3D"gmail_signature">-------------</div>=
<div class=3D"gmail_signature">- ch1: [enabled]</div><div class=3D"gmail_si=
gnature"><br></div><div class=3D"gmail_signature">=C2=A0 =C2=A0 Attributes:=
</div><div class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 overwrite mode: 1=
</div><div class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 subbufers size: 4=
096</div><div class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 number of subb=
ufers: 8</div><div class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 switch ti=
mer interval: 0</div><div class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 re=
ad timer interval: 0</div><div class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=
=A0 output: mmap()</div><div class=3D"gmail_signature"><br></div><div class=
=3D"gmail_signature">=C2=A0 =C2=A0 Events:</div><div class=3D"gmail_signatu=
re">=C2=A0 =C2=A0 =C2=A0 * (type: tracepoint) [enabled]</div><div class=3D"=
gmail_signature">- ch2: [enabled]</div><div class=3D"gmail_signature"><br><=
/div><div class=3D"gmail_signature">=C2=A0 =C2=A0 Attributes:</div><div cla=
ss=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 overwrite mode: 1</div><div cla=
ss=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 subbufers size: 32768</div><div=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 number of subbufers: 2</div=
><div class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 switch timer interval:=
 0</div><div class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 read timer inte=
rval: 0</div><div class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 output: mm=
ap()</div><div class=3D"gmail_signature"><br></div><div class=3D"gmail_sign=
ature">=C2=A0 =C2=A0 Events:</div><div class=3D"gmail_signature">=C2=A0 =C2=
=A0 =C2=A0 None</div><div class=3D"gmail_signature"><br></div><div class=3D=
"gmail_signature">Snapshot recorded successfully for session test</div><div=
 class=3D"gmail_signature">1011</div><div class=3D"gmail_signature">[07:09:=
43.278933559] (+?.?????????) 07f8cf84a38f ust_baddr_statedump:soinfo: { cpu=
_id =3D 6 }, { baddr =3D 0x7FFF645EE000, sopath =3D &quot;[vdso]&quot;, siz=
e =3D 0, mtime =3D -1 }</div><div class=3D"gmail_signature">[07:09:43.27997=
5100] (+0.000000975) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 5 }, { m=
y_string_field =3D &quot;test&quot;, my_integer_field =3D 999 }</div><div c=
lass=3D"gmail_signature">NUMBER OF DIFF HUNKS =3D =C2=A00</div><div class=
=3D"gmail_signature">Snapshot recorded successfully for session test</div><=
div class=3D"gmail_signature">2022</div><div class=3D"gmail_signature">[07:=
09:43.278933559] (+?.?????????) 07f8cf84a38f ust_baddr_statedump:soinfo: { =
cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000, sopath =3D &quot;[vdso]&quot;, =
size =3D 0, mtime =3D -1 }</div><div class=3D"gmail_signature">[07:09:43.33=
7703508] (+0.000001238) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 4 }, =
{ my_string_field =3D &quot;test&quot;, my_integer_field =3D 999 }</div><di=
v class=3D"gmail_signature">NUMBER OF DIFF HUNKS =3D =C2=A01</div><div clas=
s=3D"gmail_signature">Snapshot recorded successfully for session test</div>=
<div class=3D"gmail_signature">3033</div><div class=3D"gmail_signature">[07=
:09:43.278933559] (+?.?????????) 07f8cf84a38f ust_baddr_statedump:soinfo: {=
 cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000, sopath =3D &quot;[vdso]&quot;,=
 size =3D 0, mtime =3D -1 }</div><div class=3D"gmail_signature">[07:09:43.4=
32827051] (+0.000000308) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 6 },=
 { my_string_field =3D &quot;test&quot;, my_integer_field =3D 999 }</div><d=
iv class=3D"gmail_signature">NUMBER OF DIFF HUNKS =3D =C2=A01</div><div cla=
ss=3D"gmail_signature">Snapshot recorded successfully for session test</div=
><div class=3D"gmail_signature">4044</div><div class=3D"gmail_signature">[0=
7:09:43.278933559] (+?.?????????) 07f8cf84a38f ust_baddr_statedump:soinfo: =
{ cpu_id =3D 6 }, { baddr =3D 0x7FFF645EE000, sopath =3D &quot;[vdso]&quot;=
, size =3D 0, mtime =3D -1 }</div><div class=3D"gmail_signature">[07:09:43.=
475784825] (+0.000000501) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 5 }=
, { my_string_field =3D &quot;test&quot;, my_integer_field =3D 999 }</div><=
div class=3D"gmail_signature">NUMBER OF DIFF HUNKS =3D =C2=A01</div><div cl=
ass=3D"gmail_signature">Snapshot recorded successfully for session test</di=
v><div class=3D"gmail_signature">4735</div><div class=3D"gmail_signature">[=
07:09:43.279031320] (+?.?????????) 07f8cf84a38f tracetest:first_tp: { cpu_i=
d =3D 5 }, { my_string_field =3D &quot;test&quot;, my_integer_field =3D 0 }=
</div><div class=3D"gmail_signature">[07:09:43.549945106] (+0.000000517) 07=
f8cf84a38f tracetest:first_tp: { cpu_id =3D 6 }, { my_string_field =3D &quo=
t;test&quot;, my_integer_field =3D 999 }</div><div class=3D"gmail_signature=
">NUMBER OF DIFF HUNKS =3D =C2=A012</div><div class=3D"gmail_signature">Sna=
pshot recorded successfully for session test</div><div class=3D"gmail_signa=
ture">4437</div><div class=3D"gmail_signature">[07:09:43.335916076] (+?.???=
??????) 07f8cf84a38f ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr =
=3D 0x7FFFAD1FE000, sopath =3D &quot;[vdso]&quot;, size =3D 0, mtime =3D -1=
 }</div><div class=3D"gmail_signature">[07:09:43.654229030] (+0.000000436) =
07f8cf84a38f tracetest:first_tp: { cpu_id =3D 5 }, { my_string_field =3D &q=
uot;test&quot;, my_integer_field =3D 999 }</div><div class=3D"gmail_signatu=
re">NUMBER OF DIFF HUNKS =3D =C2=A03</div><div class=3D"gmail_signature">Sn=
apshot recorded successfully for session test</div><div class=3D"gmail_sign=
ature">4746</div><div class=3D"gmail_signature">[07:09:43.335916076] (+?.??=
???????) 07f8cf84a38f ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { baddr=
 =3D 0x7FFFAD1FE000, sopath =3D &quot;[vdso]&quot;, size =3D 0, mtime =3D -=
1 }</div><div class=3D"gmail_signature">[07:09:43.747509349] (+0.000000502)=
 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 6 }, { my_string_field =3D &=
quot;test&quot;, my_integer_field =3D 999 }</div><div class=3D"gmail_signat=
ure">NUMBER OF DIFF HUNKS =3D =C2=A011</div><div class=3D"gmail_signature">=
Snapshot recorded successfully for session test</div><div class=3D"gmail_si=
gnature">5757</div><div class=3D"gmail_signature">[07:09:43.335916076] (+?.=
?????????) 07f8cf84a38f ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { bad=
dr =3D 0x7FFFAD1FE000, sopath =3D &quot;[vdso]&quot;, size =3D 0, mtime =3D=
 -1 }</div><div class=3D"gmail_signature">[07:09:43.814938128] (+0.00000137=
1) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 4 }, { my_string_field =3D=
 &quot;test&quot;, my_integer_field =3D 999 }</div><div class=3D"gmail_sign=
ature">NUMBER OF DIFF HUNKS =3D =C2=A01</div><div class=3D"gmail_signature"=
>Snapshot recorded successfully for session test</div><div class=3D"gmail_s=
ignature">6066</div><div class=3D"gmail_signature">[07:09:43.335916076] (+?=
.?????????) 07f8cf84a38f ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, { ba=
ddr =3D 0x7FFFAD1FE000, sopath =3D &quot;[vdso]&quot;, size =3D 0, mtime =
=3D -1 }</div><div class=3D"gmail_signature">[07:09:43.919112586] (+0.00000=
0990) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 6 }, { my_string_field =
=3D &quot;test&quot;, my_integer_field =3D 999 }</div><div class=3D"gmail_s=
ignature">NUMBER OF DIFF HUNKS =3D =C2=A011</div><div class=3D"gmail_signat=
ure">Snapshot recorded successfully for session test</div><div class=3D"gma=
il_signature">6077</div><div class=3D"gmail_signature">[07:09:43.335916076]=
 (+?.?????????) 07f8cf84a38f ust_baddr_statedump:soinfo: { cpu_id =3D 2 }, =
{ baddr =3D 0x7FFFAD1FE000, sopath =3D &quot;[vdso]&quot;, size =3D 0, mtim=
e =3D -1 }</div><div class=3D"gmail_signature">[07:09:44.004234933] (+0.000=
001213) 07f8cf84a38f tracetest:first_tp: { cpu_id =3D 6 }, { my_string_fiel=
d =3D &quot;test&quot;, my_integer_field =3D 999 }</div><div class=3D"gmail=
_signature">NUMBER OF DIFF HUNKS =3D =C2=A02</div><div class=3D"gmail_signa=
ture">Waiting for data availability</div><div class=3D"gmail_signature">Tra=
cing stopped for session test</div><div class=3D"gmail_signature">Session t=
est destroyed</div><div class=3D"gmail_signature">-------------------------=
--------------------------------------</div><div class=3D"gmail_signature">=
<br></div><div class=3D"gmail_signature">Regards</div><div class=3D"gmail_s=
ignature"><br></div><div class=3D"gmail_signature">Anders Wallin</div></div=
></div>
</div>

--f46d04426bbc9dc9610507cc924b--


--===============0230692917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0230692917==--
