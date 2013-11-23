From: Eduardo Silva <edsiper@gmail.com>
Subject: Re: Undefined reference to
	__tracepoint_provider_mk_linuxtrace
Date: Sat, 23 Nov 2013 11:40:34 -0600
Message-ID: <CAMAQheNFOJ4dk1VJBAW6eaV=C=fHH091SzBUJEfpn51Huuc6ng__47594.9038904675$1385228499$gmane$org@mail.gmail.com>
References: <CAMAQheOmZZfXiQiKQXONfupwUR=YBFZuogsDxj-0aSmQQ_uJKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0484023958=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <edsiper@gmail.com>) id 1VkHCC-0002WM-Gy
	for lttng-dev@lists.lttng.org; Sat, 23 Nov 2013 12:40:46 -0500
Received: by mail-ve0-f174.google.com with SMTP id pa12so1787881veb.19
	for <lttng-dev@lists.lttng.org>; Sat, 23 Nov 2013 09:40:35 -0800 (PST)
In-Reply-To: <CAMAQheOmZZfXiQiKQXONfupwUR=YBFZuogsDxj-0aSmQQ_uJKw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0484023958==
Content-Type: multipart/alternative; boundary=089e013c70b8cb4d6f04ebdba082

--089e013c70b8cb4d6f04ebdba082
Content-Type: text/plain; charset=ISO-8859-1

as suggested on IRC, here is the code/instructions to reproduce the problem:

 $ git clone git://monkey-project.com/monkey
 $ cd monkey
 $ git checkout lttng
 $ ./configure --enable-plugins=liana --disable-plugins=* --linux-trace
 $ make

thanks



On Sat, Nov 23, 2013 at 11:24 AM, Eduardo Silva <edsiper@gmail.com> wrote:

> Hi,
>
> i am adding support of Lttng to monkey-project.com but the compiler is
> claiming an undefined reference, of course there is something wrong in my
> provider header but i am not able to catch the error.
>
> My code structure is as follows:
>
> monkey.c (src/monkey.c)
> ====================
> #define TRACEPOINT_DEFINE
> #include "mk_linuxtrace_provider.h"
>
> int main()
> {
>   ...
> }
>
>
> mk_linuxtrace_provider.h (src/include/mk_linuxtrace_provider.h)
> ====================================================
> #undef  TRACEPOINT_PROVIDER
> #define TRACEPOINT_PROVIDER mk_linuxtrace
>
> #undef  TRACEPOINT_INCLUDE
> #define TRACEPOINT_INCLUDE "mk_linuxtrace_provider.h"
>
> #if !defined(_MK_LINUXTRACE_PROVIDER_H) ||
> defined(TRACEPOINT_HEADER_MULTI_READ)
> #define _MK_LINUXTRACE_PROVIDER_H
> #include <lttng/tracepoint.h>
>
> TRACEPOINT_EVENT(
>                  mk_linuxtrace,
>                  message,
>                  TP_ARGS(char *, text),
>                  TP_FIELDS(ctf_string(message, text))
>                  )
>
> TRACEPOINT_LOGLEVEL(
>                     mk_linuxtrace,
>                     message,
>                     TRACE_WARNING)
> #endif
>
> #include <lttng/tracepoint-event.h>
>
> ---EOF---
>
> any help is appreciated,
>
> thanks
>
> --
> Eduardo Silva
> http://edsiper.linuxchile.cl
> http://monkey-project.com
>



-- 
Eduardo Silva
http://edsiper.linuxchile.cl
http://monkey-project.com

--089e013c70b8cb4d6f04ebdba082
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">as suggested on IRC, here is the code/instructions to repr=
oduce the problem:<div><br></div><div>=A0$ git clone git://<a href=3D"http:=
//monkey-project.com/monkey">monkey-project.com/monkey</a><br></div><div st=
yle>
=A0$ cd monkey</div><div style>=A0$ git checkout lttng</div><div style>=A0$=
 ./configure --enable-plugins=3Dliana --disable-plugins=3D* --linux-trace</=
div><div style>=A0$ make</div><div style><br></div><div style>thanks=A0</di=
v><div><br>
</div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">O=
n Sat, Nov 23, 2013 at 11:24 AM, Eduardo Silva <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:edsiper@gmail.com" target=3D"_blank">edsiper@gmail.com</a>&gt;<=
/span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi,=A0<div><br></div><div>i=
 am adding support of Lttng to <a href=3D"http://monkey-project.com" target=
=3D"_blank">monkey-project.com</a> but the compiler is claiming an undefine=
d reference, of course there is something wrong in my provider header but i=
 am not able to catch the error.=A0</div>

<div><br></div><div>My code structure is as follows:</div><div><br></div><d=
iv><div>monkey.c (src/monkey.c)=A0</div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>#define TRACEPOINT_DEFINE</div><di=
v>#include &quot;mk_linuxtrace_provider.h&quot;</div>

<div><br></div><div>int main()</div><div>{</div><div>=A0 ...</div><div>}</d=
iv><div><br></div><div><br></div><div>mk_linuxtrace_provider.h (src/include=
/mk_linuxtrace_provider.h)</div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>

<div>#undef =A0TRACEPOINT_PROVIDER</div><div>#define TRACEPOINT_PROVIDER mk=
_linuxtrace</div><div><br></div><div>#undef =A0TRACEPOINT_INCLUDE</div><div=
>#define TRACEPOINT_INCLUDE &quot;mk_linuxtrace_provider.h&quot;</div><div>

<br></div><div>#if !defined(_MK_LINUXTRACE_PROVIDER_H) || defined(TRACEPOIN=
T_HEADER_MULTI_READ)</div><div>#define _MK_LINUXTRACE_PROVIDER_H</div><div>=
#include &lt;lttng/tracepoint.h&gt;</div><div><br></div><div>TRACEPOINT_EVE=
NT(</div>

<div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mk_linuxtrace,</div><div>=A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0message,</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0TP_ARGS(char *, text),</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
TP_FIELDS(ctf_string(message, text))</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0)</div>

<div><br></div><div>TRACEPOINT_LOGLEVEL(</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 mk_linuxtrace,</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 message,</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TRACE_WA=
RNING)</div><div>#endif</div><div><br></div><div>#include &lt;lttng/tracepo=
int-event.h&gt;</div>

<div><br></div><div>---EOF---</div><div><br></div><div>any help is apprecia=
ted,=A0</div><div><br></div><div>thanks</div><span class=3D"HOEnZb"><font c=
olor=3D"#888888"><div><br></div><div>--=A0<br></div></font></span></div><sp=
an class=3D"HOEnZb"><font color=3D"#888888"><div>
<div dir=3D"ltr">Eduardo Silva<br>
<a href=3D"http://edsiper.linuxchile.cl" target=3D"_blank">http://edsiper.l=
inuxchile.cl</a><br><a href=3D"http://monkey-project.com" target=3D"_blank"=
>http://monkey-project.com</a></div>
</div></font></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div dir=3D"=
ltr">Eduardo Silva<br><a href=3D"http://edsiper.linuxchile.cl" target=3D"_b=
lank">http://edsiper.linuxchile.cl</a><br><a href=3D"http://monkey-project.=
com" target=3D"_blank">http://monkey-project.com</a></div>

</div>

--089e013c70b8cb4d6f04ebdba082--


--===============0484023958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0484023958==--
