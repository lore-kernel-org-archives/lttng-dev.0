From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: enable event with java log level
Date: Mon, 3 Feb 2014 14:56:54 +0000 (UTC)
Message-ID: <1603481571.17795.1391439414663.JavaMail.zimbra__33052.4382334717$1391439474$gmane$org@efficios.com>
References: <9B7E8841A008244FBC13A565047771A439389A91@eusaamb105.ericsson.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1965833266=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WAKxG-0003vp-5u
	for lttng-dev@lists.lttng.org; Mon, 03 Feb 2014 09:57:04 -0500
In-Reply-To: <9B7E8841A008244FBC13A565047771A439389A91@eusaamb105.ericsson.se>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Huiping Zhang <huiping.zhang@ericsson.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1965833266==
Content-Type: multipart/alternative;
	boundary="----=_Part_17794_2050215898.1391439414662"

------=_Part_17794_2050215898.1391439414662
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi, 

The documentation is found by running this: 

lttng enable-event --help 

You can look at the following lttng-tools files: 

regression/ust/java-jul/test_java_jul: test_jul_loglevel() 
as well as tests/utils/utils.sh 

An example usage taken from there: 

lttng enable-event -j --loglevel JUL_INFO hello 

Thanks, 

Mathieu 

----- Original Message -----

> From: "Huiping Zhang" <huiping.zhang@ericsson.com>
> To: lttng-dev@lists.lttng.org
> Sent: Thursday, January 30, 2014 10:02:11 AM
> Subject: [lttng-dev] enable event with java log level

> Hi,

> Could you give an example how to provide java logger level in enable-event?
> In Hello.java there is only sample providing logger name:

> lttng enable-event -j hello

> Big thanks, Huiping

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_17794_2050215898.1391439414662
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>Hi,<br></div><div><br></div><div=
><div>The documentation is found by running this:<br></div><div><br></div><=
div>lttng enable-event --help</div><div><br></div></div><div><br></div><div=
>You can look at the following lttng-tools files:<br></div><div><br></div><=
div>regression/ust/java-jul/test_java_jul: test_jul_loglevel()<br></div><di=
v>as well as tests/utils/utils.sh<br></div><div><br></div><div>An example u=
sage taken from there:<br></div><div><br></div><div>lttng enable-event -j -=
-loglevel JUL_INFO hello <br></div><div><br></div><div>Thanks,<br></div><di=
v><br></div><div>Mathieu<br></div><div><br></div><div><br></div><hr id=3D"z=
wchr"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;pa=
dding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decorat=
ion:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><b>From: <=
/b>"Huiping Zhang" &lt;huiping.zhang@ericsson.com&gt;<br><b>To: </b>lttng-d=
ev@lists.lttng.org<br><b>Sent: </b>Thursday, January 30, 2014 10:02:11 AM<b=
r><b>Subject: </b>[lttng-dev] enable event with java log level<br><div><br>=
</div>



<style><!--

@font-face
=09{font-family:SimSun;
=09panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
=09{font-family:SimSun;
=09panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
=09{font-family:"\@SimSun";
=09panose-1:2 1 6 0 3 1 1 1 1 1;}

p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0cm;
=09margin-bottom:.0001pt;
=09font-size:12.0pt;
=09font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:blue;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:purple;
=09text-decoration:underline;}
span.EmailStyle17
=09{mso-style-type:personal-reply;
=09font-family:"Calibri","sans-serif";
=09color:#1F497D;}
.MsoChpDefault
=09{mso-style-type:export-only;}
@page WordSection1
=09{size:612.0pt 792.0pt;
=09margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
=09{page:WordSection1;}
--></style>


<div class=3D"WordSection1">
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D" lang=3D"EN-CA">Hi,</span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D" lang=3D"EN-CA">&nbsp;</sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D" lang=3D"EN-CA">Could you =
give an example how to provide java logger level in enable-event? In Hello.=
java there is only sample providing logger name:</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D" lang=3D"EN-CA">&nbsp;</sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D" lang=3D"EN-CA">&nbsp;&nbs=
p; lttng enable-event -j hello</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D" lang=3D"EN-CA">&nbsp;</sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D" lang=3D"EN-CA">&nbsp;</sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D" lang=3D"EN-CA">Big thanks=
, Huiping</span></p>
</div>
</div>


<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev<br></blockquote><div><br><br></div><div><br></div><div>--=
 <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<=
br>http://www.efficios.com<span name=3D"x"></span><br></div></div></body></=
html>
------=_Part_17794_2050215898.1391439414662--


--===============1965833266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1965833266==--
