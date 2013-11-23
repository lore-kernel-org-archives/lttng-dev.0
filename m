From: Eduardo Silva <edsiper@gmail.com>
Subject: Undefined reference to
	__tracepoint_provider_mk_linuxtrace
Date: Sat, 23 Nov 2013 11:24:07 -0600
Message-ID: <CAMAQheOmZZfXiQiKQXONfupwUR=YBFZuogsDxj-0aSmQQ_uJKw__22024.7276629836$1385227523$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1752902449=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f50.google.com ([209.85.212.50])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <edsiper@gmail.com>) id 1VkGwH-0004B0-MS
	for lttng-dev@lists.lttng.org; Sat, 23 Nov 2013 12:24:19 -0500
Received: by mail-vb0-f50.google.com with SMTP id 10so1719636vbe.37
	for <lttng-dev@lists.lttng.org>; Sat, 23 Nov 2013 09:24:08 -0800 (PST)
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

--===============1752902449==
Content-Type: multipart/alternative; boundary=047d7bdc192cf7ca6304ebdb65b4

--047d7bdc192cf7ca6304ebdb65b4
Content-Type: text/plain; charset=ISO-8859-1

Hi,

i am adding support of Lttng to monkey-project.com but the compiler is
claiming an undefined reference, of course there is something wrong in my
provider header but i am not able to catch the error.

My code structure is as follows:

monkey.c (src/monkey.c)
====================
#define TRACEPOINT_DEFINE
#include "mk_linuxtrace_provider.h"

int main()
{
  ...
}


mk_linuxtrace_provider.h (src/include/mk_linuxtrace_provider.h)
====================================================
#undef  TRACEPOINT_PROVIDER
#define TRACEPOINT_PROVIDER mk_linuxtrace

#undef  TRACEPOINT_INCLUDE
#define TRACEPOINT_INCLUDE "mk_linuxtrace_provider.h"

#if !defined(_MK_LINUXTRACE_PROVIDER_H) ||
defined(TRACEPOINT_HEADER_MULTI_READ)
#define _MK_LINUXTRACE_PROVIDER_H
#include <lttng/tracepoint.h>

TRACEPOINT_EVENT(
                 mk_linuxtrace,
                 message,
                 TP_ARGS(char *, text),
                 TP_FIELDS(ctf_string(message, text))
                 )

TRACEPOINT_LOGLEVEL(
                    mk_linuxtrace,
                    message,
                    TRACE_WARNING)
#endif

#include <lttng/tracepoint-event.h>

---EOF---

any help is appreciated,

thanks

-- 
Eduardo Silva
http://edsiper.linuxchile.cl
http://monkey-project.com

--047d7bdc192cf7ca6304ebdb65b4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,=A0<div><br></div><div>i am adding support of Lttng to =
<a href=3D"http://monkey-project.com">monkey-project.com</a> but the compil=
er is claiming an undefined reference, of course there is something wrong i=
n my provider header but i am not able to catch the error.=A0</div>
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
<div><br></div><div style>---EOF---</div><div style><br></div><div style>an=
y help is appreciated,=A0</div><div style><br></div><div style>thanks</div>=
<div><br></div><div>--=A0<br></div></div><div><div dir=3D"ltr">Eduardo Silv=
a<br>
<a href=3D"http://edsiper.linuxchile.cl" target=3D"_blank">http://edsiper.l=
inuxchile.cl</a><br><a href=3D"http://monkey-project.com" target=3D"_blank"=
>http://monkey-project.com</a></div>
</div></div>

--047d7bdc192cf7ca6304ebdb65b4--


--===============1752902449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1752902449==--
