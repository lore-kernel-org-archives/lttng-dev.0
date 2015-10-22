From: Farhan Shariff <farhan.shariff@hotmail.com>
Subject: Automatic generation of traceprovider file based on
 source code file c++
Date: Thu, 22 Oct 2015 10:17:32 +0000
Message-ID: <BAY179-W204A02712D16FEC32286C792270__43286.2103604295$1445509122$gmane$org@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1091625550=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from bay004-omc3s12.hotmail.com ([65.54.190.150])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <farhan.shariff@hotmail.com>) id 1ZpCwE-0002gQ-Hm
 for lttng-dev@lists.lttng.org; Thu, 22 Oct 2015 06:17:39 -0400
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

--===============1091625550==
Content-Type: multipart/alternative;
	boundary="_f5836800-0fb1-4f40-8b5b-acb078087e7e_"

--_f5836800-0fb1-4f40-8b5b-acb078087e7e_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hey=2C          I have a need to insert tracepoints() at the beginning and =
end of the functions to monitor input and output parameters
- I have looked into -finstrument-functions ( liblttng-ust-cyg-profile.so a=
nd liblttng-ust-cyg-profile-fast.so)   but these do not provide information=
 about the function input and output parameters hence not of much use=20
- Also considering the fact that each functions have different arguments th=
e  TRACEPOINT_EVENT and TP_FIELDS  have to be explicitly written is very cu=
mbersome and not efficient is there a way to avoid this and automatically g=
enerate tracepoint provider file ( .tp) based on the source code c++ file.


Thanking youFarhan ShariffDesign EngineerSoftware Facilities EUV Source  AS=
ML Veldhoven- Netherlands 		 	   		  =

--_f5836800-0fb1-4f40-8b5b-acb078087e7e_
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
<body class=3D'hmmessage'><div dir=3D'ltr'>Hey=2C<div>&nbsp=3B &nbsp=3B &nb=
sp=3B &nbsp=3B &nbsp=3B I have a need to insert tracepoints() at the beginn=
ing and end of the functions to monitor input and output parameters</div><d=
iv><br></div><div>- I have looked into -finstrument-functions (&nbsp=3B<spa=
n style=3D"color: rgb(26=2C 26=2C 26)=3B font-family: 'Andale Mono WT'=2C '=
Andale Mono'=2C 'Bitstream Vera Sans Mono'=2C 'Liberation Mono'=2C 'Nimbus =
Mono L'=2C 'Ubuntu Mono'=2C Monaco=2C Consolas=2C 'Lucida Console'=2C 'Luci=
da Sans Typewriter'=2C 'Courier New'=2C Courier=2C monospace=3B font-size: =
14.4px=3B line-height: 27.2px=3B white-space: nowrap=3B background-color: r=
gba(0=2C 0=2C 0=2C 0.0470588)=3B">liblttng-ust-cyg-profile.so and&nbsp=3B</=
span><span style=3D"color: rgb(26=2C 26=2C 26)=3B font-family: 'Andale Mono=
 WT'=2C 'Andale Mono'=2C 'Bitstream Vera Sans Mono'=2C 'Liberation Mono'=2C=
 'Nimbus Mono L'=2C 'Ubuntu Mono'=2C Monaco=2C Consolas=2C 'Lucida Console'=
=2C 'Lucida Sans Typewriter'=2C 'Courier New'=2C Courier=2C monospace=3B fo=
nt-size: 14.4px=3B line-height: 27.2px=3B white-space: nowrap=3B background=
-color: rgba(0=2C 0=2C 0=2C 0.0470588)=3B">liblttng-ust-cyg-profile-fast.so=
</span><span style=3D"font-size: 12pt=3B">) &nbsp=3B but these do not provi=
de information about the function input and output parameters hence not of =
much use&nbsp=3B</span></div><div><span style=3D"font-size: 12pt=3B"><br></=
span></div><div><span style=3D"font-size: 12pt=3B">- Also considering the f=
act that each functions have different arguments the &nbsp=3B</span><span s=
tyle=3D"color: rgba(0=2C 0=2C 0=2C 0.8)=3B font-family: 'Andale Mono WT'=2C=
 'Andale Mono'=2C 'Bitstream Vera Sans Mono'=2C 'Liberation Mono'=2C 'Nimbu=
s Mono L'=2C 'Ubuntu Mono'=2C Monaco=2C Consolas=2C 'Lucida Console'=2C 'Lu=
cida Sans Typewriter'=2C 'Courier New'=2C Courier=2C monospace=3B font-size=
: 12px=3B line-height: 15px=3B background-color: rgba(0=2C 0=2C 0=2C 0.0470=
588)=3B">TRACEPOINT_EVENT and&nbsp=3B</span><span style=3D"color: rgba(0=2C=
 0=2C 0=2C 0.8)=3B font-family: 'Andale Mono WT'=2C 'Andale Mono'=2C 'Bitst=
ream Vera Sans Mono'=2C 'Liberation Mono'=2C 'Nimbus Mono L'=2C 'Ubuntu Mon=
o'=2C Monaco=2C Consolas=2C 'Lucida Console'=2C 'Lucida Sans Typewriter'=2C=
 'Courier New'=2C Courier=2C monospace=3B font-size: 12px=3B line-height: 1=
5px=3B background-color: rgba(0=2C 0=2C 0=2C 0.0470588)=3B">TP_FIELDS &nbsp=
=3B</span></div><div>have to be explicitly written is very cumbersome and n=
ot efficient is there a way to avoid this and automatically generate tracep=
oint provider file ( .tp) based on the source code c++ file.</div><div><br>=
</div><div><br></div><div><br></div><div>Thanking you</div><div><span style=
=3D"font-size: 12pt=3B">Farhan Shariff</span></div><div><div>Design Enginee=
r</div><div>Software Facilities EUV Source &nbsp=3B</div><div>ASML Veldhove=
n-&nbsp=3B<span style=3D"font-size:12pt=3B">Netherlands</span></div></div> =
		 	   		  </div></body>
</html>=

--_f5836800-0fb1-4f40-8b5b-acb078087e7e_--


--===============1091625550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1091625550==--
