From: Jeffrey Chen <cpthk@hotmail.com>
Subject: String format based events
Date: Wed, 17 Jun 2015 16:51:06 -0700
Message-ID: <BLU169-W69F0861B21CA9AE09E8C75ABA60__20216.5547213101$1434585427$gmane$org@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1375082088=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from blu004-omc3s8.hotmail.com ([65.55.116.83])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <cpthk@hotmail.com>) id 1Z5N6u-0007Ko-2B
 for lttng-dev@lists.lttng.org; Wed, 17 Jun 2015 19:51:18 -0400
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

--===============1375082088==
Content-Type: multipart/alternative;
	boundary="_678f3f03-9716-417b-afde-9ba29b01b3a0_"

--_678f3f03-9716-417b-afde-9ba29b01b3a0_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I have a question while reading the lttng documentation. Could anyone answe=
r me? Thanks a lot.

It looks like lttng events are all key-value pairs. Like { my_val1 =3D 10=
=2C my_val2 =3D "OK" }. Does lttng supports regular string format based eve=
nts=2C like Windows ETW. I want a human readable sentences in the event lik=
e "My CPU usage is 50 =2C my memory usage is 100". Of course=2C I know I co=
uld manually construct the string myself and pass the result in one string =
down to lttng. But=2C the idea is that=2C string format is slow. So=2C Wind=
ows ETW does the string formatting only when you read the logs.
For example=2C if I want to write many "My CPU usage is {0} =2C my memory u=
sage is {1}" to log. Windows ETW does not write this whole string to log. I=
t only writes the 2 variable values of this trace to the log=2C and constru=
ct back the original string when you are reading the logs.

 		 	   		  =

--_678f3f03-9716-417b-afde-9ba29b01b3a0_
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
<body class=3D'hmmessage'><div dir=3D'ltr'>I have a question while reading =
the lttng documentation. Could anyone answer me? Thanks a lot.<br><br>It lo=
oks like lttng events are all key-value pairs. Like <i>{ my_val1 =3D 10=2C =
my_val2 =3D "OK" }</i>. Does lttng supports regular string format based eve=
nts=2C like Windows ETW. I want a human readable sentences in the event lik=
e "My CPU usage is 50 =2C my memory usage is 100". Of course=2C I know I co=
uld manually construct the string myself and pass the result in one string =
down to lttng. But=2C the idea is that=2C string format is slow. So=2C Wind=
ows ETW does the string formatting only when you read the logs.<br>For exam=
ple=2C if I want to write many "My CPU usage is {0} =2C my memory usage is =
{1}" to log. Windows ETW does not write this whole string to log. It only w=
rites the 2 variable values of this trace to the log=2C and construct back =
the original string when you are reading the logs.<br><br> 		 	   		  </div=
></body>
</html>=

--_678f3f03-9716-417b-afde-9ba29b01b3a0_--


--===============1375082088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1375082088==--
