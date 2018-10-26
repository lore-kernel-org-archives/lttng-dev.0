From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Adding thread timestamp to event context
Date: Fri, 26 Oct 2018 05:49:12 -0400 (EDT)
Message-ID: <1085162603.770.1540547352286.JavaMail.zimbra__3646.79656127027$1540547236$gmane$org@efficios.com>
References: <CADwgpi8Nvz4--8V16mU=GoQN5z9dUSvphuSQ3eOL3m0RVYxEeQ@mail.gmail.com>
 <125123961.343.1540472537413.JavaMail.zimbra@efficios.com>
 <CADwgpi-d6gDUB4djoBu_Va-STEGu-2mLm_xfLH=FXb0cd9_O8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1126063146445070591=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42hK2f0KSPzl31
 for <lttng-dev@lists.lttng.org>; Fri, 26 Oct 2018 05:49:13 -0400 (EDT)
In-Reply-To: <CADwgpi-d6gDUB4djoBu_Va-STEGu-2mLm_xfLH=FXb0cd9_O8A@mail.gmail.com>
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

--===============1126063146445070591==
Content-Type: multipart/alternative;
	boundary="=_3d2ab24d-7168-4c5a-8d80-58f244ffe97f"

--=_3d2ab24d-7168-4c5a-8d80-58f244ffe97f
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

You are the first to show interest in this. It is not on our roadmap for the moment. 

Thanks, 

Mathieu 

----- On Oct 25, 2018, at 10:33 PM, Alok Priyadarshi <alokpr@gmail.com> wrote: 

> Thanks for your prompt response Mathieu. Can I expect this to happen soonish?

> On Thu, Oct 25, 2018 at 6:02 AM Mathieu Desnoyers < [
> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
> wrote:

>> ----- On Oct 24, 2018, at 11:05 PM, Alok Priyadarshi < [ mailto:alokpr@gmail.com
>> | alokpr@gmail.com ] > wrote:

>>> I am trying to add a thread timestamp to trace events. By thread timestamp I
>>> mean the value returned by clock_gettime(CLOCK_THREAD_CPUTIME_ID):
>>> [ https://linux.die.net/man/3/clock_gettime |
>>> https://linux.die.net/man/3/clock_gettime ]

>>> I could do this by creating custom events, but I am wondering if there is
>>> already a way to add this information to event context. I have tried using the
>>> following arguments to lttng-add-context, but none of them add any additional
>>> information:
>>> perf:cpu:cpu-cycles
>>> perf:cpu:cycles
>>> perf:thread:cpu-cycles
>>> perf:thread:cycles

>>> Note that I have only enabled userspace events. I use the following sequence of
>>> commands to capture trace:
>>> lttng create
>>> lttng enable-event --userspace --all
>>> lttng add-context --userspace -t vpid -t vtid -t perf:thread:cycles
>>> lttng start
>>> lttng stop

>> We would need to extend lttng-ust implementation and lttng-tools to add those
>> additional contexts. It would make sense to add these.

>> Thanks,

>> Mathieu

>>> _______________________________________________
>>> lttng-dev mailing list
>>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]

>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> [ http://www.efficios.com/ | http://www.efficios.com ]

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_3d2ab24d-7168-4c5a-8d80-58f244ffe97f
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>You are the first to show interest in this.=
 It is not on our roadmap for the moment.<br></div><div><br data-mce-bogus=
=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-b=
ogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br></div>=
<div><span id=3D"zwchr" data-marker=3D"__DIVIDER__">----- On Oct 25, 2018, =
at 10:33 PM, Alok Priyadarshi &lt;alokpr@gmail.com&gt; wrote:<br></span></d=
iv><div data-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2p=
x solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:nor=
mal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans=
-serif;font-size:12pt;"><div dir=3D"ltr">Thanks for your prompt response Ma=
thieu. Can I expect this to happen soonish?<br></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr">On Thu, Oct 25, 2018 at 6:02 AM Mathieu Desnoyers=
 &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">ma=
thieu.desnoyers@efficios.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><div><div style=3D"font-family:arial,helvetica,sans-serif;font-siz=
e:12pt;color:#000000"><div><span id=3D"m_236129768240517735zwchr">----- On =
Oct 24, 2018, at 11:05 PM, Alok Priyadarshi &lt;<a href=3D"mailto:alokpr@gm=
ail.com" target=3D"_blank">alokpr@gmail.com</a>&gt; wrote:<br></span></div>=
</div></div><div><div style=3D"font-family:arial,helvetica,sans-serif;font-=
size:12pt;color:#000000"><div><blockquote style=3D"border-left:2px solid #1=
010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-s=
tyle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;fon=
t-size:12pt"><div dir=3D"ltr">I am trying to add a thread timestamp to trac=
e events. By thread timestamp I mean the value returned by&nbsp;clock_getti=
me(CLOCK_THREAD_CPUTIME_ID):<div><a href=3D"https://linux.die.net/man/3/clo=
ck_gettime" target=3D"_blank">https://linux.die.net/man/3/clock_gettime</a>=
<br></div><br><div>I could do this by creating custom events, but I am wond=
ering if there is already a way to add this information to event context. I=
 have tried using the following arguments to lttng-add-context, but none of=
 them add any additional information:</div><div><div>perf:cpu:cpu-cycles</d=
iv><div>perf:cpu:cycles</div></div><div><div>perf:thread:cpu-cycles</div><d=
iv>perf:thread:cycles</div></div><br><div>Note that I have only enabled use=
rspace events. I use the following sequence of commands to capture trace:</=
div><div><div>lttng create</div><div>lttng enable-event --userspace --all</=
div><div>lttng add-context --userspace -t vpid -t vtid -t perf:thread:cycle=
s</div><div>lttng start</div><div>lttng stop</div></div></div></blockquote>=
</div></div></div><div><div style=3D"font-family:arial,helvetica,sans-serif=
;font-size:12pt;color:#000000"><div><div>We would need to extend lttng-ust =
implementation and lttng-tools to add those<br></div><div>additional contex=
ts. It would make sense to add these.<br></div><br><div>Thanks,<br></div><b=
r><div>Mathieu<br></div><br><br><blockquote style=3D"border-left:2px solid =
#1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font=
-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;f=
ont-size:12pt"><div dir=3D"ltr"><br></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-=
dev@lists.lttng.org</a><br><a href=3D"https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-bin/ma=
ilman/listinfo/lttng-dev</a><br></blockquote></div></div></div><div><div st=
yle=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;color:#000000"=
><br><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=
=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</a><=
br data-mce-bogus=3D"1"></div></div></div></blockquote></div><br></blockquo=
te></div><div><br></div><div data-marker=3D"__SIG_POST__">-- <br></div><div=
>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div><=
/body></html>
--=_3d2ab24d-7168-4c5a-8d80-58f244ffe97f--

--===============1126063146445070591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1126063146445070591==--
