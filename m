From: Francis Deslauriers <francis.deslauriers@mail.utoronto.ca>
Subject: Re: lttng for android
Date: Fri, 5 Dec 2014 10:17:01 -0500
Message-ID: <CADcCL0hN_cRfLBTw2dE9A7_SO7rWZfMyNhVS+EevctyAF9W1oA__13926.3181052685$1417792717$gmane$org@mail.gmail.com>
References: <5ecef07d.ad2c.14a19fa11dd.Coremail.xiechao_mail@163.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1725219372=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-by2on0057.outbound.protection.outlook.com ([207.46.100.57]
 helo=na01-by2-obe.outbound.protection.outlook.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <francis.deslauriers@mail.utoronto.ca>)
 id 1XwudT-0008Cd-MW
 for lttng-dev@lists.lttng.org; Fri, 05 Dec 2014 10:17:37 -0500
Received: by mail-qc0-f170.google.com with SMTP id x3so588836qcv.15
 for <lttng-dev@lists.lttng.org>; Fri, 05 Dec 2014 07:17:21 -0800 (PST)
In-Reply-To: <5ecef07d.ad2c.14a19fa11dd.Coremail.xiechao_mail@163.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Chao Xie <xiechao_mail@163.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1725219372==
Content-Type: multipart/alternative; boundary="001a11c25236c2fecb05097992ec"

--001a11c25236c2fecb05097992ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chao,

There has been some work going on to port LTTng to Android but I don't
think it's upstream yet.
You can try to apply the patchset that Charles Bri=C3=A8re has submitted ea=
rlier
this fall[1] but since
those are big changes it takes more time the review and test them.
Don't hesitate to share you experience with us.

Have a look at the archives of the mailing list.

[1] http://lists.lttng.org/pipermail/lttng-dev/2014-October/023678.html


Cheers,

Francis

On Fri, Dec 5, 2014 at 5:23 AM, Chao Xie <xiechao_mail@163.com> wrote:

>
>
> Hi
> If i want to collect the trace data from the target system which is the
> android platform with ARM chip, how can i compile the lttng and collect t=
he
> trace data?
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--001a11c25236c2fecb05097992ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:12.7272720336914px">Hi Chao,</spa=
n><div style=3D"font-size:12.7272720336914px"><br></div><div style=3D"font-=
size:12.7272720336914px">There has been some work going on to port LTTng to=
 Android but I don&#39;t think it&#39;s upstream yet.</div><div style=3D"fo=
nt-size:12.7272720336914px">You can try to apply the patchset that Charles =
Bri=C3=A8re has submitted earlier this fall[1] but since=C2=A0</div><div st=
yle=3D"font-size:12.7272720336914px">those are big changes it takes more ti=
me the review and test them.=C2=A0</div><div style=3D"font-size:12.72727203=
36914px">Don&#39;t hesitate to share you experience with us.</div><div styl=
e=3D"font-size:12.7272720336914px"><br></div><div style=3D"font-size:12.727=
2720336914px">Have a look at the archives of the mailing list.</div><div st=
yle=3D"font-size:12.7272720336914px"><br></div><div style=3D"font-size:12.7=
272720336914px">[1]=C2=A0<a href=3D"http://lists.lttng.org/pipermail/lttng-=
dev/2014-October/023678.html" target=3D"_blank">http://lists.lttng.org/pipe=
rmail/lttng-dev/2014-October/023678.html</a><br></div><div style=3D"font-si=
ze:12.7272720336914px"><br></div><div style=3D"font-size:12.7272720336914px=
"><br></div><div style=3D"font-size:12.7272720336914px">Cheers,</div><div s=
tyle=3D"font-size:12.7272720336914px"><br></div><div style=3D"font-size:12.=
7272720336914px">Francis</div></div><div class=3D"gmail_extra"><br><div cla=
ss=3D"gmail_quote">On Fri, Dec 5, 2014 at 5:23 AM, Chao Xie <span dir=3D"lt=
r">&lt;<a href=3D"mailto:xiechao_mail@163.com" target=3D"_blank">xiechao_ma=
il@163.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
Hi<br>
If i want to collect the trace data from the target system which is the and=
roid platform with ARM chip, how can i compile the lttng and collect the tr=
ace data?<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</blockquote></div><br></div>

--001a11c25236c2fecb05097992ec--


--===============1725219372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1725219372==--
