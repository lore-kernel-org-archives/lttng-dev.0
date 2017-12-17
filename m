From: Navin Agrawal <anavin@gmail.com>
Subject: Re: URCU binary search tree
Date: Sun, 17 Dec 2017 11:46:05 +0530
Message-ID: <CADVW7qSuUWNFWx-0a8pUWoiHjJKm7fHuyD37sexrThTY-Swo-g__17669.785678345$1513491261$gmane$org@mail.gmail.com>
References: <CADVW7qRrDRg8BxCmcts1RaZ4R_0L1Yzfxx310LHdOi4dW36GDA@mail.gmail.com>
 <241873060.34641.1513281923179.JavaMail.zimbra@efficios.com>
 <CADVW7qSbO2o9QEfk9cb5hb+b+1VsEAKwEi-qDidvZ1Pc5Nuq+w@mail.gmail.com>
 <CADVW7qT8QU5pUn5m4jrq9fuVR-mcCZ8Qha98ZFT+00w_Q2DBhA@mail.gmail.com>
 <1308685137.36035.1513358861684.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5130591640084313860=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi0-x22d.google.com (mail-oi0-x22d.google.com
 [IPv6:2607:f8b0:4003:c06::22d])
 by lists.lttng.org (Postfix) with ESMTPS id 3yzv7C2h6tzncm
 for <lttng-dev@lists.lttng.org>; Sun, 17 Dec 2017 06:16:07 +0000 (UTC)
Received: by mail-oi0-x22d.google.com with SMTP id y75so8732466oie.4
 for <lttng-dev@lists.lttng.org>; Sat, 16 Dec 2017 22:16:07 -0800 (PST)
In-Reply-To: <1308685137.36035.1513358861684.JavaMail.zimbra@efficios.com>
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

--===============5130591640084313860==
Content-Type: multipart/alternative; boundary="001a113db3503e3ef70560832b40"

--001a113db3503e3ef70560832b40
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Got it Mathieu.

Thanks a lot for your prompt response.

Regards
Navin

On Fri, Dec 15, 2017 at 10:57 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> ----- On Dec 15, 2017, at 3:30 AM, Navin Agrawal <anavin@gmail.com> wrote=
:
>
> One quick question Mathieu on the below note of yours.
>
> >>>>
> =E2=80=8B
> Note that I do _not_ consider my propotype branch to be production-ready.
>
> Can we assume that the code is functionally working in all known
> scenarios? I am trying to warm up work folks about URCU. Hence I am
> planning a demo using your RB tree code.
>
>
> The code passed all tests when I stopped developing this branch. However,
> I did not
> feel confident that I understood all corner-cases thoroughly enough to
> merge the code
> into liburcu master branch.
>
> So if things don't work as expected, it may take a lot of effort to
> understand why.
>
> That's why this development branch is provided "as is",
>
> Mathieu
>
>
> Thanks
> Navin
>
>
>
>
> On Fri, Dec 15, 2017 at 9:48 AM, Navin Agrawal <anavin@gmail.com> wrote:
>
>> Thanks Mathieu. Will check out your implementation.
>>
>> Regards
>> Navin
>>
>> On Fri, Dec 15, 2017 at 1:35 AM, Mathieu Desnoyers <
>> mathieu.desnoyers@efficios.com> wrote:
>>
>>> Hi,
>>>
>>> I did a URCU rbtree prototype branch around 2011, but it's not pretty,
>>> and it's complex.
>>>
>>> I went in a different direction afterward, and did a RCU Judy Array
>>> prototype instead.
>>>
>>> =E2=80=8B=E2=80=8B
>>> The basic problem with rbtree is that there will always be some form of
>>> higher contention on the nodes near the top.
>>>
>>> Anyway, the branch is there:
>>>
>>> http://git.lttng.org/?p=3Duserspace-rcu.git;a=3Dshortlog;
>>> h=3Drefs/heads/rbtree2
>>>
>>> See this Linux Plumbers Conference presentation introducing it:
>>>
>>> http://www.efficios.com/pub/lpc2011/Presentation-lpc2011-
>>> desnoyers-urcu.pdf
>>>
>>> =E2=80=8B=E2=80=8B
>>> Note that I do _not_ consider my propotype branch to be production-read=
y.
>>>
>>> Enjoy!
>>>
>>> Mathieu
>>>
>>> ----- On Dec 14, 2017, at 2:38 PM, Navin Agrawal <anavin@gmail.com>
>>> wrote:
>>>
>>> Hi,
>>>
>>> I have searched enough for any existing implementation of URCU based
>>> BST. But to no avail.
>>>
>>> I was keen to attempt develop it myself. But I wanted to cross if  ther=
e
>>> is any particular reason it is not developed by anyone.
>>>
>>> Do let me know.
>>>
>>> Thanks
>>> Navin
>>>
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>>>
>>> --
>>> Mathieu Desnoyers
>>> EfficiOS Inc.
>>> http://www.efficios.com
>>>
>>
>>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--001a113db3503e3ef70560832b40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif;font-size:small">Got it Mathieu.</div><div class=3D"gmail_defaul=
t" style=3D"font-family:verdana,sans-serif;font-size:small"><br></div><div =
class=3D"gmail_default" style=3D"font-family:verdana,sans-serif;font-size:s=
mall">Thanks a lot for your prompt response.</div><div class=3D"gmail_defau=
lt" style=3D"font-family:verdana,sans-serif;font-size:small"><br></div><div=
 class=3D"gmail_default" style=3D"font-family:verdana,sans-serif;font-size:=
small">Regards</div><div class=3D"gmail_default" style=3D"font-family:verda=
na,sans-serif;font-size:small">Navin</div></div><div class=3D"gmail_extra">=
<br><div class=3D"gmail_quote">On Fri, Dec 15, 2017 at 10:57 PM, Mathieu De=
snoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.=
com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><div><div style=3D"font-family:arial,hel=
vetica,sans-serif;font-size:12pt;color:#000000"><div><span id=3D"m_-4561238=
571031941528zwchr">----- On Dec 15, 2017, at 3:30 AM, Navin Agrawal &lt;<a =
href=3D"mailto:anavin@gmail.com" target=3D"_blank">anavin@gmail.com</a>&gt;=
 wrote:<br></span></div><div><blockquote style=3D"border-left:2px solid #10=
10ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-st=
yle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font=
-size:12pt"><div dir=3D"ltr"><div class=3D"gmail_default"><span style=3D"fo=
nt-family:arial,helvetica,sans-serif" face=3D"arial, helvetica, sans-serif"=
>One quick question Mathieu on the below note of yours.</span></div><div cl=
ass=3D"gmail_default"><span style=3D"font-family:arial,helvetica,sans-serif=
" face=3D"arial, helvetica, sans-serif"><br></span></div><div class=3D"gmai=
l_default"><span style=3D"font-family:arial,helvetica,sans-serif" face=3D"a=
rial, helvetica, sans-serif">&gt;&gt;&gt;&gt;<div class=3D"gmail_default" s=
tyle=3D"color:rgb(0,0,0);display:inline">=E2=80=8B</div><span style=3D"colo=
r:rgb(0,0,0)">Note that I do _not_ consider my propotype branch to be produ=
ction-ready.</span></span></div><div class=3D"gmail_default"><span style=3D=
"color:rgb(0,0,0)"><span style=3D"font-family:arial,helvetica,sans-serif" f=
ace=3D"arial, helvetica, sans-serif"><br></span></span></div><div class=3D"=
gmail_default"><span style=3D"color:#000000;font-family:arial,helvetica,san=
s-serif" face=3D"arial, helvetica, sans-serif" color=3D"#000000">Can we ass=
ume that the code is functionally=C2=A0working in all known scenarios? I am=
 trying to warm up work folks about URCU. Hence I am planning a demo using =
your RB tree code.</span></div></div></blockquote><div><br></div><div>The c=
ode passed all tests when I stopped developing this branch. However, I did =
not<br></div><div>feel confident that I understood all corner-cases thoroug=
hly enough to merge the code</div><div>into liburcu master branch.<br></div=
><div><br></div><div>So if things don&#39;t work as expected, it may take a=
 lot of effort to understand why.<br></div><div><br></div><div>That&#39;s w=
hy this development branch is provided &quot;as is&quot;,<br></div><div><br=
></div><div>Mathieu<br></div><div><br></div><blockquote style=3D"border-lef=
t:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight=
:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,=
sans-serif;font-size:12pt"><div dir=3D"ltr"><div class=3D"gmail_default"><s=
pan style=3D"color:#000000;font-family:arial,helvetica,sans-serif" face=3D"=
arial, helvetica, sans-serif" color=3D"#000000"><br></span></div><div class=
=3D"gmail_default"><span style=3D"color:#000000;font-family:arial,helvetica=
,sans-serif" face=3D"arial, helvetica, sans-serif" color=3D"#000000">Thanks=
</span></div><div class=3D"gmail_default"><span style=3D"color:#000000;font=
-family:arial,helvetica,sans-serif" face=3D"arial, helvetica, sans-serif" c=
olor=3D"#000000">Navin</span></div><div class=3D"gmail_default"><span style=
=3D"color:#000000;font-family:arial,helvetica,sans-serif" face=3D"arial, he=
lvetica, sans-serif" color=3D"#000000"><br></span></div><div class=3D"gmail=
_default" style=3D"font-family:verdana,sans-serif;font-size:small"><br></di=
v><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif;font=
-size:small"><br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_q=
uote">On Fri, Dec 15, 2017 at 9:48 AM, Navin Agrawal <span dir=3D"ltr">&lt;=
<a href=3D"mailto:anavin@gmail.com" target=3D"_blank">anavin@gmail.com</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div=
 dir=3D"ltr"><div style=3D"font-family:verdana,sans-serif;font-size:small">=
Thanks=C2=A0<span style=3D"color:rgb(0,0,0);font-family:arial,helvetica,san=
s-serif;font-size:16px">Mathieu. Will check out your implementation.</span>=
</div><div style=3D"font-family:verdana,sans-serif;font-size:small"><span s=
tyle=3D"color:rgb(0,0,0);font-family:arial,helvetica,sans-serif;font-size:1=
6px"><br></span></div><div style=3D"font-family:verdana,sans-serif;font-siz=
e:small"><span style=3D"color:rgb(0,0,0);font-family:arial,helvetica,sans-s=
erif;font-size:16px">Regards</span></div><div style=3D"font-family:verdana,=
sans-serif;font-size:small"><span style=3D"color:rgb(0,0,0);font-family:ari=
al,helvetica,sans-serif;font-size:16px">Navin</span></div></div><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Dec 15, 2017 at 1:3=
5 AM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.des=
noyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.<wbr>com<=
/a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
<div><div style=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;co=
lor:rgb(0,0,0)"><div>Hi,</div><br><div>I did a URCU rbtree prototype branch=
 around 2011, but it&#39;s not pretty, and it&#39;s complex.<br></div><br><=
div>I went in a different direction afterward, and did a RCU Judy Array pro=
totype instead.<br></div><br><div><div class=3D"gmail_default" style=3D"fon=
t-family:verdana,sans-serif;font-size:small;display:inline">=E2=80=8B=E2=80=
=8B</div>The basic problem with rbtree is that there will always be some fo=
rm of<br></div><div>higher contention on the nodes near the top.<br></div><=
br><div>Anyway, the branch is there:<br></div><br><div><a href=3D"http://gi=
t.lttng.org/?p=3Duserspace-rcu.git;a=3Dshortlog;h=3Drefs/heads/rbtree2" tar=
get=3D"_blank">http://git.lttng.org/?p=3D<wbr>userspace-rcu.git;a=3Dshortlo=
g;<wbr>h=3Drefs/heads/rbtree2</a><br></div><br><div>See this Linux Plumbers=
 Conference presentation introducing it:<br></div><br><div><a href=3D"http:=
//www.efficios.com/pub/lpc2011/Presentation-lpc2011-desnoyers-urcu.pdf" tar=
get=3D"_blank">http://www.efficios.com/pub/<wbr>lpc2011/Presentation-lpc201=
1-<wbr>desnoyers-urcu.pdf</a><br></div><br><div><div class=3D"gmail_default=
" style=3D"font-family:verdana,sans-serif;font-size:small;display:inline">=
=E2=80=8B=E2=80=8B</div>Note that I do _not_ consider my propotype branch t=
o be production-ready.<br></div><br><div>Enjoy!<br></div><br><div>Mathieu<b=
r></div><br><div><span id=3D"m_-4561238571031941528gmail-m_4335262025565913=
867m_6037529992461944716zwchr">----- On Dec 14, 2017, at 2:38 PM, Navin Agr=
awal &lt;<a href=3D"mailto:anavin@gmail.com" target=3D"_blank">anavin@gmail=
.com</a>&gt; wrote:<br></span></div><div><blockquote style=3D"border-left:2=
px solid rgb(16,16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,0);f=
ont-weight:normal;font-style:normal;text-decoration:none;font-family:Helvet=
ica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div style=3D"font-fa=
mily:verdana,sans-serif;font-size:small">Hi,</div><div style=3D"font-family=
:verdana,sans-serif;font-size:small"><br></div><div style=3D"font-family:ve=
rdana,sans-serif;font-size:small">I have searched enough for any existing i=
mplementation of URCU based BST. But to no avail.</div><div style=3D"font-f=
amily:verdana,sans-serif;font-size:small"><br></div><div style=3D"font-fami=
ly:verdana,sans-serif;font-size:small">I was keen to attempt develop it mys=
elf. But I wanted to cross if=C2=A0 there is any particular reason it is no=
t developed by anyone.</div><div style=3D"font-family:verdana,sans-serif;fo=
nt-size:small"><br></div><div style=3D"font-family:verdana,sans-serif;font-=
size:small">Do let me know.</div><div style=3D"font-family:verdana,sans-ser=
if;font-size:small"><br></div><div style=3D"font-family:verdana,sans-serif;=
font-size:small">Thanks</div><div style=3D"font-family:verdana,sans-serif;f=
ont-size:small">Navin</div><div style=3D"font-family:verdana,sans-serif;fon=
t-size:small"><br></div></div><br>______________________________<wbr>______=
___________<br>lttng-dev mailing list<br><a href=3D"mailto:lttng-dev@lists.=
lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><br><a href=3D"ht=
tps://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank"=
>https://lists.lttng.org/cgi-<wbr>bin/mailman/listinfo/lttng-dev</a><span c=
lass=3D"m_-4561238571031941528gmail-m_4335262025565913867HOEnZb"><span styl=
e=3D"color:#888888" color=3D"#888888"><br></span></span></blockquote></div>=
<span class=3D"m_-4561238571031941528gmail-m_4335262025565913867HOEnZb"><sp=
an style=3D"color:#888888" color=3D"#888888"><br><span class=3D"HOEnZb"><fo=
nt color=3D"#888888"><span class=3D"m_-4561238571031941528gmail-HOEnZb"><sp=
an style=3D"color:#888888" color=3D"#888888"><div>-- <br></div><div>Mathieu=
 Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=
=3D"_blank">http://www.efficios.com</a><br></div></span></span></font></spa=
n></span></span></div></div></blockquote></div><span class=3D"HOEnZb"><font=
 color=3D"#888888"><br></font></span></div></blockquote></div></div></div><=
span class=3D"HOEnZb"><font color=3D"#888888"><br></font></span></blockquot=
e></div><span class=3D"HOEnZb"><font color=3D"#888888"><div><br></div><div>=
-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://w=
ww.efficios.com" target=3D"_blank">http://www.efficios.com</a></div></font>=
</span></div></div></blockquote></div><br></div>

--001a113db3503e3ef70560832b40--

--===============5130591640084313860==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5130591640084313860==--
