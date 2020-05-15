From: Yonghong Yan via lttng-dev <lttng-dev@lists.lttng.org>
Subject: process/thread-specific UST tracing
Date: Fri, 15 May 2020 13:16:47 -0400
Message-ID: <CACJEY85H4OMTz9ggfZZP3QCXoWgLiJgsMVNTP8LNBAF67mQTEQ@mail.gmail.com>
Reply-To: Yonghong Yan <yanyh15@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8374015916871231770=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 by lists.lttng.org (Postfix) with ESMTPS id 49Nw7b3HgLz2411
 for <lttng-dev@lists.lttng.org>; Fri, 15 May 2020 13:16:59 -0400 (EDT)
Received: by mail-il1-x130.google.com with SMTP id j3so3268118ilk.11
 for <lttng-dev@lists.lttng.org>; Fri, 15 May 2020 10:16:59 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============8374015916871231770==
Content-Type: multipart/alternative; boundary="0000000000000e13fe05a5b2fba7"

--0000000000000e13fe05a5b2fba7
Content-Type: text/plain; charset="UTF-8"

I am tracing a multiprocess/multithreaded code (MPI/OpenMP) using
lttng-ust. Right now, I need to include process id and thread id for each
event in order to generate process/thread indexed view of the traces. Is
there a way that I can store per-process events into a specific buffer
without mixing the events with other events that are generated on the same
CPU? The same thing for per-thread events, I would like lttng or CTF to
allow to store per-thread events in a specific buffer without mixing the
events with other events on the same CPU channel. With that feature, I do
not need to store process id and thread id in each event and then need to
query all the events in order to collect per-process or per-thread event.

Thank you
Yonghong

--0000000000000e13fe05a5b2fba7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I am tracing a multiprocess/multithreaded code (MPI/OpenMP=
) using lttng-ust. Right now, I need to include process id and thread id fo=
r each event in order to=C2=A0generate process/thread indexed view of the t=
races. Is there a way that I can store per-process events into a specific b=
uffer without mixing the events with other events that are generated on the=
 same CPU? The same thing for per-thread events, I would like lttng or CTF =
to allow to store per-thread events in a specific buffer without mixing the=
 events with other events on the same CPU channel. With that feature, I do =
not need to store process id and thread id in each event and then need to q=
uery all the events in order to collect per-process or per-thread event.=C2=
=A0<div><br></div><div>Thank you</div><div>Yonghong<div><div><div dir=3D"lt=
r" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D=
"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"ltr"><div dir=
=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"></div><div dir=3D"ltr"><div dir=
=3D"ltr"><p style=3D"font-size:12.8px"></p></div><div dir=3D"ltr"></div></d=
iv></div></div></div></div></div></div></div></div></div></div></div></div>=
</div>

--0000000000000e13fe05a5b2fba7--

--===============8374015916871231770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8374015916871231770==--
