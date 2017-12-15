From: Navin Agrawal <anavin@gmail.com>
Subject: Re: URCU binary search tree
Date: Fri, 15 Dec 2017 14:00:36 +0530
Message-ID: <CADVW7qT8QU5pUn5m4jrq9fuVR-mcCZ8Qha98ZFT+00w_Q2DBhA__8295.90306752852$1513326650$gmane$org@mail.gmail.com>
References: <CADVW7qRrDRg8BxCmcts1RaZ4R_0L1Yzfxx310LHdOi4dW36GDA@mail.gmail.com>
 <241873060.34641.1513281923179.JavaMail.zimbra@efficios.com>
 <CADVW7qSbO2o9QEfk9cb5hb+b+1VsEAKwEi-qDidvZ1Pc5Nuq+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1431643110442959985=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ot0-x235.google.com (mail-ot0-x235.google.com
 [IPv6:2607:f8b0:4003:c0f::235])
 by lists.lttng.org (Postfix) with ESMTPS id 3yykCL5ssWzhrl
 for <lttng-dev@lists.lttng.org>; Fri, 15 Dec 2017 08:30:38 +0000 (UTC)
Received: by mail-ot0-x235.google.com with SMTP id y10so7176545otg.10
 for <lttng-dev@lists.lttng.org>; Fri, 15 Dec 2017 00:30:38 -0800 (PST)
In-Reply-To: <CADVW7qSbO2o9QEfk9cb5hb+b+1VsEAKwEi-qDidvZ1Pc5Nuq+w@mail.gmail.com>
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

--===============1431643110442959985==
Content-Type: multipart/alternative; boundary="001a11393f36a9238805605cd0a2"

--001a11393f36a9238805605cd0a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

One quick question Mathieu on the below note of yours.

>>>>
=E2=80=8B
Note that I do _not_ consider my propotype branch to be production-ready.

Can we assume that the code is functionally working in all known scenarios?
I am trying to warm up work folks about URCU. Hence I am planning a demo
using your RB tree code.

Thanks
Navin




On Fri, Dec 15, 2017 at 9:48 AM, Navin Agrawal <anavin@gmail.com> wrote:

> Thanks Mathieu. Will check out your implementation.
>
> Regards
> Navin
>
> On Fri, Dec 15, 2017 at 1:35 AM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com> wrote:
>
>> Hi,
>>
>> I did a URCU rbtree prototype branch around 2011, but it's not pretty,
>> and it's complex.
>>
>> I went in a different direction afterward, and did a RCU Judy Array
>> prototype instead.
>>
>> =E2=80=8B=E2=80=8B
>> The basic problem with rbtree is that there will always be some form of
>> higher contention on the nodes near the top.
>>
>> Anyway, the branch is there:
>>
>> http://git.lttng.org/?p=3Duserspace-rcu.git;a=3Dshortlog;h=3Drefs/heads/=
rbtree2
>>
>> See this Linux Plumbers Conference presentation introducing it:
>>
>> http://www.efficios.com/pub/lpc2011/Presentation-lpc2011-des
>> noyers-urcu.pdf
>>
>> =E2=80=8B=E2=80=8B
>> Note that I do _not_ consider my propotype branch to be production-ready=
.
>>
>> Enjoy!
>>
>> Mathieu
>>
>> ----- On Dec 14, 2017, at 2:38 PM, Navin Agrawal <anavin@gmail.com>
>> wrote:
>>
>> Hi,
>>
>> I have searched enough for any existing implementation of URCU based BST=
.
>> But to no avail.
>>
>> I was keen to attempt develop it myself. But I wanted to cross if  there
>> is any particular reason it is not developed by anyone.
>>
>> Do let me know.
>>
>> Thanks
>> Navin
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>
>

--001a11393f36a9238805605cd0a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D""><font face=3D"aria=
l, helvetica, sans-serif" style=3D"">One quick question Mathieu on the belo=
w note of yours.</font></div><div class=3D"gmail_default" style=3D""><font =
face=3D"arial, helvetica, sans-serif"><br></font></div><div class=3D"gmail_=
default" style=3D""><font face=3D"arial, helvetica, sans-serif">&gt;&gt;&gt=
;&gt;<div class=3D"gmail_default" style=3D"color:rgb(0,0,0);display:inline"=
>=E2=80=8B</div><span style=3D"color:rgb(0,0,0)">Note that I do _not_ consi=
der my propotype branch to be production-ready.</span></font></div><div cla=
ss=3D"gmail_default" style=3D""><span style=3D"color:rgb(0,0,0)"><font face=
=3D"arial, helvetica, sans-serif"><br></font></span></div><div class=3D"gma=
il_default" style=3D""><font color=3D"#000000" face=3D"arial, helvetica, sa=
ns-serif">Can we assume that the code is functionally=C2=A0working in all k=
nown scenarios? I am trying to warm up work folks about URCU. Hence I am pl=
anning a demo using your RB tree code.</font></div><div class=3D"gmail_defa=
ult" style=3D""><font color=3D"#000000" face=3D"arial, helvetica, sans-seri=
f"><br></font></div><div class=3D"gmail_default" style=3D""><font color=3D"=
#000000" face=3D"arial, helvetica, sans-serif">Thanks</font></div><div clas=
s=3D"gmail_default" style=3D""><font color=3D"#000000" face=3D"arial, helve=
tica, sans-serif">Navin</font></div><div class=3D"gmail_default" style=3D""=
><font color=3D"#000000" face=3D"arial, helvetica, sans-serif"><br></font><=
/div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif;f=
ont-size:small"><br></div><div class=3D"gmail_default" style=3D"font-family=
:verdana,sans-serif;font-size:small"><br></div><div class=3D"gmail_extra"><=
br><div class=3D"gmail_quote">On Fri, Dec 15, 2017 at 9:48 AM, Navin Agrawa=
l <span dir=3D"ltr">&lt;<a href=3D"mailto:anavin@gmail.com" target=3D"_blan=
k">anavin@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><div dir=3D"ltr"><div style=3D"font-family:verdana,sans=
-serif;font-size:small">Thanks=C2=A0<span style=3D"color:rgb(0,0,0);font-fa=
mily:arial,helvetica,sans-serif;font-size:16px">Mathieu. Will check out you=
r implementation.</span></div><div style=3D"font-family:verdana,sans-serif;=
font-size:small"><span style=3D"color:rgb(0,0,0);font-family:arial,helvetic=
a,sans-serif;font-size:16px"><br></span></div><div style=3D"font-family:ver=
dana,sans-serif;font-size:small"><span style=3D"color:rgb(0,0,0);font-famil=
y:arial,helvetica,sans-serif;font-size:16px">Regards</span></div><div style=
=3D"font-family:verdana,sans-serif;font-size:small"><span style=3D"color:rg=
b(0,0,0);font-family:arial,helvetica,sans-serif;font-size:16px">Navin</span=
></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On F=
ri, Dec 15, 2017 at 1:35 AM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desno=
yers@efficios.<wbr>com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><div><div style=3D"font-family:arial,helvetica,sans-=
serif;font-size:12pt;color:rgb(0,0,0)"><div>Hi,</div><div><br></div><div>I =
did a URCU rbtree prototype branch around 2011, but it&#39;s not pretty, an=
d it&#39;s complex.<br></div><div><br></div><div>I went in a different dire=
ction afterward, and did a RCU Judy Array prototype instead.<br></div><div>=
<br></div><div><div class=3D"gmail_default" style=3D"font-family:verdana,sa=
ns-serif;font-size:small;display:inline">=E2=80=8B=E2=80=8B</div>The basic =
problem with rbtree is that there will always be some form of<br></div><div=
>higher contention on the nodes near the top.<br></div><div><br></div><div>=
Anyway, the branch is there:<br></div><div><br></div><div><a href=3D"http:/=
/git.lttng.org/?p=3Duserspace-rcu.git;a=3Dshortlog;h=3Drefs/heads/rbtree2" =
target=3D"_blank">http://git.lttng.org/?p=3Dusersp<wbr>ace-rcu.git;a=3Dshor=
tlog;h=3Drefs/<wbr>heads/rbtree2</a><br></div><div><br></div><div>See this =
Linux Plumbers Conference presentation introducing it:<br></div><div><br></=
div><div><a href=3D"http://www.efficios.com/pub/lpc2011/Presentation-lpc201=
1-desnoyers-urcu.pdf" target=3D"_blank">http://www.efficios.com/pub/lp<wbr>=
c2011/Presentation-lpc2011-des<wbr>noyers-urcu.pdf</a><br></div><div><br></=
div><div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-ser=
if;font-size:small;display:inline">=E2=80=8B=E2=80=8B</div>Note that I do _=
not_ consider my propotype branch to be production-ready.<br></div><div><br=
></div><div>Enjoy!<br></div><div><br></div><div>Mathieu<br></div><div><br><=
/div><div><span id=3D"gmail-m_4335262025565913867m_6037529992461944716zwchr=
">----- On Dec 14, 2017, at 2:38 PM, Navin Agrawal &lt;<a href=3D"mailto:an=
avin@gmail.com" target=3D"_blank">anavin@gmail.com</a>&gt; wrote:<br></span=
></div><div><blockquote style=3D"border-left:2px solid rgb(16,16,255);margi=
n-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:=
normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-siz=
e:12pt"><div dir=3D"ltr"><div style=3D"font-family:verdana,sans-serif;font-=
size:small">Hi,</div><div style=3D"font-family:verdana,sans-serif;font-size=
:small"><br></div><div style=3D"font-family:verdana,sans-serif;font-size:sm=
all">I have searched enough for any existing implementation of URCU based B=
ST. But to no avail.</div><div style=3D"font-family:verdana,sans-serif;font=
-size:small"><br></div><div style=3D"font-family:verdana,sans-serif;font-si=
ze:small">I was keen to attempt develop it myself. But I wanted to cross if=
=C2=A0 there is any particular reason it is not developed by anyone.</div><=
div style=3D"font-family:verdana,sans-serif;font-size:small"><br></div><div=
 style=3D"font-family:verdana,sans-serif;font-size:small">Do let me know.</=
div><div style=3D"font-family:verdana,sans-serif;font-size:small"><br></div=
><div style=3D"font-family:verdana,sans-serif;font-size:small">Thanks</div>=
<div style=3D"font-family:verdana,sans-serif;font-size:small">Navin</div><d=
iv style=3D"font-family:verdana,sans-serif;font-size:small"><br></div></div=
>
<br>______________________________<wbr>_________________<br>lttng-dev maili=
ng list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">l=
ttng-dev@lists.lttng.org</a><br><a href=3D"https://lists.lttng.org/cgi-bin/=
mailman/listinfo/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-b=
i<wbr>n/mailman/listinfo/lttng-dev</a><span class=3D"gmail-m_43352620255659=
13867HOEnZb"><font color=3D"#888888"><br></font></span></blockquote></div><=
span class=3D"gmail-m_4335262025565913867HOEnZb"><font color=3D"#888888"><d=
iv><br></div><span class=3D"gmail-HOEnZb"><font color=3D"#888888"><div>-- <=
br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.e=
fficios.com" target=3D"_blank">http://www.efficios.com</a></div></font></sp=
an></font></span></div></div></blockquote></div><br></div>
</blockquote></div><br></div></div>

--001a11393f36a9238805605cd0a2--

--===============1431643110442959985==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1431643110442959985==--
