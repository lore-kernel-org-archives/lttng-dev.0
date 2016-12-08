From: "Mark E. Dawson, Jr. via lttng-dev" <lttng-dev@lists.lttng.org>
Subject: Re: URCU_CALL_RCU_RT and its implications
Date: Thu, 8 Dec 2016 23:50:45 +0000 (UTC)
Message-ID: <101358611.352129.1481241045528__6405.57882511548$1481241164$gmane$org@mail.yahoo.com>
References: <1238891560.614917.1481226788805.ref@mail.yahoo.com>
 <1238891560.614917.1481226788805@mail.yahoo.com>
 <2072321356.31974.1481233590402.JavaMail.zimbra@efficios.com>
Reply-To: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4183442817376169909=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm19-vm0.bullet.mail.bf1.yahoo.com
 (nm19-vm0.bullet.mail.bf1.yahoo.com [98.139.213.162])
 by lists.lttng.org (Postfix) with ESMTPS id 3tZXK04BpMzgs8
 for <lttng-dev@lists.lttng.org>; Thu,  8 Dec 2016 23:54:28 +0000 (UTC)
In-Reply-To: <2072321356.31974.1481233590402.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============4183442817376169909==
Content-Type: multipart/alternative;
	boundary="----=_Part_352128_597981840.1481241045525"

------=_Part_352128_597981840.1481241045525
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hmmm, it just dawned on me that since in QSBR mode the updater itself is a =
registered reader, then it, too, much use the rcu_thread_offline/online() f=
unctions around its network I/O system calls. Doh!

      From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 To: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>=20
Cc: lttng-dev <lttng-dev@lists.lttng.org>
 Sent: Thursday, December 8, 2016 3:46 PM
 Subject: Re: [lttng-dev] URCU_CALL_RCU_RT and its implications
  =20
----- On Dec 8, 2016, at 2:53 PM, lttng-dev <lttng-dev@lists.lttng.org> wro=
te:

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

No, it's just that the call rcu worker thread will rely on periodic polling
of the call rcu work queue.



I'm asking because we're seeing intermittent issues whereby on application =
startup, the reclamation thread (call_rcu) does exactly one cleanup, but th=
en never does it again. =C2=A0We have the URCU_CALL_RCU_RT flag set. =C2=A0=
Originally, we thought it was because the updater was not appropriately reg=
istered as a reader. But after ensuring that is the case, it still happens =
in 10% of startups.=C2=A0
Which URCU flavor are you using ? You may have a thread stuck as
being a RCU reader forever, which would cause this kind of issue.

For instance, unbalanced rcu read-side lock/unlock, or blocking on
poll() or other while holding a rcu read-side lock, or blocking on
pthread_join() while holding rcu read-side lock...

And if you use the QSBR flavor, remember that registered threads
are by default in read-side. So you need to mark them as explicitly
"offline" whenever you do any blocking op (e.g. poll(), blocking read(),
pthread_join....).




Lastly, we wonder why it would even work correctly *at all* when we failed =
to register the updater as a reader thread.
I don't understand the context of this question. Can you provide more info =
?

Thanks,

Mathieu





_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

  =20
------=_Part_352128_597981840.1481241045525
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"color:#000; background-color:#fff; f=
ont-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, =
sans-serif;font-size:16px"><div id=3D"yui_3_16_0_ym19_1_1481240908655_4439"=
><span id=3D"yui_3_16_0_ym19_1_1481240908655_4438">Hmmm, it just dawned on =
me that since in QSBR mode the updater itself is a registered reader, then =
it, too, much use the rcu_thread_offline/online() functions around its netw=
ork I/O system calls. Doh!</span></div><div class=3D"qtdSeparateBR" id=3D"y=
ui_3_16_0_ym19_1_1481240908655_4452"><br><br></div><div class=3D"yahoo_quot=
ed" id=3D"yui_3_16_0_ym19_1_1481240908655_4467" style=3D"display: block;"> =
 <div style=3D"font-family: HelveticaNeue, Helvetica Neue, Helvetica, Arial=
, Lucida Grande, sans-serif; font-size: 16px;" id=3D"yui_3_16_0_ym19_1_1481=
240908655_4466"> <div style=3D"font-family: HelveticaNeue, Helvetica Neue, =
Helvetica, Arial, Lucida Grande, sans-serif; font-size: 16px;" id=3D"yui_3_=
16_0_ym19_1_1481240908655_4465"> <div dir=3D"ltr" id=3D"yui_3_16_0_ym19_1_1=
481240908655_4464"> <font size=3D"2" face=3D"Arial" id=3D"yui_3_16_0_ym19_1=
_1481240908655_4463"> <hr size=3D"1" id=3D"yui_3_16_0_ym19_1_1481240908655_=
4462"> <b><span style=3D"font-weight:bold;">From:</span></b> Mathieu Desnoy=
ers &lt;mathieu.desnoyers@efficios.com&gt;<br> <b><span style=3D"font-weigh=
t: bold;">To:</span></b> "Mark E. Dawson, Jr." &lt;medawsonjr@yahoo.com&gt;=
 <br><b><span style=3D"font-weight: bold;">Cc:</span></b> lttng-dev &lt;ltt=
ng-dev@lists.lttng.org&gt;<br> <b><span style=3D"font-weight: bold;">Sent:<=
/span></b> Thursday, December 8, 2016 3:46 PM<br> <b><span style=3D"font-we=
ight: bold;">Subject:</span></b> Re: [lttng-dev] URCU_CALL_RCU_RT and its i=
mplications<br> </font> </div> <div class=3D"y_msg_container" id=3D"yui_3_1=
6_0_ym19_1_1481240908655_4468"><br><div id=3D"yiv8687194669"><div id=3D"yui=
_3_16_0_ym19_1_1481240908655_4471"><div style=3D"font-family:arial, helveti=
ca, sans-serif;font-size:12pt;color:#000000;" id=3D"yui_3_16_0_ym19_1_14812=
40908655_4470"><div id=3D"yui_3_16_0_ym19_1_1481240908655_4469"><span id=3D=
"yiv8687194669zwchr">----- On Dec 8, 2016, at 2:53 PM, lttng-dev &lt;lttng-=
dev@lists.lttng.org&gt; wrote:<br clear=3D"none"></span></div><div id=3D"yu=
i_3_16_0_ym19_1_1481240908655_4474"><blockquote style=3D"border-left:2px so=
lid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;=
font-style:normal;text-decoration:none;font-family:Helvetica, Arial, sans-s=
erif;font-size:12pt;" id=3D"yui_3_16_0_ym19_1_1481240908655_4473"><div styl=
e=3D"color:#000;background-color:#fff;font-family:HelveticaNeue, Helvetica =
Neue, Helvetica, Arial, Lucida Grande, sans-serif;font-size:16px;" id=3D"yu=
i_3_16_0_ym19_1_1481240908655_4472"><div id=3D"yiv8687194669yui_3_16_0_ym19=
_1_1481226442633_2947">All,</div><div id=3D"yiv8687194669yui_3_16_0_ym19_1_=
1481226442633_2947"><br clear=3D"none"></div><div id=3D"yiv8687194669yui_3_=
16_0_ym19_1_1481226442633_2947">In the documentation for the create_call_rc=
u_data() call, we have the following description of the URCU_CALL_RCU_RT fl=
ag:</div><div id=3D"yiv8687194669yui_3_16_0_ym19_1_1481226442633_2947"><br =
clear=3D"none"></div><blockquote id=3D"yiv8687194669yui_3_16_0_ym19_1_14812=
26442633_3052" style=3D"margin:0 0 0 40px;border:none;padding:0px;"><div di=
r=3D"ltr" id=3D"yiv8687194669yui_3_16_0_ym19_1_1481226442633_2947"><code id=
=3D"yiv8687194669yui_3_16_0_ym19_1_1481226442633_2989">struct call_rcu_data=
 *create_call_rcu_data(unsigned long flags, int cpu_affinity)</code><span i=
d=3D"yiv8687194669yui_3_16_0_ym19_1_1481226442633_2990" style=3D"font-famil=
y:Times;font-size:medium;">: Returns a handle that can be passed to the oth=
er functions in this list. The&nbsp;</span><code id=3D"yiv8687194669yui_3_1=
6_0_ym19_1_1481226442633_2991">flags</code><span id=3D"yiv8687194669yui_3_1=
6_0_ym19_1_1481226442633_2992" style=3D"font-family:Times;font-size:medium;=
">&nbsp;argument can be zero, or can be&nbsp;</span><code id=3D"yiv86871946=
69yui_3_16_0_ym19_1_1481226442633_2993">URCU_CALL_RCU_RT</code><span id=3D"=
yiv8687194669yui_3_16_0_ym19_1_1481226442633_2994" style=3D"font-family:Tim=
es;font-size:medium;">&nbsp;if the application threads associated with the =
new callback-invocation thread are to get real-time response from&nbsp;</sp=
an><code id=3D"yiv8687194669yui_3_16_0_ym19_1_1481226442633_2995">call_rcu(=
)</code><span id=3D"yiv8687194669yui_3_16_0_ym19_1_1481226442633_2996" styl=
e=3D"font-family:Times;font-size:medium;">&nbsp;by avoiding the need to cal=
l into the kernel to wake up the callback-invocation thread.</span></div><d=
iv dir=3D"ltr" id=3D"yiv8687194669yui_3_16_0_ym19_1_1481226442633_2947"><sp=
an style=3D"font-family:Times;font-size:medium;"><br clear=3D"none"></span>=
</div></blockquote><div id=3D"yiv8687194669yui_3_16_0_ym19_1_1481226442633_=
3169">So setting "flags" to 0 will simply use the futex mechanism for wakeu=
ps. What exactly happens when set to the RT option? Is there something else=
 that needs to be configured from the OS side to make the aforementioned op=
tion work correctly?</div></div></blockquote><div><br clear=3D"none"></div>=
<div>No, it's just that the call rcu worker thread will rely on periodic po=
lling<br clear=3D"none"></div><div>of the call rcu work queue.<br clear=3D"=
none"></div><div><br clear=3D"none"></div><blockquote style=3D"border-left:=
2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:n=
ormal;font-style:normal;text-decoration:none;font-family:Helvetica, Arial, =
sans-serif;font-size:12pt;"><div style=3D"color:#000;background-color:#fff;=
font-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande,=
 sans-serif;font-size:16px;"><br clear=3D"none"><div id=3D"yiv8687194669yui=
_3_16_0_ym19_1_1481226442633_3170">I'm asking because we're seeing intermit=
tent issues whereby on application startup, the reclamation thread (call_rc=
u) does exactly one cleanup, but then never does it again. &nbsp;We have th=
e URCU_CALL_RCU_RT flag set. &nbsp;Originally, we thought it was because th=
e updater was not appropriately registered as a reader. But after ensuring =
that is the case, it still happens in 10% of startups.&nbsp;</div></div></b=
lockquote><div>Which URCU flavor are you using ? You may have a thread stuc=
k as<br clear=3D"none"></div><div>being a RCU reader forever, which would c=
ause this kind of issue.<br clear=3D"none"></div><div><br clear=3D"none"></=
div><div>For instance, unbalanced rcu read-side lock/unlock, or blocking on=
<br clear=3D"none"></div><div>poll() or other while holding a rcu read-side=
 lock, or blocking on<br clear=3D"none"></div><div>pthread_join() while hol=
ding rcu read-side lock...<br clear=3D"none"></div><div><br clear=3D"none">=
</div><div>And if you use the QSBR flavor, remember that registered threads=
<br clear=3D"none"></div><div>are by default in read-side. So you need to m=
ark them as explicitly<br clear=3D"none"></div><div>"offline" whenever you =
do any blocking op (e.g. poll(), blocking read(),<br clear=3D"none"></div><=
div>pthread_join....).<br clear=3D"none"></div><div><br clear=3D"none"></di=
v><div><br clear=3D"none"></div><blockquote style=3D"border-left:2px solid =
#1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font=
-style:normal;text-decoration:none;font-family:Helvetica, Arial, sans-serif=
;font-size:12pt;"><div style=3D"color:#000;background-color:#fff;font-famil=
y:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-seri=
f;font-size:16px;"><br clear=3D"none"><div id=3D"yiv8687194669yui_3_16_0_ym=
19_1_1481226442633_3171">Lastly, we wonder why it would even work correctly=
 *at all* when we failed to register the updater as a reader thread.</div><=
/div></blockquote><div>I don't understand the context of this question. Can=
 you provide more info ?<br clear=3D"none"></div><div><br clear=3D"none"></=
div><div>Thanks,<br clear=3D"none"></div><div><br clear=3D"none"></div><div=
>Mathieu<div class=3D"yiv8687194669yqt2659051997" id=3D"yiv8687194669yqtfd3=
7054"><br clear=3D"none"></div></div><div class=3D"yiv8687194669yqt26590519=
97" id=3D"yiv8687194669yqtfd80120"><div><br clear=3D"none"></div><div><br c=
lear=3D"none"></div><div><br clear=3D"none"></div></div><blockquote style=
=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica, Arial, sans-serif;font-size:12pt;"><div class=3D"yiv8687194669yqt2=
659051997" id=3D"yiv8687194669yqtfd57349"><br clear=3D"none">______________=
_________________________________<br clear=3D"none">lttng-dev mailing list<=
br clear=3D"none">lttng-dev@lists.lttng.org<br clear=3D"none">https://lists=
.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</div><br clear=3D"none"></blo=
ckquote></div><div><br clear=3D"none"></div><div>-- <br clear=3D"none"></di=
v><div>Mathieu Desnoyers<br clear=3D"none">EfficiOS Inc.<br clear=3D"none">=
http://www.efficios.com</div></div></div></div><br><br></div> </div> </div>=
  </div></div></body></html>
------=_Part_352128_597981840.1481241045525--

--===============4183442817376169909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4183442817376169909==--
