From: Danny Serres <serres@live.ca>
Subject: Re: [lttng-tools PATCH] lttng-tools python module v2
Date: Thu, 9 Aug 2012 11:10:17 -0400
Message-ID: <BLU170-W905E5345CEF7B2575216BEC0CC0__8548.85792728073$1344525064$gmane$org@phx.gbl>
References: <1344452188-7579-1-git-send-email-danny.serres@efficios.com>,
	<5022CF9F.9090500@gmail.com>, <5023C796.2030205@efficios.com>
	<BLU170-W12144FEB282856DC1FADACFC0CC0@phx.gbl>,
	<5023CE9A.9080505@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1490206722=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from blu0-omc3-s25.blu0.hotmail.com ([65.55.116.100])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <serres@live.ca>) id 1SzUNT-0003AE-Fy
	for lttng-dev@lists.lttng.org; Thu, 09 Aug 2012 11:10:23 -0400
In-Reply-To: <5023CE9A.9080505@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1490206722==
Content-Type: multipart/alternative;
	boundary="_47249e04-0efc-49e4-b279-01f1c48424b2_"

--_47249e04-0efc-49e4-b279-01f1c48424b2_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




> Date: Thu=2C 9 Aug 2012 10:52:10 -0400
> From: dgoulet@efficios.com
> To: serres@live.ca
> CC: yannick.brosseau@gmail.com=3B lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] [lttng-tools PATCH] lttng-tools python module v2
>=20
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>=20
> Danny Serres:
> >=20
> >=20
> >> Date: Thu=2C 9 Aug 2012 10:22:14 -0400 From: dgoulet@efficios.com=20
> >> To: yannick.brosseau@gmail.com CC: danny.serres@efficios.com=3B
> >> lttng-dev@lists.lttng.org Subject: Re: [lttng-dev] [lttng-tools
> >> PATCH] lttng-tools python module v2
> >>=20
> >=20
> > Yannick Brosseau:
> >> On 2012-08-08 14:56=2C Danny Serres wrote:
> >>> The lttng-tools Python module can be used to directly control
> >>> the lttng-tools API inside Python=2C using 'import lttng'.
> >=20
> >>> Therefore=2C it becomes possible to create a trace=2C add events=2C=20
> >>> start/stop tracing=2C destroy a session and so on from within=20
> >>> Python.
> >=20
> >>> The module does not include URI-related functions.
> >=20
> >>> SWIG >=3D 2.0 is used to create the wrapper and its 'warning md=20
> >>> variable unused' bug is patched in Makefile.am.
> >=20
> >=20
> >> But I don't think that stuff in "extra" should be in the build=20
> >> system.
> >=20
> > Indeed. It should not.
> >=20
> > Is it possible to create the Makefile on "configure" but not
> > building the bindings with "make" ?
> >=20
> >=20
> >> Sure I'll just switch the --disable-python option to
> >> --enable-python in the configure.ac
>=20
> This seems like a good idea. Does "--enable-python" is right. Should
> we have something like "--enable-python-bindings" or
> "--enable-lttngctl-python"... or ... (you get the idea) ?
>=20

--enable-python-bindings seems more elucidatory=2C I'll go with that

Danny

> David
>=20
> >=20
> >> Danny
> >=20
> >=20
> > David
> >=20
> >=20
> >> _______________________________________________ lttng-dev
> >> mailing list lttng-dev@lists.lttng.org=20
> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >>=20
> >> _______________________________________________ lttng-dev mailing
> >> list lttng-dev@lists.lttng.org=20
> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> -----BEGIN PGP SIGNATURE-----
>=20
> iQEcBAEBCgAGBQJQI86XAAoJEELoaioR9I02XGcIAILmRSD/4ghVjJjggfTjxSuA
> E0aKMWnXpxBO70I6CgP3Gvkab5gShjxS0juv1L2BqoqvfWfolhfRJ19kbg6+fHbl
> oCYR+n1XL+7pjjQwjrKN006hEHzQXCInImX1tY0cIFZ3nfBCG6jRnyg57MM36hdC
> nDs1KYHyhFiUcSKOoZ06Vis3H+YvUYo9zB7mHEf5y7pvdQgaIP01Y5d94MP33GEK
> CZQpOMDfrlFD/qGe2BsFRw+zMc+O1irkXRszawK7bAekFpHuN+od1nEED2ZhxO8e
> Et7mU5TQn0U9usrbCHw7lkEVDCaHri/9rjoDqWWpqbHPIdHG7O8uwqQQEtg0Qd8=3D
> =3DGsvm
> -----END PGP SIGNATURE-----
 		 	   		  =

--_47249e04-0efc-49e4-b279-01f1c48424b2_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>
<br><br><div><div id=3D"SkyDrivePlaceholder"></div>&gt=3B Date: Thu=2C 9 Au=
g 2012 10:52:10 -0400<br>&gt=3B From: dgoulet@efficios.com<br>&gt=3B To: se=
rres@live.ca<br>&gt=3B CC: yannick.brosseau@gmail.com=3B lttng-dev@lists.lt=
tng.org<br>&gt=3B Subject: Re: [lttng-dev] [lttng-tools PATCH] lttng-tools =
python module v2<br>&gt=3B <br>&gt=3B -----BEGIN PGP SIGNED MESSAGE-----<br=
>&gt=3B Hash: SHA512<br>&gt=3B <br>&gt=3B Danny Serres:<br>&gt=3B &gt=3B <b=
r>&gt=3B &gt=3B <br>&gt=3B &gt=3B&gt=3B Date: Thu=2C 9 Aug 2012 10:22:14 -0=
400 From: dgoulet@efficios.com <br>&gt=3B &gt=3B&gt=3B To: yannick.brosseau=
@gmail.com CC: danny.serres@efficios.com=3B<br>&gt=3B &gt=3B&gt=3B lttng-de=
v@lists.lttng.org Subject: Re: [lttng-dev] [lttng-tools<br>&gt=3B &gt=3B&gt=
=3B PATCH] lttng-tools python module v2<br>&gt=3B &gt=3B&gt=3B <br>&gt=3B &=
gt=3B <br>&gt=3B &gt=3B Yannick Brosseau:<br>&gt=3B &gt=3B&gt=3B On 2012-08=
-08 14:56=2C Danny Serres wrote:<br>&gt=3B &gt=3B&gt=3B&gt=3B The lttng-too=
ls Python module can be used to directly control<br>&gt=3B &gt=3B&gt=3B&gt=
=3B the lttng-tools API inside Python=2C using 'import lttng'.<br>&gt=3B &g=
t=3B <br>&gt=3B &gt=3B&gt=3B&gt=3B Therefore=2C it becomes possible to crea=
te a trace=2C add events=2C <br>&gt=3B &gt=3B&gt=3B&gt=3B start/stop tracin=
g=2C destroy a session and so on from within <br>&gt=3B &gt=3B&gt=3B&gt=3B =
Python.<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B&gt=3B&gt=3B The module does not =
include URI-related functions.<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B&gt=3B&gt=
=3B SWIG &gt=3B=3D 2.0 is used to create the wrapper and its 'warning md <b=
r>&gt=3B &gt=3B&gt=3B&gt=3B variable unused' bug is patched in Makefile.am.=
<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B <br>&gt=3B &gt=3B&gt=3B But I don't thi=
nk that stuff in "extra" should be in the build <br>&gt=3B &gt=3B&gt=3B sys=
tem.<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B Indeed. It should not.<br>&gt=3B &g=
t=3B <br>&gt=3B &gt=3B Is it possible to create the Makefile on "configure"=
 but not<br>&gt=3B &gt=3B building the bindings with "make" ?<br>&gt=3B &gt=
=3B <br>&gt=3B &gt=3B <br>&gt=3B &gt=3B&gt=3B Sure I'll just switch the --d=
isable-python option to<br>&gt=3B &gt=3B&gt=3B --enable-python in the confi=
gure.ac<br>&gt=3B <br>&gt=3B This seems like a good idea. Does "--enable-py=
thon" is right. Should<br>&gt=3B we have something like "--enable-python-bi=
ndings" or<br>&gt=3B "--enable-lttngctl-python"... or ... (you get the idea=
) ?<br>&gt=3B <br><br>--enable-python-bindings seems more elucidatory=2C I'=
ll go with that<br><br>Danny<br><br>&gt=3B David<br>&gt=3B <br>&gt=3B &gt=
=3B <br>&gt=3B &gt=3B&gt=3B Danny<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B <br>&g=
t=3B &gt=3B David<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B <br>&gt=3B &gt=3B&gt=
=3B _______________________________________________ lttng-dev<br>&gt=3B &gt=
=3B&gt=3B mailing list lttng-dev@lists.lttng.org <br>&gt=3B &gt=3B&gt=3B ht=
tp://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br>&gt=3B &gt=3B&gt=
=3B <br>&gt=3B &gt=3B&gt=3B _______________________________________________=
 lttng-dev mailing<br>&gt=3B &gt=3B&gt=3B list lttng-dev@lists.lttng.org <b=
r>&gt=3B &gt=3B&gt=3B http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng=
-dev<br>&gt=3B -----BEGIN PGP SIGNATURE-----<br>&gt=3B <br>&gt=3B iQEcBAEBC=
gAGBQJQI86XAAoJEELoaioR9I02XGcIAILmRSD/4ghVjJjggfTjxSuA<br>&gt=3B E0aKMWnXp=
xBO70I6CgP3Gvkab5gShjxS0juv1L2BqoqvfWfolhfRJ19kbg6+fHbl<br>&gt=3B oCYR+n1XL=
+7pjjQwjrKN006hEHzQXCInImX1tY0cIFZ3nfBCG6jRnyg57MM36hdC<br>&gt=3B nDs1KYHyh=
FiUcSKOoZ06Vis3H+YvUYo9zB7mHEf5y7pvdQgaIP01Y5d94MP33GEK<br>&gt=3B CZQpOMDfr=
lFD/qGe2BsFRw+zMc+O1irkXRszawK7bAekFpHuN+od1nEED2ZhxO8e<br>&gt=3B Et7mU5TQn=
0U9usrbCHw7lkEVDCaHri/9rjoDqWWpqbHPIdHG7O8uwqQQEtg0Qd8=3D<br>&gt=3B =3DGsvm=
<br>&gt=3B -----END PGP SIGNATURE-----<br></div> 		 	   		  </div></body>
</html>=

--_47249e04-0efc-49e4-b279-01f1c48424b2_--


--===============1490206722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1490206722==--
