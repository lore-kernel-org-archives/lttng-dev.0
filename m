From: Jeffrey Chen <cpthk@hotmail.com>
Subject: String format based events
Date: Thu, 18 Jun 2015 00:49:49 -0700
Message-ID: <BLU169-W872AF3E2846656BC64AC76ABA50__10317.0618917376$1434613860$gmane$org@phx.gbl>
References: <BLU169-W69F0861B21CA9AE09E8C75ABA60@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0461367814=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from blu004-omc3s4.hotmail.com ([65.55.116.79])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <cpthk@hotmail.com>) id 1Z5UaA-0001Kj-T1
 for lttng-dev@lists.lttng.org; Thu, 18 Jun 2015 03:50:00 -0400
In-Reply-To: <BLU169-W69F0861B21CA9AE09E8C75ABA60@phx.gbl>
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

--===============0461367814==
Content-Type: multipart/alternative;
	boundary="_7e6428fc-6d22-4efe-94e5-bea65a273b29_"

--_7e6428fc-6d22-4efe-94e5-bea65a273b29_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


=0A=
=0A=
=0A=
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

--_7e6428fc-6d22-4efe-94e5-bea65a273b29_
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
<body class=3D'hmmessage'><div dir=3D'ltr'><br><div>=0A=
=0A=
<style><!--=0A=
.ExternalClass .ecxhmmessage P {=0A=
padding:0px=3B=0A=
}=0A=
=0A=
.ExternalClass body.ecxhmmessage {=0A=
font-size:12pt=3B=0A=
font-family:Calibri=3B=0A=
}=0A=
=0A=
--></style>=0A=
<div dir=3D"ltr">I have a question while reading the lttng documentation. C=
ould anyone answer me? Thanks a lot.<br>It looks like lttng events are all =
key-value pairs. Like <i>{ my_val1 =3D 10=2C my_val2 =3D "OK" }</i>. Does l=
ttng supports regular string format based events=2C like Windows ETW. I wan=
t a human readable sentences in the event like "My CPU usage is 50 =2C my m=
emory usage is 100". Of course=2C I know I could manually construct the str=
ing myself and pass the result in one string down to lttng. But=2C the idea=
 is that=2C string format is slow. So=2C Windows ETW does the string format=
ting only when you read the logs.<br>For example=2C if I want to write many=
 "My CPU usage is {0} =2C my memory usage is {1}" to log. Windows ETW does =
not write this whole string to log. It only writes the 2 variable values of=
 this trace to the log=2C and construct back the original string when you a=
re reading the logs.<br><br> 		 	   		  </div></div> 		 	   		  </div></bod=
y>
</html>=

--_7e6428fc-6d22-4efe-94e5-bea65a273b29_--


--===============0461367814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0461367814==--
