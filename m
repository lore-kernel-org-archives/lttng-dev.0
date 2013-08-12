From: Kannan Ramaswamy <rkannan@hotmail.com>
Subject: tracing scheduler wakeup latency with lttng
Date: Mon, 12 Aug 2013 15:15:31 +0000
Message-ID: <BLU170-W489208B5DACFA89CF0F8ADB85B0__32820.4462690794$1376320598$gmane$org@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0800612054=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from blu0-omc3-s10.blu0.hotmail.com ([65.55.116.85])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <rkannan@hotmail.com>) id 1V8tqL-0005FB-FH
	for lttng-dev@lists.lttng.org; Mon, 12 Aug 2013 11:15:43 -0400
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

--===============0800612054==
Content-Type: multipart/alternative;
	boundary="_2bf79bf1-36dc-45ef-90fa-8df1510b3020_"

--_2bf79bf1-36dc-45ef-90fa-8df1510b3020_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi=2CI am new to lttng and am reading through the documentation. Does anyon=
e have experience tracing linux scheduler latencies with lttng? I will be g=
rateful if you could provide a cheat sheet of instructions to follow. I wan=
t to get a call trace of kernel operations for each time the scheduler wake=
up was over some prespecified microsecond duration.
I have compiled lttng 2.2 on a vanilla 3.10.5 kernel on a 16 core Intel Xeo=
n CPU E5-2690 @2.90GHz. I am trying to identify and reduce my multithreaded=
 multicast based application service latency.
Thanks=2C--Kannan.
 		 	   		  =

--_2bf79bf1-36dc-45ef-90fa-8df1510b3020_
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
<body class=3D'hmmessage'><div dir=3D'ltr'>Hi=2C<div>I am new to lttng and =
am reading through the documentation. Does anyone have experience tracing l=
inux scheduler latencies with lttng? I will be grateful if you could provid=
e a cheat sheet of instructions to follow. I want to get a call trace of ke=
rnel operations for each time the scheduler wakeup was over some prespecifi=
ed microsecond duration.</div><div><br></div><div>I have compiled lttng 2.2=
 on a vanilla 3.10.5 kernel on a 16 core Intel Xeon CPU E5-2690 @2.90GHz. I=
 am trying to identify and reduce my multithreaded multicast based applicat=
ion service latency.</div><div><br></div><div>Thanks=2C</div><div>--Kannan.=
</div><div><br></div> 		 	   		  </div></body>
</html>=

--_2bf79bf1-36dc-45ef-90fa-8df1510b3020_--


--===============0800612054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0800612054==--
