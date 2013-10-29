From: Marcus Tomlinson <themarcustomlinson@gmail.com>
Subject: VERY EASY one-liner fix to LTTng
Date: Tue, 29 Oct 2013 15:45:53 +0200
Message-ID: <E79B4F21-5D60-4AE0-BEBD-CA8DEF079300__47754.2498418645$1383054625$gmane$org@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Content-Type: multipart/mixed; boundary="===============2125924992=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <themarcustomlinson@gmail.com>) id 1Vb9cU-0001PL-FU
	for lttng-dev@lists.lttng.org; Tue, 29 Oct 2013 09:46:12 -0400
Received: by mail-wi0-f171.google.com with SMTP id f4so1264920wiw.4
	for <lttng-dev@lists.lttng.org>; Tue, 29 Oct 2013 06:45:58 -0700 (PDT)
Received: from [192.168.0.101] (41-133-125-195.dsl.mweb.co.za.
	[41.133.125.195])
	by mx.google.com with ESMTPSA id dn2sm5044423wid.1.2013.10.29.06.45.56
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 29 Oct 2013 06:45:57 -0700 (PDT)
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


--===============2125924992==
Content-Type: multipart/signed; boundary="Apple-Mail=_B8B43024-4556-4BD9-9ED1-252C61E10703"; protocol="application/pgp-signature"; micalg=pgp-sha512


--Apple-Mail=_B8B43024-4556-4BD9-9ED1-252C61E10703
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_5843B902-9A5B-46CD-A1CF-F532B3B791EE"


--Apple-Mail=_5843B902-9A5B-46CD-A1CF-F532B3B791EE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hi, could I ask that somebody please make a VERY EASY fix to LTTng and =
push it for me.

I get compiler warnings about a missing initialiser for member =91padding=92=
 in tracepoint.
Removing these warnings is really simple:

line 252 of =93tracepoint.h=94 needs to change from:
			_TP_EXTRACT_STRING(_args),				=
\
to:
			_TP_EXTRACT_STRING(_args), {}				=
\

Thanks in advance!

--Apple-Mail=_5843B902-9A5B-46CD-A1CF-F532B3B791EE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">Hi, =
could I ask that somebody please make a VERY EASY fix to LTTng and push =
it for me.<div><br></div><div>I get compiler warnings about a missing =
initialiser for member =91padding=92 in tracepoint.</div><div>Removing =
these warnings is really simple:</div><div><br></div><div>line 252 of =
=93tracepoint.h=94 needs to change from:</div><div>
<pre style=3D"margin-top: 0px; margin-bottom: =
0px;"><!--StartFragment--><span style=3D" color:#c0c0c0;">			=
</span>_TP_EXTRACT_STRING(_args),<span style=3D" color:#c0c0c0;">		=
		</span><span style=3D" =
color:#c0c0c0;">\</span></pre></div><div>to:</div><div>
<pre style=3D"margin-top: 0px; margin-bottom: =
0px;"><!--StartFragment--><span style=3D" color:#c0c0c0;">			=
</span>_TP_EXTRACT_STRING(_args), {}<span style=3D" color:#c0c0c0;">		=
		</span><span style=3D" =
color:#c0c0c0;">\</span></pre><pre style=3D"margin-top: 0px; =
margin-bottom: 0px;"><span style=3D" =
color:#c0c0c0;"><br></span></pre><pre style=3D"margin-top: 0px; =
margin-bottom: 0px;"><div style=3D"font-family: Helvetica; white-space: =
normal;">Thanks in advance!</div></pre></div></body></html>=

--Apple-Mail=_5843B902-9A5B-46CD-A1CF-F532B3B791EE--

--Apple-Mail=_B8B43024-4556-4BD9-9ED1-252C61E10703
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJSb7wRAAoJECemNjAZ749kleEH/2RuNkaMecaL8ESVGV5HUR9r
yrIyEbx2HQWo/K+c6YWy2TDIl2xmvcaSYEGX+DCI4g8NUyeuoLRbfLtxjbKPDnS9
oXpCs4PPF+5iiJirXdUX780tLgMJAbT0cnWTS8tTrVuJbqfpe1MUGd6QsIlTPUFf
u3PR7UtKZVccfZdWbM1/Q/tZ6EuPmHq9V9iUmHisQ2F5bmrIWR9uuSEfcXrofF7p
jtxro62wC1JUx2PIb9lxi33aX6V5b16BZjhTiJ+NCrwMEIAA69deRjbO8cIRRCkR
jhKTjlJeTGS9+fJ0Yk0Y5f4WDFBS6mairXxHCQHZwPcWBjrBP1brONjVGa28Sjk=
=4ZUi
-----END PGP SIGNATURE-----

--Apple-Mail=_B8B43024-4556-4BD9-9ED1-252C61E10703--


--===============2125924992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2125924992==--
