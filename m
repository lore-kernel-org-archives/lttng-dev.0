From: Michael Sullivan <sully@msully.net>
Subject: Re: Alternative to signals/sys_membarrier() in liburcu
Date: Thu, 12 Mar 2015 12:04:07 -0400
Message-ID: <CANW5cDkiZoysNM3rqb4v6Tj996ocsaSh=OZoBLfp4h7ZGb4bxg__10149.6212454096$1426179786$gmane$org@mail.gmail.com>
References: <CANW5cDmTCM9ZmhN7-2eWUEYvD+Y=sGt2i7mecdPTTLHMcT8fPg@mail.gmail.com>
 <867044376.285926.1426172227750.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1630573324=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <msully4321@gmail.com>) id 1YW5an-0003xQ-84
 for lttng-dev@lists.lttng.org; Thu, 12 Mar 2015 12:04:15 -0400
Received: by qcwr17 with SMTP id r17so19599132qcw.11
 for <lttng-dev@lists.lttng.org>; Thu, 12 Mar 2015 09:04:07 -0700 (PDT)
In-Reply-To: <867044376.285926.1426172227750.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1630573324==
Content-Type: multipart/alternative; boundary=001a11c0b36aa01cb90511198851

--001a11c0b36aa01cb90511198851
Content-Type: text/plain; charset=UTF-8

On Thu, Mar 12, 2015 at 10:57 AM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

>
> Even though it depends on internal behavior not currently specified by
> mprotect,
> I'd very much like to see the prototype you have,
>
>
I ended up posting my code at
https://github.com/msullivan/userspace-rcu/tree/msync-barrier.
The interesting patch is
https://github.com/msullivan/userspace-rcu/commit/04656b468d418efbc5d934ab07954eb8395a7ab0
.

Quick blog post I wrote about it at
http://www.msully.net/blog/2015/02/24/forcing-memory-barriers-on-other-cpus-with-mprotect2/
.
(I talked briefly about sys_membarrier in the post as best as I could piece
together from LKML; if my comment on it is inaccurate I can edit the post.)

-Michael Sullivan

--001a11c0b36aa01cb90511198851
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Thu, Mar 12, 2015 at 10:57 AM, Mathieu Desnoyers <span =
dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D=
"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<br><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><div><div style=3D"font-family:times new roman,new york,=
times,serif;font-size:12pt;color:rgb(0,0,0)"><br><div>Even though it depend=
s on internal behavior not currently specified by mprotect,<br></div><div>I=
&#39;d very much like to see the prototype you have,<br></div><div><br></di=
v></div></div></blockquote><div><br>I ended up posting my code at <a href=
=3D"https://github.com/msullivan/userspace-rcu/tree/msync-barrier">https://=
github.com/msullivan/userspace-rcu/tree/msync-barrier</a>.<br>The interesti=
ng patch is <a href=3D"https://github.com/msullivan/userspace-rcu/commit/04=
656b468d418efbc5d934ab07954eb8395a7ab0">https://github.com/msullivan/usersp=
ace-rcu/commit/04656b468d418efbc5d934ab07954eb8395a7ab0</a>.<br><br></div><=
div>Quick blog post I wrote about it at <a href=3D"http://www.msully.net/bl=
og/2015/02/24/forcing-memory-barriers-on-other-cpus-with-mprotect2/">http:/=
/www.msully.net/blog/2015/02/24/forcing-memory-barriers-on-other-cpus-with-=
mprotect2/</a>.<br></div><div>(I talked briefly about sys_membarrier in the=
 post as best as I could piece together from LKML; if my comment on it is i=
naccurate I can edit the post.)<br></div><div><br></div><div>-Michael Sulli=
van<br></div></div></div></div>

--001a11c0b36aa01cb90511198851--


--===============1630573324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1630573324==--
