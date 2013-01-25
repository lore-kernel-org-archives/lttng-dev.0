From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Sync instrumentation to today's linux 3.8
Date: Fri, 25 Jan 2013 17:10:26 -0500
Message-ID: <CAC6yHM5Vd8zZc-1nmFuVfuxiH3yUwA+mNUd6cejZFfvFb4kURw__27742.3266125426$1359151881$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0414423026=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1TyrTk-0003q6-07
	for lttng-dev@lists.lttng.org; Fri, 25 Jan 2013 17:10:32 -0500
Received: by mail-ia0-f169.google.com with SMTP id j5so1412961iaf.0
	for <lttng-dev@lists.lttng.org>; Fri, 25 Jan 2013 14:10:26 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0414423026==
Content-Type: multipart/alternative; boundary=e89a8f3baa43d0c9e504d424312f

--e89a8f3baa43d0c9e504d424312f
Content-Type: text/plain; charset=ISO-8859-1

To prepare instrumentation for the next linux release, here is the ticket I
was working on. It's mostly straight forward.

http://redmine.dorsal.polymtl.ca/issues/431

There is one issue with ext4 includes. I had to copy fs/ext4/ext4.h and
ext4_extent.h for the function ext4_ext_get_actual_len(). I added them to
instrumentation/mainline/fs/ext4 directory. I'm not sure if it's the best
solution.

Still testing to do, thought. BTW, is there a test setup for regression? I
would like to verify that it doesn't break any supported kernel and I don't
have the required setup.

With this, maybe lttng-modules 2.1 can target linux 3.8?

Cheers,

Francis

--e89a8f3baa43d0c9e504d424312f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">To prepare instrumentation for the next linux release, her=
e is the ticket I was working on. It&#39;s mostly straight forward.=A0<div>=
<br></div><div><a href=3D"http://redmine.dorsal.polymtl.ca/issues/431">http=
://redmine.dorsal.polymtl.ca/issues/431</a><br>
<div><br></div><div>There is one issue with ext4 includes. I had to copy fs=
/ext4/ext4.h and ext4_extent.h for the function=A0ext4_ext_get_actual_len()=
. I added them to instrumentation/mainline/fs/ext4 directory. I&#39;m not s=
ure if it&#39;s the best solution.<br>
</div><div style><br></div><div style>Still testing to do, thought. BTW, is=
 there a test setup for regression? I would like to verify that it doesn&#3=
9;t break any supported kernel and I don&#39;t have the required setup.<br>
</div><div style><br></div><div style>With this, maybe lttng-modules 2.1 ca=
n target linux 3.8?=A0</div><div style><br></div><div style>Cheers,</div><d=
iv style><br></div><div style>Francis</div></div></div>

--e89a8f3baa43d0c9e504d424312f--


--===============0414423026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0414423026==--
