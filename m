From: Vivek Kumar <vivekkumar.p@gmail.com>
Subject: Issue faced in logging the traces
Date: Fri, 15 Feb 2013 14:22:36 +0530
Message-ID: <CAG15VGA_O+6P9cLT8h3U-_W=YUVHEVFiBN5Zrm6Gj4i1qBV6BQ__10821.8293208212$1360930689$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0351272775=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f53.google.com ([209.85.212.53])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <vivekkumar.p@gmail.com>) id 1U6H2A-000889-4w
	for lttng-dev@lists.lttng.org; Fri, 15 Feb 2013 03:52:42 -0500
Received: by mail-vb0-f53.google.com with SMTP id fj18so2023027vbb.40
	for <lttng-dev@lists.lttng.org>; Fri, 15 Feb 2013 00:52:36 -0800 (PST)
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

--===============0351272775==
Content-Type: multipart/alternative; boundary=20cf307ac86736e6d804d5bf7f28

--20cf307ac86736e6d804d5bf7f28
Content-Type: text/plain; charset=UTF-8

Hi,

I am trying to port LTTng to my arm based board.
For userspace tracing, I have been able to successfully port followings:
LTTng-tools,
LTT-ust Library
Userspace-rcu
libpopt

Now I can see that lttng-sessiond is running, and am able to create
sessions, enable-event and start and stop tracing.
But, I don't see traces be logged in the home directory (indeed nothing
happens, i.e, not even the creation of the base directory -> lttng-traces).
Am I missing anything because of that LTTng is failing to log traces?
Please help.

Regards, Vivek


-- 
Best, Vivek

--20cf307ac86736e6d804d5bf7f28
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div><div>=C2=A0</div><div>I am trying to port LTTng to my arm bas=
ed board.</div><div>For userspace tracing, I have been able to successfully=
 port followings:</div><div>LTTng-tools,</div><div>LTT-ust Library</div><di=
v>
Userspace-rcu</div><div>libpopt</div><div>=C2=A0</div><div>Now I can see th=
at lttng-sessiond is running, and am able to create sessions, enable-event =
and start and stop tracing.</div><div>But, I don&#39;t see traces be logged=
 in the home directory (indeed nothing happens, i.e, not even the creation =
of the base directory -&gt;=C2=A0lttng-traces).</div>
<div>Am I missing anything because of that LTTng is failing to log traces?<=
/div><div>Please help.</div><div>=C2=A0</div><div>Regards, Vivek</div><div>=
<br clear=3D"all"><br>-- <br>Best, Vivek
</div>

--20cf307ac86736e6d804d5bf7f28--


--===============0351272775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0351272775==--
