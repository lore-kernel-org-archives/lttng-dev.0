From: Yuxin Ren <ryx@gwmail.gwu.edu>
Subject: Re: RCU consistency guarantees
Date: Fri, 6 Dec 2019 09:51:32 -0500
Message-ID: <CAAKbDreZ8NerP-jsxezOmN3rktVSAk1a=RJw2YQY83UpQRrXfQ__41393.5417238221$1575643930$gmane$org@mail.gmail.com>
References: <CAAKbDrdMRrhnSzpPBZLf3nNUDW4YZLPkZkTD5gNJu+A9rATkWA@mail.gmail.com>
 <194534011.751.1575629349181.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7949053342543689592=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 by lists.lttng.org (Postfix) with ESMTPS id 47TwXN6pc2z11fr
 for <lttng-dev@lists.lttng.org>; Fri,  6 Dec 2019 09:51:48 -0500 (EST)
Received: by mail-lj1-x236.google.com with SMTP id c19so7894618lji.11
 for <lttng-dev@lists.lttng.org>; Fri, 06 Dec 2019 06:51:48 -0800 (PST)
In-Reply-To: <194534011.751.1575629349181.JavaMail.zimbra@efficios.com>
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

--===============7949053342543689592==
Content-Type: multipart/alternative; boundary="00000000000059ff2805990a2f47"

--00000000000059ff2805990a2f47
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2019 at 5:49 AM Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

>
> ----- On Dec 5, 2019, at 8:17 PM, Yuxin Ren <ryx@gwmail.gwu.edu> wrote:
>
> Hi,
> I am a student, and learning RCU now, but still know very little about it=
.
> Are there any documents/papers/materials which (in)formally define and
> explain RCU consistency guarantees?
>
>
> You may want to have a look at
>
> User-Level Implementations of Read-Copy Update
> Article in IEEE Transactions on Parallel and Distributed Systems 23(2):37=
5
> - 382 =C2=B7 March 2012
>

Thanks for your info.
However, I do not think URCU talks about any consistency model formally.

From previous communication with Paul, he said RCU is not
designed for linearizability, and it is totally acceptable that RCU is
not linearizable.
However, I am curious how to accurately/formally Characterize RCU
consistency model/guarantees

>
> as a starting point.
>
> Thanks,
>
> Mathieu
>
>
> I know there are some consistency models in the database area (such as
> PRAM, Read Uncommitted, etc) from https://jepsen.io/consistency and [1].
> How does RCU related to those consistency models?
>
> I also found some comments online (One key distinction is that both MVCC
> and RLU provide much stronger consistency guarantees to readers than does
> RCU ...) (https://lwn.net/Articles/777036/).
> I do not understand how we reason/dresibe/compare the
> consistency guarantees. ( I even do not know what consistency guarantees
> provided by RCU formally)
> Could someone explain this to me?
>
>
>
> [1] Bailis, P., Davidson, A., Fekete, A., Ghodsi, A., Hellerstein, J. M.,
> & Stoica, I. (2013). Highly available transactions: Virtues and
> limitations. Proceedings of the VLDB Endowment, 7(3), 181-192.
>
> Thanks
> Yuxin
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

--00000000000059ff2805990a2f47
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 6, 2019 at 5:49 AM Mathie=
u Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.d=
esnoyers@efficios.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"><div><div style=3D"font-family:arial,helvetica,sans-se=
rif;font-size:12pt;color:rgb(0,0,0)"><div><br></div><div><span id=3D"gmail-=
m_2574264377435822574zwchr">----- On Dec 5, 2019, at 8:17 PM, Yuxin Ren &lt=
;<a href=3D"mailto:ryx@gwmail.gwu.edu" target=3D"_blank">ryx@gwmail.gwu.edu=
</a>&gt; wrote:<br></span></div><div><blockquote style=3D"border-left:2px s=
olid rgb(16,16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font-=
weight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,=
Arial,sans-serif;font-size:12pt"><div dir=3D"ltr">Hi,<br><div>I am a studen=
t, and learning RCU now, but still know very little about it.</div><div>Are=
 there any documents/papers/materials which (in)formally define and explain=
 RCU consistency=C2=A0guarantees?</div></div></blockquote><div><br></div><d=
iv><div>You may want to have a look at<br></div><div><br></div><div>User-Le=
vel Implementations of Read-Copy Update</div><div>Article=E2=80=82in=E2=80=
=82IEEE Transactions on Parallel and Distributed Systems 23(2):375 - 382 =
=C2=B7 March 2012</div></div></div></div></div></blockquote><div><br></div>=
<div>Thanks for your info.</div><div>However, I do not think URCU talks abo=
ut any consistency=C2=A0model formally.=C2=A0</div><div><br></div><div>From=
 previous=C2=A0communication with=C2=A0Paul, he said RCU is not designed=C2=
=A0for=C2=A0linearizability, and it is totally acceptable=C2=A0that RCU is =
not=C2=A0linearizable.</div><div>However, I am curious how to accurately/fo=
rmally=C2=A0Characterize RCU consistency=C2=A0model/guarantees</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><div><div style=3D"font-family:a=
rial,helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><div><div><div><=
br></div><div>as a starting point.</div><br></div><div><div><div>Thanks,</d=
iv><div><br></div><div>Mathieu</div></div><div><br></div></div><blockquote =
style=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;padding-left:=
5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration:n=
one;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"=
><br><div>I know there are some consistency models in the database area (su=
ch as PRAM,=C2=A0Read Uncommitted, etc) from=C2=A0<a href=3D"https://jepsen=
.io/consistency" rel=3D"nofollow noopener noreferrer" target=3D"_blank">htt=
ps://jepsen.io/consistency</a>=C2=A0and [1].</div><div>How does RCU related=
 to those consistency models?</div><br><div>I also found some comments onli=
ne (One key distinction is that both MVCC and RLU provide much stronger con=
sistency guarantees to readers than does RCU ...) (<a href=3D"https://lwn.n=
et/Articles/777036/" rel=3D"nofollow noopener noreferrer" target=3D"_blank"=
>https://lwn.net/Articles/777036/</a>).</div><div>I do not understand how w=
e reason/dresibe/compare the consistency=C2=A0guarantees. ( I even do not k=
now what consistency guarantees provided by RCU formally)</div><div>Could s=
omeone explain this=C2=A0to me?</div></div></blockquote></div><div><br><blo=
ckquote style=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;paddi=
ng-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-deco=
ration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=
=3D"ltr"><br><div>[1]=C2=A0Bailis, P., Davidson, A., Fekete, A., Ghodsi, A.=
, Hellerstein, J. M., &amp; Stoica, I. (2013). Highly available transaction=
s: Virtues and limitations. Proceedings of the VLDB Endowment, 7(3), 181-19=
2.</div><br><div>Thanks</div><font color=3D"#888888"><div>Yuxin</div></font=
></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-=
dev@lists.lttng.org</a><br><a href=3D"https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-bin/ma=
ilman/listinfo/lttng-dev</a><br></blockquote></div><div><br></div><div>-- <=
br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.e=
fficios.com" target=3D"_blank">http://www.efficios.com</a></div></div></div=
></blockquote></div></div>

--00000000000059ff2805990a2f47--

--===============7949053342543689592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7949053342543689592==--
