From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Snapshot gives no events after calling it more then
 the number sub-buffers in the channel
Date: Thu, 8 Dec 2016 17:35:22 +0000 (UTC)
Message-ID: <1208499797.31516.1481218522033.JavaMail.zimbra__37504.5573259287$1481218437$gmane$org@efficios.com>
References: <CAF2baFcNqGtivF-GnVMKegWBtx65E_UZR86PGD0dQWdMXVx18g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0149382930565573934=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tZMvn6fFhzfn2
 for <lttng-dev@lists.lttng.org>; Thu,  8 Dec 2016 17:35:33 +0000 (UTC)
In-Reply-To: <CAF2baFcNqGtivF-GnVMKegWBtx65E_UZR86PGD0dQWdMXVx18g@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Anders Wallin <wallinux@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0149382930565573934==
Content-Type: multipart/alternative;
	boundary="=_50468b78-ff36-460d-97ce-f0d1f38d1806"

--=_50468b78-ff36-460d-97ce-f0d1f38d1806
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Dec 7, 2016, at 9:27 AM, Anders Wallin <wallinux@gmail.com> wrote: 

> Hi,
> Taking a number of snapshots always showed the events in the buffer, before the
> commit de3fb857f034c208c135a10a3cdec2dfe43fbda6

> Fix: ust-consumer: flush empty packets on snapshot channel
> Snapshot operation on a non-stopped stream should use a "final" flush to
> ensure empty packets are flushed, so we gather timestamps at the moment
> where the snapshot is taken. This is important for streams that have a
> low amount of activity, which might be on an empty packet when the
> snapshot is triggered.

> After this the number of snapshots that can be taken and getting events is equal
> to number of sub-buffers!?
> I think this i BUG!

Hi, 

This has been done on purpose. By moving one packet forward even if there is no data 
in the current packet, we are able to save the end timestamp corresponding to the moment the 
snapshot is taken, which gives us information about the proper time-range to consider for each 
stream. 

This is needed for the babeltrace stream intersection feature to work properly on 
snapshots in cases where some streams have low even throughput. 

Can you describe your use-cases that rely on the prior behavior ? 

Thanks, 

Mathieu 

> The following test script shows the problem!
> -----------------------------------------------------------------
> #!/bin/sh

> TRACEAPP="/usr/lib/lttng-tools/ptest/tests/utils/testapp/gen-ust-events/gen-ust-events
> 1"
> TRACEPATH=$HOME/lttng-snapshots
> SESSION=tracetest
> CHANNEL=tracechannel

> # cleanup
> lttng destroy $SESSION
> rm -rf $TRACEPATH
> sleep 1

> lttng create $SESSION --snapshot -U file://$TRACEPATH
> lttng enable-channel $CHANNEL -u --subbuf-size 4k --num-subbuf 2
> lttng enable-event -a -u -c $CHANNEL -s $SESSION
> lttng start $SESSION
> lttng --version
> #lttng list $SESSION

> $TRACEAPP
> sleep 1

> for i in $(seq 1 5); do
> lttng snapshot record --session $SESSION --name $i-something
> sleep 1
> echo "------------------------------------"
> echo " $i print events"
> babeltrace $TRACEPATH/$i-something* | head -1
> done
> ------------------------------------------------------------------------

> BEFOR the patch the output is like this (I have removed some lines to make it
> easier to read);
> --------------------------------------------------------------------------------------------------------------------------
> Session tracetest created.
> Default snapshot output set to: file:///root/lttng-snapshots
> Snapshot mode set. Every channel enabled for that session will be set in
> overwrite mode and mmap output.
> UST channel tracechannel enabled for session tracetest
> All UST events are enabled in channel tracechannel
> Tracing started for session tracetest
> lttng (LTTng Trace Control) 2.7.2

> --- create some user events ---
> Snapshot recorded successfully for session tracetest
> ------------------------------------
> 1 print events
> [15:02:11.886716015] (+?.?????????) axxiaarm lttng_ust_statedump:start: { cpu_id
> = 9 }, { }
> ------------------------------------
> Snapshot recorded successfully for session tracetest
> 2 print events
> [15:02:11.886716015] (+?.?????????) axxiaarm lttng_ust_statedump:start: { cpu_id
> = 9 }, { }
> ------------------------------------
> Snapshot recorded successfully for session tracetest
> 3 print events
> [15:02:11.886716015] (+?.?????????) axxiaarm lttng_ust_statedump:start: { cpu_id
> = 9 }, { }
> ------------------------------------
> Snapshot recorded successfully for session tracetest
> 4 print events
> [15:02:11.886716015] (+?.?????????) axxiaarm lttng_ust_statedump:start: { cpu_id
> = 9 }, { }
> ------------------------------------
> Snapshot recorded successfully for session tracetest
> 5 print events
> [15:02:11.886716015] (+?.?????????) axxiaarm lttng_ust_statedump:start: { cpu_id
> = 9 }, { }

> AFTER the patch the output is like this (I have removed some lines to make it
> easier to read);
> --------------------------------------------------------------------------------------------------------------------------
> Session tracetest created.
> Default snapshot output set to: file:///root/lttng-snapshots
> Snapshot mode set. Every channel enabled for that session will be set in
> overwrite mode and mmap output.
> UST channel tracechannel enabled for session tracetest
> All UST events are enabled in channel tracechannel
> Tracing started for session tracetest
> lttng (LTTng Trace Control) 2.7.5

> --- create some user events ---
> Snapshot recorded successfully for session tracetest
> ------------------------------------
> 1 print events
> [15:02:11.886716015] (+?.?????????) axxiaarm lttng_ust_statedump:start: { cpu_id
> = 9 }, { }
> ------------------------------------
> Snapshot recorded successfully for session tracetest
> 2 print events
> [15:02:11.886716015] (+?.?????????) axxiaarm lttng_ust_statedump:start: { cpu_id
> = 9 }, { }
> ------------------------------------
> Snapshot recorded successfully for session tracetest
> 3 print events
> ------------------------------------
> Snapshot recorded successfully for session tracetest
> 4 print events
> ------------------------------------
> Snapshot recorded successfully for session tracetest
> 5 print events

> Tested on 2.7.5 and 2.8.2 with the same result

> Regards
> Anders Wallin

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_50468b78-ff36-460d-97ce-f0d1f38d1806
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><span id=3D"zwchr"=
 data-marker=3D"__DIVIDER__">----- On Dec 7, 2016, at 9:27 AM, Anders Walli=
n &lt;wallinux@gmail.com&gt; wrote:<br></span><div data-marker=3D"__QUOTED_=
TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;=
padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decor=
ation:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=
=3D"ltr">Hi,<br><div>Taking a number of snapshots always showed the events =
in the buffer, before the</div><div>commit de3fb857f034c208c135a10a3cdec2df=
e43fbda6&nbsp;</div><div><br><div><div>&nbsp; &nbsp; Fix: ust-consumer: flu=
sh empty packets on snapshot channel</div><div>&nbsp; &nbsp; Snapshot opera=
tion on a non-stopped stream should use a "final" flush to</div><div>&nbsp;=
 &nbsp; ensure empty packets are flushed, so we gather timestamps at the mo=
ment</div><div>&nbsp; &nbsp; where the snapshot is taken. This is important=
 for streams that have a</div><div>&nbsp; &nbsp; low amount of activity, wh=
ich might be on an empty packet when the</div><div>&nbsp; &nbsp; snapshot i=
s triggered.</div><br><div>After this the number of snapshots that can be t=
aken and getting events is equal to number of sub-buffers!?</div><div>I thi=
nk this i BUG!</div></div></div></div></blockquote><div><br></div><div>Hi,<=
br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>This=
 has been done on purpose. By moving one packet forward even if there is no=
 data</div><div>in the current packet, we are able to save the end timestam=
p corresponding to the moment the</div><div>snapshot is taken, which gives =
us information about the proper time-range to consider for each<br data-mce=
-bogus=3D"1"></div><div>stream.<br data-mce-bogus=3D"1"></div><div><br data=
-mce-bogus=3D"1"></div><div>This is needed for the babeltrace stream inters=
ection feature to work properly on<br data-mce-bogus=3D"1"></div><div>snaps=
hots in cases where some streams have low even throughput.<br data-mce-bogu=
s=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Can you describe you=
r use-cases that rely on the prior behavior ?<br data-mce-bogus=3D"1"></div=
><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"><=
/div><div><br data-mce-bogus=3D"1"></div><div>Mathieu</div><div><br data-mc=
e-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010FF;marg=
in-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:norma=
l;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12p=
t;"><div dir=3D"ltr"><div><div><br><div>The following test script shows the=
 problem!</div><div>-------------------------------------------------------=
----------</div><div><div>#!/bin/sh</div><br><div>TRACEAPP=3D"/usr/lib/lttn=
g-tools/ptest/tests/utils/testapp/gen-ust-events/gen-ust-events 1"</div><di=
v>TRACEPATH=3D$HOME/lttng-snapshots<br></div><div>SESSION=3Dtracetest</div>=
<div>CHANNEL=3Dtracechannel</div><br><div># cleanup</div><div>lttng destroy=
 $SESSION<br></div><div>rm -rf $TRACEPATH</div><div>sleep 1</div><br><div>l=
ttng create $SESSION --snapshot -U file://$TRACEPATH</div><div>lttng enable=
-channel $CHANNEL -u --subbuf-size 4k --num-subbuf 2</div><div>lttng enable=
-event -a -u -c $CHANNEL -s $SESSION</div><div>lttng start $SESSION</div><d=
iv>lttng --version</div><div>#lttng list $SESSION</div><br><div>$TRACEAPP&n=
bsp;<br></div><div>sleep 1</div><br><div>for i in $(seq 1 5); do</div><div>=
&nbsp; lttng snapshot record --session $SESSION --name $i-something</div><d=
iv>&nbsp; sleep 1</div><div>&nbsp; echo "----------------------------------=
--"</div><div>&nbsp; echo " $i print events"&nbsp;</div><div>&nbsp; babeltr=
ace $TRACEPATH/$i-something* | head -1</div><div>done</div></div><div>-----=
-------------------------------------------------------------------</div><b=
r><div>BEFOR the patch the output is like this (I have removed some lines t=
o make it easier to read);</div><div>--------------------------------------=
---------------------------------------------------------------------------=
---------</div><div><div>Session tracetest created.<br></div><div>Default s=
napshot output set to: file:///root/lttng-snapshots</div><div>Snapshot mode=
 set. Every channel enabled for that session will be set in overwrite mode =
and mmap output.</div><div>UST channel tracechannel enabled for session tra=
cetest</div><div>All UST events are enabled in channel tracechannel</div><d=
iv>Tracing started for session tracetest</div><div>lttng (LTTng Trace Contr=
ol) 2.7.2</div><br><div>--- create some user events ---<br></div><div>Snaps=
hot recorded successfully for session tracetest</div><div>-----------------=
-------------------</div><div>&nbsp;1 print events</div><div>[15:02:11.8867=
16015] (+?.?????????) axxiaarm lttng_ust_statedump:start: { cpu_id =3D 9 },=
 { }</div><div>------------------------------------<br></div><div>Snapshot =
recorded successfully for session tracetest</div><div>&nbsp;2 print events<=
/div><div><div>[15:02:11.886716015] (+?.?????????) axxiaarm lttng_ust_state=
dump:start: { cpu_id =3D 9 }, { }</div></div></div><div><div><div>---------=
---------------------------<br></div><div>Snapshot recorded successfully fo=
r session tracetest</div><div>&nbsp;3 print events</div><div>[15:02:11.8867=
16015] (+?.?????????) axxiaarm lttng_ust_statedump:start: { cpu_id =3D 9 },=
 { }</div></div></div><div><div><div>------------------------------------<b=
r></div><div>Snapshot recorded successfully for session tracetest</div><div=
>&nbsp;4 print events</div><div>[15:02:11.886716015] (+?.?????????) axxiaar=
m lttng_ust_statedump:start: { cpu_id =3D 9 }, { }</div></div></div><div><d=
iv><div>------------------------------------<br></div><div>Snapshot recorde=
d successfully for session tracetest</div><div>&nbsp;5 print events</div><d=
iv>[15:02:11.886716015] (+?.?????????) axxiaarm lttng_ust_statedump:start: =
{ cpu_id =3D 9 }, { }</div></div></div><br><div><br><div>AFTER the patch th=
e output is like this (I have removed some lines to make it easier to read)=
;</div><div>---------------------------------------------------------------=
-----------------------------------------------------------</div><div><div>=
Session tracetest created.<br></div><div>Default snapshot output set to: fi=
le:///root/lttng-snapshots</div><div>Snapshot mode set. Every channel enabl=
ed for that session will be set in overwrite mode and mmap output.</div><di=
v>UST channel tracechannel enabled for session tracetest</div><div>All UST =
events are enabled in channel tracechannel</div><div>Tracing started for se=
ssion tracetest</div><div>lttng (LTTng Trace Control) 2.7.5</div><br><div>-=
-- create some user events ---<br></div><div>Snapshot recorded successfully=
 for session tracetest</div><div>------------------------------------</div>=
<div>&nbsp;1 print events</div><div>[15:02:11.886716015] (+?.?????????) axx=
iaarm lttng_ust_statedump:start: { cpu_id =3D 9 }, { }</div><div>----------=
--------------------------<br></div><div>Snapshot recorded successfully for=
 session tracetest</div><div>&nbsp;2 print events</div><div>[15:02:11.88671=
6015] (+?.?????????) axxiaarm lttng_ust_statedump:start: { cpu_id =3D 9 }, =
{ }</div></div><div><div>------------------------------------<br></div><div=
>Snapshot recorded successfully for session tracetest</div><div>&nbsp;3 pri=
nt events</div><div>------------------------------------<br></div></div><di=
v><div>Snapshot recorded successfully for session tracetest</div><div>&nbsp=
;4 print events</div><div>------------------------------------<br></div></d=
iv><div><div>Snapshot recorded successfully for session tracetest</div><div=
>&nbsp;5 print events</div><br></div></div></div><br><div>Tested on 2.7.5 a=
nd 2.8.2 with the same result<br clear=3D"all"><div><div class=3D"gmail_sig=
nature"><br></div><div class=3D"gmail_signature">Regards</div><div class=3D=
"gmail_signature">Anders Wallin</div></div></div></div></div><br>__________=
_____________________________________<br>lttng-dev mailing list<br>lttng-de=
v@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng=
-dev<br></blockquote></div><br><div data-marker=3D"__SIG_POST__">-- <br></d=
iv><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div>=
</div></body></html>
--=_50468b78-ff36-460d-97ce-f0d1f38d1806--

--===============0149382930565573934==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0149382930565573934==--
