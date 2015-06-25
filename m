From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [lttng-tools 2.5] [Backport]Missing include for out
	of tree build
Date: Thu, 25 Jun 2015 11:52:09 -0400
Message-ID: <CA+jJMxuVX9tJGNY8S2htcZGU2Tp-zxgtHDRfbwGQfexNAqiMZg__36734.7402651378$1435247627$gmane$org@mail.gmail.com>
References: <54CAB978.5060407@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1317911245=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Z89Rn-00042Z-M9
 for lttng-dev@lists.lttng.org; Thu, 25 Jun 2015 11:52:24 -0400
Received: by padev16 with SMTP id ev16so52118522pad.0
 for <lttng-dev@lists.lttng.org>; Thu, 25 Jun 2015 08:52:10 -0700 (PDT)
In-Reply-To: <54CAB978.5060407@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============1317911245==
Content-Type: multipart/alternative; boundary=047d7b15fcb72fe69c0519599b9d

--047d7b15fcb72fe69c0519599b9d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Necro-bumping this to confirm this was merged as in stable-2.5 on Fri Feb 6
15:42:07 2015 -0500.

Thanks!
J=C3=A9r=C3=A9mie

On Thu, Jan 29, 2015 at 5:51 PM, Jonathan Rajotte Julien <
Jonathan.rajotte-julien@efficios.com> wrote:

> Hey,
>
> While making sure we support out of tree build for lttng-tools
> master/stable-2.6/stable-2.5 I found that 2.5 was failing at oot build.
> After some digging, it looks like a patch submitted to fix this problem w=
as
> not backported to 2.5.
>
> The commit in question currently in master and 2.6 branch :
>
> commit 4900d3cd9c4accc131a6a79986151cf3e6236031
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Tue Jul 29 18:10:27 2014 -0400
>
>     Fix: out of tree build by adding missing ini.c include
>
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>     Signed-off-by: David Goulet <dgoulet@efficios.com>
>
> diff --git a/src/common/config/ini.c b/src/common/config/ini.c
> index 4369a32..7b2a4b6 100644
> --- a/src/common/config/ini.c
> +++ b/src/common/config/ini.c
> @@ -31,9 +31,11 @@
>   * http://code.google.com/p/inih/
>   */
>
> +#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <ctype.h>
>  #include <string.h>
> +#include <common/common.h>
>
>  #include "ini.h"
>
> Cheers!
>
> --
> Jonathan R. Julien
> Efficios
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7b15fcb72fe69c0519599b9d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Necro-bumping this to confirm this was merged as in stable=
-2.5 on=C2=A0Fri Feb 6 15:42:07 2015 -0500.<div><br></div><div>Thanks!</div=
><div>J=C3=A9r=C3=A9mie</div></div><div class=3D"gmail_extra"><br><div clas=
s=3D"gmail_quote">On Thu, Jan 29, 2015 at 5:51 PM, Jonathan Rajotte Julien =
<span dir=3D"ltr">&lt;<a href=3D"mailto:Jonathan.rajotte-julien@efficios.co=
m" target=3D"_blank">Jonathan.rajotte-julien@efficios.com</a>&gt;</span> wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">Hey,<br>
<br>
While making sure we support out of tree build for lttng-tools master/stabl=
e-2.6/stable-2.5 I found that 2.5 was failing at oot build.=C2=A0 After som=
e digging, it looks like a patch submitted to fix this problem was not back=
ported to 2.5.<br>
<br>
The commit in question currently in master and 2.6 branch :<br>
<br>
commit 4900d3cd9c4accc131a6a79986151cf3e6236031<br>
Author: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.=
com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<br>
Date:=C2=A0 =C2=A0Tue Jul 29 18:10:27 2014 -0400<br>
<br>
=C2=A0 =C2=A0 Fix: out of tree build by adding missing ini.c include<br>
<br>
=C2=A0 =C2=A0 Signed-off-by: Mathieu Desnoyers &lt;<a href=3D"mailto:mathie=
u.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com<=
/a>&gt;<br>
=C2=A0 =C2=A0 Signed-off-by: David Goulet &lt;<a href=3D"mailto:dgoulet@eff=
icios.com" target=3D"_blank">dgoulet@efficios.com</a>&gt;<br>
<br>
diff --git a/src/common/config/ini.c b/src/common/config/ini.c<br>
index 4369a32..7b2a4b6 100644<br>
--- a/src/common/config/ini.c<br>
+++ b/src/common/config/ini.c<br>
@@ -31,9 +31,11 @@<br>
=C2=A0 * <a href=3D"http://code.google.com/p/inih/" rel=3D"noreferrer" targ=
et=3D"_blank">http://code.google.com/p/inih/</a><br>
=C2=A0 */<br>
<br>
+#define _GNU_SOURCE<br>
=C2=A0#include &lt;stdio.h&gt;<br>
=C2=A0#include &lt;ctype.h&gt;<br>
=C2=A0#include &lt;string.h&gt;<br>
+#include &lt;common/common.h&gt;<br>
<br>
=C2=A0#include &quot;ini.h&quot;<br>
<br>
Cheers!<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
-- <br>
Jonathan R. Julien<br>
Efficios<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div>

--047d7b15fcb72fe69c0519599b9d--


--===============1317911245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1317911245==--
