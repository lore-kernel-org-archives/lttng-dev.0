From: Danny Serres <serres@live.ca>
Subject: Re: [lttng-tools PATCH] lttng-tools python module v2
Date: Thu, 9 Aug 2012 10:43:39 -0400
Message-ID: <BLU170-W12144FEB282856DC1FADACFC0CC0__23618.6881586493$1344523456$gmane$org@phx.gbl>
References: <1344452188-7579-1-git-send-email-danny.serres@efficios.com>,
	<5022CF9F.9090500@gmail.com>, <5023C796.2030205@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1910614193=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from blu0-omc3-s19.blu0.hotmail.com ([65.55.116.94])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <serres@live.ca>) id 1SzTxg-0002uW-3b
	for lttng-dev@lists.lttng.org; Thu, 09 Aug 2012 10:43:44 -0400
In-Reply-To: <5023C796.2030205@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com, yannick.brosseau@gmail.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1910614193==
Content-Type: multipart/alternative;
	boundary="_7329aefe-7abe-47a4-b9f7-b1b6ad37b339_"

--_7329aefe-7abe-47a4-b9f7-b1b6ad37b339_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




> Date: Thu=2C 9 Aug 2012 10:22:14 -0400
> From: dgoulet@efficios.com
> To: yannick.brosseau@gmail.com
> CC: danny.serres@efficios.com=3B lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] [lttng-tools PATCH] lttng-tools python module v2
>=20
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>=20
>=20
> Yannick Brosseau:
> > On 2012-08-08 14:56=2C Danny Serres wrote:
> >> The lttng-tools Python module can be used to directly control the
> >> lttng-tools API inside Python=2C using 'import lttng'.
> >>=20
> >> Therefore=2C it becomes possible to create a trace=2C add events=2C=20
> >> start/stop tracing=2C destroy a session and so on from within
> >> Python.
> >>=20
> >> The module does not include URI-related functions.
> >>=20
> >> SWIG >=3D 2.0 is used to create the wrapper and its 'warning md
> >> variable unused' bug is patched in Makefile.am.
> >>=20
> >=20
> > But I don't think that stuff in "extra" should be in the build
> > system.
>=20
> Indeed. It should not.
>=20
> Is it possible to create the Makefile on "configure" but not building
> the bindings with "make" ?
>=20

Sure I'll just switch the --disable-python option to --enable-python in the=
 configure.ac


Danny



> David
>=20
> >=20
> > _______________________________________________ lttng-dev mailing
> > list lttng-dev@lists.lttng.org=20
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> -----BEGIN PGP SIGNATURE-----
>=20
> iQEcBAEBCgAGBQJQI8eTAAoJEELoaioR9I02H24H/iepIFDK0qRvL1pU4S0H2EQx
> iMhDNGF/CLzG/FnOWEyZgoNR6lhc1lSUjaFs6FL56VcVueBuCW07rsTJDu2NgCYz
> TsHO29KAR3qrk+ymwSR53TeK2qXt8gr5AXYbc8mK0/DBWWQAxrmJXKSOy8qQ2tmV
> O0OBWVayDRWttusOknZgabAZF7JBitsoIQ2ZRNRlNtqIUxlbdsQlliujEpzjBu8b
> iCuZ/ZXxZ/oeClF1Pnoh64+yziHTfsBVFEbee4CpnBiRBn/6CsxEOF/ZscgWWkOl
> DOUWxj739xHcbtEtWBDo8iu6eqtOCuqVi4RKPqtmk4mqme8Tj7fTQg6YIJ+SZbU=3D
> =3DwKL0
> -----END PGP SIGNATURE-----
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
 		 	   		  =

--_7329aefe-7abe-47a4-b9f7-b1b6ad37b339_
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
g 2012 10:22:14 -0400<br>&gt=3B From: dgoulet@efficios.com<br>&gt=3B To: ya=
nnick.brosseau@gmail.com<br>&gt=3B CC: danny.serres@efficios.com=3B lttng-d=
ev@lists.lttng.org<br>&gt=3B Subject: Re: [lttng-dev] [lttng-tools PATCH] l=
ttng-tools python module v2<br>&gt=3B <br>&gt=3B -----BEGIN PGP SIGNED MESS=
AGE-----<br>&gt=3B Hash: SHA512<br>&gt=3B <br>&gt=3B <br>&gt=3B Yannick Bro=
sseau:<br>&gt=3B &gt=3B On 2012-08-08 14:56=2C Danny Serres wrote:<br>&gt=
=3B &gt=3B&gt=3B The lttng-tools Python module can be used to directly cont=
rol the<br>&gt=3B &gt=3B&gt=3B lttng-tools API inside Python=2C using 'impo=
rt lttng'.<br>&gt=3B &gt=3B&gt=3B <br>&gt=3B &gt=3B&gt=3B Therefore=2C it b=
ecomes possible to create a trace=2C add events=2C <br>&gt=3B &gt=3B&gt=3B =
start/stop tracing=2C destroy a session and so on from within<br>&gt=3B &gt=
=3B&gt=3B Python.<br>&gt=3B &gt=3B&gt=3B <br>&gt=3B &gt=3B&gt=3B The module=
 does not include URI-related functions.<br>&gt=3B &gt=3B&gt=3B <br>&gt=3B =
&gt=3B&gt=3B SWIG &gt=3B=3D 2.0 is used to create the wrapper and its 'warn=
ing md<br>&gt=3B &gt=3B&gt=3B variable unused' bug is patched in Makefile.a=
m.<br>&gt=3B &gt=3B&gt=3B <br>&gt=3B &gt=3B <br>&gt=3B &gt=3B But I don't t=
hink that stuff in "extra" should be in the build<br>&gt=3B &gt=3B system.<=
br>&gt=3B <br>&gt=3B Indeed. It should not.<br>&gt=3B <br>&gt=3B Is it poss=
ible to create the Makefile on "configure" but not building<br>&gt=3B the b=
indings with "make" ?<br>&gt=3B <br><br>Sure I'll just switch the --disable=
-python option to --enable-python in the configure.ac<br><br>
Danny<br>
<br><br>&gt=3B David<br>&gt=3B <br>&gt=3B &gt=3B <br>&gt=3B &gt=3B ________=
_______________________________________ lttng-dev mailing<br>&gt=3B &gt=3B =
list lttng-dev@lists.lttng.org <br>&gt=3B &gt=3B http://lists.lttng.org/cgi=
-bin/mailman/listinfo/lttng-dev<br>&gt=3B -----BEGIN PGP SIGNATURE-----<br>=
&gt=3B <br>&gt=3B iQEcBAEBCgAGBQJQI8eTAAoJEELoaioR9I02H24H/iepIFDK0qRvL1pU4=
S0H2EQx<br>&gt=3B iMhDNGF/CLzG/FnOWEyZgoNR6lhc1lSUjaFs6FL56VcVueBuCW07rsTJD=
u2NgCYz<br>&gt=3B TsHO29KAR3qrk+ymwSR53TeK2qXt8gr5AXYbc8mK0/DBWWQAxrmJXKSOy=
8qQ2tmV<br>&gt=3B O0OBWVayDRWttusOknZgabAZF7JBitsoIQ2ZRNRlNtqIUxlbdsQlliujE=
pzjBu8b<br>&gt=3B iCuZ/ZXxZ/oeClF1Pnoh64+yziHTfsBVFEbee4CpnBiRBn/6CsxEOF/Zs=
cgWWkOl<br>&gt=3B DOUWxj739xHcbtEtWBDo8iu6eqtOCuqVi4RKPqtmk4mqme8Tj7fTQg6YI=
J+SZbU=3D<br>&gt=3B =3DwKL0<br>&gt=3B -----END PGP SIGNATURE-----<br>&gt=3B=
 <br>&gt=3B _______________________________________________<br>&gt=3B lttng=
-dev mailing list<br>&gt=3B lttng-dev@lists.lttng.org<br>&gt=3B http://list=
s.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></div> 		 	   		  </div><=
/body>
</html>=

--_7329aefe-7abe-47a4-b9f7-b1b6ad37b339_--


--===============1910614193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1910614193==--
