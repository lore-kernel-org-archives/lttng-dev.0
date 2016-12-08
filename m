From: "Mark E. Dawson, Jr. via lttng-dev" <lttng-dev@lists.lttng.org>
Subject: Re: URCU_CALL_RCU_RT and its implications
Date: Thu, 8 Dec 2016 21:55:45 +0000 (UTC)
Message-ID: <1754715736.731421.1481234145616__17434.5177518719$1481234354$gmane$org@mail.yahoo.com>
References: <1238891560.614917.1481226788805.ref@mail.yahoo.com>
 <1238891560.614917.1481226788805@mail.yahoo.com>
 <2072321356.31974.1481233590402.JavaMail.zimbra@efficios.com>
Reply-To: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4691383105499259026=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm36-vm8.bullet.mail.bf1.yahoo.com
 (nm36-vm8.bullet.mail.bf1.yahoo.com [72.30.239.70])
 by lists.lttng.org (Postfix) with ESMTPS id 3tZTnw0pCCzgcV
 for <lttng-dev@lists.lttng.org>; Thu,  8 Dec 2016 22:00:51 +0000 (UTC)
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

--===============4691383105499259026==
Content-Type: multipart/alternative;
	boundary="----=_Part_731420_1238982096.1481234145613"

------=_Part_731420_1238982096.1481234145613
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Yes, this is QSBR flavor.=C2=A0
Regarding the context to your last question, I'm curious about how an updat=
er in QSBR mode using call_rcu *without properly registering itself as a re=
ader* could ever work properly. In our case, this was the initial mistake w=
e noticed that we were doing, yet we only encountered the aforementioned st=
artup error a relatively small percentage of the time (i.e., the reclamatio=
n thread only performing a cleanup once).

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
------=_Part_731420_1238982096.1481234145613
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"color:#000; background-color:#fff; f=
ont-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, =
sans-serif;font-size:16px"><div id=3D"yui_3_16_0_ym19_1_1481233834337_5494"=
>Yes, this is QSBR flavor.&nbsp;</div><div id=3D"yui_3_16_0_ym19_1_14812338=
34337_5494"><br></div><div id=3D"yui_3_16_0_ym19_1_1481233834337_5494">Rega=
rding the context to your last question, I'm curious about how an updater i=
n QSBR mode using call_rcu *without properly registering itself as a reader=
* could ever work properly. In our case, this was the initial mistake we no=
ticed that we were doing, yet we only encountered the aforementioned startu=
p error a relatively small percentage of the time (i.e., the reclamation th=
read only performing a cleanup once).</div><div class=3D"qtdSeparateBR" id=
=3D"yui_3_16_0_ym19_1_1481233834337_5507"><br><br></div><div class=3D"yahoo=
_quoted" id=3D"yui_3_16_0_ym19_1_1481233834337_5519" style=3D"display: bloc=
k;">  <div style=3D"font-family: HelveticaNeue, Helvetica Neue, Helvetica, =
Arial, Lucida Grande, sans-serif; font-size: 16px;" id=3D"yui_3_16_0_ym19_1=
_1481233834337_5518"> <div style=3D"font-family: HelveticaNeue, Helvetica N=
eue, Helvetica, Arial, Lucida Grande, sans-serif; font-size: 16px;" id=3D"y=
ui_3_16_0_ym19_1_1481233834337_5517"> <div dir=3D"ltr" id=3D"yui_3_16_0_ym1=
9_1_1481233834337_5657"> <font size=3D"2" face=3D"Arial" id=3D"yui_3_16_0_y=
m19_1_1481233834337_5656"> <hr size=3D"1"> <b><span style=3D"font-weight:bo=
ld;">From:</span></b> Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&=
gt;<br> <b><span style=3D"font-weight: bold;">To:</span></b> "Mark E. Dawso=
n, Jr." &lt;medawsonjr@yahoo.com&gt; <br><b><span style=3D"font-weight: bol=
d;">Cc:</span></b> lttng-dev &lt;lttng-dev@lists.lttng.org&gt;<br> <b><span=
 style=3D"font-weight: bold;">Sent:</span></b> Thursday, December 8, 2016 3=
:46 PM<br> <b><span style=3D"font-weight: bold;">Subject:</span></b> Re: [l=
ttng-dev] URCU_CALL_RCU_RT and its implications<br> </font> </div> <div cla=
ss=3D"y_msg_container" id=3D"yui_3_16_0_ym19_1_1481233834337_5516"><br><div=
 id=3D"yiv0967250936"><div id=3D"yui_3_16_0_ym19_1_1481233834337_5515"><div=
 style=3D"font-family:arial, helvetica, sans-serif;font-size:12pt;color:#00=
0000;" id=3D"yui_3_16_0_ym19_1_1481233834337_5514"><div id=3D"yui_3_16_0_ym=
19_1_1481233834337_5658"><span id=3D"yiv0967250936zwchr">----- On Dec 8, 20=
16, at 2:53 PM, lttng-dev &lt;lttng-dev@lists.lttng.org&gt; wrote:<br clear=
=3D"none"></span></div><div id=3D"yui_3_16_0_ym19_1_1481233834337_5513"><bl=
ockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-lef=
t:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;=
font-family:Helvetica, Arial, sans-serif;font-size:12pt;" id=3D"yui_3_16_0_=
ym19_1_1481233834337_5621"><div style=3D"color:#000;background-color:#fff;f=
ont-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, =
sans-serif;font-size:16px;" id=3D"yui_3_16_0_ym19_1_1481233834337_5620"><di=
v id=3D"yiv0967250936yui_3_16_0_ym19_1_1481226442633_2947">All,</div><div i=
d=3D"yiv0967250936yui_3_16_0_ym19_1_1481226442633_2947"><br clear=3D"none">=
</div><div id=3D"yiv0967250936yui_3_16_0_ym19_1_1481226442633_2947">In the =
documentation for the create_call_rcu_data() call, we have the following de=
scription of the URCU_CALL_RCU_RT flag:</div><div id=3D"yiv0967250936yui_3_=
16_0_ym19_1_1481226442633_2947"><br clear=3D"none"></div><blockquote id=3D"=
yiv0967250936yui_3_16_0_ym19_1_1481226442633_3052" style=3D"margin:0 0 0 40=
px;border:none;padding:0px;"><div dir=3D"ltr" id=3D"yiv0967250936yui_3_16_0=
_ym19_1_1481226442633_2947"><code id=3D"yiv0967250936yui_3_16_0_ym19_1_1481=
226442633_2989">struct call_rcu_data *create_call_rcu_data(unsigned long fl=
ags, int cpu_affinity)</code><span id=3D"yiv0967250936yui_3_16_0_ym19_1_148=
1226442633_2990" style=3D"font-family:Times;font-size:medium;">: Returns a =
handle that can be passed to the other functions in this list. The&nbsp;</s=
pan><code id=3D"yiv0967250936yui_3_16_0_ym19_1_1481226442633_2991">flags</c=
ode><span id=3D"yiv0967250936yui_3_16_0_ym19_1_1481226442633_2992" style=3D=
"font-family:Times;font-size:medium;">&nbsp;argument can be zero, or can be=
&nbsp;</span><code id=3D"yiv0967250936yui_3_16_0_ym19_1_1481226442633_2993"=
>URCU_CALL_RCU_RT</code><span id=3D"yiv0967250936yui_3_16_0_ym19_1_14812264=
42633_2994" style=3D"font-family:Times;font-size:medium;">&nbsp;if the appl=
ication threads associated with the new callback-invocation thread are to g=
et real-time response from&nbsp;</span><code id=3D"yiv0967250936yui_3_16_0_=
ym19_1_1481226442633_2995">call_rcu()</code><span id=3D"yiv0967250936yui_3_=
16_0_ym19_1_1481226442633_2996" style=3D"font-family:Times;font-size:medium=
;">&nbsp;by avoiding the need to call into the kernel to wake up the callba=
ck-invocation thread.</span></div><div dir=3D"ltr" id=3D"yiv0967250936yui_3=
_16_0_ym19_1_1481226442633_2947"><span style=3D"font-family:Times;font-size=
:medium;"><br clear=3D"none"></span></div></blockquote><div id=3D"yiv096725=
0936yui_3_16_0_ym19_1_1481226442633_3169">So setting "flags" to 0 will simp=
ly use the futex mechanism for wakeups. What exactly happens when set to th=
e RT option? Is there something else that needs to be configured from the O=
S side to make the aforementioned option work correctly?</div></div></block=
quote><div><br clear=3D"none"></div><div>No, it's just that the call rcu wo=
rker thread will rely on periodic polling<br clear=3D"none"></div><div>of t=
he call rcu work queue.<br clear=3D"none"></div><div><br clear=3D"none"></d=
iv><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;paddi=
ng-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration=
:none;font-family:Helvetica, Arial, sans-serif;font-size:12pt;" id=3D"yui_3=
_16_0_ym19_1_1481233834337_5628"><div style=3D"color:#000;background-color:=
#fff;font-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Gr=
ande, sans-serif;font-size:16px;" id=3D"yui_3_16_0_ym19_1_1481233834337_562=
7"><br clear=3D"none"><div id=3D"yiv0967250936yui_3_16_0_ym19_1_14812264426=
33_3170">I'm asking because we're seeing intermittent issues whereby on app=
lication startup, the reclamation thread (call_rcu) does exactly one cleanu=
p, but then never does it again. &nbsp;We have the URCU_CALL_RCU_RT flag se=
t. &nbsp;Originally, we thought it was because the updater was not appropri=
ately registered as a reader. But after ensuring that is the case, it still=
 happens in 10% of startups.&nbsp;</div></div></blockquote><div>Which URCU =
flavor are you using ? You may have a thread stuck as<br clear=3D"none"></d=
iv><div id=3D"yui_3_16_0_ym19_1_1481233834337_5629">being a RCU reader fore=
ver, which would cause this kind of issue.<br clear=3D"none"></div><div id=
=3D"yui_3_16_0_ym19_1_1481233834337_5631"><br clear=3D"none"></div><div id=
=3D"yui_3_16_0_ym19_1_1481233834337_5524">For instance, unbalanced rcu read=
-side lock/unlock, or blocking on<br clear=3D"none"></div><div>poll() or ot=
her while holding a rcu read-side lock, or blocking on<br clear=3D"none"></=
div><div>pthread_join() while holding rcu read-side lock...<br clear=3D"non=
e"></div><div><br clear=3D"none"></div><div>And if you use the QSBR flavor,=
 remember that registered threads<br clear=3D"none"></div><div>are by defau=
lt in read-side. So you need to mark them as explicitly<br clear=3D"none"><=
/div><div id=3D"yui_3_16_0_ym19_1_1481233834337_5522">"offline" whenever yo=
u do any blocking op (e.g. poll(), blocking read(),<br clear=3D"none"></div=
><div>pthread_join....).<br clear=3D"none"></div><div><br clear=3D"none"></=
div><div><br clear=3D"none"></div><blockquote style=3D"border-left:2px soli=
d #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;fo=
nt-style:normal;text-decoration:none;font-family:Helvetica, Arial, sans-ser=
if;font-size:12pt;"><div style=3D"color:#000;background-color:#fff;font-fam=
ily:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-se=
rif;font-size:16px;"><br clear=3D"none"><div id=3D"yiv0967250936yui_3_16_0_=
ym19_1_1481226442633_3171">Lastly, we wonder why it would even work correct=
ly *at all* when we failed to register the updater as a reader thread.</div=
></div></blockquote><div>I don't understand the context of this question. C=
an you provide more info ?<br clear=3D"none"></div><div><br clear=3D"none">=
</div><div>Thanks,<br clear=3D"none"></div><div><br clear=3D"none"></div><d=
iv id=3D"yui_3_16_0_ym19_1_1481233834337_5512">Mathieu<div class=3D"yiv0967=
250936yqt4998000334" id=3D"yiv0967250936yqtfd47668"><br clear=3D"none"></di=
v></div><div class=3D"yiv0967250936yqt4998000334" id=3D"yiv0967250936yqtfd5=
9846"><div id=3D"yui_3_16_0_ym19_1_1481233834337_5624"><br clear=3D"none"><=
/div><div><br clear=3D"none"></div><div><br clear=3D"none"></div></div><blo=
ckquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left=
:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;f=
ont-family:Helvetica, Arial, sans-serif;font-size:12pt;"><div class=3D"yiv0=
967250936yqt4998000334" id=3D"yiv0967250936yqtfd70691"><br clear=3D"none">_=
______________________________________________<br clear=3D"none">lttng-dev =
mailing list<br clear=3D"none">lttng-dev@lists.lttng.org<br clear=3D"none">=
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</div><br clear=
=3D"none"></blockquote></div><div><br clear=3D"none"></div><div>-- <br clea=
r=3D"none"></div><div>Mathieu Desnoyers<br clear=3D"none">EfficiOS Inc.<br =
clear=3D"none">http://www.efficios.com</div></div></div></div><br><br></div=
> </div> </div>  </div></div></body></html>
------=_Part_731420_1238982096.1481234145613--

--===============4691383105499259026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4691383105499259026==--
