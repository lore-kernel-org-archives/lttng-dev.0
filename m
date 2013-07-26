From: =?ISO-8859-1?Q?Martin_=DCnsal?= <martinunsal@gmail.com>
Subject: Questions about LTTNG_UST_REGISTER_TIMEOUT
Date: Fri, 26 Jul 2013 12:29:08 -0700
Message-ID: <CACsXv7Dfq5h+69JL2ZuiW2xto7Cfm9ABaUKF0eV-yT-8_ooDQQ__32597.7241890088$1374867010$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0822085075=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f177.google.com ([209.85.128.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <martinunsal@gmail.com>) id 1V2nhR-0006xl-IP
	for lttng-dev@lists.lttng.org; Fri, 26 Jul 2013 15:29:19 -0400
Received: by mail-ve0-f177.google.com with SMTP id cz10so1565622veb.36
	for <lttng-dev@lists.lttng.org>; Fri, 26 Jul 2013 12:29:08 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0822085075==
Content-Type: multipart/alternative; boundary=001a11c3da000e805304e26f281c

--001a11c3da000e805304e26f281c
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

I am a new lttng-ust user. I would like to leave tracepoints compiled into
production code. I have verified that inactive tracepoints have extremely
low overhead, but I am concerned about startup time and
LTTNG_UST_REGISTER_TIMEOUT. Our typical use case is that we are not tracing
and there is no lttng-sessiond, we enable tracing only in development or QA.

The specific questions:

1) What scenarios might the timeout come into play? I have tested with and
without lttng-sessiond running and I have seen no more than 10ms overhead
during app startup caused by lttng. That's no problem, but if there is some
unforeseen scenario where I introduce 3s overhead I am in a world of hurt!

2) If I set LTTNG_UST_REGISTER_TIMEOUT=0, what scenario would this fail and
how would it fail? (Silently or detectably?)

Actually I think these are more or less the same question viewed from two
different angles.

Thanks much. BTW I should say, I've been doing coordinated userspace and
kernel tracing for performance issues in Linux for many, many years using a
variety of homegrown tools and LTTng is fantastic, just the right feature
set and excellent performance. It's what I wish I'd built. :)

Martin

--001a11c3da000e805304e26f281c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-family:arial,sans-serif;font-size:13px=
">Hi all,</span><div style=3D"font-family:arial,sans-serif;font-size:13px">=
<br></div><div style=3D"font-family:arial,sans-serif;font-size:13px">I am a=
 new lttng-ust user. I would like to leave tracepoints compiled into produc=
tion code. I have verified that inactive tracepoints have extremely low ove=
rhead, but I am concerned about startup time and LTTNG_UST_REGISTER_TIMEOUT=
. Our typical use case is that we are not tracing and there is no lttng-ses=
siond, we enable tracing only in development or QA.</div>
<div style=3D"font-family:arial,sans-serif;font-size:13px"><br></div><div s=
tyle=3D"font-family:arial,sans-serif;font-size:13px">The specific questions=
:</div><div style=3D"font-family:arial,sans-serif;font-size:13px"><br></div=
><div style=3D"font-family:arial,sans-serif;font-size:13px">
1) What scenarios might the timeout come into play? I have tested with and =
without lttng-sessiond running and I have seen no more than 10ms overhead d=
uring app startup caused by lttng. That&#39;s no problem, but if there is s=
ome unforeseen scenario where I introduce 3s overhead I am in a world of hu=
rt!</div>
<div style=3D"font-family:arial,sans-serif;font-size:13px"><br></div><div s=
tyle=3D"font-family:arial,sans-serif;font-size:13px">2) If I set LTTNG_UST_=
REGISTER_TIMEOUT=3D0, what scenario would this fail and how would it fail? =
(Silently or detectably?)</div>
<div style=3D"font-family:arial,sans-serif;font-size:13px"><br></div><div s=
tyle=3D"font-family:arial,sans-serif;font-size:13px">Actually I think these=
 are more or less the same question viewed from two different angles.</div>
<div style=3D"font-family:arial,sans-serif;font-size:13px"><br></div><div s=
tyle=3D"font-family:arial,sans-serif;font-size:13px">Thanks much. BTW I sho=
uld say, I&#39;ve been doing coordinated userspace and kernel tracing for p=
erformance issues in Linux for many, many years using a variety of homegrow=
n tools and LTTng is fantastic, just the right feature set and excellent pe=
rformance. It&#39;s what I wish I&#39;d built. :)</div>
<div style=3D"font-family:arial,sans-serif;font-size:13px"><br></div><div s=
tyle=3D"font-family:arial,sans-serif;font-size:13px">Martin</div><div style=
=3D"font-family:arial,sans-serif;font-size:13px"><br></div></div>

--001a11c3da000e805304e26f281c--


--===============0822085075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0822085075==--
