From: Evgeniy Ivanov <i@eivanov.com>
Subject: Re: Both liburcu-bp.so and liburcu-qsbr linked to binary
Date: Thu, 24 Nov 2016 11:39:29 +0300
Message-ID: <CAO6Ho0fDbjEZM8=NQR2DFCLcXHJPOygEx54v=QEddPJFnsPSSQ__27072.1206245527$1479976780$gmane$org@mail.gmail.com>
References: <CAO6Ho0c7RikfKbafPLEMPpEksEr6m=rx-4ipqAn8651MjkodTw@mail.gmail.com>
 <782004345.12395.1479918162583.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9175209182662675190=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 by lists.lttng.org (Postfix) with ESMTPS id 3tPXjL580qzmhG
 for <lttng-dev@lists.lttng.org>; Thu, 24 Nov 2016 08:40:54 +0000 (UTC)
Received: by mail-io0-x243.google.com with SMTP id r94so4326109ioe.1
 for <lttng-dev@lists.lttng.org>; Thu, 24 Nov 2016 00:39:30 -0800 (PST)
In-Reply-To: <782004345.12395.1479918162583.JavaMail.zimbra@efficios.com>
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

--===============9175209182662675190==
Content-Type: multipart/alternative; boundary=94eb2c19d4ea9eb5b8054207f18c

--94eb2c19d4ea9eb5b8054207f18c
Content-Type: text/plain; charset=UTF-8

Thank you, Mathieu!

On Wed, Nov 23, 2016 at 7:22 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> ----- On Nov 23, 2016, at 4:13 AM, Evgeniy Ivanov <i@eivanov.com> wrote:
>
> Hi,
> My program uses QSBR (together with CDS). Also we use lttng-ust for
> performance analyses. In maps I see that both liburcu-bp.so (dependency
> from liblttng-ust-tracepoint.so) and liburcu-qsbr.so are linked. Can it
> potentially break anything? Is it possible to rebuild lttng-ust with QSBR?
>
> It won't break anything, and no, it is not possible to use qsbr for
> lttng-ust.
>
> You end up having different RCU "domains" within your application, which is
> allright.
>
> Thanks,
>
> Mathieu
>
>
>
>
> --
> Cheers,
> Evgeniy
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



-- 
Cheers,
Evgeniy

--94eb2c19d4ea9eb5b8054207f18c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you, Mathieu!</div><div class=3D"gmail_extra"><br><d=
iv class=3D"gmail_quote">On Wed, Nov 23, 2016 at 7:22 PM, Mathieu Desnoyers=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" ta=
rget=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex"><div><div style=3D"font-family:arial,helvetica,=
sans-serif;font-size:12pt;color:#000000"><span class=3D""><div><span id=3D"=
m_-8708080386672804290zwchr">----- On Nov 23, 2016, at 4:13 AM, Evgeniy Iva=
nov &lt;<a href=3D"mailto:i@eivanov.com" target=3D"_blank">i@eivanov.com</a=
>&gt; wrote:<br></span></div></span><div><span class=3D""><blockquote style=
=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr">Hi,<br><div>My pr=
ogram uses QSBR (together with CDS). Also we use lttng-ust for performance =
analyses. In maps I see that both liburcu-bp.so (dependency from liblttng-u=
st-tracepoint.so)=C2=A0<wbr>and=C2=A0liburcu-qsbr.so are linked. Can it pot=
entially break anything? Is it possible to rebuild lttng-ust with QSBR?</di=
v></div></blockquote></span><div>It won&#39;t break anything, and no, it is=
 not possible to use qsbr for lttng-ust.<br></div><div><br></div><div>You e=
nd up having different RCU &quot;domains&quot; within your application, whi=
ch is<br></div><div>allright.<br></div><div><br></div><div>Thanks,<br></div=
><div><br></div><div>Mathieu<br></div><div><br></div><div><br></div><blockq=
uote style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5p=
x;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font=
-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div><b=
r clear=3D"all"><span class=3D"HOEnZb"><font color=3D"#888888"><br>-- <br><=
div class=3D"m_-8708080386672804290gmail_signature">Cheers,<br>Evgeniy</div=
></font></span></div></div><span class=3D"HOEnZb"><font color=3D"#888888"><=
br>______________________________<wbr>_________________<br>lttng-dev mailin=
g list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lt=
tng-dev@lists.lttng.org</a><br><a href=3D"https://lists.lttng.org/cgi-bin/m=
ailman/listinfo/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-<w=
br>bin/mailman/listinfo/lttng-dev</a><br></font></span></blockquote></div><=
span class=3D"HOEnZb"><font color=3D"#888888"><div><br></div><div>-- <br></=
div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.effici=
os.com" target=3D"_blank">http://www.efficios.com</a></div></font></span></=
div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><d=
iv class=3D"gmail_signature" data-smartmail=3D"gmail_signature">Cheers,<br>=
Evgeniy</div>
</div>

--94eb2c19d4ea9eb5b8054207f18c--

--===============9175209182662675190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============9175209182662675190==--
