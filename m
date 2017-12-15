From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: URCU binary search tree
Date: Fri, 15 Dec 2017 17:27:41 +0000 (UTC)
Message-ID: <1308685137.36035.1513358861684.JavaMail.zimbra__45221.3224758909$1513358763$gmane$org@efficios.com>
References: <CADVW7qRrDRg8BxCmcts1RaZ4R_0L1Yzfxx310LHdOi4dW36GDA@mail.gmail.com>
 <241873060.34641.1513281923179.JavaMail.zimbra@efficios.com>
 <CADVW7qSbO2o9QEfk9cb5hb+b+1VsEAKwEi-qDidvZ1Pc5Nuq+w@mail.gmail.com>
 <CADVW7qT8QU5pUn5m4jrq9fuVR-mcCZ8Qha98ZFT+00w_Q2DBhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1464089093646071299=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3yyy4R1fx1zCbs
 for <lttng-dev@lists.lttng.org>; Fri, 15 Dec 2017 17:25:27 +0000 (UTC)
In-Reply-To: <CADVW7qT8QU5pUn5m4jrq9fuVR-mcCZ8Qha98ZFT+00w_Q2DBhA@mail.gmail.com>
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

--===============1464089093646071299==
Content-Type: multipart/alternative;
	boundary="=_303b42fd-545f-4ace-8214-5ce5f6509623"

--=_303b42fd-545f-4ace-8214-5ce5f6509623
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Dec 15, 2017, at 3:30 AM, Navin Agrawal <anavin@gmail.com> wrote:=
=20

> One quick question Mathieu on the below note of yours.


> =E2=80=8B
> Note that I do _not_ consider my propotype branch to be production-ready.

> Can we assume that the code is functionally working in all known scenario=
s? I am
> trying to warm up work folks about URCU. Hence I am planning a demo using=
 your
> RB tree code.

The code passed all tests when I stopped developing this branch. However, I=
 did not=20
feel confident that I understood all corner-cases thoroughly enough to merg=
e the code=20
into liburcu master branch.=20

So if things don't work as expected, it may take a lot of effort to underst=
and why.=20

That's why this development branch is provided "as is",=20

Mathieu=20

> Thanks
> Navin

> On Fri, Dec 15, 2017 at 9:48 AM, Navin Agrawal < [ mailto:anavin@gmail.co=
m |
> anavin@gmail.com ] > wrote:

>> Thanks Mathieu. Will check out your implementation.

>> Regards
>> Navin

>> On Fri, Dec 15, 2017 at 1:35 AM, Mathieu Desnoyers < [
>> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ]=
 >
>> wrote:

>>> Hi,

>>> I did a URCU rbtree prototype branch around 2011, but it's not pretty, =
and it's
>>> complex.

>>> I went in a different direction afterward, and did a RCU Judy Array pro=
totype
>>> instead.

>>> =E2=80=8B=E2=80=8B
>>> The basic problem with rbtree is that there will always be some form of
>>> higher contention on the nodes near the top.

>>> Anyway, the branch is there:

>>> [ http://git.lttng.org/?p=3Duserspace-rcu.git;a=3Dshortlog;h=3Drefs/hea=
ds/rbtree2 |
>>> http://git.lttng.org/?p=3Duserspace-rcu.git;a=3Dshortlog;h=3Drefs/heads=
/rbtree2 ]

>>> See this Linux Plumbers Conference presentation introducing it:

>>> [ http://www.efficios.com/pub/lpc2011/Presentation-lpc2011-desnoyers-ur=
cu.pdf |
>>> http://www.efficios.com/pub/lpc2011/Presentation-lpc2011-desnoyers-urcu=
.pdf ]

>>> =E2=80=8B=E2=80=8B
>>> Note that I do _not_ consider my propotype branch to be production-read=
y.

>>> Enjoy!

>>> Mathieu

>>> ----- On Dec 14, 2017, at 2:38 PM, Navin Agrawal < [ mailto:anavin@gmai=
l.com |
>>> anavin@gmail.com ] > wrote:

>>>> Hi,

>>>> I have searched enough for any existing implementation of URCU based B=
ST. But to
>>>> no avail.

>>>> I was keen to attempt develop it myself. But I wanted to cross if ther=
e is any
>>>> particular reason it is not developed by anyone.

>>>> Do let me know.

>>>> Thanks
>>>> Navin

>>>> _______________________________________________
>>>> lttng-dev mailing list
>>>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
>>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]

>>> --
>>> Mathieu Desnoyers
>>> EfficiOS Inc.
>>> [ http://www.efficios.com/ | http://www.efficios.com ]

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_303b42fd-545f-4ace-8214-5ce5f6509623
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Dec 15, 2017, at 3:30 AM, Navin Agrawal &lt;anavin@gmail.com&g=
t; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockquote =
style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;col=
or:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fami=
ly:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div class=
=3D"gmail_default" style=3D""><span data-mce-style=3D"font-family: arial,he=
lvetica,sans-serif;" style=3D"font-family: arial,helvetica,sans-serif;" fac=
e=3D"arial, helvetica, sans-serif">One quick question Mathieu on the below =
note of yours.</span></div><div class=3D"gmail_default" style=3D""><span da=
ta-mce-style=3D"font-family: arial,helvetica,sans-serif;" style=3D"font-fam=
ily: arial,helvetica,sans-serif;" face=3D"arial, helvetica, sans-serif"><br=
></span></div><div class=3D"gmail_default" style=3D""><span data-mce-style=
=3D"font-family: arial,helvetica,sans-serif;" style=3D"font-family: arial,h=
elvetica,sans-serif;" face=3D"arial, helvetica, sans-serif">&gt;&gt;&gt;&gt=
;<div class=3D"gmail_default" style=3D"color:rgb(0,0,0);display:inline">=E2=
=80=8B</div><span style=3D"color:rgb(0,0,0)">Note that I do _not_ consider =
my propotype branch to be production-ready.</span></span></div><div class=
=3D"gmail_default" style=3D""><span style=3D"color:rgb(0,0,0)"><span data-m=
ce-style=3D"font-family: arial,helvetica,sans-serif;" style=3D"font-family:=
 arial,helvetica,sans-serif;" face=3D"arial, helvetica, sans-serif"><br></s=
pan></span></div><div class=3D"gmail_default" style=3D""><span data-mce-sty=
le=3D"color: #000000; font-family: arial,helvetica,sans-serif;" style=3D"co=
lor: #000000; font-family: arial,helvetica,sans-serif;" face=3D"arial, helv=
etica, sans-serif" color=3D"#000000">Can we assume that the code is functio=
nally&nbsp;working in all known scenarios? I am trying to warm up work folk=
s about URCU. Hence I am planning a demo using your RB tree code.</span></d=
iv></div></blockquote><div><br></div><div>The code passed all tests when I =
stopped developing this branch. However, I did not<br></div><div>feel confi=
dent that I understood all corner-cases thoroughly enough to merge the code=
</div><div>into liburcu master branch.<br data-mce-bogus=3D"1"></div><div><=
br data-mce-bogus=3D"1"></div><div>So if things don't work as expected, it =
may take a lot of effort to understand why.<br data-mce-bogus=3D"1"></div><=
div><br data-mce-bogus=3D"1"></div><div>That's why this development branch =
is provided "as is",<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-b=
ogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010FF;margin-=
left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;t=
ext-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"=
><div dir=3D"ltr"><div class=3D"gmail_default" style=3D""><span data-mce-st=
yle=3D"color: #000000; font-family: arial,helvetica,sans-serif;" style=3D"c=
olor: #000000; font-family: arial,helvetica,sans-serif;" face=3D"arial, hel=
vetica, sans-serif" color=3D"#000000"><br></span></div><div class=3D"gmail_=
default" style=3D""><span data-mce-style=3D"color: #000000; font-family: ar=
ial,helvetica,sans-serif;" style=3D"color: #000000; font-family: arial,helv=
etica,sans-serif;" face=3D"arial, helvetica, sans-serif" color=3D"#000000">=
Thanks</span></div><div class=3D"gmail_default" style=3D""><span data-mce-s=
tyle=3D"color: #000000; font-family: arial,helvetica,sans-serif;" style=3D"=
color: #000000; font-family: arial,helvetica,sans-serif;" face=3D"arial, he=
lvetica, sans-serif" color=3D"#000000">Navin</span></div><div class=3D"gmai=
l_default" style=3D""><span data-mce-style=3D"color: #000000; font-family: =
arial,helvetica,sans-serif;" style=3D"color: #000000; font-family: arial,he=
lvetica,sans-serif;" face=3D"arial, helvetica, sans-serif" color=3D"#000000=
"><br></span></div><div class=3D"gmail_default" style=3D"font-family:verdan=
a,sans-serif;font-size:small"><br></div><div class=3D"gmail_default" style=
=3D"font-family:verdana,sans-serif;font-size:small"><br></div><div class=3D=
"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Dec 15, 2017 at 9:48 A=
M, Navin Agrawal <span dir=3D"ltr">&lt;<a href=3D"mailto:anavin@gmail.com" =
target=3D"_blank">anavin@gmail.com</a>&gt;</span> wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div style=3D"font-fami=
ly:verdana,sans-serif;font-size:small">Thanks&nbsp;<span style=3D"color:rgb=
(0,0,0);font-family:arial,helvetica,sans-serif;font-size:16px">Mathieu. Wil=
l check out your implementation.</span></div><div style=3D"font-family:verd=
ana,sans-serif;font-size:small"><span style=3D"color:rgb(0,0,0);font-family=
:arial,helvetica,sans-serif;font-size:16px"><br></span></div><div style=3D"=
font-family:verdana,sans-serif;font-size:small"><span style=3D"color:rgb(0,=
0,0);font-family:arial,helvetica,sans-serif;font-size:16px">Regards</span><=
/div><div style=3D"font-family:verdana,sans-serif;font-size:small"><span st=
yle=3D"color:rgb(0,0,0);font-family:arial,helvetica,sans-serif;font-size:16=
px">Navin</span></div></div><div class=3D"gmail_extra"><br><div class=3D"gm=
ail_quote">On Fri, Dec 15, 2017 at 1:35 AM, Mathieu Desnoyers <span dir=3D"=
ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank=
">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div><div style=3D"font-family:arial,helve=
tica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><div>Hi,</div><br><div>I d=
id a URCU rbtree prototype branch around 2011, but it's not pretty, and it'=
s complex.<br></div><br><div>I went in a different direction afterward, and=
 did a RCU Judy Array prototype instead.<br></div><br><div><div class=3D"gm=
ail_default" style=3D"font-family:verdana,sans-serif;font-size:small;displa=
y:inline">=E2=80=8B=E2=80=8B</div>The basic problem with rbtree is that the=
re will always be some form of<br></div><div>higher contention on the nodes=
 near the top.<br></div><br><div>Anyway, the branch is there:<br></div><br>=
<div><a href=3D"http://git.lttng.org/?p=3Duserspace-rcu.git;a=3Dshortlog;h=
=3Drefs/heads/rbtree2" target=3D"_blank">http://git.lttng.org/?p=3Duserspac=
e-rcu.git;a=3Dshortlog;h=3Drefs/heads/rbtree2</a><br></div><br><div>See thi=
s Linux Plumbers Conference presentation introducing it:<br></div><br><div>=
<a href=3D"http://www.efficios.com/pub/lpc2011/Presentation-lpc2011-desnoye=
rs-urcu.pdf" target=3D"_blank">http://www.efficios.com/pub/lpc2011/Presenta=
tion-lpc2011-desnoyers-urcu.pdf</a><br></div><br><div><div class=3D"gmail_d=
efault" style=3D"font-family:verdana,sans-serif;font-size:small;display:inl=
ine">=E2=80=8B=E2=80=8B</div>Note that I do _not_ consider my propotype bra=
nch to be production-ready.<br></div><br><div>Enjoy!<br></div><br><div>Math=
ieu<br></div><br><div><span id=3D"gmail-m_4335262025565913867m_603752999246=
1944716zwchr">----- On Dec 14, 2017, at 2:38 PM, Navin Agrawal &lt;<a href=
=3D"mailto:anavin@gmail.com" target=3D"_blank">anavin@gmail.com</a>&gt; wro=
te:<br></span></div><div><blockquote style=3D"border-left:2px solid rgb(16,=
16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:norma=
l;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-s=
erif;font-size:12pt"><div dir=3D"ltr"><div style=3D"font-family:verdana,san=
s-serif;font-size:small">Hi,</div><div style=3D"font-family:verdana,sans-se=
rif;font-size:small"><br></div><div style=3D"font-family:verdana,sans-serif=
;font-size:small">I have searched enough for any existing implementation of=
 URCU based BST. But to no avail.</div><div style=3D"font-family:verdana,sa=
ns-serif;font-size:small"><br></div><div style=3D"font-family:verdana,sans-=
serif;font-size:small">I was keen to attempt develop it myself. But I wante=
d to cross if&nbsp; there is any particular reason it is not developed by a=
nyone.</div><div style=3D"font-family:verdana,sans-serif;font-size:small"><=
br></div><div style=3D"font-family:verdana,sans-serif;font-size:small">Do l=
et me know.</div><div style=3D"font-family:verdana,sans-serif;font-size:sma=
ll"><br></div><div style=3D"font-family:verdana,sans-serif;font-size:small"=
>Thanks</div><div style=3D"font-family:verdana,sans-serif;font-size:small">=
Navin</div><div style=3D"font-family:verdana,sans-serif;font-size:small"><b=
r></div></div><br>_______________________________________________<br>lttng-=
dev mailing list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"=
_blank">lttng-dev@lists.lttng.org</a><br><a href=3D"https://lists.lttng.org=
/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">https://lists.lttng.=
org/cgi-bin/mailman/listinfo/lttng-dev</a><span class=3D"gmail-m_4335262025=
565913867HOEnZb"><span data-mce-style=3D"color: #888888;" style=3D"color: #=
888888;" color=3D"#888888"><br></span></span></blockquote></div><span class=
=3D"gmail-m_4335262025565913867HOEnZb"><span data-mce-style=3D"color: #8888=
88;" style=3D"color: #888888;" color=3D"#888888"><br><span class=3D"gmail-H=
OEnZb"><span data-mce-style=3D"color: #888888;" style=3D"color: #888888;" c=
olor=3D"#888888"><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<=
br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficio=
s.com</a><br data-mce-bogus=3D"1"></div></span></span></span></span></div><=
/div></blockquote></div><br></div></blockquote></div></div></div><br></bloc=
kquote></div><div><br></div><div data-marker=3D"__SIG_POST__">-- <br></div>=
<div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></d=
iv></body></html>
--=_303b42fd-545f-4ace-8214-5ce5f6509623--

--===============1464089093646071299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1464089093646071299==--
