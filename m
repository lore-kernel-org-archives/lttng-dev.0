From: "Mark E. Dawson, Jr. via lttng-dev" <lttng-dev@lists.lttng.org>
Subject: URCU_CALL_RCU_RT and its implications
Date: Thu, 8 Dec 2016 19:53:08 +0000 (UTC)
Message-ID: <1238891560.614917.1481226788805__44068.9198709608$1481226978$gmane$org@mail.yahoo.com>
References: <1238891560.614917.1481226788805.ref@mail.yahoo.com>
Reply-To: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2608387757941030040=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm12-vm0.bullet.mail.bf1.yahoo.com
 (nm12-vm0.bullet.mail.bf1.yahoo.com [98.139.213.140])
 by lists.lttng.org (Postfix) with ESMTPS id 3tZR4D3gf2zfy1
 for <lttng-dev@lists.lttng.org>; Thu,  8 Dec 2016 19:58:04 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2608387757941030040==
Content-Type: multipart/alternative;
	boundary="----=_Part_614916_1704170568.1481226788803"

------=_Part_614916_1704170568.1481226788803
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

All,
In the documentation for the create_call_rcu_data() call, we have the follo=
wing description of the URCU_CALL_RCU_RT flag:

struct call_rcu_data *create_call_rcu_data(unsigned long flags, int cpu_aff=
inity): Returns a handle that can be passed to the other functions in this =
list. The=C2=A0flags=C2=A0argument can be zero, or can be=C2=A0URCU_CALL_RC=
U_RT=C2=A0if the application threads associated with the new callback-invoc=
ation thread are to get real-time response from=C2=A0call_rcu()=C2=A0by avo=
iding the need to call into the kernel to wake up the callback-invocation t=
hread.

So setting "flags" to 0 will simply use the futex mechanism for wakeups. Wh=
at exactly happens when set to the RT option? Is there something else that =
needs to be configured from the OS side to make the aforementioned option w=
ork correctly?
I'm asking because we're seeing intermittent issues whereby on application =
startup, the reclamation thread (call_rcu) does exactly one cleanup, but th=
en never does it again. =C2=A0We have the URCU_CALL_RCU_RT flag set. =C2=A0=
Originally, we thought it was because the updater was not appropriately reg=
istered as a reader. But after ensuring that is the case, it still happens =
in 10% of startups.=C2=A0
Lastly, we wonder why it would even work correctly *at all* when we failed =
to register the updater as a reader thread.
------=_Part_614916_1704170568.1481226788803
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"color:#000; background-color:#fff; f=
ont-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, =
sans-serif;font-size:16px"><div id=3D"yui_3_16_0_ym19_1_1481226442633_2947"=
>All,</div><div id=3D"yui_3_16_0_ym19_1_1481226442633_2947"><br></div><div =
id=3D"yui_3_16_0_ym19_1_1481226442633_2947">In the documentation for the cr=
eate_call_rcu_data() call, we have the following description of the URCU_CA=
LL_RCU_RT flag:</div><div id=3D"yui_3_16_0_ym19_1_1481226442633_2947"><br><=
/div><blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;" =
id=3D"yui_3_16_0_ym19_1_1481226442633_3052"><div id=3D"yui_3_16_0_ym19_1_14=
81226442633_2947" dir=3D"ltr"><code id=3D"yui_3_16_0_ym19_1_1481226442633_2=
989">struct call_rcu_data *create_call_rcu_data(unsigned long flags, int cp=
u_affinity)</code><span style=3D"font-family: Times; font-size: medium;" id=
=3D"yui_3_16_0_ym19_1_1481226442633_2990">: Returns a handle that can be pa=
ssed to the other functions in this list. The&nbsp;</span><code id=3D"yui_3=
_16_0_ym19_1_1481226442633_2991">flags</code><span style=3D"font-family: Ti=
mes; font-size: medium;" id=3D"yui_3_16_0_ym19_1_1481226442633_2992">&nbsp;=
argument can be zero, or can be&nbsp;</span><code id=3D"yui_3_16_0_ym19_1_1=
481226442633_2993">URCU_CALL_RCU_RT</code><span style=3D"font-family: Times=
; font-size: medium;" id=3D"yui_3_16_0_ym19_1_1481226442633_2994">&nbsp;if =
the application threads associated with the new callback-invocation thread =
are to get real-time response from&nbsp;</span><code id=3D"yui_3_16_0_ym19_=
1_1481226442633_2995">call_rcu()</code><span style=3D"font-family: Times; f=
ont-size: medium;" id=3D"yui_3_16_0_ym19_1_1481226442633_2996">&nbsp;by avo=
iding the need to call into the kernel to wake up the callback-invocation t=
hread.</span></div><div id=3D"yui_3_16_0_ym19_1_1481226442633_2947" dir=3D"=
ltr"><span style=3D"font-family: Times; font-size: medium;"><br></span></di=
v></blockquote><div id=3D"yui_3_16_0_ym19_1_1481226442633_3169">So setting =
"flags" to 0 will simply use the futex mechanism for wakeups. What exactly =
happens when set to the RT option? Is there something else that needs to be=
 configured from the OS side to make the aforementioned option work correct=
ly?</div><div><br></div><div id=3D"yui_3_16_0_ym19_1_1481226442633_3170">I'=
m asking because we're seeing intermittent issues whereby on application st=
artup, the reclamation thread (call_rcu) does exactly one cleanup, but then=
 never does it again. &nbsp;We have the URCU_CALL_RCU_RT flag set. &nbsp;Or=
iginally, we thought it was because the updater was not appropriately regis=
tered as a reader. But after ensuring that is the case, it still happens in=
 10% of startups.&nbsp;</div><div><br></div><div id=3D"yui_3_16_0_ym19_1_14=
81226442633_3171">Lastly, we wonder why it would even work correctly *at al=
l* when we failed to register the updater as a reader thread.</div></div></=
body></html>
------=_Part_614916_1704170568.1481226788803--

--===============2608387757941030040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2608387757941030040==--
