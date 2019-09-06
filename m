From: Matthew Khouzam via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: CTF writer in Java
Date: Fri, 6 Sep 2019 17:22:18 +0000
Message-ID: <DM6PR15MB3100BD28047D833EE424AB9F9EBA0__13949.8189253331$1567790559$gmane$org@DM6PR15MB3100.namprd15.prod.outlook.com>
References: <34675397.591240.1557142800147.JavaMail.zimbra@univ-pau.fr>,
 <20190506132639.GA12560@joraj-alpa>
Reply-To: Matthew Khouzam <matthew.khouzam@ericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4303433011635936461=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790041.outbound.protection.outlook.com [40.107.79.41])
 by lists.lttng.org (Postfix) with ESMTPS id 46Q4B54ccqzsPY
 for <lttng-dev@lists.lttng.org>; Fri,  6 Sep 2019 13:22:21 -0400 (EDT)
In-Reply-To: <20190506132639.GA12560@joraj-alpa>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>, Lea Brunschwig <lea.brunschwig@univ-pau.fr>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============4303433011635936461==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR15MB3100BD28047D833EE424AB9F9EBA0DM6PR15MB3100namp_"

--_000_DM6PR15MB3100BD28047D833EE424AB9F9EBA0DM6PR15MB3100namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Lea,

Trace Compass has some branches that try out CTF writing, I would like to k=
now, are you looking to trace your execution (JUL log into LTTng is the bes=
t answer there) or do you want to output results of a simulation to CTF? in=
 that case, maybe we can help.

Matthew
________________________________
From: lttng-dev <lttng-dev-bounces@lists.lttng.org> on behalf of Jonathan R=
ajotte-Julien <jonathan.rajotte-julien@efficios.com>
Sent: Monday, May 6, 2019 9:26 AM
To: Lea Brunschwig <lea.brunschwig@univ-pau.fr>
Cc: lttng-dev@lists.lttng.org <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] CTF writer in Java

Hi Lea,

On Mon, May 06, 2019 at 01:40:00PM +0200, Lea Brunschwig wrote:
> Hello,
>
> I am working on a Java API that permits to create UML state machine and t=
o run
> them. I have created a Java interface allowing to implement customizable =
trace
> for this tool: the user can implement its own way to gather information f=
rom
> the execution for instance print in the console via System.out.println() =
or
> print in a xml file, etc...
>
> In the scope of the project I am working on I would like to provide the u=
sers
> a Java class implemeting my interface with the CTF format but I can not m=
anage
> to find a code able to write a CTF trace in Java. Does such a code exist?

lttng-ust provides JUL and log4j java agents that leverage the current lttn=
g stack.

https://protect2.fireeye.com/url?k=3D17ffaa63-4b767024-17ffeaf8-0cc47ad93e9=
6-93494158a8a39a6e&u=3Dhttps://lttng.org/docs/v2.10/#doc-java-application

We do not provide a Java CTF writer as is AFAIK.

Cheers.

>
> Since CTF traces seem to be really specific I do not want to intent to wr=
ite
> my own version of a CTF trace because I am scared it would not be accurat=
e and
> would not work with the already existing CTF readers.
>
> Thank you in advance.
> L=E9a Brunschwig

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://protect2.fireeye.com/url?k=3Dd7cdd732-8b440d75-d7cd97a9-0cc47ad93=
e96-efdf3fabe4e12a0a&u=3Dhttps://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev


--
Jonathan Rajotte-Julien
EfficiOS
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://protect2.fireeye.com/url?k=3D2d4debf7-71c431b0-2d4dab6c-0cc47ad93e9=
6-b75580c67b316f90&u=3Dhttps://lists.lttng.org/cgi-bin/mailman/listinfo/ltt=
ng-dev

--_000_DM6PR15MB3100BD28047D833EE424AB9F9EBA0DM6PR15MB3100namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Lea,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Trace Compass has some branches that try out CTF writing, I would like to k=
now, are you looking to trace your execution (JUL log into LTTng is the bes=
t answer there) or do you want to output results of a simulation to CTF? in=
 that case, maybe we can help.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Matthew<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> lttng-dev &lt;lttng-d=
ev-bounces@lists.lttng.org&gt; on behalf of Jonathan Rajotte-Julien &lt;jon=
athan.rajotte-julien@efficios.com&gt;<br>
<b>Sent:</b> Monday, May 6, 2019 9:26 AM<br>
<b>To:</b> Lea Brunschwig &lt;lea.brunschwig@univ-pau.fr&gt;<br>
<b>Cc:</b> lttng-dev@lists.lttng.org &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Subject:</b> Re: [lttng-dev] CTF writer in Java</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Lea,<br>
<br>
On Mon, May 06, 2019 at 01:40:00PM &#43;0200, Lea Brunschwig wrote:<br>
&gt; Hello, <br>
&gt; <br>
&gt; I am working on a Java API that permits to create UML state machine an=
d to run<br>
&gt; them. I have created a Java interface allowing to implement customizab=
le trace<br>
&gt; for this tool: the user can implement its own way to gather informatio=
n from<br>
&gt; the execution for instance print in the console via System.out.println=
() or<br>
&gt; print in a xml file, etc... <br>
&gt; <br>
&gt; In the scope of the project I am working on I would like to provide th=
e users<br>
&gt; a Java class implemeting my interface with the CTF format but I can no=
t manage<br>
&gt; to find a code able to write a CTF trace in Java. Does such a code exi=
st? <br>
<br>
lttng-ust provides JUL and log4j java agents that leverage the current lttn=
g stack.<br>
<br>
<a href=3D"https://protect2.fireeye.com/url?k=3D17ffaa63-4b767024-17ffeaf8-=
0cc47ad93e96-93494158a8a39a6e&amp;u=3Dhttps://lttng.org/docs/v2.10/#doc-jav=
a-application">https://protect2.fireeye.com/url?k=3D17ffaa63-4b767024-17ffe=
af8-0cc47ad93e96-93494158a8a39a6e&amp;u=3Dhttps://lttng.org/docs/v2.10/#doc=
-java-application</a><br>
<br>
We do not provide a Java CTF writer as is AFAIK.<br>
<br>
Cheers.<br>
<br>
&gt; <br>
&gt; Since CTF traces seem to be really specific I do not want to intent to=
 write<br>
&gt; my own version of a CTF trace because I am scared it would not be accu=
rate and<br>
&gt; would not work with the already existing CTF readers. <br>
&gt; <br>
&gt; Thank you in advance. <br>
&gt; L=E9a Brunschwig <br>
<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; lttng-dev@lists.lttng.org<br>
&gt; <a href=3D"https://protect2.fireeye.com/url?k=3Dd7cdd732-8b440d75-d7cd=
97a9-0cc47ad93e96-efdf3fabe4e12a0a&amp;u=3Dhttps://lists.lttng.org/cgi-bin/=
mailman/listinfo/lttng-dev">
https://protect2.fireeye.com/url?k=3Dd7cdd732-8b440d75-d7cd97a9-0cc47ad93e9=
6-efdf3fabe4e12a0a&amp;u=3Dhttps://lists.lttng.org/cgi-bin/mailman/listinfo=
/lttng-dev</a><br>
<br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
<a href=3D"https://protect2.fireeye.com/url?k=3D2d4debf7-71c431b0-2d4dab6c-=
0cc47ad93e96-b75580c67b316f90&amp;u=3Dhttps://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev">https://protect2.fireeye.com/url?k=3D2d4debf7-71c431=
b0-2d4dab6c-0cc47ad93e96-b75580c67b316f90&amp;u=3Dhttps://lists.lttng.org/c=
gi-bin/mailman/listinfo/lttng-dev</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR15MB3100BD28047D833EE424AB9F9EBA0DM6PR15MB3100namp_--

--===============4303433011635936461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4303433011635936461==--
