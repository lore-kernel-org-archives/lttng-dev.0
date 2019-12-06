From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: RCU consistency guarantees
Date: Fri, 6 Dec 2019 05:49:09 -0500 (EST)
Message-ID: <194534011.751.1575629349181.JavaMail.zimbra__43626.0490723484$1575629380$gmane$org@efficios.com>
References: <CAAKbDrdMRrhnSzpPBZLf3nNUDW4YZLPkZkTD5gNJu+A9rATkWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7951139539516759308=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 47Tq8X4jFWz11bd
 for <lttng-dev@lists.lttng.org>; Fri,  6 Dec 2019 05:49:16 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id E619D35553F
 for <lttng-dev@lists.lttng.org>; Fri,  6 Dec 2019 05:49:09 -0500 (EST)
In-Reply-To: <CAAKbDrdMRrhnSzpPBZLf3nNUDW4YZLPkZkTD5gNJu+A9rATkWA@mail.gmail.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7951139539516759308==
Content-Type: multipart/alternative;
	boundary="=_6922dbbd-f2bd-4f89-981c-96d88c3c974d"

--=_6922dbbd-f2bd-4f89-981c-96d88c3c974d
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Dec 5, 2019, at 8:17 PM, Yuxin Ren <ryx@gwmail.gwu.edu> wrote:=20

> Hi,
> I am a student, and learning RCU now, but still know very little about it=
.
> Are there any documents/papers/materials which (in)formally define and ex=
plain
> RCU consistency guarantees?

You may want to have a look at=20

User-Level Implementations of Read-Copy Update=20
Article in IEEE Transactions on Parallel and Distributed Systems 23(2):375 =
- 382 =C2=B7 March 2012=20

as a starting point.=20

Thanks,=20

Mathieu=20

> I know there are some consistency models in the database area (such as PR=
AM,
> Read Uncommitted, etc) from [ https://jepsen.io/consistency |
> https://jepsen.io/consistency ] and [1].
> How does RCU related to those consistency models?

> I also found some comments online (One key distinction is that both MVCC =
and RLU
> provide much stronger consistency guarantees to readers than does RCU ...=
) ( [
> https://lwn.net/Articles/777036/ | https://lwn.net/Articles/777036/ ] ).
> I do not understand how we reason/dresibe/compare the consistency guarant=
ees. (
> I even do not know what consistency guarantees provided by RCU formally)
> Could someone explain this to me?

> [1] Bailis, P., Davidson, A., Fekete, A., Ghodsi, A., Hellerstein, J. M.,=
 &
> Stoica, I. (2013). Highly available transactions: Virtues and limitations=
.
> Proceedings of the VLDB Endowment, 7(3), 181-192.

> Thanks
> Yuxin

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_6922dbbd-f2bd-4f89-981c-96d88c3c974d
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br data-mce-bogus=3D"1"></div><div><span i=
d=3D"zwchr" data-marker=3D"__DIVIDER__">----- On Dec 5, 2019, at 8:17 PM, Y=
uxin Ren &lt;ryx@gwmail.gwu.edu&gt; wrote:<br></span></div><div data-marker=
=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;mar=
gin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:norm=
al;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12=
pt;"><div dir=3D"ltr">Hi,<br><div>I am a student, and learning RCU now, but=
 still know very little about it.</div><div>Are there any documents/papers/=
materials which (in)formally define and explain RCU consistency&nbsp;guaran=
tees?</div></div></blockquote><div><br></div><div><div>You may want to have=
 a look at<br></div><div><br></div><div>User-Level Implementations of Read-=
Copy Update</div><div>Article=E2=80=82in=E2=80=82IEEE Transactions on Paral=
lel and Distributed Systems 23(2):375 - 382 =C2=B7 March 2012</div><div><br=
></div><div>as a starting point.</div><br></div><div><div><div>Thanks,</div=
><div><br></div><div>Mathieu</div></div><div><br data-mce-bogus=3D"1"></div=
></div><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;p=
adding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decora=
tion:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=
=3D"ltr"><br><div>I know there are some consistency models in the database =
area (such as PRAM,&nbsp;Read Uncommitted, etc) from&nbsp;<a href=3D"https:=
//jepsen.io/consistency" target=3D"_blank" rel=3D"nofollow noopener norefer=
rer">https://jepsen.io/consistency</a>&nbsp;and [1].</div><div>How does RCU=
 related to those consistency models?</div><br><div>I also found some comme=
nts online (One key distinction is that both MVCC and RLU provide much stro=
nger consistency guarantees to readers than does RCU ...) (<a href=3D"https=
://lwn.net/Articles/777036/" target=3D"_blank" rel=3D"nofollow noopener nor=
eferrer">https://lwn.net/Articles/777036/</a>).</div><div>I do not understa=
nd how we reason/dresibe/compare the consistency&nbsp;guarantees. ( I even =
do not know what consistency guarantees provided by RCU formally)</div><div=
>Could someone explain this&nbsp;to me?</div></div></blockquote></div><div =
data-marker=3D"__QUOTED_TEXT__"><br><blockquote style=3D"border-left:2px so=
lid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;=
font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-ser=
if;font-size:12pt;"><div dir=3D"ltr"><br><div>[1]&nbsp;Bailis, P., Davidson=
, A., Fekete, A., Ghodsi, A., Hellerstein, J. M., &amp; Stoica, I. (2013). =
Highly available transactions: Virtues and limitations. Proceedings of the =
VLDB Endowment, 7(3), 181-192.</div><br><div>Thanks</div><font color=3D"#88=
8888"><div>Yuxin</div></font></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_6922dbbd-f2bd-4f89-981c-96d88c3c974d--

--===============7951139539516759308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7951139539516759308==--
