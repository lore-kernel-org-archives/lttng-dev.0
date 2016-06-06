From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: SPMC Queue in URCU
Date: Mon, 6 Jun 2016 20:08:46 +0000 (UTC)
Message-ID: <188943617.29620.1465243726034.JavaMail.zimbra__28457.4047815569$1465243751$gmane$org@efficios.com>
References: <1733955808.5920250.1465238884157.JavaMail.yahoo.ref@mail.yahoo.com>
 <1733955808.5920250.1465238884157.JavaMail.yahoo@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5873824463718565214=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id D6A94A3706
 for <lttng-dev@lists.lttng.org>; Mon,  6 Jun 2016 20:08:50 +0000 (UTC)
In-Reply-To: <1733955808.5920250.1465238884157.JavaMail.yahoo@mail.yahoo.com>
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

--===============5873824463718565214==
Content-Type: multipart/alternative;
	boundary="----=_Part_29619_558370463.1465243726033"

------=_Part_29619_558370463.1465243726033
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Jun 6, 2016, at 2:48 PM, Mark E. Dawson, Jr. <medawsonjr@yahoo.com> wrote: 

> All,

> Is there a data structure offered by Userspace RCU that provides a bounded
> single producer multiple consumer queue? Or are we better off just using the
> linked list URCU data structure despite the cpu cache implications?

Hi, 

What we have in URCU is an unbounded SPMC queue (wfcqueue.h). 
You could theoretically use it with a counter to make it bounded, but 
it might not be as efficient as a bounded SPMC queue, since we use 
a linked list rather than a circular buffer. It would be interesting to 
compare the performance of the two approaches. 

Note that wfcqueue is wait-free on the enqueue, blocking on the 
dequeue. It is used internally by URCU to implement the call_rcu 
scheme. 

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

------=_Part_29619_558370463.1465243726033
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><span id=3D"zwchr" data-mark=
er=3D"__DIVIDER__">----- On Jun 6, 2016, at 2:48 PM, Mark E. Dawson, Jr. &l=
t;medawsonjr@yahoo.com&gt; wrote:<br></span></div><div data-marker=3D"__QUO=
TED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:=
5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-d=
ecoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div=
 style=3D"color:#000; background-color:#fff; font-family:HelveticaNeue, Hel=
vetica Neue, Helvetica, Arial, Lucida Grande, sans-serif;font-size:16px"><d=
iv id=3D"yui_3_16_0_ym19_1_1465238402299_6084">All,</div><div id=3D"yui_3_1=
6_0_ym19_1_1465238402299_6084"><br></div><div id=3D"yui_3_16_0_ym19_1_14652=
38402299_6084">Is there a data structure offered by Userspace RCU that prov=
ides a bounded single producer multiple consumer queue? Or are we better of=
f just using the linked list URCU data structure despite the cpu cache impl=
ications?</div></div></blockquote><div><br></div><div><div>Hi,</div><div><b=
r></div><div>What we have in URCU is an unbounded SPMC queue (wfcqueue.h).<=
/div><div>You could theoretically use it with a counter to make it bounded,=
 but</div><div>it might not be as efficient as a bounded SPMC queue, since =
we use</div><div>a linked list rather than a circular buffer. It would be i=
nteresting to</div><div>compare the performance of the two approaches.</div=
><div><br data-mce-bogus=3D"1"></div><div>Note that wfcqueue is wait-free o=
n the enqueue, blocking on the<br data-mce-bogus=3D"1"></div><div>dequeue. =
It is used internally by URCU to implement the call_rcu<br data-mce-bogus=
=3D"1"></div><div>scheme.<br data-mce-bogus=3D"1"></div><div><br></div><div=
>Thanks,</div><div><br></div><div>Mathieu</div><div><br></div></div><div><b=
r data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #10=
10FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-st=
yle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font=
-size:12pt;"><br>_______________________________________________<br>lttng-d=
ev mailing list<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi=
-bin/mailman/listinfo/lttng-dev<br></blockquote></div><div><br></div><div d=
ata-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS=
 Inc.<br>http://www.efficios.com</div></div></body></html>
------=_Part_29619_558370463.1465243726033--

--===============5873824463718565214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5873824463718565214==--
