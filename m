From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: URCU binary search tree
Date: Thu, 14 Dec 2017 20:05:23 +0000 (UTC)
Message-ID: <241873060.34641.1513281923179.JavaMail.zimbra__33858.4921359599$1513281796$gmane$org@efficios.com>
References: <CADVW7qRrDRg8BxCmcts1RaZ4R_0L1Yzfxx310LHdOi4dW36GDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7301698666367576591=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3yyPct5Kgyzj56
 for <lttng-dev@lists.lttng.org>; Thu, 14 Dec 2017 20:03:10 +0000 (UTC)
In-Reply-To: <CADVW7qRrDRg8BxCmcts1RaZ4R_0L1Yzfxx310LHdOi4dW36GDA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Navin Agrawal <anavin@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7301698666367576591==
Content-Type: multipart/alternative;
	boundary="=_6a0e619f-7a46-4785-acef-0ac761b0b728"

--=_6a0e619f-7a46-4785-acef-0ac761b0b728
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi, 

I did a URCU rbtree prototype branch around 2011, but it's not pretty, and it's complex. 

I went in a different direction afterward, and did a RCU Judy Array prototype instead. 

The basic problem with rbtree is that there will always be some form of 
higher contention on the nodes near the top. 

Anyway, the branch is there: 

http://git.lttng.org/?p=userspace-rcu.git;a=shortlog;h=refs/heads/rbtree2 

See this Linux Plumbers Conference presentation introducing it: 

http://www.efficios.com/pub/lpc2011/Presentation-lpc2011-desnoyers-urcu.pdf 

Note that I do _not_ consider my propotype branch to be production-ready. 

Enjoy! 

Mathieu 

----- On Dec 14, 2017, at 2:38 PM, Navin Agrawal <anavin@gmail.com> wrote: 

> Hi,

> I have searched enough for any existing implementation of URCU based BST. But to
> no avail.

> I was keen to attempt develop it myself. But I wanted to cross if there is any
> particular reason it is not developed by anyone.

> Do let me know.

> Thanks
> Navin

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_6a0e619f-7a46-4785-acef-0ac761b0b728
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi,</div><div><br data-mce-bogus=3D"1"></di=
v><div>I did a URCU rbtree prototype branch around 2011, but it's not prett=
y, and it's complex.<br></div><div><br data-mce-bogus=3D"1"></div><div>I we=
nt in a different direction afterward, and did a RCU Judy Array prototype i=
nstead.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><=
div>The basic problem with rbtree is that there will always be some form of=
<br data-mce-bogus=3D"1"></div><div>higher contention on the nodes near the=
 top.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><di=
v>Anyway, the branch is there:<br data-mce-bogus=3D"1"></div><div><br data-=
mce-bogus=3D"1"></div><div>http://git.lttng.org/?p=3Duserspace-rcu.git;a=3D=
shortlog;h=3Drefs/heads/rbtree2<br data-mce-bogus=3D"1"></div><div><br data=
-mce-bogus=3D"1"></div><div>See this Linux Plumbers Conference presentation=
 introducing it:<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1=
"></div><div>http://www.efficios.com/pub/lpc2011/Presentation-lpc2011-desno=
yers-urcu.pdf<br data-mce-bogus=3D"1"></div><div><br></div><div>Note that I=
 do _not_ consider my propotype branch to be production-ready.<br data-mce-=
bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Enjoy!<br data-m=
ce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br da=
ta-mce-bogus=3D"1"></div><div><br></div><div><span id=3D"zwchr" data-marker=
=3D"__DIVIDER__">----- On Dec 14, 2017, at 2:38 PM, Navin Agrawal &lt;anavi=
n@gmail.com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"=
><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding=
-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:n=
one;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr=
"><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif;font=
-size:small">Hi,</div><div class=3D"gmail_default" style=3D"font-family:ver=
dana,sans-serif;font-size:small"><br></div><div class=3D"gmail_default" sty=
le=3D"font-family:verdana,sans-serif;font-size:small">I have searched enoug=
h for any existing implementation of URCU based BST. But to no avail.</div>=
<div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif;font-s=
ize:small"><br></div><div class=3D"gmail_default" style=3D"font-family:verd=
ana,sans-serif;font-size:small">I was keen to attempt develop it myself. Bu=
t I wanted to cross if&nbsp; there is any particular reason it is not devel=
oped by anyone.</div><div class=3D"gmail_default" style=3D"font-family:verd=
ana,sans-serif;font-size:small"><br></div><div class=3D"gmail_default" styl=
e=3D"font-family:verdana,sans-serif;font-size:small">Do let me know.</div><=
div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif;font-si=
ze:small"><br></div><div class=3D"gmail_default" style=3D"font-family:verda=
na,sans-serif;font-size:small">Thanks</div><div class=3D"gmail_default" sty=
le=3D"font-family:verdana,sans-serif;font-size:small">Navin</div><div class=
=3D"gmail_default" style=3D"font-family:verdana,sans-serif;font-size:small"=
><br></div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_6a0e619f-7a46-4785-acef-0ac761b0b728--

--===============7301698666367576591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7301698666367576591==--
