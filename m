From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: URCU_CALL_RCU_RT and its implications
Date: Thu, 8 Dec 2016 21:46:30 +0000 (UTC)
Message-ID: <2072321356.31974.1481233590402.JavaMail.zimbra__7722.75256827033$1481233499$gmane$org@efficios.com>
References: <1238891560.614917.1481226788805.ref@mail.yahoo.com>
 <1238891560.614917.1481226788805@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8660503077552706487=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tZTTf3V2hzgbY
 for <lttng-dev@lists.lttng.org>; Thu,  8 Dec 2016 21:46:46 +0000 (UTC)
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
To: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============8660503077552706487==
Content-Type: multipart/alternative;
	boundary="=_1e4de41f-f182-4046-b86c-da4e5408e598"

--=_1e4de41f-f182-4046-b86c-da4e5408e598
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Dec 8, 2016, at 2:53 PM, lttng-dev <lttng-dev@lists.lttng.org> wrote: 

> All,

> In the documentation for the create_call_rcu_data() call, we have the following
> description of the URCU_CALL_RCU_RT flag:

>> struct call_rcu_data *create_call_rcu_data(unsigned long flags, int
>> cpu_affinity) : Returns a handle that can be passed to the other functions in
>> this list. The flags argument can be zero, or can be URCU_CALL_RCU_RT if the
>> application threads associated with the new callback-invocation thread are to
>> get real-time response from call_rcu() by avoiding the need to call into the
>> kernel to wake up the callback-invocation thread.

> So setting "flags" to 0 will simply use the futex mechanism for wakeups. What
> exactly happens when set to the RT option? Is there something else that needs
> to be configured from the OS side to make the aforementioned option work
> correctly?

No, it's just that the call rcu worker thread will rely on periodic polling 
of the call rcu work queue. 

> I'm asking because we're seeing intermittent issues whereby on application
> startup, the reclamation thread (call_rcu) does exactly one cleanup, but then
> never does it again. We have the URCU_CALL_RCU_RT flag set. Originally, we
> thought it was because the updater was not appropriately registered as a
> reader. But after ensuring that is the case, it still happens in 10% of
> startups.

Which URCU flavor are you using ? You may have a thread stuck as 
being a RCU reader forever, which would cause this kind of issue. 

For instance, unbalanced rcu read-side lock/unlock, or blocking on 
poll() or other while holding a rcu read-side lock, or blocking on 
pthread_join() while holding rcu read-side lock... 

And if you use the QSBR flavor, remember that registered threads 
are by default in read-side. So you need to mark them as explicitly 
"offline" whenever you do any blocking op (e.g. poll(), blocking read(), 
pthread_join....). 

> Lastly, we wonder why it would even work correctly *at all* when we failed to
> register the updater as a reader thread.

I don't understand the context of this question. Can you provide more info ? 

Thanks, 

Mathieu 

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_1e4de41f-f182-4046-b86c-da4e5408e598
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Dec 8, 2016, at 2:53 PM, lttng-dev &lt;lttng-dev@lists.lttng.o=
rg&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockqu=
ote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px=
;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-=
family:Helvetica,Arial,sans-serif;font-size:12pt;"><div style=3D"color:#000=
; background-color:#fff; font-family:HelveticaNeue, Helvetica Neue, Helveti=
ca, Arial, Lucida Grande, sans-serif;font-size:16px"><div id=3D"yui_3_16_0_=
ym19_1_1481226442633_2947">All,</div><div id=3D"yui_3_16_0_ym19_1_148122644=
2633_2947"><br></div><div id=3D"yui_3_16_0_ym19_1_1481226442633_2947">In th=
e documentation for the create_call_rcu_data() call, we have the following =
description of the URCU_CALL_RCU_RT flag:</div><div id=3D"yui_3_16_0_ym19_1=
_1481226442633_2947"><br></div><blockquote style=3D"margin: 0 0 0 40px; bor=
der: none; padding: 0px;" id=3D"yui_3_16_0_ym19_1_1481226442633_3052"><div =
id=3D"yui_3_16_0_ym19_1_1481226442633_2947" dir=3D"ltr"><code id=3D"yui_3_1=
6_0_ym19_1_1481226442633_2989">struct call_rcu_data *create_call_rcu_data(u=
nsigned long flags, int cpu_affinity)</code><span style=3D"font-family: Tim=
es; font-size: medium;" id=3D"yui_3_16_0_ym19_1_1481226442633_2990">: Retur=
ns a handle that can be passed to the other functions in this list. The&nbs=
p;</span><code id=3D"yui_3_16_0_ym19_1_1481226442633_2991">flags</code><spa=
n style=3D"font-family: Times; font-size: medium;" id=3D"yui_3_16_0_ym19_1_=
1481226442633_2992">&nbsp;argument can be zero, or can be&nbsp;</span><code=
 id=3D"yui_3_16_0_ym19_1_1481226442633_2993">URCU_CALL_RCU_RT</code><span s=
tyle=3D"font-family: Times; font-size: medium;" id=3D"yui_3_16_0_ym19_1_148=
1226442633_2994">&nbsp;if the application threads associated with the new c=
allback-invocation thread are to get real-time response from&nbsp;</span><c=
ode id=3D"yui_3_16_0_ym19_1_1481226442633_2995">call_rcu()</code><span styl=
e=3D"font-family: Times; font-size: medium;" id=3D"yui_3_16_0_ym19_1_148122=
6442633_2996">&nbsp;by avoiding the need to call into the kernel to wake up=
 the callback-invocation thread.</span></div><div id=3D"yui_3_16_0_ym19_1_1=
481226442633_2947" dir=3D"ltr"><span style=3D"font-family: Times; font-size=
: medium;"><br></span></div></blockquote><div id=3D"yui_3_16_0_ym19_1_14812=
26442633_3169">So setting "flags" to 0 will simply use the futex mechanism =
for wakeups. What exactly happens when set to the RT option? Is there somet=
hing else that needs to be configured from the OS side to make the aforemen=
tioned option work correctly?</div></div></blockquote><div><br></div><div>N=
o, it's just that the call rcu worker thread will rely on periodic polling<=
br data-mce-bogus=3D"1"></div><div>of the call rcu work queue.<br data-mce-=
bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"=
border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;f=
ont-weight:normal;font-style:normal;text-decoration:none;font-family:Helvet=
ica,Arial,sans-serif;font-size:12pt;"><div style=3D"color:#000; background-=
color:#fff; font-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lu=
cida Grande, sans-serif;font-size:16px"><br><div id=3D"yui_3_16_0_ym19_1_14=
81226442633_3170">I'm asking because we're seeing intermittent issues where=
by on application startup, the reclamation thread (call_rcu) does exactly o=
ne cleanup, but then never does it again. &nbsp;We have the URCU_CALL_RCU_R=
T flag set. &nbsp;Originally, we thought it was because the updater was not=
 appropriately registered as a reader. But after ensuring that is the case,=
 it still happens in 10% of startups.&nbsp;</div></div></blockquote><div>Wh=
ich URCU flavor are you using ? You may have a thread stuck as<br></div><di=
v>being a RCU reader forever, which would cause this kind of issue.<br data=
-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>For instanc=
e, unbalanced rcu read-side lock/unlock, or blocking on<br></div><div>poll(=
) or other while holding a rcu read-side lock, or blocking on<br data-mce-b=
ogus=3D"1"></div><div>pthread_join() while holding rcu read-side lock...<br=
 data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>And if=
 you use the QSBR flavor, remember that registered threads<br data-mce-bogu=
s=3D"1"></div><div>are by default in read-side. So you need to mark them as=
 explicitly<br data-mce-bogus=3D"1"></div><div>"offline" whenever you do an=
y blocking op (e.g. poll(), blocking read(),<br data-mce-bogus=3D"1"></div>=
<div>pthread_join....).<br data-mce-bogus=3D"1"></div><div><br data-mce-bog=
us=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"bor=
der-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font=
-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetica=
,Arial,sans-serif;font-size:12pt;"><div style=3D"color:#000; background-col=
or:#fff; font-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucid=
a Grande, sans-serif;font-size:16px"><br><div id=3D"yui_3_16_0_ym19_1_14812=
26442633_3171">Lastly, we wonder why it would even work correctly *at all* =
when we failed to register the updater as a reader thread.</div></div></blo=
ckquote><div>I don't understand the context of this question. Can you provi=
de more info ?<br></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br=
 data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathie=
u<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div><b=
r data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquot=
e style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;c=
olor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fa=
mily:Helvetica,Arial,sans-serif;font-size:12pt;"><br>______________________=
_________________________<br>lttng-dev mailing list<br>lttng-dev@lists.lttn=
g.org<br>https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></bl=
ockquote></div><div><br></div><div data-marker=3D"__SIG_POST__">-- <br></di=
v><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div><=
/div></body></html>
--=_1e4de41f-f182-4046-b86c-da4e5408e598--

--===============8660503077552706487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8660503077552706487==--
