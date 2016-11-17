From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: How do tracepoint macros interact with the
 optimizer?
Date: Thu, 17 Nov 2016 16:50:06 +0000 (UTC)
Message-ID: <32594678.5908.1479401406952.JavaMail.zimbra__43040.6494685032$1479401369$gmane$org@efficios.com>
References: <CAGYXaSbnjG1Sh8bx5B2vcsAsfaOKo66yr6-Lt+saZPuuyAJDpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0848579426043097015=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tKRvL6M0Gzmdw
 for <lttng-dev@lists.lttng.org>; Thu, 17 Nov 2016 16:50:22 +0000 (UTC)
In-Reply-To: <CAGYXaSbnjG1Sh8bx5B2vcsAsfaOKo66yr6-Lt+saZPuuyAJDpg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Evgeny Roubinchtein <zhenya1007@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0848579426043097015==
Content-Type: multipart/alternative;
	boundary="=_8192f777-2905-48d9-9f71-5c2467841967"

--=_8192f777-2905-48d9-9f71-5c2467841967
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

---- On Nov 17, 2016, at 10:34 AM, Evgeny Roubinchtein <zhenya1007@gmail.com> wrote: 

> Dear LTTNG users and developers,
> I would like to know how the tracepoint macro interacts with the compiler's code
> optimizer (I am specifically interested in GCC 4.9 if that makes a difference).

> Suppose I add a tracepoint to the section of code that the optimizer would have
> eliminated, and then compile with optimization. What happens? Does the
> optimizer eliminate the statement(s) that the tracepoint macro expands to? Or
> does the tracepoint macro do something to force the optimizer to keep the
> statement(s) in? (e.g., declare some variable volatile, or some moral
> equivalent).

If you put a tracepoint in dead code, it will prevent dead code elimination, because 
the code is not dead anymore: it now has a side-effect, which is to call the tracepoint 
callbacks if there are any ever connected. Also, reading the "state" variable is done 
with a volatile load, which is considered as another side-effect. 

> Now essentially the same question about local variables. To make things simple,
> let's imagine that my tracepoint definition has a single variable declared
> inside TP_ARGS, i.e., something like:
> TRACEPOINT_EVENT (
> my_provider, my_trace_point
> TP_ARGS (int, foo_arg),
> TP_FIELDS( ctf_integer(int, foo, foo_arg)))
> Let's also imagine that, in my code, I have an automatic local variable, (let's
> call it `bar`) that would normally be "optimized out", and I add a tracepoint
> statement that references "bar", and compile with optimization. What happens?
> Specifically, can it happen that the optimizer is now prevented from
> "optimizing out" `bar`, and is, e.g., forced to stack-allocated it (rather than
> keeping it in a register, or whatever other techniques it employs to "optimize
> it out").

Adding a tracepoint adds liveness contraints (this is on purpose). 
So it may increase register pressure, or in some situations require 
to save/reload the variable from the stack, but note that such reload 
would be done within the "unlikely" if() branch, so loading such variable 
from the stack would only affect "tracing active" case. 

As a rule of thumb, you may want to keep your static tracepoints 
close to where variables are actually used by the application. 

Another aspect to consider with respect to optimisations: if you 
put a tracepoint in a "leaf" function, the function call of the tracepoint 
turns it into a non-leaf function. 

Those are very relevant questions :) Let me know if you need 
further clarification. 

Thanks, 

Mathieu 

> Please Cc me on replies as I am not subscribed to the list.

> Thank you in advance!

> --
> Best,
> Zhenya

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_8192f777-2905-48d9-9f71-5c2467841967
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">---- On Nov 17, 2016, at 10:34 AM, Evgeny Roubinchtein &lt;zhenya1007@g=
mail.com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><b=
lockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-le=
ft:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none=
;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr">D=
ear LTTNG users and developers,<br><div>I would like to know how the tracep=
oint macro interacts with the compiler's code optimizer (I am specifically =
interested in GCC 4.9 if that makes a difference). &nbsp;</div><br><div>Sup=
pose I add a tracepoint to the section of code that the optimizer would hav=
e eliminated, and then compile with optimization.&nbsp; What happens?&nbsp;=
 Does the optimizer eliminate the statement(s) that the tracepoint macro ex=
pands to?&nbsp; Or does the tracepoint macro do something to force the opti=
mizer to keep the statement(s) in? (e.g., declare some variable volatile, o=
r some moral equivalent).</div></div></blockquote><div>If you put a tracepo=
int in dead code, it will prevent dead code elimination, because</div><div>=
 the code is not dead anymore: it now has a side-effect, which is to call t=
he tracepoint</div><div>callbacks if there are any ever connected. Also, re=
ading the "state" variable is done<br></div><div>with a volatile load, whic=
h is considered as another side-effect.<br data-mce-bogus=3D"1"></div><div>=
<br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #=
1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-=
style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;fo=
nt-size:12pt;"><div dir=3D"ltr"><div>Now essentially the same question abou=
t local variables.&nbsp; To make things simple, let's imagine that my trace=
point definition has a single variable declared inside TP_ARGS, i.e., somet=
hing like:</div><div>TRACEPOINT_EVENT (<br></div><div>&nbsp; &nbsp; &nbsp; =
my_provider, &nbsp;my_trace_point</div><div>&nbsp; &nbsp; &nbsp; TP_ARGS (i=
nt, foo_arg),</div><div>&nbsp; &nbsp; &nbsp; &nbsp;TP_FIELDS( ctf_integer(i=
nt, foo, foo_arg)))</div><div>Let's also imagine that, in my code, I have a=
n automatic local variable, (let's call it `bar`) that would normally be "o=
ptimized out", and I add a tracepoint statement that references "bar", and =
compile with optimization.&nbsp; What happens?&nbsp; Specifically, can it h=
appen that the optimizer is now prevented from "optimizing out" `bar`, and =
is, e.g., forced to stack-allocated it (rather than keeping it in a registe=
r, or whatever other techniques it employs to "optimize it out").</div></di=
v></blockquote><div>Adding a tracepoint adds liveness contraints (this is o=
n purpose).<br></div><div>So it may increase register pressure, or in some =
situations require</div><div>to save/reload the variable from the stack, bu=
t note that such reload</div><div>would be done within the "unlikely" if() =
branch, so loading such variable</div><div>from the stack would only affect=
 "tracing active" case.<br data-mce-bogus=3D"1"></div><div><br data-mce-bog=
us=3D"1"></div><div>As a rule of thumb, you may want to keep your static tr=
acepoints<br data-mce-bogus=3D"1"></div><div>close to where variables are a=
ctually used by the application.<br data-mce-bogus=3D"1"></div><div><br dat=
a-mce-bogus=3D"1"></div><div>Another aspect to consider with respect to opt=
imisations: if you</div><div>put a tracepoint in a "leaf" function, the fun=
ction call of the tracepoint</div><div>turns it into a non-leaf function.<b=
r data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Those=
 are very relevant questions :) Let me know if you need<br data-mce-bogus=
=3D"1"></div><div>further clarification.<br data-mce-bogus=3D"1"></div><div=
><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div>=
<div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></=
div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2p=
x solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:nor=
mal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans=
-serif;font-size:12pt;"><div dir=3D"ltr"><br><div>Please Cc me on replies a=
s I am not subscribed to the list.</div><br><div>Thank you in advance!</div=
><br><div>--&nbsp;</div><div>Best,</div><div>Zhenya</div></div><br>________=
_______________________________________<br>lttng-dev mailing list<br>lttng-=
dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/listinfo/ltt=
ng-dev<br></blockquote></div><div><br></div><div data-marker=3D"__SIG_POST_=
_">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.effic=
ios.com</div></div></body></html>
--=_8192f777-2905-48d9-9f71-5c2467841967--

--===============0848579426043097015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0848579426043097015==--
