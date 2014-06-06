From: Antoine Busque <antoine.busque@efficios.com>
Subject: [PATCH lttng-modules] Fix: blktrace instrumentation for
	backported branches
Date: Fri, 6 Jun 2014 18:00:59 -0400
Message-ID: <CA+MZcXvcHsLm3y5hyTSU718OfPF5cP2A_+XOoesOJ6898iK-mQ__2583.20778743855$1402092107$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0292646121=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <nintendopro@gmail.com>) id 1Wt2C9-0004Jg-NA
 for lttng-dev@lists.lttng.org; Fri, 06 Jun 2014 18:01:07 -0400
Received: by mail-pd0-f174.google.com with SMTP id r10so2925100pdi.33
 for <lttng-dev@lists.lttng.org>; Fri, 06 Jun 2014 15:00:59 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0292646121==
Content-Type: multipart/alternative; boundary=e89a8f13ed2029565e04fb31ffdb

--e89a8f13ed2029565e04fb31ffdb
Content-Type: text/plain; charset=UTF-8

The following commit from kernel 3.15 changing the API of a block layer
tracepoint has been backported to multiple branches:

commit af5040da01ef980670b3741b3e10733ee3e33566
Author: Roman Pen <r.peniaev@gmail.com>
Date:   Tue Mar 4 23:13:10 2014 +0900

    blktrace: fix accounting of partially completed requests

This patch fixes the resulting build failure by adding the proper
version checks. The versions and corresponding commit SHA-1 hashes are
as follow:

   3.2.58
       commit 5b85afa68e4f56c27f1d5c6f49e5257bce6448e6

   3.4.91
       commit 14eee5bd065d6aac0acbdc6092a25ba68c55b9c8

   3.10.41
       commit e9d933941569c107e0083c3c115467c699a57db2

   3.12.21
       commit 5104b40a981d26212ced149fbd43ad0b6b72910b

   3.14.15
       commit 0a8eda9c00ef37e8b40de77f2b0714317191bcf2

Signed-off-by: Antoine Busque <antoine.busque@efficios.com>
---
 instrumentation/events/lttng-module/block.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/instrumentation/events/lttng-module/block.h
b/instrumentation/events/lttng-module/block.h
index 4f3460e..5684153 100644
--- a/instrumentation/events/lttng-module/block.h
+++ b/instrumentation/events/lttng-module/block.h
@@ -221,8 +221,11 @@ DEFINE_EVENT(block_rq_with_error, block_rq_requeue,
     TP_ARGS(q, rq)
 )

-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)    \
-    || LTTNG_KERNEL_RANGE(3,2,58, 3,3,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,5)    \
+    || LTTNG_KERNEL_RANGE(3,2,58, 3,3,0)        \
+    || LTTNG_KERNEL_RANGE(3,4,91, 3,5,1)        \
+    || LTTNG_KERNEL_RANGE(3,10,41, 3,11,0)        \
+    || LTTNG_KERNEL_RANGE(3,12,21, 3,13,0))

 /**
  * block_rq_complete - block IO operation completed by device driver
-- 
2.0.0

--e89a8f13ed2029565e04fb31ffdb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The following commit from kernel 3.15 changing the API of =
a block layer<br>tracepoint has been backported to multiple branches:<br><b=
r>commit af5040da01ef980670b3741b3e10733ee3e33566<br>Author: Roman Pen &lt;=
<a href=3D"mailto:r.peniaev@gmail.com">r.peniaev@gmail.com</a>&gt;<br>
Date:=C2=A0=C2=A0 Tue Mar 4 23:13:10 2014 +0900<br><br>=C2=A0=C2=A0=C2=A0 b=
lktrace: fix accounting of partially completed requests<br><br>This patch f=
ixes the resulting build failure by adding the proper<br>version checks. Th=
e versions and corresponding commit SHA-1 hashes are<br>
as follow:<br><br>=C2=A0=C2=A0 3.2.58<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 commit 5b85afa68e4f56c27f1d5c6f49e5257bce6448e6<br><br>=C2=A0=C2=A0 3.4=
.91<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit 14eee5bd065d6aac0acbdc60=
92a25ba68c55b9c8<br><br>=C2=A0=C2=A0 3.10.41<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 commit e9d933941569c107e0083c3c115467c699a57db2<br>
<br>=C2=A0=C2=A0 3.12.21<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit 510=
4b40a981d26212ced149fbd43ad0b6b72910b<br><br>=C2=A0=C2=A0 3.14.15<br>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit 0a8eda9c00ef37e8b40de77f2b0714317191b=
cf2<br><br>Signed-off-by: Antoine Busque &lt;<a href=3D"mailto:antoine.busq=
ue@efficios.com">antoine.busque@efficios.com</a>&gt;<br>
---<br>=C2=A0instrumentation/events/lttng-module/block.h | 7 +++++--<br>=C2=
=A01 file changed, 5 insertions(+), 2 deletions(-)<br><br>diff --git a/inst=
rumentation/events/lttng-module/block.h b/instrumentation/events/lttng-modu=
le/block.h<br>
index 4f3460e..5684153 100644<br>--- a/instrumentation/events/lttng-module/=
block.h<br>+++ b/instrumentation/events/lttng-module/block.h<br>@@ -221,8 +=
221,11 @@ DEFINE_EVENT(block_rq_with_error, block_rq_requeue,<br>=C2=A0=C2=
=A0=C2=A0=C2=A0 TP_ARGS(q, rq)<br>
=C2=A0)<br>=C2=A0<br>-#if (LINUX_VERSION_CODE &gt;=3D KERNEL_VERSION(3,15,0=
)=C2=A0=C2=A0=C2=A0 \<br>-=C2=A0=C2=A0=C2=A0 || LTTNG_KERNEL_RANGE(3,2,58, =
3,3,0))<br>+#if (LINUX_VERSION_CODE &gt;=3D KERNEL_VERSION(3,14,5)=C2=A0=C2=
=A0=C2=A0 \<br>+=C2=A0=C2=A0=C2=A0 || LTTNG_KERNEL_RANGE(3,2,58, 3,3,0)=C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 \<br>
+=C2=A0=C2=A0=C2=A0 || LTTNG_KERNEL_RANGE(3,4,91, 3,5,1)=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 \<br>+=C2=A0=C2=A0=C2=A0 || LTTNG_KERNEL_RANGE(3,10,41, =
3,11,0)=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 \<br>+=C2=A0=C2=A0=C2=A0 || LT=
TNG_KERNEL_RANGE(3,12,21, 3,13,0))<br>=C2=A0<br>=C2=A0/**<br>=C2=A0 * block=
_rq_complete - block IO operation completed by device driver<br>
-- <br>2.0.0<br><br><br></div>

--e89a8f13ed2029565e04fb31ffdb--


--===============0292646121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0292646121==--
