From: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>
Subject: Re: SPMC Queue in URCU
Date: Mon, 6 Jun 2016 20:19:02 +0000 (UTC)
Message-ID: <897997834.5701164.1465244342476.JavaMail.yahoo__25334.1022682891$1465244370$gmane$org@mail.yahoo.com>
References: <1733955808.5920250.1465238884157.JavaMail.yahoo.ref@mail.yahoo.com>
 <1733955808.5920250.1465238884157.JavaMail.yahoo@mail.yahoo.com>
 <188943617.29620.1465243726034.JavaMail.zimbra@efficios.com>
Reply-To: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7418184843469164585=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm21-vm0.bullet.mail.bf1.yahoo.com
 (nm21-vm0.bullet.mail.bf1.yahoo.com [98.139.213.137])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id D860EA37B5
 for <lttng-dev@lists.lttng.org>; Mon,  6 Jun 2016 20:19:04 +0000 (UTC)
In-Reply-To: <188943617.29620.1465243726034.JavaMail.zimbra@efficios.com>
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

--===============7418184843469164585==
Content-Type: multipart/alternative;
	boundary="----=_Part_5701163_522825831.1465244342472"

------=_Part_5701163_522825831.1465244342472
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ah, so even the wfcqueue is a linked list under the covers? No ring buffer or other cache-friendly data structure types available?

      From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 To: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com> 
Cc: lttng-dev <lttng-dev@lists.lttng.org>
 Sent: Monday, June 6, 2016 3:08 PM
 Subject: Re: [lttng-dev] SPMC Queue in URCU
   

----- On Jun 6, 2016, at 2:48 PM, Mark E. Dawson, Jr. <medawsonjr@yahoo.com> wrote:

All,
Is there a data structure offered by Userspace RCU that provides a bounded single producer multiple consumer queue? Or are we better off just using the linked list URCU data structure despite the cpu cache implications?

Hi,
What we have in URCU is an unbounded SPMC queue (wfcqueue.h).You could theoretically use it with a counter to make it bounded, butit might not be as efficient as a bounded SPMC queue, since we usea linked list rather than a circular buffer. It would be interesting tocompare the performance of the two approaches.
Note that wfcqueue is wait-free on the enqueue, blocking on the
dequeue. It is used internally by URCU to implement the call_rcu
scheme.

Thanks,
Mathieu



_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

   
------=_Part_5701163_522825831.1465244342472
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"color:#000; background-color:#fff; f=
ont-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, =
sans-serif;font-size:16px"><div id=3D"yui_3_16_0_ym19_1_1465244153514_3520"=
><span id=3D"yui_3_16_0_ym19_1_1465244153514_3576">Ah, so even the wfcqueue=
 is a linked list under the covers? No ring buffer or other cache-friendly =
data structure types available?</span></div><div class=3D"qtdSeparateBR" id=
=3D"yui_3_16_0_ym19_1_1465244153514_3526"><br><br></div><div class=3D"yahoo=
_quoted" id=3D"yui_3_16_0_ym19_1_1465244153514_3524" style=3D"display: bloc=
k;">  <div style=3D"font-family: HelveticaNeue, Helvetica Neue, Helvetica, =
Arial, Lucida Grande, sans-serif; font-size: 16px;" id=3D"yui_3_16_0_ym19_1=
_1465244153514_3523"> <div style=3D"font-family: HelveticaNeue, Helvetica N=
eue, Helvetica, Arial, Lucida Grande, sans-serif; font-size: 16px;" id=3D"y=
ui_3_16_0_ym19_1_1465244153514_3522"> <div dir=3D"ltr" id=3D"yui_3_16_0_ym1=
9_1_1465244153514_3521"> <font size=3D"2" face=3D"Arial" id=3D"yui_3_16_0_y=
m19_1_1465244153514_3549"> <hr size=3D"1" id=3D"yui_3_16_0_ym19_1_146524415=
3514_3548"> <b><span style=3D"font-weight:bold;">From:</span></b> Mathieu D=
esnoyers &lt;mathieu.desnoyers@efficios.com&gt;<br> <b><span style=3D"font-=
weight: bold;">To:</span></b> "Mark E. Dawson, Jr." &lt;medawsonjr@yahoo.co=
m&gt; <br><b><span style=3D"font-weight: bold;">Cc:</span></b> lttng-dev &l=
t;lttng-dev@lists.lttng.org&gt;<br> <b><span style=3D"font-weight: bold;">S=
ent:</span></b> Monday, June 6, 2016 3:08 PM<br> <b><span style=3D"font-wei=
ght: bold;">Subject:</span></b> Re: [lttng-dev] SPMC Queue in URCU<br> </fo=
nt> </div> <div class=3D"y_msg_container" id=3D"yui_3_16_0_ym19_1_146524415=
3514_3554"><br><div id=3D"yiv8190243793"><div id=3D"yui_3_16_0_ym19_1_14652=
44153514_3553"><div style=3D"font-family:arial, helvetica, sans-serif;font-=
size:12pt;color:#000000;" id=3D"yui_3_16_0_ym19_1_1465244153514_3552"><div =
id=3D"yui_3_16_0_ym19_1_1465244153514_3551"><br clear=3D"none"></div><div c=
lass=3D"yiv8190243793yqt5593141440" id=3D"yiv8190243793yqt24330"><div id=3D=
"yui_3_16_0_ym19_1_1465244153514_3556"><span id=3D"yiv8190243793zwchr">----=
- On Jun 6, 2016, at 2:48 PM, Mark E. Dawson, Jr. &lt;medawsonjr@yahoo.com&=
gt; wrote:<br clear=3D"none"></span></div><div id=3D"yui_3_16_0_ym19_1_1465=
244153514_3608"><blockquote style=3D"border-left:2px solid #1010FF;margin-l=
eft:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;te=
xt-decoration:none;font-family:Helvetica, Arial, sans-serif;font-size:12pt;=
" id=3D"yui_3_16_0_ym19_1_1465244153514_3607"><div style=3D"color:#000;back=
ground-color:#fff;font-family:HelveticaNeue, Helvetica Neue, Helvetica, Ari=
al, Lucida Grande, sans-serif;font-size:16px;" id=3D"yui_3_16_0_ym19_1_1465=
244153514_3606"><div id=3D"yiv8190243793yui_3_16_0_ym19_1_1465238402299_608=
4">All,</div><div id=3D"yiv8190243793yui_3_16_0_ym19_1_1465238402299_6084">=
<br clear=3D"none"></div><div id=3D"yiv8190243793yui_3_16_0_ym19_1_14652384=
02299_6084">Is there a data structure offered by Userspace RCU that provide=
s a bounded single producer multiple consumer queue? Or are we better off j=
ust using the linked list URCU data structure despite the cpu cache implica=
tions?</div></div></blockquote><div id=3D"yui_3_16_0_ym19_1_1465244153514_3=
609"><br clear=3D"none"></div><div id=3D"yui_3_16_0_ym19_1_1465244153514_36=
11"><div id=3D"yui_3_16_0_ym19_1_1465244153514_3610">Hi,</div><div id=3D"yu=
i_3_16_0_ym19_1_1465244153514_3612"><br clear=3D"none"></div><div id=3D"yui=
_3_16_0_ym19_1_1465244153514_3613">What we have in URCU is an unbounded SPM=
C queue (wfcqueue.h).</div><div id=3D"yui_3_16_0_ym19_1_1465244153514_3614"=
>You could theoretically use it with a counter to make it bounded, but</div=
><div>it might not be as efficient as a bounded SPMC queue, since we use</d=
iv><div>a linked list rather than a circular buffer. It would be interestin=
g to</div><div>compare the performance of the two approaches.</div><div><br=
 clear=3D"none"></div><div>Note that wfcqueue is wait-free on the enqueue, =
blocking on the<br clear=3D"none"></div><div>dequeue. It is used internally=
 by URCU to implement the call_rcu<br clear=3D"none"></div><div>scheme.<br =
clear=3D"none"></div><div><br clear=3D"none"></div><div>Thanks,</div><div><=
br clear=3D"none"></div><div>Mathieu</div><div><br clear=3D"none"></div></d=
iv><div><br clear=3D"none"></div><blockquote style=3D"border-left:2px solid=
 #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;fon=
t-style:normal;text-decoration:none;font-family:Helvetica, Arial, sans-seri=
f;font-size:12pt;"><br clear=3D"none">_____________________________________=
__________<br clear=3D"none">lttng-dev mailing list<br clear=3D"none">lttng=
-dev@lists.lttng.org<br clear=3D"none">https://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev<br clear=3D"none"></blockquote></div></div><div><br =
clear=3D"none"></div><div>-- <br clear=3D"none"></div><div>Mathieu Desnoyer=
s<br clear=3D"none">EfficiOS Inc.<br clear=3D"none">http://www.efficios.com=
</div></div></div></div><br><br></div> </div> </div>  </div></div></body></=
html>
------=_Part_5701163_522825831.1465244342472--

--===============7418184843469164585==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7418184843469164585==--
