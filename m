From: Evgeniy Ivanov <i@eivanov.com>
Subject: Problem with perf:thread in 2.5.0
Date: Thu, 24 Jul 2014 12:23:15 +0400
Message-ID: <CAO6Ho0fvPCgt6vK3S1DjsjfnRymRG=NUDSb8M_gJPdOjJ8UP0g__1760.07192717424$1406190246$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1962620894=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <lolkaantimat@gmail.com>) id 1XAEJ7-0003i8-Kb
 for lttng-dev@lists.lttng.org; Thu, 24 Jul 2014 04:23:23 -0400
Received: by mail-ig0-f174.google.com with SMTP id c1so6194258igq.13
 for <lttng-dev@lists.lttng.org>; Thu, 24 Jul 2014 01:23:16 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1962620894==
Content-Type: multipart/alternative; boundary=047d7bdc17421bdd9c04feec2b3d

--047d7bdc17421bdd9c04feec2b3d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi!

I use lttng-2.5.0 (tools, modules, =E2=80=A6) and linux-3.8.13. When I try =
to add
context for performance counters I get the following error:

> lttng add-context -u -t perf:cpu:cpu-cycles
Error: perf:cpu:cpu-cycles: UST invalid context
Warning: Some command(s) went wrong

We have another machine with 2.5.0 (modules are not installed though) and
adding perf:cpu:cpu-cycles works fine, but it is always zero in results.


--=20
Cheers,
Evgeniy

--047d7bdc17421bdd9c04feec2b3d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi!<div><br></div><div>I use lttng-2.5.0 (tools, modules, =
=E2=80=A6) and linux-3.8.13. When I try to add context for performance coun=
ters I get the following error:</div><div><div><br></div><div>&gt; lttng ad=
d-context -u -t perf:cpu:cpu-cycles</div>
<div>Error: perf:cpu:cpu-cycles: UST invalid context</div><div>Warning: Som=
e command(s) went wrong</div></div><div><br></div><div>We have another mach=
ine with 2.5.0 (modules are not installed though) and adding perf:cpu:cpu-c=
ycles works fine, but it is always zero in results.<br clear=3D"all">
<div><br></div><div><br></div>-- <br>Cheers,<br>Evgeniy
</div></div>

--047d7bdc17421bdd9c04feec2b3d--


--===============1962620894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1962620894==--
