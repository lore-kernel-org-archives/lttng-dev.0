From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: process/thread-specific UST tracing
Date: Fri, 15 May 2020 15:15:16 -0400 (EDT)
Message-ID: <996953575.22598.1589570116107.JavaMail.zimbra@efficios.com>
References: <CACJEY85H4OMTz9ggfZZP3QCXoWgLiJgsMVNTP8LNBAF67mQTEQ@mail.gmail.com>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2140998864923875700=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49Nyvh269Mz23xj
 for <lttng-dev@lists.lttng.org>; Fri, 15 May 2020 15:21:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A080F2B2256
 for <lttng-dev@lists.lttng.org>; Fri, 15 May 2020 15:15:16 -0400 (EDT)
In-Reply-To: <CACJEY85H4OMTz9ggfZZP3QCXoWgLiJgsMVNTP8LNBAF67mQTEQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yonghong Yan <yanyh15@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2140998864923875700==
Content-Type: multipart/alternative;
	boundary="=_805e3d30-41da-4d66-bb38-41b754ace32c"

--=_805e3d30-41da-4d66-bb38-41b754ace32c
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On May 15, 2020, at 1:16 PM, lttng-dev <lttng-dev@lists.lttng.org> wrote: 

> I am tracing a multiprocess/multithreaded code (MPI/OpenMP) using lttng-ust.
> Right now, I need to include process id and thread id for each event in order
> to generate process/thread indexed view of the traces. Is there a way that I
> can store per-process events into a specific buffer without mixing the events
> with other events that are generated on the same CPU? The same thing for
> per-thread events, I would like lttng or CTF to allow to store per-thread
> events in a specific buffer without mixing the events with other events on the
> same CPU channel. With that feature, I do not need to store process id and
> thread id in each event and then need to query all the events in order to
> collect per-process or per-thread event.

No, but you can use kernel tracing (lttng-modules) of the scheduler events (sched:*) to map 
the CPU number to the currently running thread and process at trace post-processing. 

By doing so, both current thread and process become implicit with the CPU number. 

Thanks, 

Mathieu 

> Thank you
> Yonghong

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_805e3d30-41da-4d66-bb38-41b754ace32c
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><div><span id=3D"z=
wchr" data-marker=3D"__DIVIDER__">----- On May 15, 2020, at 1:16 PM, lttng-=
dev &lt;lttng-dev@lists.lttng.org&gt; wrote:<br></span></div><div data-mark=
er=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;m=
argin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:no=
rmal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:=
12pt;"><div dir=3D"ltr">I am tracing a multiprocess/multithreaded code (MPI=
/OpenMP) using lttng-ust. Right now, I need to include process id and threa=
d id for each event in order to&nbsp;generate process/thread indexed view o=
f the traces. Is there a way that I can store per-process events into a spe=
cific buffer without mixing the events with other events that are generated=
 on the same CPU? The same thing for per-thread events, I would like lttng =
or CTF to allow to store per-thread events in a specific buffer without mix=
ing the events with other events on the same CPU channel. With that feature=
, I do not need to store process id and thread id in each event and then ne=
ed to query all the events in order to collect per-process or per-thread ev=
ent.&nbsp;</div></blockquote><div>No, but you can use kernel tracing (lttng=
-modules) of the scheduler events (sched:*) to map</div><div>the CPU number=
 to the currently running thread and process at trace post-processing.<br d=
ata-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>By doing=
 so, both current thread and process become implicit with the CPU number.<b=
r data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thank=
s,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>M=
athieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><d=
iv><br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><bloc=
kquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:=
5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;fo=
nt-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><br>=
<div>Thank you</div><div>Yonghong</div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_805e3d30-41da-4d66-bb38-41b754ace32c--

--===============2140998864923875700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2140998864923875700==--
