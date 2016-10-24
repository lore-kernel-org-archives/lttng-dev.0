From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: LTTng-modules with RT kernel
Date: Mon, 24 Oct 2016 17:30:54 +0000 (UTC)
Message-ID: <235909180.1299.1477330254016.JavaMail.zimbra__35028.0790044509$1477330268$gmane$org@efficios.com>
References: <CAAqXYd31SHfHyrW2SWrBe8EmbQnAc1dwNXy0xo+EXXLXYaEung@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3657978641746315571=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 7A309A0E51
 for <lttng-dev@lists.lttng.org>; Mon, 24 Oct 2016 17:30:59 +0000 (UTC)
In-Reply-To: <CAAqXYd31SHfHyrW2SWrBe8EmbQnAc1dwNXy0xo+EXXLXYaEung@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Gaylord Charles <gaylord.charles@veo-labs.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3657978641746315571==
Content-Type: multipart/alternative;
	boundary="=_8e7912c2-12a6-4c85-9b15-2ad56e7df00f"

--=_8e7912c2-12a6-4c85-9b15-2ad56e7df00f
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Oct 24, 2016, at 11:23 AM, Gaylord Charles <gaylord.charles@veo-labs.com> wrote: 

> Hello,

> I am currently testing LTTng latest versions with a PREEMPT_RT kernel
> (4.6.7-rt12). I've got:
> - LTTng-modules 2.8.3
> - LTTng-tools 2.8.2
> - LTTng-UST 2.8.1

> When calling "lttng create", the following message appears:
> Cannot add context lttng_add_preemptible_to_ctx
> Cannot add context lttng_add_migratable_to_ctx

> A quick look at the source code (lttng-context.c) makes me wonder if there could
> be a bug. The "lttng_add_preemptible_to_ctx" function returns 0, so if my
> understanding is correct, there is no problem.
> Do I miss something ?

Fix pushed into master, stable-2.9, and stable-2.8 of lttng-modules: 

commit d0e59d6f099f4663cc62bffb59d960cd4235064f 
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> 
Date: Mon Oct 24 13:27:01 2016 -0400 

Fix: preemptible and migratable context error handling 

When built against preempt-rt and preempt kernels, the "return 0" case 
means success, but lttng-modules incorrectly prints an error in the 
kernel log. 

Given that we handle the -ENOSYS error in lttng_context_init, there is 
no need to keep the ifdefs in that function. 

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> 

Thanks for reporting! 

Mathieu 

> Regards.
> Gaylord

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_8e7912c2-12a6-4c85-9b15-2ad56e7df00f
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><span id=3D"zwchr"=
 data-marker=3D"__DIVIDER__">----- On Oct 24, 2016, at 11:23 AM, Gaylord Ch=
arles &lt;gaylord.charles@veo-labs.com&gt; wrote:<br></span><div data-marke=
r=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;ma=
rgin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:nor=
mal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:1=
2pt;"><div dir=3D"ltr"><div><div><div><div><div><div><div><div>Hello,<br><b=
r></div>I am currently testing LTTng latest versions with a PREEMPT_RT kern=
el (4.6.7-rt12). I've got:<br></div>&nbsp;- LTTng-modules 2.8.3<br></div>&n=
bsp;- LTTng-tools 2.8.2<br></div>&nbsp;- LTTng-UST 2.8.1<br><br></div>When =
calling "lttng create", the following message appears: <br>&nbsp;&nbsp;&nbs=
p;&nbsp; Cannot add context lttng_add_preemptible_to_ctx<br>&nbsp;&nbsp;&nb=
sp;&nbsp; Cannot add context lttng_add_migratable_to_ctx<br><br></div>A qui=
ck look at the source code (lttng-context.c) makes me wonder if there could=
 be a bug. The "lttng_add_preemptible_to_ctx" function returns 0, so if my =
understanding is correct, there is no problem.<br></div>Do I miss something=
 ?</div></div></blockquote><div><br></div><div>Fix pushed into master, stab=
le-2.9, and stable-2.8 of lttng-modules:<br data-mce-bogus=3D"1"></div><div=
><br data-mce-bogus=3D"1"></div><div>commit d0e59d6f099f4663cc62bffb59d960c=
d4235064f<br>Author: Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&g=
t;<br>Date:&nbsp;&nbsp; Mon Oct 24 13:27:01 2016 -0400<br><br>&nbsp;&nbsp;&=
nbsp; Fix: preemptible and migratable context error handling<br>&nbsp;&nbsp=
;&nbsp; <br>&nbsp;&nbsp;&nbsp; When built against preempt-rt and preempt ke=
rnels, the "return 0" case<br>&nbsp;&nbsp;&nbsp; means success, but lttng-m=
odules incorrectly prints an error in the<br>&nbsp;&nbsp;&nbsp; kernel log.=
<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; Given that we handle the -ENO=
SYS error in lttng_context_init, there is<br>&nbsp;&nbsp;&nbsp; no need to =
keep the ifdefs in that function.<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nb=
sp; Signed-off-by: Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;=
<br><br data-mce-bogus=3D"1"></div><div>Thanks for reporting!<br data-mce-b=
ogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-m=
ce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div><br data-mce-=
bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010FF;margin=
-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;=
text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;=
"><div dir=3D"ltr"><div><br><br></div>Regards.<br><div><div><div><div><div>=
<div><div><div><div>Gaylord<br></div></div></div></div></div></div></div></=
div></div></div><br>_______________________________________________<br>lttn=
g-dev mailing list<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/=
cgi-bin/mailman/listinfo/lttng-dev<br></blockquote></div><br><div data-mark=
er=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br=
>http://www.efficios.com</div></div></body></html>
--=_8e7912c2-12a6-4c85-9b15-2ad56e7df00f--

--===============3657978641746315571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3657978641746315571==--
