From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Prototype of LTTng-UST support for Python
Date: Tue, 2 Dec 2014 09:20:05 -0500
Message-ID: <CAC6yHM6B7HNZHGPNSq6rNQXjvFkaNQna22RG4gtGrzKNL1LiYw__24682.634327519$1417530049$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2077035065=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <francis.giraldeau@gmail.com>) id 1XvoJH-000302-DP
 for lttng-dev@lists.lttng.org; Tue, 02 Dec 2014 09:20:12 -0500
Received: by mail-qa0-f52.google.com with SMTP id dc16so8614768qab.25
 for <lttng-dev@lists.lttng.org>; Tue, 02 Dec 2014 06:20:06 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2077035065==
Content-Type: multipart/alternative; boundary=001a1133322a76f24605093c6c03

--001a1133322a76f24605093c6c03
Content-Type: text/plain; charset=UTF-8

After reading CTF and the API bindings in Python, what was missing is
tracing Python itself using LTTng-UST.

Here is a prototype to record function call and return for CPython using
LTTng-UST.

https://github.com/giraldeau/python-profile-ust

Would you rather use the fully qualified object name
(package.module.class.method) or file and line number?

Probably other tracepoints could be interesting? Feedback welcome.

Cheers,

Francis

--001a1133322a76f24605093c6c03
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>After reading CTF and the API bindings in Python, wha=
t was missing is tracing Python itself using LTTng-UST.</div><div><br></div=
><div>Here is a prototype to record function call and return for CPython us=
ing LTTng-UST.</div><div><br></div><div><a href=3D"https://github.com/giral=
deau/python-profile-ust">https://github.com/giraldeau/python-profile-ust</a=
><br></div><div><br></div><div>Would you rather use the fully qualified obj=
ect name (package.module.class.method) or file and line number?<br></div><d=
iv><br></div><div>Probably other tracepoints could be interesting? Feedback=
 welcome.=C2=A0</div><div><br></div><div>Cheers,</div><div><br></div><div>F=
rancis</div></div>

--001a1133322a76f24605093c6c03--


--===============2077035065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2077035065==--
