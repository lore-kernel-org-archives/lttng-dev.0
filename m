From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: enable-event wildcards
Date: Mon, 29 Apr 2019 12:03:24 -0400 (EDT)
Message-ID: <858603224.136.1556553804055.JavaMail.zimbra__31468.9169333846$1556553827$gmane$org@efficios.com>
References: <CAHryLm77cSdg4WDwYrfsCr9fHYyRH5rrQKq7O=Roq3k14_aVjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1281585701728403438=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44t8b76SV3z1L6l
 for <lttng-dev@lists.lttng.org>; Mon, 29 Apr 2019 12:03:31 -0400 (EDT)
In-Reply-To: <CAHryLm77cSdg4WDwYrfsCr9fHYyRH5rrQKq7O=Roq3k14_aVjQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Joe Sutker <jomasu22@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1281585701728403438==
Content-Type: multipart/alternative;
	boundary="=_12fb051e-2fc9-4d17-a84b-cd3065b34ac7"

--=_12fb051e-2fc9-4d17-a84b-cd3065b34ac7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Apr 29, 2019, at 11:13 AM, Joe Sutker <jomasu22@gmail.com> wrote: 

> Hello LTTng Devs,
> When using `lttng enable-event -u`, putting a wildcard anywhere but the end of
> the event name causes an error (Invalid event name). Is this intended behavior?
> If so, the man pages should probably be changed.

Remember to escape wildcards in a shell, else the shell expands it to matching filenames in your current working directory. e.g. 

lttng enable-event -u '*' 

Thanks, 

Mathieu 

> Thanks,

> Joe

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_12fb051e-2fc9-4d17-a84b-cd3065b34ac7
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><div><span id=3D"z=
wchr" data-marker=3D"__DIVIDER__">----- On Apr 29, 2019, at 11:13 AM, Joe S=
utker &lt;jomasu22@gmail.com&gt; wrote:<br></span></div><div data-marker=3D=
"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin=
-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;=
text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;=
"><div dir=3D"ltr">Hello LTTng Devs,<br><div>When using `lttng enable-event=
 -u`, putting a wildcard anywhere but the end of the&nbsp;event name causes=
 an error (Invalid event name). Is this intended behavior? If so, the man p=
ages should probably be changed.</div></div></blockquote><div>Remember to e=
scape wildcards in a shell, else the shell expands it to matching filenames=
 in your current working directory. e.g.<br></div><div><br data-mce-bogus=
=3D"1"></div><div>lttng enable-event -u '*'<br data-mce-bogus=3D"1"></div><=
div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></d=
iv><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"=
></div><div><br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></=
div><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padd=
ing-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoratio=
n:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"=
ltr"><br><div>Thanks,</div><br><div>Joe</div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_12fb051e-2fc9-4d17-a84b-cd3065b34ac7--

--===============1281585701728403438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1281585701728403438==--
