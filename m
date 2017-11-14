From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Channel buffer allocation
Date: Tue, 14 Nov 2017 00:19:30 +0000 (UTC)
Message-ID: <124557787.14370.1510618770915.JavaMail.zimbra__28065.1868939914$1510618738$gmane$org@efficios.com>
References: <CALVR4zA3F2RWH+Zc4Nddn59JnOfqxjjDJtS_0rJs1=+xjtZk6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3642965680499592714=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3ybSmB1WTmz166W
 for <lttng-dev@lists.lttng.org>; Tue, 14 Nov 2017 00:18:49 +0000 (UTC)
In-Reply-To: <CALVR4zA3F2RWH+Zc4Nddn59JnOfqxjjDJtS_0rJs1=+xjtZk6A@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Nalin Pai <nalinpai@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3642965680499592714==
Content-Type: multipart/alternative;
	boundary="=_c0a3594c-0dd3-48fa-9f6a-27de2187f611"

--=_c0a3594c-0dd3-48fa-9f6a-27de2187f611
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Nov 13, 2017, at 1:40 PM, Nalin Pai <nalinpai@gmail.com> wrote: 

> Hi,
> In the per-pid buffer scheme, when are the ring buffers allocated for each pid?
> Is it when a channel is created or is it an event provided by that process is
> enabled for a specific channel.

In per-pid buffers, the buffers are allocated for each registered process whenever 
each of those process is registered (typically at program launch). Buffer allocation 
of per-pid buffers brings a significant overhead on systems with short-lived processes. 
Using "per-uid" buffers is recommended instead in those situations. 

> I am trying to understand whether there is an overhead to creating many
> channels. Will a process incur the allocation of buffers for a channel that is
> not interested in any of the events that the process is providing?

Yes, a process will have to allocate buffers if it's registered to lttng-sessiond, even if 
it does not contain any event enabled for that channel. This is needed to handle 
dynamically loaded libraries for instance, which may add additional events into a 
process after its initial constructor execution. 

Thanks, 

Mathieu 

> -Nalin

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_c0a3594c-0dd3-48fa-9f6a-27de2187f611
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><div><span id=3D"z=
wchr" data-marker=3D"__DIVIDER__">----- On Nov 13, 2017, at 1:40 PM, Nalin =
Pai &lt;nalinpai@gmail.com&gt; wrote:<br></span></div><div data-marker=3D"_=
_QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-l=
eft:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;te=
xt-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;">=
<div dir=3D"ltr">Hi,<br><div>In the per-pid buffer scheme, when are the rin=
g buffers allocated for each pid? Is it when a channel is created or is it =
an event provided by that process is enabled for a specific channel.</div><=
/div></blockquote><div><br></div><div>In per-pid buffers, the buffers are a=
llocated for each registered process whenever<br data-mce-bogus=3D"1"></div=
><div>each of those process is registered (typically at program launch). Bu=
ffer allocation<br data-mce-bogus=3D"1"></div><div>of per-pid buffers bring=
s a significant overhead on systems with short-lived processes.<br data-mce=
-bogus=3D"1"></div><div>Using "per-uid" buffers is recommended instead in t=
hose situations.<br data-mce-bogus=3D"1"></div><blockquote style=3D"border-=
left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-wei=
ght:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Ari=
al,sans-serif;font-size:12pt;"><div dir=3D"ltr"><br><div>I am trying to und=
erstand whether there is an overhead to creating many channels. Will a proc=
ess incur the allocation of buffers for a channel that is not interested in=
 any of the events that the process is providing?</div></div></blockquote><=
div>Yes, a process will have to allocate buffers if it's registered to lttn=
g-sessiond, even if<br></div><div>it does not contain any event enabled for=
 that channel. This is needed to handle<br data-mce-bogus=3D"1"></div><div>=
dynamically loaded libraries for instance, which may add additional events =
into a<br data-mce-bogus=3D"1"></div><div>process after its initial constru=
ctor execution.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"=
></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-b=
ogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"b=
order-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;fo=
nt-weight:normal;font-style:normal;text-decoration:none;font-family:Helveti=
ca,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><br><div>-Nalin</div>=
<br></div><br>_______________________________________________<br>lttng-dev =
mailing list<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bi=
n/mailman/listinfo/lttng-dev<br></blockquote></div><div><br></div><div data=
-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS In=
c.<br>http://www.efficios.com</div></div></body></html>
--=_c0a3594c-0dd3-48fa-9f6a-27de2187f611--

--===============3642965680499592714==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3642965680499592714==--
