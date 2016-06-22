From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: rculfhash: memory leak
Date: Wed, 22 Jun 2016 20:27:52 +0000 (UTC)
Message-ID: <359376533.45668.1466627272227.JavaMail.zimbra__9915.9166020856$1466627309$gmane$org@efficios.com>
References: <1466591182.908422886@f279.i.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3395701959846150435=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 2EA8DA2E0D
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jun 2016 20:27:58 +0000 (UTC)
In-Reply-To: <1466591182.908422886@f279.i.mail.ru>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?utf-8?B?0JTQtdC90LjRgSDQmtC+0YDQtdGI0LrQvtCy?= <dynamic-wind@mail.ru>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

--===============3395701959846150435==
Content-Type: multipart/alternative;
	boundary="----=_Part_45667_1110883712.1466627272227"

------=_Part_45667_1110883712.1466627272227
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Jun 22, 2016, at 6:26 AM, =D0=94=D0=B5=D0=BD=D0=B8=D1=81 =D0=9A=D0=
=BE=D1=80=D0=B5=D1=88=D0=BA=D0=BE=D0=B2 <dynamic-wind@mail.ru> wrote:=20

> Hello,
> there's a small memory leak in the rculfhash observed under FreeBSD-10 wh=
en
> destroying a table.
> The line
> pthread_mutex_init(&ht->resize_mutex, NULL);
> actually calloc's some memory for resize_mutex, and there should be a cal=
l to
> pthread_mutex_destroy(3) in cds_lfht_destroy to free it. There's no such =
call
> in the latest (0.9.2) Userspace RCU.
> Cheers!
Hi,=20

Thanks for letting me know! It appears that Linux don't allocate=20
memory for those,which might be why I never stumbled on those=20
issues.=20

I just pushed the following string of commits, also taking care of=20
similar issues with wfcqueue, wfqueue, wfstack and lfstack APIs.=20
I add to add new "destroy" API to those to handle this.=20

commit 2af1c19e6a553878fcb2a5106f050d5ed7ac0f54=20
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>=20
Date: Wed Jun 22 16:21:43 2016 -0400=20

Fix: tests: invoke destroy APIs for queues/stacks=20

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>=20

commit 200d100e05ed8e10c47f971939042f2406df92ef=20
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>=20
Date: Wed Jun 22 16:20:25 2016 -0400=20

Fix: add missing destroy functions to queues/stack APIs=20

Queues and stack APIs that invoke pthread_mutex_init() should have a=20
"destroy" counterpart which calls pthread_mutex_destroy(), ortherwise=20
this causes small memory leaks on platforms where pthread_mutex_init=20
performs memory allocation.=20

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>=20

commit b4edfa8157bb45827c3236809e550b4d13c0ae22=20
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>=20
Date: Wed Jun 22 16:17:37 2016 -0400=20

Fix: add missing __cds_wfcq_init for LGPL API=20

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>=20

commit 59629f09c1ee8395b1e22797a6924703e825e345=20
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>=20
Date: Wed Jun 22 15:50:21 2016 -0400=20

Fix: memory leak on hash table destroy=20

There is a missing call to pthread_mutex_destroy(3) to match=20
pthread_mutex_init(3) in the hash table creation.=20

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>=20

Thanks,=20

Mathieu=20

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_45667_1110883712.1466627272227
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Jun 22, 2016, at 6:26 AM, =D0=94=D0=B5=D0=BD=D0=B8=D1=81 =D0=
=9A=D0=BE=D1=80=D0=B5=D1=88=D0=BA=D0=BE=D0=B2 &lt;dynamic-wind@mail.ru&gt; =
wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockquote sty=
le=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:=
#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:=
Helvetica,Arial,sans-serif;font-size:12pt;">Hello,<br>there's a small memor=
y leak in the rculfhash observed under FreeBSD-10 when destroying a table.&=
nbsp;<br>The line<br>pthread_mutex_init(&amp;ht-&gt;resize_mutex, NULL);<br=
>actually calloc's some memory for resize_mutex, and there should be a call=
 to pthread_mutex_destroy(3) in cds_lfht_destroy to free it. There's no suc=
h call in the latest (0.9.2) Userspace RCU.<br>Cheers!</blockquote><div>Hi,=
<br></div><div><br data-mce-bogus=3D"1"></div><div>Thanks for letting me kn=
ow! It appears that Linux don't allocate</div><div>memory for those,which m=
ight be why I never stumbled on those</div><div>issues.<br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>I just pushed the fol=
lowing string of commits, also taking care of<br data-mce-bogus=3D"1"></div=
><div>similar issues with wfcqueue, wfqueue, wfstack and lfstack APIs.<br d=
ata-mce-bogus=3D"1"></div><div>I add to add new "destroy" API to those to h=
andle this.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></d=
iv><div>commit 2af1c19e6a553878fcb2a5106f050d5ed7ac0f54<br>Author: Mathieu =
Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;<br>Date: Wed Jun 22 16:21:=
43 2016 -0400<br><br> Fix: tests: invoke destroy APIs for queues/stacks<br>=
 <br> Signed-off-by: Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&g=
t;<br><br>commit 200d100e05ed8e10c47f971939042f2406df92ef<br>Author: Mathie=
u Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;<br>Date: Wed Jun 22 16:2=
0:25 2016 -0400<br><br> Fix: add missing destroy functions to queues/stack =
APIs<br> <br> Queues and stack APIs that invoke pthread_mutex_init() should=
 have a<br> "destroy" counterpart which calls pthread_mutex_destroy(), orth=
erwise<br> this causes small memory leaks on platforms where pthread_mutex_=
init<br> performs memory allocation.<br> <br> Signed-off-by: Mathieu Desnoy=
ers &lt;mathieu.desnoyers@efficios.com&gt;<br><br>commit b4edfa8157bb45827c=
3236809e550b4d13c0ae22<br>Author: Mathieu Desnoyers &lt;mathieu.desnoyers@e=
fficios.com&gt;<br>Date: Wed Jun 22 16:17:37 2016 -0400<br><br> Fix: add mi=
ssing __cds_wfcq_init for LGPL API<br> <br> Signed-off-by: Mathieu Desnoyer=
s &lt;mathieu.desnoyers@efficios.com&gt;<br><br>commit 59629f09c1ee8395b1e2=
2797a6924703e825e345<br>Author: Mathieu Desnoyers &lt;mathieu.desnoyers@eff=
icios.com&gt;<br>Date: Wed Jun 22 15:50:21 2016 -0400<br><br> Fix: memory l=
eak on hash table destroy<br> <br> There is a missing call to pthread_mutex=
_destroy(3) to match<br> pthread_mutex_init(3) in the hash table creation.<=
br> <br> Signed-off-by: Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.co=
m&gt;<br></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce=
-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data=
-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote styl=
e=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#=
000;font-weight:normal;font-style:normal;text-decoration:none;font-family:H=
elvetica,Arial,sans-serif;font-size:12pt;"><br><br>________________________=
_______________________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.=
org<br>https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></bloc=
kquote></div><div><br></div><div data-marker=3D"__SIG_POST__">-- <br></div>=
<div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></d=
iv></body></html>
------=_Part_45667_1110883712.1466627272227--

--===============3395701959846150435==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3395701959846150435==--
