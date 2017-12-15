From: Navin Agrawal <anavin@gmail.com>
Subject: Re: URCU binary search tree
Date: Fri, 15 Dec 2017 09:48:51 +0530
Message-ID: <CADVW7qSbO2o9QEfk9cb5hb+b+1VsEAKwEi-qDidvZ1Pc5Nuq+w__45080.7791123681$1513311547$gmane$org@mail.gmail.com>
References: <CADVW7qRrDRg8BxCmcts1RaZ4R_0L1Yzfxx310LHdOi4dW36GDA@mail.gmail.com>
 <241873060.34641.1513281923179.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9085074848781952406=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ot0-x229.google.com (mail-ot0-x229.google.com
 [IPv6:2607:f8b0:4003:c0f::229])
 by lists.lttng.org (Postfix) with ESMTPS id 3yyccr4r56zhMS
 for <lttng-dev@lists.lttng.org>; Fri, 15 Dec 2017 04:18:52 +0000 (UTC)
Received: by mail-ot0-x229.google.com with SMTP id j2so6819716ota.13
 for <lttng-dev@lists.lttng.org>; Thu, 14 Dec 2017 20:18:52 -0800 (PST)
In-Reply-To: <241873060.34641.1513281923179.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============9085074848781952406==
Content-Type: multipart/alternative; boundary="001a113758c844d53a0560594c48"

--001a113758c844d53a0560594c48
Content-Type: text/plain; charset="UTF-8"

Thanks Mathieu. Will check out your implementation.

Regards
Navin

On Fri, Dec 15, 2017 at 1:35 AM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> Hi,
>
> I did a URCU rbtree prototype branch around 2011, but it's not pretty, and
> it's complex.
>
> I went in a different direction afterward, and did a RCU Judy Array
> prototype instead.
>
> The basic problem with rbtree is that there will always be some form of
> higher contention on the nodes near the top.
>
> Anyway, the branch is there:
>
> http://git.lttng.org/?p=userspace-rcu.git;a=shortlog;h=refs/heads/rbtree2
>
> See this Linux Plumbers Conference presentation introducing it:
>
> http://www.efficios.com/pub/lpc2011/Presentation-lpc2011-
> desnoyers-urcu.pdf
>
> Note that I do _not_ consider my propotype branch to be production-ready.
>
> Enjoy!
>
> Mathieu
>
> ----- On Dec 14, 2017, at 2:38 PM, Navin Agrawal <anavin@gmail.com> wrote:
>
> Hi,
>
> I have searched enough for any existing implementation of URCU based BST.
> But to no avail.
>
> I was keen to attempt develop it myself. But I wanted to cross if  there
> is any particular reason it is not developed by anyone.
>
> Do let me know.
>
> Thanks
> Navin
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--001a113758c844d53a0560594c48
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif;font-size:small">Thanks=C2=A0<span style=3D"color:rgb(0,0,0);fon=
t-family:arial,helvetica,sans-serif;font-size:16px">Mathieu. Will check out=
 your implementation.</span></div><div class=3D"gmail_default" style=3D"fon=
t-family:verdana,sans-serif;font-size:small"><span style=3D"color:rgb(0,0,0=
);font-family:arial,helvetica,sans-serif;font-size:16px"><br></span></div><=
div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif;font-si=
ze:small"><span style=3D"color:rgb(0,0,0);font-family:arial,helvetica,sans-=
serif;font-size:16px">Regards</span></div><div class=3D"gmail_default" styl=
e=3D"font-family:verdana,sans-serif;font-size:small"><span style=3D"color:r=
gb(0,0,0);font-family:arial,helvetica,sans-serif;font-size:16px">Navin</spa=
n></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On =
Fri, Dec 15, 2017 at 1:35 AM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desn=
oyers@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<div><div style=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;co=
lor:#000000"><div>Hi,</div><div><br></div><div>I did a URCU rbtree prototyp=
e branch around 2011, but it&#39;s not pretty, and it&#39;s complex.<br></d=
iv><div><br></div><div>I went in a different direction afterward, and did a=
 RCU Judy Array prototype instead.<br></div><div><br></div><div>The basic p=
roblem with rbtree is that there will always be some form of<br></div><div>=
higher contention on the nodes near the top.<br></div><div><br></div><div>A=
nyway, the branch is there:<br></div><div><br></div><div><a href=3D"http://=
git.lttng.org/?p=3Duserspace-rcu.git;a=3Dshortlog;h=3Drefs/heads/rbtree2" t=
arget=3D"_blank">http://git.lttng.org/?p=3D<wbr>userspace-rcu.git;a=3Dshort=
log;<wbr>h=3Drefs/heads/rbtree2</a><br></div><div><br></div><div>See this L=
inux Plumbers Conference presentation introducing it:<br></div><div><br></d=
iv><div><a href=3D"http://www.efficios.com/pub/lpc2011/Presentation-lpc2011=
-desnoyers-urcu.pdf" target=3D"_blank">http://www.efficios.com/pub/<wbr>lpc=
2011/Presentation-lpc2011-<wbr>desnoyers-urcu.pdf</a><br></div><div><br></d=
iv><div>Note that I do _not_ consider my propotype branch to be production-=
ready.<br></div><div><br></div><div>Enjoy!<br></div><div><br></div><div>Mat=
hieu<br></div><div><br></div><div><span id=3D"m_6037529992461944716zwchr">-=
---- On Dec 14, 2017, at 2:38 PM, Navin Agrawal &lt;<a href=3D"mailto:anavi=
n@gmail.com" target=3D"_blank">anavin@gmail.com</a>&gt; wrote:<br></span></=
div><div><blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px=
;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-deco=
ration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=
=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,sans-ser=
if;font-size:small">Hi,</div><div class=3D"gmail_default" style=3D"font-fam=
ily:verdana,sans-serif;font-size:small"><br></div><div class=3D"gmail_defau=
lt" style=3D"font-family:verdana,sans-serif;font-size:small">I have searche=
d enough for any existing implementation of URCU based BST. But to no avail=
.</div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif=
;font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-fami=
ly:verdana,sans-serif;font-size:small">I was keen to attempt develop it mys=
elf. But I wanted to cross if=C2=A0 there is any particular reason it is no=
t developed by anyone.</div><div class=3D"gmail_default" style=3D"font-fami=
ly:verdana,sans-serif;font-size:small"><br></div><div class=3D"gmail_defaul=
t" style=3D"font-family:verdana,sans-serif;font-size:small">Do let me know.=
</div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif;=
font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-famil=
y:verdana,sans-serif;font-size:small">Thanks</div><div class=3D"gmail_defau=
lt" style=3D"font-family:verdana,sans-serif;font-size:small">Navin</div><di=
v class=3D"gmail_default" style=3D"font-family:verdana,sans-serif;font-size=
:small"><br></div></div>
<br>______________________________<wbr>_________________<br>lttng-dev maili=
ng list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">l=
ttng-dev@lists.lttng.org</a><br><a href=3D"https://lists.lttng.org/cgi-bin/=
mailman/listinfo/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-<=
wbr>bin/mailman/listinfo/lttng-dev</a><span class=3D"HOEnZb"><font color=3D=
"#888888"><br></font></span></blockquote></div><span class=3D"HOEnZb"><font=
 color=3D"#888888"><div><br></div><div>-- <br></div><div>Mathieu Desnoyers<=
br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">h=
ttp://www.efficios.com</a></div></font></span></div></div></blockquote></di=
v><br></div>

--001a113758c844d53a0560594c48--

--===============9085074848781952406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============9085074848781952406==--
