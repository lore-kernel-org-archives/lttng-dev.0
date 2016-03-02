From: Jeffrey Chen <cpthk@live.com>
Subject: Segfault during process exit
Date: Wed, 2 Mar 2016 19:07:21 +0000
Message-ID: <DM3PR13MB07829B1DB9D8EEE29BE9124BC7BC0__23740.140166092$1456945708$gmane$org@DM3PR13MB0782.namprd13.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1746539761=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from blu004-omc4s4.hotmail.com ([65.55.111.143])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <cpthk@live.com>) id 1abC7N-000420-6O
 for lttng-dev@lists.lttng.org; Wed, 02 Mar 2016 14:07:31 -0500
Content-Language: en-US
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

--===============1746539761==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM3PR13MB07829B1DB9D8EEE29BE9124BC7BC0DM3PR13MB0782namp_"

--_000_DM3PR13MB07829B1DB9D8EEE29BE9124BC7BC0DM3PR13MB0782namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi:


Our system process will spawn several background threads to do tasks. Durin=
g the process exit, there is no guarantee that these background threads are=
 finished. I have noticed several times that the execution would segfault d=
uring exiting. The stacktrace is showing that the segfault happened at the =
call to write trace, tracepoint(). My guess is that LTTng cleaned up the tr=
acing connection, and the background thread was still running. Has anyone n=
oticed this issue? I thought about trying wait for all the background threa=
ds to complete, but this is very difficult to do in a complex system, as th=
e background thread could spawn more threads during the process. Is there a=
ny way to solve this? Thanks.

--_000_DM3PR13MB07829B1DB9D8EEE29BE9124BC7BC0DM3PR13MB0782namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Hi:</p>
<p><br>
</p>
<p>Our system process will spawn several background threads to do tasks. Du=
ring the process exit, there is no guarantee that these background threads =
are finished. I have noticed several times that the execution would segfaul=
t during exiting. The stacktrace
 is showing that the segfault happened at the call to write trace, tracepoi=
nt(). My guess is that LTTng cleaned up the tracing connection, and the bac=
kground thread was still running. Has anyone noticed this issue?&nbsp;I tho=
ught about trying wait for all the background
 threads to complete, but this is very difficult to do in a complex system,=
 as the background thread could spawn more threads during the process.
<span id=3D"ms-rterangepaste-start"></span>Is there any way to solve this? =
<span id=3D"ms-rterangepaste-end">
</span>Thanks.<br>
</p>
</div>
</body>
</html>

--_000_DM3PR13MB07829B1DB9D8EEE29BE9124BC7BC0DM3PR13MB0782namp_--


--===============1746539761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1746539761==--
