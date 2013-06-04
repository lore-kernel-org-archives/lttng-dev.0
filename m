From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: LTTng on Fedora 19 beta
Date: Tue, 4 Jun 2013 15:03:56 -0400
Message-ID: <CAC6yHM5bEy2rJpMKZ=jUY-L3+JJFEfkmYv5WpJj61Xf2zYZPAQ__28649.0971841433$1370372685$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1782202738=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1UjwWX-0003j9-Td
	for lttng-dev@lists.lttng.org; Tue, 04 Jun 2013 15:04:02 -0400
Received: by mail-ie0-f179.google.com with SMTP id c13so1323991ieb.10
	for <lttng-dev@lists.lttng.org>; Tue, 04 Jun 2013 12:03:56 -0700 (PDT)
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

--===============1782202738==
Content-Type: multipart/alternative; boundary=089e013a2d803148eb04de58befc

--089e013a2d803148eb04de58befc
Content-Type: text/plain; charset=ISO-8859-1

Hi,

Here is a small blog entry on how to install lttng on Fedora 19 beta.

http://multivax.blogspot.ca/2013/06/how-to-setup-lttng-on-fedora-19.html

There is an issue: lttng-modules 2.2.0-rc2 is required for compatibility
reasons with linux kernel 3.9.4, but packages of lttng-tools and lttng-ust
in Fedora are version 2.1.1. While AFAIK they are compatibles, it's a
bit awkward to have different versions installed. Are there any
show-stoppers that prevent upgrading packages to 2.2.0-rc2 in Fedora?

Thanks!

Francis Giraldeau

--089e013a2d803148eb04de58befc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div style>Here is a small blog entry on=
 how to install lttng on Fedora 19 beta.</div><div style><br></div><div sty=
le><a href=3D"http://multivax.blogspot.ca/2013/06/how-to-setup-lttng-on-fed=
ora-19.html">http://multivax.blogspot.ca/2013/06/how-to-setup-lttng-on-fedo=
ra-19.html</a><br>
</div><div style><br></div><div style>There is an issue: lttng-modules 2.2.=
0-rc2 is required for compatibility reasons with linux kernel 3.9.4, but pa=
ckages of lttng-tools and lttng-ust in Fedora are version 2.1.1. While AFAI=
K they are compatibles, it&#39;s a bit=A0awkward=A0to have different versio=
ns installed. Are there any show-stoppers that prevent upgrading packages t=
o 2.2.0-rc2 in Fedora?</div>
<div style><br></div><div style>Thanks!</div><div style><br></div><div styl=
e>Francis Giraldeau</div></div>

--089e013a2d803148eb04de58befc--


--===============1782202738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1782202738==--
