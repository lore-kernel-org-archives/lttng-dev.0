From: "Mark E. Dawson, Jr. via lttng-dev" <lttng-dev@lists.lttng.org>
Subject: Re: URCU_CALL_RCU_RT and its implications
Date: Thu, 8 Dec 2016 19:59:48 +0000 (UTC)
Message-ID: <1252570317.649997.1481227188949__34010.3760514923$1481227338$gmane$org@mail.yahoo.com>
References: <1238891560.614917.1481226788805.ref@mail.yahoo.com>
 <1238891560.614917.1481226788805@mail.yahoo.com>
Reply-To: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2495604107336642446=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm42-vm8.bullet.mail.bf1.yahoo.com
 (nm42-vm8.bullet.mail.bf1.yahoo.com [216.109.114.207])
 by lists.lttng.org (Postfix) with ESMTPS id 3tZRC5596Kzg6k
 for <lttng-dev@lists.lttng.org>; Thu,  8 Dec 2016 20:04:01 +0000 (UTC)
In-Reply-To: <1238891560.614917.1481226788805@mail.yahoo.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>, Lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2495604107336642446==
Content-Type: multipart/alternative;
	boundary="----=_Part_649996_382730768.1481227188946"

------=_Part_649996_382730768.1481227188946
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

And yes, the rcu_quiescent_state() is being regularly called in the updater=
 thread, just as an fyi.

      From: "Mark E. Dawson, Jr. via lttng-dev" <lttng-dev@lists.lttng.org>
 To: Lttng-dev <lttng-dev@lists.lttng.org>=20
 Sent: Thursday, December 8, 2016 1:53 PM
 Subject: [lttng-dev] URCU_CALL_RCU_RT and its implications
  =20
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
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


  =20
------=_Part_649996_382730768.1481227188946
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"color:#000; background-color:#fff; f=
ont-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, =
sans-serif;font-size:16px"><div id=3D"yui_3_16_0_ym19_1_1481226938043_9555"=
><span id=3D"yui_3_16_0_ym19_1_1481226938043_9580">And yes, the rcu_quiesce=
nt_state() is being regularly called in the updater thread, just as an fyi.=
</span></div><div class=3D"qtdSeparateBR" id=3D"yui_3_16_0_ym19_1_148122693=
8043_9554"><br><br></div><div class=3D"yahoo_quoted" id=3D"yui_3_16_0_ym19_=
1_1481226938043_9544" style=3D"display: block;">  <div style=3D"font-family=
: HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-seri=
f; font-size: 16px;" id=3D"yui_3_16_0_ym19_1_1481226938043_9543"> <div styl=
e=3D"font-family: HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida G=
rande, sans-serif; font-size: 16px;" id=3D"yui_3_16_0_ym19_1_1481226938043_=
9542"> <div dir=3D"ltr" id=3D"yui_3_16_0_ym19_1_1481226938043_9551"> <font =
size=3D"2" face=3D"Arial" id=3D"yui_3_16_0_ym19_1_1481226938043_9553"> <hr =
size=3D"1" id=3D"yui_3_16_0_ym19_1_1481226938043_9552"> <b><span style=3D"f=
ont-weight:bold;">From:</span></b> "Mark E. Dawson, Jr. via lttng-dev" &lt;=
lttng-dev@lists.lttng.org&gt;<br> <b><span style=3D"font-weight: bold;">To:=
</span></b> Lttng-dev &lt;lttng-dev@lists.lttng.org&gt; <br> <b><span style=
=3D"font-weight: bold;">Sent:</span></b> Thursday, December 8, 2016 1:53 PM=
<br> <b><span style=3D"font-weight: bold;">Subject:</span></b> [lttng-dev] =
URCU_CALL_RCU_RT and its implications<br> </font> </div> <div class=3D"y_ms=
g_container" id=3D"yui_3_16_0_ym19_1_1481226938043_9541"><br><div id=3D"yiv=
2166555474"><div id=3D"yui_3_16_0_ym19_1_1481226938043_9540"><div style=3D"=
color:#000;background-color:#fff;font-family:HelveticaNeue, Helvetica Neue,=
 Helvetica, Arial, Lucida Grande, sans-serif;font-size:16px;" id=3D"yui_3_1=
6_0_ym19_1_1481226938043_9539"><div id=3D"yiv2166555474yui_3_16_0_ym19_1_14=
81226442633_2947">All,</div><div id=3D"yiv2166555474yui_3_16_0_ym19_1_14812=
26442633_2947"><br></div><div id=3D"yiv2166555474yui_3_16_0_ym19_1_14812264=
42633_2947">In the documentation for the create_call_rcu_data() call, we ha=
ve the following description of the URCU_CALL_RCU_RT flag:</div><div id=3D"=
yiv2166555474yui_3_16_0_ym19_1_1481226442633_2947"><br></div><blockquote st=
yle=3D"margin:0 0 0 40px;border:none;padding:0px;" id=3D"yiv2166555474yui_3=
_16_0_ym19_1_1481226442633_3052"><div id=3D"yiv2166555474yui_3_16_0_ym19_1_=
1481226442633_2947" dir=3D"ltr"><code id=3D"yiv2166555474yui_3_16_0_ym19_1_=
1481226442633_2989">struct call_rcu_data *create_call_rcu_data(unsigned lon=
g flags, int cpu_affinity)</code><span style=3D"font-family:Times;font-size=
:medium;" id=3D"yiv2166555474yui_3_16_0_ym19_1_1481226442633_2990">: Return=
s a handle that can be passed to the other functions in this list. The&nbsp=
;</span><code id=3D"yiv2166555474yui_3_16_0_ym19_1_1481226442633_2991">flag=
s</code><span style=3D"font-family:Times;font-size:medium;" id=3D"yiv216655=
5474yui_3_16_0_ym19_1_1481226442633_2992">&nbsp;argument can be zero, or ca=
n be&nbsp;</span><code id=3D"yiv2166555474yui_3_16_0_ym19_1_1481226442633_2=
993">URCU_CALL_RCU_RT</code><span style=3D"font-family:Times;font-size:medi=
um;" id=3D"yiv2166555474yui_3_16_0_ym19_1_1481226442633_2994">&nbsp;if the =
application threads associated with the new callback-invocation thread are =
to get real-time response from&nbsp;</span><code id=3D"yiv2166555474yui_3_1=
6_0_ym19_1_1481226442633_2995">call_rcu()</code><span style=3D"font-family:=
Times;font-size:medium;" id=3D"yiv2166555474yui_3_16_0_ym19_1_1481226442633=
_2996">&nbsp;by avoiding the need to call into the kernel to wake up the ca=
llback-invocation thread.</span></div><div id=3D"yiv2166555474yui_3_16_0_ym=
19_1_1481226442633_2947" dir=3D"ltr"><span style=3D"font-family:Times;font-=
size:medium;"><br></span></div></blockquote><div id=3D"yiv2166555474yui_3_1=
6_0_ym19_1_1481226442633_3169">So setting "flags" to 0 will simply use the =
futex mechanism for wakeups. What exactly happens when set to the RT option=
? Is there something else that needs to be configured from the OS side to m=
ake the aforementioned option work correctly?</div><div><br></div><div id=
=3D"yiv2166555474yui_3_16_0_ym19_1_1481226442633_3170">I'm asking because w=
e're seeing intermittent issues whereby on application startup, the reclama=
tion thread (call_rcu) does exactly one cleanup, but then never does it aga=
in. &nbsp;We have the URCU_CALL_RCU_RT flag set. &nbsp;Originally, we thoug=
ht it was because the updater was not appropriately registered as a reader.=
 But after ensuring that is the case, it still happens in 10% of startups.&=
nbsp;</div><div><br></div><div id=3D"yiv2166555474yui_3_16_0_ym19_1_1481226=
442633_3171">Lastly, we wonder why it would even work correctly *at all* wh=
en we failed to register the updater as a reader thread.</div></div></div><=
/div><br>_______________________________________________<br>lttng-dev maili=
ng list<br><a ymailto=3D"mailto:lttng-dev@lists.lttng.org" href=3D"mailto:l=
ttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><br><a href=3D"https=
://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">ht=
tps://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br><br><br></d=
iv> </div> </div>  </div></div></body></html>
------=_Part_649996_382730768.1481227188946--

--===============2495604107336642446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2495604107336642446==--
