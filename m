From: =?utf-8?q?Christophe_B=C3=A9dard_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Subject: Correctly using callstack-user context
Date: Mon, 11 May 2020 17:09:40 -0400
Message-ID: <CAAS9doY1Ez7N=_H6e-w9eWg0LBJp+MMasuOEmzbO0DGyLSzViA@mail.gmail.com>
Reply-To: =?UTF-8?Q?Christophe_B=C3=A9dard?= <bedard.christophe@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4328271482442741472=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by lists.lttng.org (Postfix) with ESMTPS id 49LYVd6llXz20cb
 for <lttng-dev@lists.lttng.org>; Mon, 11 May 2020 17:10:17 -0400 (EDT)
Received: by mail-ej1-x635.google.com with SMTP id se13so2491897ejb.9
 for <lttng-dev@lists.lttng.org>; Mon, 11 May 2020 14:10:17 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============4328271482442741472==
Content-Type: multipart/alternative; boundary="000000000000077bb905a565c63c"

--000000000000077bb905a565c63c
Content-Type: text/plain; charset="UTF-8"

Hi,

As part of a big software safety certification effort, we are looking into
making sure that some functions of our API do not allocate memory and do
not use any blocking syscalls.

This part is done and is working (using kmem_mm_page_{alloc,free} for
memory allocations for now). However, if we do get memory allocations, we
want to know where they're from. To do this, I've been looking at using the
callstack-user context. However, I have a hard time getting more than 1
callstack-user address.

I'm on 5.3.0-46-generic, i.e. CONFIG_ARCH_STACKWALK-compatible, from what I
could find. I tried creating a minimal version using
-fno-omit-frame-pointer & without any optimization, but I still get only
one address in the callstack_user context when I know there should be at
least a few.

Note that this is running inside a Docker container, but lttng-modules is
installed on the host, and a root session-daemon is running inside the
Docker container. Also, I installed LTTng using the stable-2.11 Ubuntu PPA.

Is there something I might be doing wrong? Am I supposed to compile
lttng-modules from source in order to use the callstack-* contexts? I
couldn't find much documentation about this, other than the brief mention
in the 2.11 docs.

Regards,


Christophe

--000000000000077bb905a565c63c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>As part of a big software safety ce=
rtification effort, we are looking into making sure that some functions of =
our API do not allocate memory and do not use any blocking syscalls.</div><=
div><br></div><div>This part is done and is working (using kmem_mm_page_{al=
loc,free} for memory allocations for now). However, if we do get memory all=
ocations, we want to know where they&#39;re from. To do this, I&#39;ve been=
 looking at using the callstack-user=C2=A0context. However, I have a hard t=
ime getting more than 1 callstack-user=C2=A0address.</div><div><br></div><d=
iv>I&#39;m on 5.3.0-46-generic, i.e. CONFIG_ARCH_STACKWALK-compatible, from=
 what I could find. I tried creating a minimal version using -fno-omit-fram=
e-pointer &amp; without any optimization, but I still get only one address =
in the callstack_user context when I know there should be at least a few.</=
div><div><br></div><div>Note that this is running inside a Docker container=
, but lttng-modules is installed on the host, and a root session-daemon is =
running inside the Docker container. Also, I installed LTTng using the stab=
le-2.11 Ubuntu PPA.</div><div><br></div><div>Is there something I might be =
doing wrong? Am I supposed to compile lttng-modules from source in order to=
 use the callstack-* contexts? I couldn&#39;t find much=C2=A0documentation =
about this,=C2=A0other than the brief mention in the 2.11 docs.</div><div><=
br></div><div>Regards,</div><div><br></div><div><br></div><div>Christophe</=
div></div>

--000000000000077bb905a565c63c--

--===============4328271482442741472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4328271482442741472==--
