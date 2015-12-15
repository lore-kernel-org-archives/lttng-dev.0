From: Jeffrey Chen <cpthk@hotmail.com>
Subject: LTTng trace files organize
Date: Tue, 15 Dec 2015 11:21:19 -0800
Message-ID: <BLU169-W8699661F4E1AB4D32F0737ABEE0__40363.462866708$1450207337$gmane$org@phx.gbl>
References: <BLU169-W15347D6012352D6D99D6B9ABEE0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2124651602=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from blu004-omc3s37.hotmail.com ([65.55.116.112])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <cpthk@hotmail.com>) id 1a8vA8-00060J-Cs
 for lttng-dev@lists.lttng.org; Tue, 15 Dec 2015 14:21:29 -0500
In-Reply-To: <BLU169-W15347D6012352D6D99D6B9ABEE0@phx.gbl>
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

--===============2124651602==
Content-Type: multipart/alternative;
	boundary="_eb50ca11-6d70-4c71-b904-f2fd269b46d7_"

--_eb50ca11-6d70-4c71-b904-f2fd269b46d7_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi:

I have a question on how LTTng organize trace files. I noticed by default f=
or userspace tracing=2C LTTng writes a trace file per CPU core. So=2C I wou=
ld get something like channel0_0=2C channel0_1=2C channel0_2=2C channel0_3=
=2C for the case of 4 CPU cores. Is there a way to config LTTng only writes=
 to 1 trace file? This is much easier for us to organize the traces for our=
 use case. Thanks.
 		 	   		   		 	   		  =

--_eb50ca11-6d70-4c71-b904-f2fd269b46d7_
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
<body class=3D'hmmessage'><div dir=3D'ltr'><br><div><div dir=3D"ltr">Hi:<br=
><br>I have a question on how LTTng organize trace files. I noticed by defa=
ult for userspace tracing=2C LTTng writes a trace file per CPU core. So=2C =
I would get something like channel0_0=2C channel0_1=2C channel0_2=2C channe=
l0_3=2C for the case of 4 CPU cores. Is there a way to config LTTng only wr=
ites to 1 trace file? This is much easier for us to organize the traces for=
 our use case. Thanks.<br> 		 	   		  </div></div> 		 	   		  </div></body>
</html>=

--_eb50ca11-6d70-4c71-b904-f2fd269b46d7_--


--===============2124651602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2124651602==--
