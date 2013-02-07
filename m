From: =?UTF-8?B?6LW15a6H6b6Z?= <zylthinking@gmail.com>
Subject: my user space rcu code
Date: Thu, 7 Feb 2013 18:02:14 +0800
Message-ID: <CAEYCTcJjofYAfDQTYRtVOUQedfnm0TnNKBXwAUGMcd07fM2gFA__43396.5952754535$1360250045$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0745176043=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f50.google.com ([209.85.215.50])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <zylthinking@gmail.com>) id 1U3OJV-0005ol-KB
	for lttng-dev@lists.lttng.org; Thu, 07 Feb 2013 05:02:41 -0500
Received: by mail-la0-f50.google.com with SMTP id ec20so2420738lab.9
	for <lttng-dev@lists.lttng.org>; Thu, 07 Feb 2013 02:02:35 -0800 (PST)
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

--===============0745176043==
Content-Type: multipart/alternative; boundary=e89a8f234685bb0cb804d51f8ae4

--e89a8f234685bb0cb804d51f8ae4
Content-Type: text/plain; charset=UTF-8

Hi,

I write a user space rcu, code at
https://github.com/zylthinking/tools/blob/master/rcu.h
https://github.com/zylthinking/tools/blob/master/rcu.c.

I notice the main difference  with liburcu should be I use a daemon thread
to do works such as waking up sleepers, while the liburcu does not.

I wonder why we can't use such a thread. When we use it, the
rcu_read_(un)lock will not includes wake up writers any more. which will
help to improve performance. It is the cost of such a daemon thread is too
high?

zhao yulong

--e89a8f234685bb0cb804d51f8ae4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div style>I write a user space rcu, cod=
e at=C2=A0</div><div style><a href=3D"https://github.com/zylthinking/tools/=
blob/master/rcu.h">https://github.com/zylthinking/tools/blob/master/rcu.h</=
a><br>

</div><div style><a href=3D"https://github.com/zylthinking/tools/blob/maste=
r/rcu.c">https://github.com/zylthinking/tools/blob/master/rcu.c</a>.</div><=
div style><br></div><div style>I notice the main difference =C2=A0with libu=
rcu should be I use a daemon thread to do works such as waking up sleepers,=
 while the liburcu does not.</div>

<div style><br></div><div style>I wonder why we can&#39;t use such a thread=
. When we use it, the rcu_read_(un)lock will not includes wake up writers a=
ny more. which will help to=C2=A0improve=C2=A0performance. It is the=C2=A0c=
ost of such a daemon thread=C2=A0is too high?</div>

<div style><br></div><div style>zhao yulong</div></div>

--e89a8f234685bb0cb804d51f8ae4--


--===============0745176043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0745176043==--
