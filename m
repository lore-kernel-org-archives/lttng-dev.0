From: Yuxin Ren <ryx@gwmail.gwu.edu>
Subject: RCU consistency guarantees
Date: Thu, 5 Dec 2019 20:15:10 -0500
Message-ID: <CAAKbDreHuNhhFE6hvz=kUBGyUw9pi=Jp=iw_T1zFMZLzfVvAxA__46535.203773395$1575645491$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0022435181231759913=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by lists.lttng.org (Postfix) with ESMTPS id 47TZQQ17R8z10nJ
 for <lttng-dev@lists.lttng.org>; Thu,  5 Dec 2019 20:15:25 -0500 (EST)
Received: by mail-lf1-x130.google.com with SMTP id b15so3966598lfc.4
 for <lttng-dev@lists.lttng.org>; Thu, 05 Dec 2019 17:15:25 -0800 (PST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0022435181231759913==
Content-Type: multipart/alternative; boundary="000000000000c1cb7a0598fec713"

--000000000000c1cb7a0598fec713
Content-Type: text/plain; charset="UTF-8"

Hi,

I am a student, and learning RCU now, but still know very little about it.
Are there any documents/papers/materials which (in)formally define and
explain RCU consistency guarantees?

I know there are some consistency models in the database area (such as
PRAM, Read Uncommitted, etc) from https://jepsen.io/consistency and [1].
How does RCU related to those consistency models?

I also found some comments online (One key distinction is that both MVCC
and RLU provide much stronger consistency guarantees to readers than does
RCU ...) (https://lwn.net/Articles/777036/).
I do not understand how we reason/dresibe/compare the
consistency guarantees. ( I even do not know what consistency guarantees
provided by RCU formally)
Could someone explain this to me?

[1] Bailis, P., Davidson, A., Fekete, A., Ghodsi, A., Hellerstein, J. M., &
Stoica, I. (2013). Highly available transactions: Virtues and limitations.
Proceedings of the VLDB Endowment, 7(3), 181-192.

Thanks
Yuxin

--000000000000c1cb7a0598fec713
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I am a student, and learning RCU no=
w, but still know very little about it.</div><div>Are there any documents/p=
apers/materials which (in)formally define and explain RCU consistency=C2=A0=
guarantees?</div><div><br></div><div>I know there are some consistency mode=
ls in the database area (such as PRAM,=C2=A0Read Uncommitted, etc) from=C2=
=A0<a href=3D"https://jepsen.io/consistency">https://jepsen.io/consistency<=
/a> and [1].</div><div>How does RCU related to those consistency models?</d=
iv><div><br></div><div>I also found some comments online (One key distincti=
on is that both MVCC and RLU provide much stronger consistency guarantees t=
o readers than does RCU ...) (<a href=3D"https://lwn.net/Articles/777036/">=
https://lwn.net/Articles/777036/</a>).</div><div>I do not understand how we=
 reason/dresibe/compare the consistency=C2=A0guarantees. ( I even do not kn=
ow what consistency guarantees provided by RCU formally)</div><div>Could so=
meone explain this=C2=A0to me?</div><div><br></div><div>[1]=C2=A0Bailis, P.=
, Davidson, A., Fekete, A., Ghodsi, A., Hellerstein, J. M., &amp; Stoica, I=
. (2013). Highly available transactions: Virtues and limitations. Proceedin=
gs of the VLDB Endowment, 7(3), 181-192.</div><div><br></div><div>Thanks</d=
iv><div>Yuxin</div></div>

--000000000000c1cb7a0598fec713--

--===============0022435181231759913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0022435181231759913==--
