From: Marcus Tomlinson <themarcustomlinson@gmail.com>
Subject: Fwd: VERY EASY one-liner fix to LTTng
Date: Wed, 30 Oct 2013 09:08:00 +0200
Message-ID: <72E40E92-B166-4803-89CF-09A972C5B8F8__31982.3932870806$1383116935$gmane$org@gmail.com>
References: <E79B4F21-5D60-4AE0-BEBD-CA8DEF079300@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Content-Type: multipart/mixed; boundary="===============2074273174=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <themarcustomlinson@gmail.com>) id 1VbPt0-00009L-Cb
	for lttng-dev@lists.lttng.org; Wed, 30 Oct 2013 03:08:15 -0400
Received: by mail-wg0-f51.google.com with SMTP id l18so870489wgh.30
	for <lttng-dev@lists.lttng.org>; Wed, 30 Oct 2013 00:08:08 -0700 (PDT)
Received: from [192.168.0.101] (41-133-125-195.dsl.mweb.co.za.
	[41.133.125.195])
	by mx.google.com with ESMTPSA id q3sm12485516wib.5.2013.10.30.00.08.05
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Wed, 30 Oct 2013 00:08:07 -0700 (PDT)
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


--===============2074273174==
Content-Type: multipart/signed; boundary="Apple-Mail=_911C8073-77B6-44A3-9170-A76EDEB22370"; protocol="application/pgp-signature"; micalg=pgp-sha512


--Apple-Mail=_911C8073-77B6-44A3-9170-A76EDEB22370
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_1A9BA44B-AC00-427B-A8B3-92ECDE6E9119"


--Apple-Mail=_1A9BA44B-AC00-427B-A8B3-92ECDE6E9119
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hi again, so to make things a little easier than easy, here is a patch =
that=92ll do the trick.
If anyone manages to find some time to get this committed, please could =
you let me know.
Thanks again!



Begin forwarded message:

> From: Marcus Tomlinson <themarcustomlinson@gmail.com>
> Subject: VERY EASY one-liner fix to LTTng
> Date: 29 October 2013 at 3:45:53 PM SAST
> To: lttng-dev@lists.lttng.org
>=20
> Hi, could I ask that somebody please make a VERY EASY fix to LTTng and =
push it for me.
>=20
> I get compiler warnings about a missing initialiser for member =
=91padding=92 in tracepoint.
> Removing these warnings is really simple:
>=20
> line 252 of =93tracepoint.h=94 needs to change from:
> 			_TP_EXTRACT_STRING(_args),				=
\
> to:
> 			_TP_EXTRACT_STRING(_args), {}				=
\
>=20
> Thanks in advance!


--Apple-Mail=_1A9BA44B-AC00-427B-A8B3-92ECDE6E9119
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_5E2D29A6-64E2-4D6D-968F-0700B7C178F6"


--Apple-Mail=_5E2D29A6-64E2-4D6D-968F-0700B7C178F6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><div>Hi again, so to make things a little easier =
than easy, here is a patch that=92ll do the trick.</div><div>If anyone =
manages to find some time to get this committed, please could you let me =
know.</div><div>Thanks again!</div><div><br></div></body></html>=

--Apple-Mail=_5E2D29A6-64E2-4D6D-968F-0700B7C178F6
Content-Disposition: attachment;
	filename=missing_initialiser_fix.patch
Content-Type: application/octet-stream;
	name="missing_initialiser_fix.patch"
Content-Transfer-Encoding: 7bit

=== modified file 'include/lttng/tracepoint.h'
--- include/lttng/tracepoint.h	2013-07-10 13:09:21 +0000
+++ include/lttng/tracepoint.h	2013-10-29 15:18:07 +0000
@@ -352,6 +352,7 @@
 			NULL,							\
 			_TRACEPOINT_UNDEFINED_REF(_provider), 			\
 			_TP_EXTRACT_STRING(_args),				\
+			{}							\
 		};								\
 	static struct tracepoint * __tracepoint_ptr_##_provider##___##_name	\
 		__attribute__((used, section("__tracepoints_ptrs"))) =		\


--Apple-Mail=_5E2D29A6-64E2-4D6D-968F-0700B7C178F6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><br><div><br><div>Begin forwarded message:</div><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite"><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px;"><span style=3D"font-family:'Helvetica'; color:rgba(0, =
0, 0, 1.0);"><b>From: </b></span><span =
style=3D"font-family:'Helvetica';">Marcus Tomlinson &lt;<a =
href=3D"mailto:themarcustomlinson@gmail.com">themarcustomlinson@gmail.com<=
/a>&gt;<br></span></div><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px;"><span =
style=3D"font-family:'Helvetica'; color:rgba(0, 0, 0, 1.0);"><b>Subject: =
</b></span><span style=3D"font-family:'Helvetica';"><b>VERY EASY =
one-liner fix to LTTng</b><br></span></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px;"><span =
style=3D"font-family:'Helvetica'; color:rgba(0, 0, 0, 1.0);"><b>Date: =
</b></span><span style=3D"font-family:'Helvetica';">29 October 2013 at =
3:45:53 PM SAST<br></span></div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px;"><span =
style=3D"font-family:'Helvetica'; color:rgba(0, 0, 0, 1.0);"><b>To: =
</b></span><span style=3D"font-family:'Helvetica';"><a =
href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><br=
></span></div><br><div><meta http-equiv=3D"Content-Type" =
content=3D"text/html charset=3Dwindows-1252"><div style=3D"word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;">Hi, could I ask that somebody please make a VERY =
EASY fix to LTTng and push it for me.<div><br></div><div>I get compiler =
warnings about a missing initialiser for member =91padding=92 in =
tracepoint.</div><div>Removing these warnings is really =
simple:</div><div><br></div><div>line 252 of =93tracepoint.h=94 needs to =
change from:</div><div>
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
normal;">Thanks in =
advance!</div></pre></div></div></div></blockquote></div><br></body></html=
>=

--Apple-Mail=_5E2D29A6-64E2-4D6D-968F-0700B7C178F6--

--Apple-Mail=_1A9BA44B-AC00-427B-A8B3-92ECDE6E9119--

--Apple-Mail=_911C8073-77B6-44A3-9170-A76EDEB22370
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJScLBQAAoJECemNjAZ749kCcUH/R6GVEe7it1DgzzXxC98PM4c
Zquim8t74gnh+3Rn05JxVGUWpmuYDaGGyiCD1aJ4cVNxk56/UsqWfnq5MjI3c+ky
7G3qtE6McBXXZTPHWMYiv+gGnnNBPoVwD/MojFs64ZXECfPZC54FMH8F2qjhtajl
k8uE0YAneQDddKLXSPGgKhe0XDa/u8ofPtyEwkF6a3aT1YibUDVFt33HKe0epH/B
688Hd7Nv6Du6fj9Du/Ps9hxgGSdvI/MRwBWqr21eRe2mR+d/o9pqiL0VUPWeWj6p
bLiMg5BFXYIw933lx0gDS1BfvbNwFfKQWmXym+WPkRyhdba0ehXX9n7tXRCQVFU=
=SRDJ
-----END PGP SIGNATURE-----

--Apple-Mail=_911C8073-77B6-44A3-9170-A76EDEB22370--


--===============2074273174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2074273174==--
