From: craig harmer <charmster@gmail.com>
Subject: bug #857 -- babeltrace may core dump if index file is
	too short (with patch)
Date: Sat, 13 Dec 2014 19:08:19 -0800
Message-ID: <CADjtVtb6J6ird2fYgWibLzq4tFmjNtv8G23Z+Krk6Fqabcc5Pw__34199.373125057$1418545131$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0580963730=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <charmster@gmail.com>) id 1XzzXl-0003CS-7F
 for lttng-dev@lists.lttng.org; Sat, 13 Dec 2014 22:08:29 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so3385953igb.17
 for <lttng-dev@lists.lttng.org>; Sat, 13 Dec 2014 19:08:19 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: charmer-lttng.org@punchdown.org
List-Id: lttng-dev@lists.lttng.org

--===============0580963730==
Content-Type: multipart/alternative; boundary=20cf30244df91daa5b050a2470c1

--20cf30244df91daa5b050a2470c1
Content-Type: text/plain; charset=UTF-8

hi all,

i opened a bug at bugs.lttng.org about a problem that i had where
babeltrace would exit, possibly with a core dump, if one the trace's index
files was too short.

you can read the bug, with patch, at Bug #857 babeltrace will exit (often
with a core dump) if an index file is too short
<https://bugs.lttng.org/issues/857>

i submitted a patch for the problem also fixes a few other places that
short reads are not handled properly.

there hasn't been any activity on the bug since i submitted the patch about
1 month ago, so i'm wondering if i need to submit the patch to this list as
well.

cheers,

craig.

--20cf30244df91daa5b050a2470c1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:trebuche=
t ms,sans-serif">hi all,<br><br></div><div class=3D"gmail_default" style=3D=
"font-family:trebuchet ms,sans-serif">i opened a bug at <a href=3D"http://b=
ugs.lttng.org">bugs.lttng.org</a> about a problem that i had where babeltra=
ce would exit, possibly with a core dump, if one the trace&#39;s index file=
s was too short.<br><br></div><div class=3D"gmail_default" style=3D"font-fa=
mily:trebuchet ms,sans-serif">you can read the bug, with patch, at <a href=
=3D"https://bugs.lttng.org/issues/857">Bug #857 babeltrace will exit (often=
 with a core dump) if an index file is too short</a><br></div><div class=3D=
"gmail_default" style=3D"font-family:trebuchet ms,sans-serif"><br></div><di=
v class=3D"gmail_default" style=3D"font-family:trebuchet ms,sans-serif">i s=
ubmitted a patch for the problem also fixes a few other places that short r=
eads are not handled properly.<br><br></div><div class=3D"gmail_default" st=
yle=3D"font-family:trebuchet ms,sans-serif">there hasn&#39;t been any activ=
ity on the bug since i submitted the patch about 1 month ago, so i&#39;m wo=
ndering if i need to submit the patch to this list as well.<br><br></div><d=
iv class=3D"gmail_default" style=3D"font-family:trebuchet ms,sans-serif">ch=
eers,<br><br>craig.<br></div></div>

--20cf30244df91daa5b050a2470c1--


--===============0580963730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0580963730==--
