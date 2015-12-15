From: Jeffrey Chen <cpthk@hotmail.com>
Subject: Re: LTTng trace files organize
Date: Tue, 15 Dec 2015 12:19:40 -0800
Message-ID: <BLU169-W132E42A2DADD554A7B1D3BFABEE0__10965.2806110264$1450210859$gmane$org@phx.gbl>
References: <BLU169-W15347D6012352D6D99D6B9ABEE0@phx.gbl>,
 <56706E63.4010105@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1224090186=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from blu004-omc1s20.hotmail.com ([65.55.116.31])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <cpthk@hotmail.com>) id 1a8w4Y-0006KN-Od
 for lttng-dev@lists.lttng.org; Tue, 15 Dec 2015 15:19:50 -0500
In-Reply-To: <56706E63.4010105@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte Julien <jonathan.rajotte-julien@efficios.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1224090186==
Content-Type: multipart/alternative;
	boundary="_4751c42b-964d-4328-8a53-3d6967e4e7f7_"

--_4751c42b-964d-4328-8a53-3d6967e4e7f7_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

We need to read the traces while trace session is still running. We set the=
 max-file-size. When LTTng rollover to the next trace file=2C we would want=
 to read the old traces from the old trace files. If LTTng separate the tra=
ces per CPU core=2C time T traces might be at the first trace file of CPU 1=
=2C but at 6th trace file of CPU 3. It is much harder for use to search for=
 traces=2C when each CPU core writes their own trace files. We will need to=
 do extra processing to search for the traces at time T for each CPU core's=
 trace files.



> To: lttng-dev@lists.lttng.org
> From: Jonathan.rajotte-julien@efficios.com
> Date: Tue=2C 15 Dec 2015 14:47:47 -0500
> Subject: Re: [lttng-dev] LTTng trace files organize
>=20
> Hey Jeffrey
>=20
> On 2015-12-15 02:15 PM=2C Jeffrey Chen wrote:
> > Hi:
> >
> > I have a question on how LTTng organize trace files. I noticed by=20
> > default for userspace tracing=2C LTTng writes a trace file per CPU core=
.=20
> > So=2C I would get something like channel0_0=2C channel0_1=2C channel0_2=
=2C=20
> > channel0_3=2C for the case of 4 CPU cores. Is there a way to config=20
> > LTTng only writes to 1 trace file? This is much easier for us to=20
> > organize the traces for our use case.
> If you don't mind me asking what exactly would be your use case here?=20
> Folder separation is not enough (via  -o on lttng create) ?
>=20
> Cheers
>=20
> > Thanks.
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>=20
> --=20
> Jonathan R. Julien
> Efficios
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
 		 	   		  =

--_4751c42b-964d-4328-8a53-3d6967e4e7f7_
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
font-size: 12pt=3B
font-family:Calibri
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>We need to read the traces while=
 trace session is still running. We set the max-file-size. When LTTng rollo=
ver to the next trace file=2C we would want to read the old traces from the=
 old trace files. If LTTng separate the traces per CPU core=2C time T trace=
s might be at the first trace file of CPU 1=2C but at 6th trace file of CPU=
 3. It is much harder for use to search for traces=2C when each CPU core wr=
ites their own trace files. We will need to do extra processing to search f=
or the traces at time T for each CPU core's trace files.<br><br><br><br><di=
v>&gt=3B To: lttng-dev@lists.lttng.org<br>&gt=3B From: Jonathan.rajotte-jul=
ien@efficios.com<br>&gt=3B Date: Tue=2C 15 Dec 2015 14:47:47 -0500<br>&gt=
=3B Subject: Re: [lttng-dev] LTTng trace files organize<br>&gt=3B <br>&gt=
=3B Hey Jeffrey<br>&gt=3B <br>&gt=3B On 2015-12-15 02:15 PM=2C Jeffrey Chen=
 wrote:<br>&gt=3B &gt=3B Hi:<br>&gt=3B &gt=3B<br>&gt=3B &gt=3B I have a que=
stion on how LTTng organize trace files. I noticed by <br>&gt=3B &gt=3B def=
ault for userspace tracing=2C LTTng writes a trace file per CPU core. <br>&=
gt=3B &gt=3B So=2C I would get something like channel0_0=2C channel0_1=2C c=
hannel0_2=2C <br>&gt=3B &gt=3B channel0_3=2C for the case of 4 CPU cores. I=
s there a way to config <br>&gt=3B &gt=3B LTTng only writes to 1 trace file=
? This is much easier for us to <br>&gt=3B &gt=3B organize the traces for o=
ur use case.<br>&gt=3B If you don't mind me asking what exactly would be yo=
ur use case here? <br>&gt=3B Folder separation is not enough (via  -o on lt=
tng create) ?<br>&gt=3B <br>&gt=3B Cheers<br>&gt=3B <br>&gt=3B &gt=3B Thank=
s.<br>&gt=3B &gt=3B<br>&gt=3B &gt=3B<br>&gt=3B &gt=3B _____________________=
__________________________<br>&gt=3B &gt=3B lttng-dev mailing list<br>&gt=
=3B &gt=3B lttng-dev@lists.lttng.org<br>&gt=3B &gt=3B http://lists.lttng.or=
g/cgi-bin/mailman/listinfo/lttng-dev<br>&gt=3B <br>&gt=3B -- <br>&gt=3B Jon=
athan R. Julien<br>&gt=3B Efficios<br>&gt=3B <br>&gt=3B <br>&gt=3B ________=
_______________________________________<br>&gt=3B lttng-dev mailing list<br=
>&gt=3B lttng-dev@lists.lttng.org<br>&gt=3B http://lists.lttng.org/cgi-bin/=
mailman/listinfo/lttng-dev<br></div> 		 	   		  </div></body>
</html>=

--_4751c42b-964d-4328-8a53-3d6967e4e7f7_--


--===============1224090186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1224090186==--
