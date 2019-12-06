From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: RCU consistency guarantees
Date: Fri, 6 Dec 2019 10:59:05 -0500 (EST)
Message-ID: <512711764.1078.1575647945136.JavaMail.zimbra__23192.7767208376$1575647964$gmane$org@efficios.com>
References: <CAAKbDrdMRrhnSzpPBZLf3nNUDW4YZLPkZkTD5gNJu+A9rATkWA@mail.gmail.com>
 <194534011.751.1575629349181.JavaMail.zimbra@efficios.com>
 <CAAKbDreZ8NerP-jsxezOmN3rktVSAk1a=RJw2YQY83UpQRrXfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7098162895546590200=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 47Ty225Ndbz11tS
 for <lttng-dev@lists.lttng.org>; Fri,  6 Dec 2019 10:59:06 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 027D826F8E1
 for <lttng-dev@lists.lttng.org>; Fri,  6 Dec 2019 10:59:06 -0500 (EST)
In-Reply-To: <CAAKbDreZ8NerP-jsxezOmN3rktVSAk1a=RJw2YQY83UpQRrXfQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yuxin Ren <ryx@gwmail.gwu.edu>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>
List-Id: lttng-dev@lists.lttng.org

--===============7098162895546590200==
Content-Type: multipart/alternative;
	boundary="=_a750b78c-95fb-445c-8c13-4664ffae9078"

--=_a750b78c-95fb-445c-8c13-4664ffae9078
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Dec 6, 2019, at 3:51 PM, Yuxin Ren <ryx@gwmail.gwu.edu> wrote:=20

> On Fri, Dec 6, 2019 at 5:49 AM Mathieu Desnoyers < [
> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] =
>
> wrote:

>> ----- On Dec 5, 2019, at 8:17 PM, Yuxin Ren < [ mailto:ryx@gwmail.gwu.ed=
u |
>> ryx@gwmail.gwu.edu ] > wrote:

>>> Hi,
>>> I am a student, and learning RCU now, but still know very little about =
it.
>>> Are there any documents/papers/materials which (in)formally define and =
explain
>>> RCU consistency guarantees?

>> You may want to have a look at

>> User-Level Implementations of Read-Copy Update
>> Article in IEEE Transactions on Parallel and Distributed Systems 23(2):3=
75 - 382
>> =C2=B7 March 2012

> Thanks for your info.
> However, I do not think URCU talks about any consistency model formally.

> From previous communication with Paul, he said RCU is not designed for
> linearizability, and it is totally acceptable that RCU is not linearizabl=
e.
> However, I am curious how to accurately/formally Characterize RCU consist=
ency
> model/guarantees

Adding Paul E. McKenney in CC.=20

I am referring to the section "Overview of RCU semantics" in the paper. Not=
 sure it has the level of=20
formality you are looking for though. Paul, do you have pointers to additio=
nal material ?=20

Thanks,=20

Mathieu=20

>> as a starting point.

>> Thanks,

>> Mathieu

>>> I know there are some consistency models in the database area (such as =
PRAM,
>>> Read Uncommitted, etc) from [ https://jepsen.io/consistency |
>>> https://jepsen.io/consistency ] and [1].
>>> How does RCU related to those consistency models?

>>> I also found some comments online (One key distinction is that both MVC=
C and RLU
>>> provide much stronger consistency guarantees to readers than does RCU .=
..) ( [
>>> https://lwn.net/Articles/777036/ | https://lwn.net/Articles/777036/ ] )=
.
>>> I do not understand how we reason/dresibe/compare the consistency guara=
ntees. (
>>> I even do not know what consistency guarantees provided by RCU formally=
)
>>> Could someone explain this to me?

>>> [1] Bailis, P., Davidson, A., Fekete, A., Ghodsi, A., Hellerstein, J. M=
., &
>>> Stoica, I. (2013). Highly available transactions: Virtues and limitatio=
ns.
>>> Proceedings of the VLDB Endowment, 7(3), 181-192.

>>> Thanks
>>> Yuxin

>>> _______________________________________________
>>> lttng-dev mailing list
>>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]

>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> [ http://www.efficios.com/ | http://www.efficios.com ]

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_a750b78c-95fb-445c-8c13-4664ffae9078
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br data-mce-bogus=3D"1"></div><div><span i=
d=3D"zwchr" data-marker=3D"__DIVIDER__">----- On Dec 6, 2019, at 3:51 PM, Y=
uxin Ren &lt;ryx@gwmail.gwu.edu&gt; wrote:<br></span></div><div data-marker=
=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;mar=
gin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:norm=
al;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12=
pt;"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"elided-t=
ext"><div dir=3D"ltr">On Fri, Dec 6, 2019 at 5:49 AM Mathieu Desnoyers &lt;=
<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank" rel=3D"=
nofollow noopener noreferrer">mathieu.desnoyers@efficios.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb( 204 , 204 , 204 );padding-left:1ex"><div><div=
 style=3D"font-family:'arial' , 'helvetica' , sans-serif;font-size:12pt;col=
or:rgb( 0 , 0 , 0 )"><br><div><span id=3D"gmail-m_2574264377435822574zwchr"=
>----- On Dec 5, 2019, at 8:17 PM, Yuxin Ren &lt;<a href=3D"mailto:ryx@gwma=
il.gwu.edu" target=3D"_blank" rel=3D"nofollow noopener noreferrer">ryx@gwma=
il.gwu.edu</a>&gt; wrote:<br></span></div><div><blockquote style=3D"border-=
left:2px solid rgb( 16 , 16 , 255 );margin-left:5px;padding-left:5px;color:=
rgb( 0 , 0 , 0 );font-weight:normal;font-style:normal;text-decoration:none;=
font-family:'helvetica' , 'arial' , sans-serif;font-size:12pt"><div dir=3D"=
ltr">Hi,<br><div>I am a student, and learning RCU now, but still know very =
little about it.</div><div>Are there any documents/papers/materials which (=
in)formally define and explain RCU consistency&nbsp;guarantees?</div></div>=
</blockquote><br><div><div>You may want to have a look at<br></div><br><div=
>User-Level Implementations of Read-Copy Update</div><div>Article=E2=80=82i=
n=E2=80=82IEEE Transactions on Parallel and Distributed Systems 23(2):375 -=
 382 =C2=B7 March 2012</div></div></div></div></div></blockquote><br><div>T=
hanks for your info.</div><div>However, I do not think URCU talks about any=
 consistency&nbsp;model formally.&nbsp;</div><br><div>From previous&nbsp;co=
mmunication with&nbsp;Paul, he said RCU is not designed&nbsp;for&nbsp;linea=
rizability, and it is totally acceptable&nbsp;that RCU is not&nbsp;lineariz=
able.</div><div>However, I am curious how to accurately/formally&nbsp;Chara=
cterize RCU consistency&nbsp;model/guarantees</div></div></div></blockquote=
><div>Adding Paul E. McKenney in CC.<br data-mce-bogus=3D"1"></div><div><br=
 data-mce-bogus=3D"1"></div><div>I am referring to the section "Overview of=
 RCU semantics" in the paper. Not sure it has the level of<br data-mce-bogu=
s=3D"1"></div><div>formality you are looking for though. Paul, do you have =
pointers to additional material ?<br data-mce-bogus=3D"1"></div><div><br da=
ta-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><b=
r data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><di=
v><br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><block=
quote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5=
px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;fon=
t-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div =
class=3D"elided-text"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb( 204 , 204 , 204 );padding-left:1e=
x"><div><div style=3D"font-family:'arial' , 'helvetica' , sans-serif;font-s=
ize:12pt;color:rgb( 0 , 0 , 0 )"><div><div><br><div>as a starting point.</d=
iv><br></div><div><div><div>Thanks,</div><br><div>Mathieu</div></div><br></=
div><blockquote style=3D"border-left:2px solid rgb( 16 , 16 , 255 );margin-=
left:5px;padding-left:5px;color:rgb( 0 , 0 , 0 );font-weight:normal;font-st=
yle:normal;text-decoration:none;font-family:'helvetica' , 'arial' , sans-se=
rif;font-size:12pt"><div dir=3D"ltr"><br><div>I know there are some consist=
ency models in the database area (such as PRAM,&nbsp;Read Uncommitted, etc)=
 from&nbsp;<a href=3D"https://jepsen.io/consistency" rel=3D"nofollow noopen=
er noreferrer nofollow noopener noreferrer" target=3D"_blank">https://jepse=
n.io/consistency</a>&nbsp;and [1].</div><div>How does RCU related to those =
consistency models?</div><br><div>I also found some comments online (One ke=
y distinction is that both MVCC and RLU provide much stronger consistency g=
uarantees to readers than does RCU ...) (<a href=3D"https://lwn.net/Article=
s/777036/" rel=3D"nofollow noopener noreferrer nofollow noopener noreferrer=
" target=3D"_blank">https://lwn.net/Articles/777036/</a>).</div><div>I do n=
ot understand how we reason/dresibe/compare the consistency&nbsp;guarantees=
. ( I even do not know what consistency guarantees provided by RCU formally=
)</div><div>Could someone explain this&nbsp;to me?</div></div></blockquote>=
</div><div><br><blockquote style=3D"border-left:2px solid rgb( 16 , 16 , 25=
5 );margin-left:5px;padding-left:5px;color:rgb( 0 , 0 , 0 );font-weight:nor=
mal;font-style:normal;text-decoration:none;font-family:'helvetica' , 'arial=
' , sans-serif;font-size:12pt"><div dir=3D"ltr"><br><div>[1]&nbsp;Bailis, P=
., Davidson, A., Fekete, A., Ghodsi, A., Hellerstein, J. M., &amp; Stoica, =
I. (2013). Highly available transactions: Virtues and limitations. Proceedi=
ngs of the VLDB Endowment, 7(3), 181-192.</div><br><div>Thanks</div><font c=
olor=3D"#888888"><div>Yuxin</div></font></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank" rel=3D=
"nofollow noopener noreferrer">lttng-dev@lists.lttng.org</a><br><a href=3D"=
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blan=
k" rel=3D"nofollow noopener noreferrer">https://lists.lttng.org/cgi-bin/mai=
lman/listinfo/lttng-dev</a><br></blockquote></div><br><div>-- <br></div><di=
v>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com"=
 target=3D"_blank" rel=3D"nofollow noopener noreferrer">http://www.efficios=
.com</a><br data-mce-bogus=3D"1"></div></div></div></blockquote></div></div=
><br></blockquote></div><div><br></div><div data-marker=3D"__SIG_POST__">--=
 <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.c=
om</div></div></body></html>
--=_a750b78c-95fb-445c-8c13-4664ffae9078--

--===============7098162895546590200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7098162895546590200==--
