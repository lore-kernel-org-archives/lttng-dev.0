From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Undefined reference
	to	__tracepoint_provider_mk_linuxtrace
Date: Sat, 23 Nov 2013 17:45:04 +0000 (UTC)
Message-ID: <1694077371.74375.1385228704275.JavaMail.zimbra__47799.716590862$1385228762$gmane$org@efficios.com>
References: <CAMAQheOmZZfXiQiKQXONfupwUR=YBFZuogsDxj-0aSmQQ_uJKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0510360106=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VkHGT-0004Ls-N0
	for lttng-dev@lists.lttng.org; Sat, 23 Nov 2013 12:45:11 -0500
In-Reply-To: <CAMAQheOmZZfXiQiKQXONfupwUR=YBFZuogsDxj-0aSmQQ_uJKw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Eduardo Silva <edsiper@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0510360106==
Content-Type: multipart/alternative;
	boundary="----=_Part_74374_1812179875.1385228704274"

------=_Part_74374_1812179875.1385228704274
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> From: "Eduardo Silva" <edsiper@gmail.com>
> To: lttng-dev@lists.lttng.org
> Sent: Saturday, November 23, 2013 12:24:07 PM
> Subject: [lttng-dev] Undefined reference to
> __tracepoint_provider_mk_linuxtrace

> Hi,

> i am adding support of Lttng to monkey-project.com but the compiler is
> claiming an undefined reference, of course there is something wrong in my
> provider header but i am not able to catch the error.

> My code structure is as follows:

> monkey.c (src/monkey.c)
> ====================
> #define TRACEPOINT_DEFINE

You'll want to add: 

#define TRACEPOINT_CREATE_PROBES 

here. It is missing from the lttng-ust(3) man page though. I'll fix it. 

Thanks, 

Mathieu 

> #include "mk_linuxtrace_provider.h"

> int main()
> {
> ...
> }

> mk_linuxtrace_provider.h (src/include/mk_linuxtrace_provider.h)
> ====================================================
> #undef TRACEPOINT_PROVIDER
> #define TRACEPOINT_PROVIDER mk_linuxtrace

> #undef TRACEPOINT_INCLUDE
> #define TRACEPOINT_INCLUDE "mk_linuxtrace_provider.h"

> #if !defined(_MK_LINUXTRACE_PROVIDER_H) ||
> defined(TRACEPOINT_HEADER_MULTI_READ)
> #define _MK_LINUXTRACE_PROVIDER_H
> #include <lttng/tracepoint.h>

> TRACEPOINT_EVENT(
> mk_linuxtrace,
> message,
> TP_ARGS(char *, text),
> TP_FIELDS(ctf_string(message, text))
> )

> TRACEPOINT_LOGLEVEL(
> mk_linuxtrace,
> message,
> TRACE_WARNING)
> #endif

> #include <lttng/tracepoint-event.h>

> ---EOF---

> any help is appreciated,

> thanks

> --
> Eduardo Silva
> http://edsiper.linuxchile.cl
> http://monkey-project.com

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_74374_1812179875.1385228704274
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div><br></div><div><br></div><hr id=
=3D"zwchr"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5=
px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-de=
coration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><b>Fr=
om: </b>"Eduardo Silva" &lt;edsiper@gmail.com&gt;<br><b>To: </b>lttng-dev@l=
ists.lttng.org<br><b>Sent: </b>Saturday, November 23, 2013 12:24:07 PM<br><=
b>Subject: </b>[lttng-dev] Undefined reference to&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;__tracepoint_provider_mk_linuxtrace<br><div><br></div=
><div dir=3D"ltr">Hi,&nbsp;<div><br></div><div>i am adding support of Lttng=
 to <a href=3D"http://monkey-project.com" target=3D"_blank">monkey-project.=
com</a> but the compiler is claiming an undefined reference, of course ther=
e is something wrong in my provider header but i am not able to catch the e=
rror.&nbsp;</div><div><br></div><div>My code structure is as follows:</div>=
<div><br></div><div><div>monkey.c (src/monkey.c)&nbsp;</div><div>=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>#define TRACE=
POINT_DEFINE</div></div></div></blockquote><div><br></div><div>You'll want =
to add:<br></div><div><br></div><div>#define TRACEPOINT_CREATE_PROBES<br></=
div><div><br></div><div>here. It is missing from the lttng-ust(3) man page =
though. I'll fix it.<br></div><div><br></div><div>Thanks,<br></div><div><br=
></div><div>Mathieu<br></div><blockquote style=3D"border-left:2px solid #10=
10FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-st=
yle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font=
-size:12pt;"><div dir=3D"ltr"><div><div>#include "mk_linuxtrace_provider.h"=
</div><div><br></div><div>int main()</div><div>{</div><div>&nbsp; ...</div>=
<div>}</div><div><br></div><div><br></div><div>mk_linuxtrace_provider.h (sr=
c/include/mk_linuxtrace_provider.h)</div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>#undef &nb=
sp;TRACEPOINT_PROVIDER</div><div>#define TRACEPOINT_PROVIDER mk_linuxtrace<=
/div><div><br></div><div>#undef &nbsp;TRACEPOINT_INCLUDE</div><div>#define =
TRACEPOINT_INCLUDE "mk_linuxtrace_provider.h"</div><div><br></div><div>#if =
!defined(_MK_LINUXTRACE_PROVIDER_H) || defined(TRACEPOINT_HEADER_MULTI_READ=
)</div><div>#define _MK_LINUXTRACE_PROVIDER_H</div><div>#include &lt;lttng/=
tracepoint.h&gt;</div><div><br></div><div>TRACEPOINT_EVENT(</div><div>&nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;mk_linuxtrace,</di=
v><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;messag=
e,</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
TP_ARGS(char *, text),</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;TP_FIELDS(ctf_string(message, text))</div><div>&nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;)</div><div><br></div=
><div>TRACEPOINT_LOGLEVEL(</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; mk_linuxtrace,</div><div>&nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; message,</div><div>&nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TRACE_WAR=
NING)</div><div>#endif</div><div><br></div><div>#include &lt;lttng/tracepoi=
nt-event.h&gt;</div><div><br></div><div style=3D"">---EOF---</div><div styl=
e=3D""><br></div><div style=3D"">any help is appreciated,&nbsp;</div><div s=
tyle=3D""><br></div><div style=3D"">thanks</div><div><br></div><div>--&nbsp=
;<br></div></div><div><div dir=3D"ltr">Eduardo Silva<br><a href=3D"http://e=
dsiper.linuxchile.cl" target=3D"_blank">http://edsiper.linuxchile.cl</a><br=
><a href=3D"http://monkey-project.com" target=3D"_blank">http://monkey-proj=
ect.com</a><br data-mce-bogus=3D"1"></div></div></div><br>_________________=
______________________________<br>lttng-dev mailing list<br>lttng-dev@lists=
.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br>=
</blockquote><div><br><br></div><div><br></div><div>-- <br></div><div><span=
 name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficio=
s.com<span name=3D"x"></span><br></div></div></body></html>
------=_Part_74374_1812179875.1385228704274--


--===============0510360106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0510360106==--
