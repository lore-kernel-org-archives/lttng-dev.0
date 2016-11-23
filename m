From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Both liburcu-bp.so and liburcu-qsbr linked to binary
Date: Wed, 23 Nov 2016 16:22:42 +0000 (UTC)
Message-ID: <782004345.12395.1479918162583.JavaMail.zimbra__40450.2077064992$1479918115$gmane$org@efficios.com>
References: <CAO6Ho0c7RikfKbafPLEMPpEksEr6m=rx-4ipqAn8651MjkodTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2108006088448831777=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tP7156Shqzm6l
 for <lttng-dev@lists.lttng.org>; Wed, 23 Nov 2016 16:23:05 +0000 (UTC)
In-Reply-To: <CAO6Ho0c7RikfKbafPLEMPpEksEr6m=rx-4ipqAn8651MjkodTw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Evgeniy Ivanov <i@eivanov.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2108006088448831777==
Content-Type: multipart/alternative;
	boundary="=_b5b1d247-e8db-499e-9dfe-f5a1f6abd5d5"

--=_b5b1d247-e8db-499e-9dfe-f5a1f6abd5d5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Nov 23, 2016, at 4:13 AM, Evgeniy Ivanov <i@eivanov.com> wrote: 

> Hi,
> My program uses QSBR (together with CDS). Also we use lttng-ust for performance
> analyses. In maps I see that both liburcu-bp.so (dependency from
> liblttng-ust-tracepoint.so) and liburcu-qsbr.so are linked. Can it potentially
> break anything? Is it possible to rebuild lttng-ust with QSBR?

It won't break anything, and no, it is not possible to use qsbr for lttng-ust. 

You end up having different RCU "domains" within your application, which is 
allright. 

Thanks, 

Mathieu 

> --
> Cheers,
> Evgeniy

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_b5b1d247-e8db-499e-9dfe-f5a1f6abd5d5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Nov 23, 2016, at 4:13 AM, Evgeniy Ivanov &lt;i@eivanov.com&gt;=
 wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockquote st=
yle=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color=
:#000;font-weight:normal;font-style:normal;text-decoration:none;font-family=
:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr">Hi,<br><div>M=
y program uses QSBR (together with CDS). Also we use lttng-ust for performa=
nce analyses. In maps I see that both liburcu-bp.so (dependency from libltt=
ng-ust-tracepoint.so)&nbsp;and&nbsp;liburcu-qsbr.so are linked. Can it pote=
ntially break anything? Is it possible to rebuild lttng-ust with QSBR?</div=
></div></blockquote><div>It won't break anything, and no, it is not possibl=
e to use qsbr for lttng-ust.<br></div><div><br data-mce-bogus=3D"1"></div><=
div>You end up having different RCU "domains" within your application, whic=
h is<br data-mce-bogus=3D"1"></div><div>allright.<br data-mce-bogus=3D"1"><=
/div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"=
1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D=
"1"></div><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5p=
x;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-dec=
oration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div d=
ir=3D"ltr"><div><br clear=3D"all"><br>-- <br><div class=3D"gmail_signature"=
>Cheers,<br>Evgeniy</div></div></div><br>__________________________________=
_____________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>htt=
ps://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote></d=
iv><div><br></div><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathi=
eu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></body>=
</html>
--=_b5b1d247-e8db-499e-9dfe-f5a1f6abd5d5--

--===============2108006088448831777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2108006088448831777==--
