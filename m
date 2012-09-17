From: RADERMACHER Ansgar 206501 <Ansgar.RADERMACHER@cea.fr>
Subject: Userspace tracing, TP declaration via C++
Date: Mon, 17 Sep 2012 12:37:43 +0000
Message-ID: <386C5D4D5C53C24CBC2C60CAAFD2136A170E5A3E__41078.7940877073$1347886048$gmane$org@EXDAG0-B1.intra.cea.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0607125656=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sainfoin-out.extra.cea.fr ([132.167.192.145])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Ansgar.RADERMACHER@cea.fr>) id 1TDaaG-0001Bz-5j
	for lttng-dev@lists.lttng.org; Mon, 17 Sep 2012 08:37:52 -0400
Received: from pisaure.intra.cea.fr (pisaure.intra.cea.fr [132.166.88.21])
	by sainfoin.extra.cea.fr (8.14.2/8.14.2/CEAnet-Internet-out-2.3) with
	ESMTP id q8HCbjT2028815
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Mon, 17 Sep 2012 14:37:45 +0200
Received: from muguet1.intra.cea.fr (muguet1.intra.cea.fr [132.166.192.6])
	by pisaure.intra.cea.fr (8.14.4/8.14.4) with ESMTP id q8HCbjk3017021
	for <lttng-dev@lists.lttng.org>; Mon, 17 Sep 2012 14:37:45 +0200
	(envelope-from Ansgar.RADERMACHER@cea.fr)
Received: from EXCAH-B2.intra.cea.fr (excah-b2.intra.cea.fr [132.166.88.87])
	by muguet1.intra.cea.fr (8.13.8/8.13.8/CEAnet-Intranet-out-1.2) with
	ESMTP id q8HCbjgv029619
	for <lttng-dev@lists.lttng.org>; Mon, 17 Sep 2012 14:37:45 +0200
Content-Language: en-US
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

--===============0607125656==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_386C5D4D5C53C24CBC2C60CAAFD2136A170E5A3EEXDAG0B1intrace_"

--_000_386C5D4D5C53C24CBC2C60CAAFD2136A170E5A3EEXDAG0B1intrace_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I'd like to use LTTng in the context of C++ projects. Unless I missed somet=
hing, the trace provider iitself is always a "c" file, in the examples call=
ed tp.c (I use the 2.0.5. of the LTTng tools, linux kernel 3.1.10 and gcc/g=
++ 4.6.2).

If I use a C++ file instead, e.g. by renaming the tp.c to tp.cpp, the compi=
lation fails, since the two enumerations alloc and sync are defined within =
the scope of the lttng_ust_lib_ring_buffer_config structure and thus their =
literals are not found (there are additional problems, if I try to define t=
hese two enumerations on top level).

Using a c file instead of a C++ is a bit problemaitc, since I am currently =
integrating LTTng into the Papyrus code generation and I do not like mixing=
 the C and C++ code generation (although possible).

Is there a know work-around or upcoming solution to declare a tracepoint an=
d compile it with g++ ?

Best regards

Ansgar


--_000_386C5D4D5C53C24CBC2C60CAAFD2136A170E5A3EEXDAG0B1intrace_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style id=3D"owaParaStyle" type=3D"text/css">P {margin-top:0;margin-bottom:=
0;}</style>
</head>
<body ocsi=3D"0" fpstyle=3D"1">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">Hello,<br>
<br>
I'd like to use LTTng in the context of C&#43;&#43; projects. Unless I miss=
ed something, the trace provider iitself is always a &quot;c&quot; file, in=
 the examples called tp.c (I use the 2.0.5. of the LTTng tools, linux kerne=
l 3.1.10 and gcc/g&#43;&#43; 4.6.2).<br>
<br>
If I use a C&#43;&#43; file instead, e.g. by renaming the tp.c to tp.cpp, t=
he compilation fails, since the two enumerations alloc and sync are defined=
 within the scope of the lttng_ust_lib_ring_buffer_config structure and thu=
s their literals are not found (there are
 additional problems, if I try to define these two enumerations on top leve=
l).<br>
<br>
Using a c file instead of a C&#43;&#43; is a bit problemaitc, since I am cu=
rrently integrating LTTng into the Papyrus code generation and I do not lik=
e mixing the C and C&#43;&#43; code generation (although possible).<br>
<br>
Is there a know work-around or upcoming solution to declare a tracepoint an=
d compile it with g&#43;&#43; ?<br>
<br>
Best regards<br>
<br>
Ansgar<br>
<br>
</div>
</body>
</html>

--_000_386C5D4D5C53C24CBC2C60CAAFD2136A170E5A3EEXDAG0B1intrace_--


--===============0607125656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0607125656==--
