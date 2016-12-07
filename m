From: Anders Wallin <wallinux@gmail.com>
Subject: Snapshot gives no events after calling it more then the
 number sub-buffers in the channel
Date: Wed, 7 Dec 2016 15:27:34 +0100
Message-ID: <CAF2baFcNqGtivF-GnVMKegWBtx65E_UZR86PGD0dQWdMXVx18g__17606.3573723242$1481120868$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5758732908244378227=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi0-x22f.google.com (mail-oi0-x22f.google.com
 [IPv6:2607:f8b0:4003:c06::22f])
 by lists.lttng.org (Postfix) with ESMTPS id 3tYgqZ3WGtzdqP
 for <lttng-dev@lists.lttng.org>; Wed,  7 Dec 2016 14:29:30 +0000 (UTC)
Received: by mail-oi0-x22f.google.com with SMTP id y198so417879859oia.1
 for <lttng-dev@lists.lttng.org>; Wed, 07 Dec 2016 06:27:36 -0800 (PST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============5758732908244378227==
Content-Type: multipart/alternative; boundary=001a1141cae87259a9054312528c

--001a1141cae87259a9054312528c
Content-Type: text/plain; charset=UTF-8

Hi,

Taking a number of snapshots always showed the events in the buffer, before
the
commit de3fb857f034c208c135a10a3cdec2dfe43fbda6

    Fix: ust-consumer: flush empty packets on snapshot channel

    Snapshot operation on a non-stopped stream should use a "final" flush to
    ensure empty packets are flushed, so we gather timestamps at the moment
    where the snapshot is taken. This is important for streams that have a
    low amount of activity, which might be on an empty packet when the
    snapshot is triggered.

After this the number of snapshots that can be taken and getting events is
equal to number of sub-buffers!?
I think this i BUG!

The following test script shows the problem!
-----------------------------------------------------------------
#!/bin/sh

TRACEAPP="/usr/lib/lttng-tools/ptest/tests/utils/testapp/gen-ust-events/gen-ust-events
1"
TRACEPATH=$HOME/lttng-snapshots
SESSION=tracetest
CHANNEL=tracechannel

# cleanup
lttng destroy $SESSION
rm -rf $TRACEPATH
sleep 1

lttng create $SESSION --snapshot -U file://$TRACEPATH
lttng enable-channel $CHANNEL -u --subbuf-size 4k --num-subbuf 2
lttng enable-event -a -u -c $CHANNEL -s $SESSION
lttng start $SESSION
lttng --version
#lttng list $SESSION

$TRACEAPP
sleep 1

for i in $(seq 1 5); do
  lttng snapshot record --session $SESSION --name $i-something
  sleep 1
  echo "------------------------------------"
  echo " $i print events"
  babeltrace $TRACEPATH/$i-something* | head -1
done
------------------------------------------------------------------------

BEFOR the patch the output is like this (I have removed some lines to make
it easier to read);
--------------------------------------------------------------------------------------------------------------------------
Session tracetest created.
Default snapshot output set to: file:///root/lttng-snapshots
Snapshot mode set. Every channel enabled for that session will be set in
overwrite mode and mmap output.
UST channel tracechannel enabled for session tracetest
All UST events are enabled in channel tracechannel
Tracing started for session tracetest
lttng (LTTng Trace Control) 2.7.2

--- create some user events ---
Snapshot recorded successfully for session tracetest
------------------------------------
 1 print events
[15:02:11.886716015] (+?.?????????) axxiaarm lttng_ust_statedump:start: {
cpu_id = 9 }, { }
------------------------------------
Snapshot recorded successfully for session tracetest
 2 print events
[15:02:11.886716015] (+?.?????????) axxiaarm lttng_ust_statedump:start: {
cpu_id = 9 }, { }
------------------------------------
Snapshot recorded successfully for session tracetest
 3 print events
[15:02:11.886716015] (+?.?????????) axxiaarm lttng_ust_statedump:start: {
cpu_id = 9 }, { }
------------------------------------
Snapshot recorded successfully for session tracetest
 4 print events
[15:02:11.886716015] (+?.?????????) axxiaarm lttng_ust_statedump:start: {
cpu_id = 9 }, { }
------------------------------------
Snapshot recorded successfully for session tracetest
 5 print events
[15:02:11.886716015] (+?.?????????) axxiaarm lttng_ust_statedump:start: {
cpu_id = 9 }, { }


AFTER the patch the output is like this (I have removed some lines to make
it easier to read);
--------------------------------------------------------------------------------------------------------------------------
Session tracetest created.
Default snapshot output set to: file:///root/lttng-snapshots
Snapshot mode set. Every channel enabled for that session will be set in
overwrite mode and mmap output.
UST channel tracechannel enabled for session tracetest
All UST events are enabled in channel tracechannel
Tracing started for session tracetest
lttng (LTTng Trace Control) 2.7.5

--- create some user events ---
Snapshot recorded successfully for session tracetest
------------------------------------
 1 print events
[15:02:11.886716015] (+?.?????????) axxiaarm lttng_ust_statedump:start: {
cpu_id = 9 }, { }
------------------------------------
Snapshot recorded successfully for session tracetest
 2 print events
[15:02:11.886716015] (+?.?????????) axxiaarm lttng_ust_statedump:start: {
cpu_id = 9 }, { }
------------------------------------
Snapshot recorded successfully for session tracetest
 3 print events
------------------------------------
Snapshot recorded successfully for session tracetest
 4 print events
------------------------------------
Snapshot recorded successfully for session tracetest
 5 print events


Tested on 2.7.5 and 2.8.2 with the same result

Regards
Anders Wallin

--001a1141cae87259a9054312528c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Taking a number of snapshots always=
 showed the events in the buffer, before the</div><div>commit de3fb857f034c=
208c135a10a3cdec2dfe43fbda6=C2=A0</div><div><div><br></div><div><div>=C2=A0=
 =C2=A0 Fix: ust-consumer: flush empty packets on snapshot channel</div><di=
v>=C2=A0 =C2=A0=C2=A0</div><div>=C2=A0 =C2=A0 Snapshot operation on a non-s=
topped stream should use a &quot;final&quot; flush to</div><div>=C2=A0 =C2=
=A0 ensure empty packets are flushed, so we gather timestamps at the moment=
</div><div>=C2=A0 =C2=A0 where the snapshot is taken. This is important for=
 streams that have a</div><div>=C2=A0 =C2=A0 low amount of activity, which =
might be on an empty packet when the</div><div>=C2=A0 =C2=A0 snapshot is tr=
iggered.</div><div><br></div><div>After this the number of snapshots that c=
an be taken and getting events is equal to number of sub-buffers!?</div><di=
v>I think this i BUG!</div><div><br></div><div>The following test script sh=
ows the problem!</div><div>------------------------------------------------=
-----------------</div><div><div>#!/bin/sh</div><div><br></div><div>TRACEAP=
P=3D&quot;/usr/lib/lttng-tools/ptest/tests/utils/testapp/gen-ust-events/gen=
-ust-events 1&quot;</div><div>TRACEPATH=3D$HOME/lttng-snapshots<br></div><d=
iv>SESSION=3Dtracetest</div><div>CHANNEL=3Dtracechannel</div><div><br></div=
><div># cleanup</div><div>lttng destroy $SESSION<br></div><div>rm -rf $TRAC=
EPATH</div><div>sleep 1</div><div><br></div><div>lttng create $SESSION --sn=
apshot -U file://$TRACEPATH</div><div>lttng enable-channel $CHANNEL -u --su=
bbuf-size 4k --num-subbuf 2</div><div>lttng enable-event -a -u -c $CHANNEL =
-s $SESSION</div><div>lttng start $SESSION</div><div>lttng --version</div><=
div>#lttng list $SESSION</div><div><br></div><div>$TRACEAPP=C2=A0<br></div>=
<div>sleep 1</div><div><br></div><div>for i in $(seq 1 5); do</div><div>=C2=
=A0 lttng snapshot record --session $SESSION --name $i-something</div><div>=
=C2=A0 sleep 1</div><div>=C2=A0 echo &quot;--------------------------------=
----&quot;</div><div>=C2=A0 echo &quot; $i print events&quot;=C2=A0</div><d=
iv>=C2=A0 babeltrace $TRACEPATH/$i-something* | head -1</div><div>done</div=
></div><div>---------------------------------------------------------------=
---------</div><div><br></div><div>BEFOR the patch the output is like this =
(I have removed some lines to make it easier to read);</div><div>----------=
---------------------------------------------------------------------------=
-------------------------------------</div><div><div>Session tracetest crea=
ted.<br></div><div>Default snapshot output set to: file:///root/lttng-snaps=
hots</div><div>Snapshot mode set. Every channel enabled for that session wi=
ll be set in overwrite mode and mmap output.</div><div>UST channel tracecha=
nnel enabled for session tracetest</div><div>All UST events are enabled in =
channel tracechannel</div><div>Tracing started for session tracetest</div><=
div>lttng (LTTng Trace Control) 2.7.2</div><div><br></div><div>--- create s=
ome user events ---<br></div><div>Snapshot recorded successfully for sessio=
n tracetest</div><div>------------------------------------</div><div>=C2=A0=
1 print events</div><div>[15:02:11.886716015] (+?.?????????) axxiaarm lttng=
_ust_statedump:start: { cpu_id =3D 9 }, { }</div><div>---------------------=
---------------<br></div><div>Snapshot recorded successfully for session tr=
acetest</div><div>=C2=A02 print events</div><div><div>[15:02:11.886716015] =
(+?.?????????) axxiaarm lttng_ust_statedump:start: { cpu_id =3D 9 }, { }</d=
iv></div></div><div><div><div>------------------------------------<br></div=
><div>Snapshot recorded successfully for session tracetest</div><div>=C2=A0=
3 print events</div><div>[15:02:11.886716015] (+?.?????????) axxiaarm lttng=
_ust_statedump:start: { cpu_id =3D 9 }, { }</div></div></div><div><div><div=
>------------------------------------<br></div><div>Snapshot recorded succe=
ssfully for session tracetest</div><div>=C2=A04 print events</div><div>[15:=
02:11.886716015] (+?.?????????) axxiaarm lttng_ust_statedump:start: { cpu_i=
d =3D 9 }, { }</div></div></div><div><div><div>----------------------------=
--------<br></div><div>Snapshot recorded successfully for session tracetest=
</div><div>=C2=A05 print events</div><div>[15:02:11.886716015] (+?.????????=
?) axxiaarm lttng_ust_statedump:start: { cpu_id =3D 9 }, { }</div></div></d=
iv><div><br></div><div><div><br></div><div>AFTER the patch the output is li=
ke this (I have removed some lines to make it easier to read);</div><div>--=
---------------------------------------------------------------------------=
---------------------------------------------</div><div><div>Session tracet=
est created.<br></div><div>Default snapshot output set to: file:///root/ltt=
ng-snapshots</div><div>Snapshot mode set. Every channel enabled for that se=
ssion will be set in overwrite mode and mmap output.</div><div>UST channel =
tracechannel enabled for session tracetest</div><div>All UST events are ena=
bled in channel tracechannel</div><div>Tracing started for session tracetes=
t</div><div>lttng (LTTng Trace Control) 2.7.5</div><div><br></div><div>--- =
create some user events ---<br></div><div>Snapshot recorded successfully fo=
r session tracetest</div><div>------------------------------------</div><di=
v>=C2=A01 print events</div><div>[15:02:11.886716015] (+?.?????????) axxiaa=
rm lttng_ust_statedump:start: { cpu_id =3D 9 }, { }</div><div>-------------=
-----------------------<br></div><div>Snapshot recorded successfully for se=
ssion tracetest</div><div>=C2=A02 print events</div><div>[15:02:11.88671601=
5] (+?.?????????) axxiaarm lttng_ust_statedump:start: { cpu_id =3D 9 }, { }=
</div></div><div><div>------------------------------------<br></div><div>Sn=
apshot recorded successfully for session tracetest</div><div>=C2=A03 print =
events</div><div>------------------------------------<br></div></div><div><=
div>Snapshot recorded successfully for session tracetest</div><div>=C2=A04 =
print events</div><div>------------------------------------<br></div></div>=
<div><div>Snapshot recorded successfully for session tracetest</div><div>=
=C2=A05 print events</div><div><br></div></div></div></div><div><br></div><=
div>Tested on 2.7.5 and 2.8.2 with the same result<br clear=3D"all"><div><d=
iv class=3D"gmail_signature"><br></div><div class=3D"gmail_signature">Regar=
ds</div><div class=3D"gmail_signature">Anders Wallin</div></div>
</div></div></div>

--001a1141cae87259a9054312528c--

--===============5758732908244378227==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5758732908244378227==--
