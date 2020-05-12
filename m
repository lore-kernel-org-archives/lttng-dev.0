From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Correctly using callstack-user context
Date: Tue, 12 May 2020 08:27:21 -0400 (EDT)
Message-ID: <1486835767.11198.1589286441675.JavaMail.zimbra@efficios.com>
References: <CAAS9doY1Ez7N=_H6e-w9eWg0LBJp+MMasuOEmzbO0DGyLSzViA@mail.gmail.com>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0376285538098370231=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49Lxrx03vzz21NC
 for <lttng-dev@lists.lttng.org>; Tue, 12 May 2020 08:27:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3C6D72AA686
 for <lttng-dev@lists.lttng.org>; Tue, 12 May 2020 08:27:22 -0400 (EDT)
In-Reply-To: <CAAS9doY1Ez7N=_H6e-w9eWg0LBJp+MMasuOEmzbO0DGyLSzViA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Christophe =?utf-8?Q?B=C3=A9dard?= <bedard.christophe@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0376285538098370231==
Content-Type: multipart/alternative;
	boundary="=_88a11504-6bad-472e-a687-87261d5e381b"

--=_88a11504-6bad-472e-a687-87261d5e381b
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On May 11, 2020, at 5:09 PM, lttng-dev <lttng-dev@lists.lttng.org> wrote: 

> Hi,
> As part of a big software safety certification effort, we are looking into
> making sure that some functions of our API do not allocate memory and do not
> use any blocking syscalls.

> This part is done and is working (using kmem_mm_page_{alloc,free} for memory
> allocations for now). However, if we do get memory allocations, we want to know
> where they're from. To do this, I've been looking at using the callstack-user
> context. However, I have a hard time getting more than 1 callstack-user
> address.

> I'm on 5.3.0-46-generic, i.e. CONFIG_ARCH_STACKWALK-compatible, from what I
> could find. I tried creating a minimal version using -fno-omit-frame-pointer &
> without any optimization, but I still get only one address in the
> callstack_user context when I know there should be at least a few.

> Note that this is running inside a Docker container, but lttng-modules is
> installed on the host, and a root session-daemon is running inside the Docker
> container. Also, I installed LTTng using the stable-2.11 Ubuntu PPA.

> Is there something I might be doing wrong? Am I supposed to compile
> lttng-modules from source in order to use the callstack-* contexts? I couldn't
> find much documentation about this, other than the brief mention in the 2.11
> docs.

How does your test program issue the system call ? Is it directly with syscall() (see syscall(2) man page), or 
does it call into libc ? Is your entire libc compiled with -fno-omit-frame-pointer ? 

As soon as one library in the chain to the system call is compiled without frame pointers, this is where the 
stack walk stops. This is usually libc. 

Thanks, 

Mathieu 

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_88a11504-6bad-472e-a687-87261d5e381b
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On May 11, 2020, at 5:09 PM, lttng-dev &lt;lttng-dev@lists.lttng.=
org&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockq=
uote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5p=
x;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font=
-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr">Hi,<br=
><div>As part of a big software safety certification effort, we are looking=
 into making sure that some functions of our API do not allocate memory and=
 do not use any blocking syscalls.</div><br><div>This part is done and is w=
orking (using kmem_mm_page_{alloc,free} for memory allocations for now). Ho=
wever, if we do get memory allocations, we want to know where they're from.=
 To do this, I've been looking at using the callstack-user&nbsp;context. Ho=
wever, I have a hard time getting more than 1 callstack-user&nbsp;address.<=
/div><br><div>I'm on 5.3.0-46-generic, i.e. CONFIG_ARCH_STACKWALK-compatibl=
e, from what I could find. I tried creating a minimal version using -fno-om=
it-frame-pointer &amp; without any optimization, but I still get only one a=
ddress in the callstack_user context when I know there should be at least a=
 few.</div><br><div>Note that this is running inside a Docker container, bu=
t lttng-modules is installed on the host, and a root session-daemon is runn=
ing inside the Docker container. Also, I installed LTTng using the stable-2=
.11 Ubuntu PPA.</div><br><div>Is there something I might be doing wrong? Am=
 I supposed to compile lttng-modules from source in order to use the callst=
ack-* contexts? I couldn't find much&nbsp;documentation about this,&nbsp;ot=
her than the brief mention in the 2.11 docs.</div></div></blockquote><div><=
br></div><div>How does your test program issue the system call ? Is it dire=
ctly with syscall() (see syscall(2) man page), or<br data-mce-bogus=3D"1"><=
/div><div>does it call into libc ? Is your entire libc compiled with -fno-o=
mit-frame-pointer ?<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div>As soon as one library in the chain to the system call is=
 compiled without frame pointers, this is where the<br data-mce-bogus=3D"1"=
></div><div>stack walk stops. This is usually libc.<br data-mce-bogus=3D"1"=
></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu</div></div><d=
iv><br data-mce-bogus=3D"1"></div><div data-marker=3D"__SIG_POST__">-- <br>=
</div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</d=
iv></div></body></html>
--=_88a11504-6bad-472e-a687-87261d5e381b--

--===============0376285538098370231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0376285538098370231==--
