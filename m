From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Adding thread timestamp to event context
Date: Thu, 25 Oct 2018 09:02:17 -0400 (EDT)
Message-ID: <125123961.343.1540472537413.JavaMail.zimbra__44929.085209924$1540472429$gmane$org@efficios.com>
References: <CADwgpi8Nvz4--8V16mU=GoQN5z9dUSvphuSQ3eOL3m0RVYxEeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7885584927417509912=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42gnN145FyzgS5
 for <lttng-dev@lists.lttng.org>; Thu, 25 Oct 2018 09:02:25 -0400 (EDT)
In-Reply-To: <CADwgpi8Nvz4--8V16mU=GoQN5z9dUSvphuSQ3eOL3m0RVYxEeQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Alok Priyadarshi <alokpr@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7885584927417509912==
Content-Type: multipart/alternative;
	boundary="=_581c9afe-d63e-4220-9b3d-5c5f0d93a30b"

--=_581c9afe-d63e-4220-9b3d-5c5f0d93a30b
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Oct 24, 2018, at 11:05 PM, Alok Priyadarshi <alokpr@gmail.com> wrote: 

> I am trying to add a thread timestamp to trace events. By thread timestamp I
> mean the value returned by clock_gettime(CLOCK_THREAD_CPUTIME_ID):
> [ https://linux.die.net/man/3/clock_gettime |
> https://linux.die.net/man/3/clock_gettime ]

> I could do this by creating custom events, but I am wondering if there is
> already a way to add this information to event context. I have tried using the
> following arguments to lttng-add-context, but none of them add any additional
> information:
> perf:cpu:cpu-cycles
> perf:cpu:cycles
> perf:thread:cpu-cycles
> perf:thread:cycles

> Note that I have only enabled userspace events. I use the following sequence of
> commands to capture trace:
> lttng create
> lttng enable-event --userspace --all
> lttng add-context --userspace -t vpid -t vtid -t perf:thread:cycles
> lttng start
> lttng stop

We would need to extend lttng-ust implementation and lttng-tools to add those 
additional contexts. It would make sense to add these. 

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

--=_581c9afe-d63e-4220-9b3d-5c5f0d93a30b
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Oct 24, 2018, at 11:05 PM, Alok Priyadarshi &lt;alokpr@gmail.c=
om&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockqu=
ote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px=
;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-=
family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr">I am tr=
ying to add a thread timestamp to trace events. By thread timestamp I mean =
the value returned by&nbsp;clock_gettime(CLOCK_THREAD_CPUTIME_ID):<div><a h=
ref=3D"https://linux.die.net/man/3/clock_gettime" target=3D"_blank">https:/=
/linux.die.net/man/3/clock_gettime</a><br></div><br><div>I could do this by=
 creating custom events, but I am wondering if there is already a way to ad=
d this information to event context. I have tried using the following argum=
ents to lttng-add-context, but none of them add any additional information:=
</div><div><div>perf:cpu:cpu-cycles</div><div>perf:cpu:cycles</div></div><d=
iv><div>perf:thread:cpu-cycles</div><div>perf:thread:cycles</div></div><br>=
<div>Note that I have only enabled userspace events. I use the following se=
quence of commands to capture trace:</div><div><div>lttng create</div><div>=
lttng enable-event --userspace --all</div><div>lttng add-context --userspac=
e -t vpid -t vtid -t perf:thread:cycles</div><div>lttng start</div><div>ltt=
ng stop</div></div></div></blockquote><div>We would need to extend lttng-us=
t implementation and lttng-tools to add those<br></div><div>additional cont=
exts. It would make sense to add these.<br data-mce-bogus=3D"1"></div><div>=
<br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><=
div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></d=
iv><div><br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div>=
<blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-=
left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:no=
ne;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"=
><br></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_581c9afe-d63e-4220-9b3d-5c5f0d93a30b--

--===============7885584927417509912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7885584927417509912==--
