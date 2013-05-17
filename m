From: David OShea <David.OShea@quantum.com>
Subject: Re: Patches to enable building on CentOS 5.x (glibc 2.5)
Date: Fri, 17 May 2013 06:52:08 +0000
Message-ID: <20998D40D9A2B7499CA5A3A2666CB1EB23FDDEC5__25115.0575852536$1368773578$gmane$org@ZURMSG1.QUANTUM.com>
References: <20998D40D9A2B7499CA5A3A2666CB1EB23FDCE2B@ZURMSG1.QUANTUM.com>
	<CAEzWAeKCwo_OB=3LcDwrRw-NU3UTGbjtd+Hb82hMrj9fA5935w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1506954180=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0a-000ceb01.pphosted.com ([67.231.144.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=38496238c9=david.oshea@quantum.com>)
	id 1UdEWV-0008L6-BE
	for lttng-dev@lists.lttng.org; Fri, 17 May 2013 02:52:15 -0400
In-Reply-To: <CAEzWAeKCwo_OB=3LcDwrRw-NU3UTGbjtd+Hb82hMrj9fA5935w@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Brosseau, Yannick" <yannick.brosseau@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1506954180==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_20998D40D9A2B7499CA5A3A2666CB1EB23FDDEC5ZURMSG1QUANTUMc_"

--_000_20998D40D9A2B7499CA5A3A2666CB1EB23FDDEC5ZURMSG1QUANTUMc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Yannick,

Yes, we patched the latest (as of around a month ago) versions to work on C=
entOS 5.  Sorry, I neglected to mention that this is for UST only, not kern=
el tracing, hence my not saying anything about the modules!

If the changes aren't going to go upstream into the git repositories, I ima=
gine there is more chance of the CentOS 5 support becoming broken - somethi=
ng could be committed upstream that requires further patching, or conflicts=
 with the patches.  In this case, then, I don't think EPEL packages would h=
elp us much, and quite possibly nobody else is interested in CentOS 5 :)  A=
lso, we needed to backport some lttng-ust commits from master to get suppor=
t for dynamic trace providers to work, so we're more interested in seeing f=
uture releases include the changes than seeing a patched version of the cur=
rent release, and therefore I don't think there would be any value in us mo=
ving to an EPEL package for the same version of LTTng that we're already us=
ing.

I can certainly provide the patches to you anyway, but I'm not so keen to s=
pend time improving them if they're not going upstream, e.g. one thing I th=
ink needs to be investigated is whether the kernel versions provided by Cen=
tOS 5 include the system calls that we had to add wrappers for; I haven't p=
aid any attention to what kernel version I'm using, I'm not sure if it is a=
 standard CentOS 5 one.

Thanks!
David


From: Brosseau, Yannick [mailto:yannick.brosseau@gmail.com]
Sent: Friday, 17 May 2013 12:44 AM
To: David OShea
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] Patches to enable building on CentOS 5.x (glibc 2.=
5)

Hi,

So you made it work with CentOS 5?
I don't know if we want it upstream, but I could maybe use them to build a =
package for EPEL5.
Yannick

On Wed, May 15, 2013 at 7:38 AM, David OShea <David.OShea@quantum.com<mailt=
o:David.OShea@quantum.com>> wrote:
Hi,

Would contributions of patches to enable lttng-tools and lttng-ust to build=
 with glibc 2.5 (as is shipped with CentOS 5.x) and to enable lttng-gen-tp =
to run with Python 2.4 (as shipped on CentOS 5.x) be accepted?

What is missing from glibc 2.5 is:

- a system call wrapper for sched_getcpu()
- a system call wrapper for sync_file_range()
- htobe32() and other similar endian conversion functions

babeltrace and userspace-rcu did not require patching.

Thanks in advance,
David

P.S. If you see this, thanks for all your recent replies, Mathieu, I will t=
ry to get back to you soon!

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any dis=
closure, copying, or further distribution of confidential information is no=
t permitted unless such privilege is explicitly granted in writing by Quant=
um. Quantum reserves the right to have electronic communications, including=
 email and attachments, sent across its networks filtered through anti viru=
s and spam software programs and retain such messages in order to comply wi=
th applicable data security and retention requirements. Quantum is not resp=
onsible for the proper and complete transmission of the substance of this c=
ommunication or for any delay in its receipt.

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org<mailto:lttng-dev@lists.lttng.org>
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



--
Yannick Brosseau
yannickbrosseau.com<http://yannickbrosseau.com>

--_000_20998D40D9A2B7499CA5A3A2666CB1EB23FDDEC5ZURMSG1QUANTUMc_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-AU" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Hi Yannick,<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Yes, we patched the lates=
t (as of around a month ago) versions to work on CentOS 5.&nbsp; Sorry, I n=
eglected to mention that this is for UST only, not kernel tracing,
 hence my not saying anything about the modules!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">If the changes aren&#8217=
;t going to go upstream into the git repositories, I imagine there is more =
chance of the CentOS 5 support becoming broken &#8211; something could
 be committed upstream that requires further patching, or conflicts with th=
e patches.&nbsp; In this case, then, I don&#8217;t think EPEL packages woul=
d help us much, and quite possibly nobody else is interested in CentOS 5 :)=
&nbsp; Also, we needed to backport some lttng-ust
 commits from master to get support for dynamic trace providers to work, so=
 we&#8217;re more interested in seeing future releases include the changes =
than seeing a patched version of the current release, and therefore I don&#=
8217;t think there would be any value in us
 moving to an EPEL package for the same version of LTTng that we&#8217;re a=
lready using.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">I can certainly provide t=
he patches to you anyway, but I&#8217;m not so keen to spend time improving=
 them if they&#8217;re not going upstream, e.g. one thing I think needs
 to be investigated is whether the kernel versions provided by CentOS 5 inc=
lude the system calls that we had to add wrappers for; I haven&#8217;t paid=
 any attention to what kernel version I&#8217;m using, I&#8217;m not sure i=
f it is a standard CentOS 5 one.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Thanks!<br>
David<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:10.0pt;fo=
nt-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span =
lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&qu=
ot;sans-serif&quot;"> Brosseau, Yannick [mailto:yannick.brosseau@gmail.com]
<br>
<b>Sent:</b> Friday, 17 May 2013 12:44 AM<br>
<b>To:</b> David OShea<br>
<b>Cc:</b> lttng-dev@lists.lttng.org<br>
<b>Subject:</b> Re: [lttng-dev] Patches to enable building on CentOS 5.x (g=
libc 2.5)<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<div>
<p class=3D"MsoNormal">Hi,<br>
<br>
So you made it work with CentOS 5?<o:p></o:p></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">I don't know if we wa=
nt it upstream, but I could maybe use them to build a package for EPEL5.<o:=
p></o:p></p>
</div>
<p class=3D"MsoNormal">Yannick<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">On Wed, May 15, 2013 at 7:38 AM, David OShea &lt;<a =
href=3D"mailto:David.OShea@quantum.com" target=3D"_blank">David.OShea@quant=
um.com</a>&gt; wrote:<o:p></o:p></p>
<p class=3D"MsoNormal">Hi,<br>
<br>
Would contributions of patches to enable lttng-tools and lttng-ust to build=
 with glibc 2.5 (as is shipped with CentOS 5.x) and to enable lttng-gen-tp =
to run with Python 2.4 (as shipped on CentOS 5.x) be accepted?<br>
<br>
What is missing from glibc 2.5 is:<br>
<br>
- a system call wrapper for sched_getcpu()<br>
- a system call wrapper for sync_file_range()<br>
- htobe32() and other similar endian conversion functions<br>
<br>
babeltrace and userspace-rcu did not require patching.<br>
<br>
Thanks in advance,<br>
David<br>
<br>
P.S. If you see this, thanks for all your recent replies, Mathieu, I will t=
ry to get back to you soon!<br>
<br>
----------------------------------------------------------------------<br>
The information contained in this transmission may be confidential. Any dis=
closure, copying, or further distribution of confidential information is no=
t permitted unless such privilege is explicitly granted in writing by Quant=
um. Quantum reserves the right to
 have electronic communications, including email and attachments, sent acro=
ss its networks filtered through anti virus and spam software programs and =
retain such messages in order to comply with applicable data security and r=
etention requirements. Quantum is
 not responsible for the proper and complete transmission of the substance =
of this communication or for any delay in its receipt.<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><br>
<br clear=3D"all">
<br>
-- <br>
Yannick Brosseau<br>
<a href=3D"http://yannickbrosseau.com" target=3D"_blank">yannickbrosseau.co=
m</a> <o:p>
</o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_20998D40D9A2B7499CA5A3A2666CB1EB23FDDEC5ZURMSG1QUANTUMc_--


--===============1506954180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1506954180==--
