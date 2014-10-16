From: Anand Neeli <anand.neeli@gmail.com>
Subject: compilation warning
Date: Thu, 16 Oct 2014 23:13:32 +0530
Message-ID: <CAM5kDqz4vYK2aDoRzXu3=LpjFVa2p0M38uidO2qG6JC0x9-n3w__20902.6507138789$1413481482$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0436964950=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1Xep5N-0001AU-V6
 for lttng-dev@lists.lttng.org; Thu, 16 Oct 2014 13:43:41 -0400
Received: by mail-wi0-f172.google.com with SMTP id n3so93188wiv.5
 for <lttng-dev@lists.lttng.org>; Thu, 16 Oct 2014 10:43:32 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0436964950==
Content-Type: multipart/alternative; boundary=001a11c1b6ca7658f005058dc95c

--001a11c1b6ca7658f005058dc95c
Content-Type: text/plain; charset=UTF-8

Hi All,
I get following warning during compilation of my instrumented module.
I know i can suppress this, but just wanted to get to your notice.


In file included from /usr/include/lttng/ust-tracepoint-event.h:26:0,

                 from /usr/include/lttng/tracepoint-event.h:58,

                 from src/common_tracepoint.h:135,

                 from src/common_tracepoint.c:10:

/usr/include/i386-linux-gnu/urcu/rculist.h: In function 'cds_list_del_rcu':

/usr/include/i386-linux-gnu/urcu/rculist.h:72:2: error: to be safe all
intermediate pointers in cast from 'struct cds_list_head **' to 'struct
cds_list_head * volatile*' must be 'const' qualified [-Werror=cast-qual]



Thanks,

Anand Neeli

--001a11c1b6ca7658f005058dc95c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div>I get following warning during compilation of =
my instrumented module.</div><div>I know i can suppress this, but just want=
ed to get to your notice.</div><div>







<p><br></p>
<p>In file included from /usr/include/lttng/ust-tracepoint-event.h:26:0,</p=
>
<p>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from /usr/=
include/lttng/tracepoint-event.h:58,</p>
<p>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from src/c=
ommon_tracepoint.h:135,</p>
<p>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from src/c=
ommon_tracepoint.c:10:</p>
<p>/usr/include/i386-linux-gnu/urcu/rculist.h: In function &#39;cds_list_de=
l_rcu&#39;:</p><p>/usr/include/i386-linux-gnu/urcu/rculist.h:72:2: error: t=
o be safe all intermediate pointers in cast from &#39;struct cds_list_head =
**&#39; to &#39;struct cds_list_head * volatile*&#39; must be &#39;const&#3=
9; qualified [-Werror=3Dcast-qual]</p>
<p><br></p><p><br></p><p>Thanks,</p><p>Anand Neeli</p></div></div>

--001a11c1b6ca7658f005058dc95c--


--===============0436964950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0436964950==--
