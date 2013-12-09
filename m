From: David Goulet <dgoulet@efficios.com>
Subject: Re: no trace data are collected for UST
Date: Mon, 9 Dec 2013 15:17:06 -0500
Message-ID: <20131209201706.GC7628__3018.54680660671$1386620296$gmane$org@thessa>
References: <c3d1fc94-92e2-43b3-af78-6315aaa7419d@aliyun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1684839714=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Vq7GU-0005Kd-OC
	for lttng-dev@lists.lttng.org; Mon, 09 Dec 2013 15:17:20 -0500
In-Reply-To: <c3d1fc94-92e2-43b3-af78-6315aaa7419d@aliyun.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============1684839714==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08 Dec (10:33:09), zhenyu.ren wrote:
> Hi, lttng-dev=A0=A0 =A0 All seems well but no trace data are produced for=
 UST.=A0(1) link static lib(.a) into target program=A0 =A0g++ -o target ...=
 provider.o xx.o ... -ldl -llttng-ust -lurcu-cds -lurcu-bp -llttng-ust-trac=
epoint(2) run target and lttng-sessiond(root&uid)/consumerd etc....$lttng-s=
tartAvailable tracing sessions:=A0 1) auto-20131208-100815 (/home/admin/ltt=
ng-traces/auto-20131208-100815) [active]Use lttng list <session_name> for m=
ore details$lttng list -uUST events:-------------
> PID: 42025 - Name: /home/admin/target=A0 =A0 =A0 target_ioitem:AddIOWorkI=
tem (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)$lttng list auto-20=
131208-100815Tracing session auto-20131208-100815: [active]=A0 =A0 Trace pa=
th: /home/admin/lttng-traces/auto-20131208-100815
> =3D=3D=3D Domain: UST global =3D=3D=3D
> Buffer type: per UID
> Channels:-------------- channel0: [enabled]
> =A0 =A0 Attributes:=A0 =A0 =A0 overwrite mode: 0=A0 =A0 =A0 subbufers siz=
e: 131072=A0 =A0 =A0 number of subbufers: 4=A0 =A0 =A0 switch timer interva=
l: 0=A0 =A0 =A0 read timer interval: 0=A0 =A0 =A0 output: mmap()
> =A0 =A0 Events:=A0 =A0 =A0 * (type: tracepoint) [enabled]
> $lttng stopWaiting for data availability......Tracing stopped for session=
 auto-20131208-100815$ls -l ~/lttng-traces/auto-20131208-100815/ust/uid/505=
/64-bit/total 100-rw-rw---- 1 admin admin 4096 Dec =A08 10:11 channel0_0-rw=
-rw---- 1 admin admin 4096 Dec =A08 10:11 channel0_1-rw-rw---- 1 admin admi=
n 4096 Dec =A08 10:11 channel0_10-rw-rw---- 1 admin admin 4096 Dec =A08 10:=
11 channel0_11...-rw-rw---- 1 admin admin 4096 Dec =A08 10:11 metadata$babe=
ltrace ~/lttng-traces/auto-20131208-100815/"empty result"=A0 =A0I am very s=
ure tracepoint=A0target_ioitem:AddIOWorkItem has been running since printf =
log at the next line does work. Why lttng list -u shows me=A0=A0tracepoint=
=A0target_ioitem:AddIOWorkItem there,but no trace data are produced for ust=
?Thankszhenyu.ren

Hey!

Can you provide a code snippet that reproduce this issue along with the
exact list of commands you used.

(Also, please try to avoid the weird text wrapping ;)

Thanks!
David

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJSpiVCXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I0264kH/2m5pPvUr+wo8NrAdOoFri8Z
ue2+0h5Gk7TbeKSPLrVljoVZviX8ADzAhfmZdRJojmPIK8g4N7uOgPjdTaL5QT9V
t+2QvWWD2K3AzTkId4I648aIEUPCLEuhJq19RYUROPpyF89iuD5KIWkxTnVYMUfm
s3r1nqxmckBdSp86/d+FUk8Bjkcau3A1myVFlp1MUi/HRH6sFyrH6IAdoNyN3jjV
nF7ctPtLuVYNb85AH4C0VT6QmEMgUEoQoQ27s4zi7by0r4zuUxw2ubrPeJLKB6OF
fT0B8cCXeWK0gvoKcMIjQygEO3IQ2F3qA1fOMeM2buUHANAJe0tKDjqwBhqXfvA=
=vqB2
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--


--===============1684839714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1684839714==--
