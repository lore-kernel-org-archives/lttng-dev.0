From: Denis Yevgenyevich <denis.yevgenyevich@gmail.com>
Subject: liburcu's assertion failed when cannot allocate memory
Date: Thu, 15 Jun 2017 16:02:30 +0300
Message-ID: <CA+prXCGO_VUK5Y_Rj8M2w3S6SDof4eFSVv3WLOg2+XwgiKGwCQ__36282.333956524$1497539263$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1510464821836176539=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb0-x22b.google.com (mail-yb0-x22b.google.com
 [IPv6:2607:f8b0:4002:c09::22b])
 by lists.lttng.org (Postfix) with ESMTPS id 3wpNxw6md4z12Ks
 for <lttng-dev@lists.lttng.org>; Thu, 15 Jun 2017 13:04:36 +0000 (UTC)
Received: by mail-yb0-x22b.google.com with SMTP id 4so3820525ybl.1
 for <lttng-dev@lists.lttng.org>; Thu, 15 Jun 2017 06:02:32 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1510464821836176539==
Content-Type: multipart/alternative; boundary="001a114ff5d61009a80551ff485c"

--001a114ff5d61009a80551ff485c
Content-Type: text/plain; charset="UTF-8"

My memory-constrained application dumps core saying

Assertion failed: (!ret), function _cds_wfcq_init, file
./urcu/static/wfcqueue.h, line 107.
Abort

The function was called from the call_rcu thread, my app does not call
wfcqueue directly.

My operating system is FreeBSD-10.3, you won't reproduce the failure in
Linux.
Apparently developers assumed that pthread_mutex_init cannot fail. This
assumption is ok for Linux, but not so with FreeBSD, which allocates
mutexes with calloc.

Could you please add proper error handling so that (at least) call_rcu
threads could cope with memory allocation failures?

Cheers...

--001a114ff5d61009a80551ff485c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>My memory-constrained application dumps cor=
e saying<br><br>Assertion failed: (!ret), function _cds_wfcq_init, file ./u=
rcu/static/wfcqueue.h, line 107.<br>Abort<br><br></div><div>The function wa=
s called from the call_rcu thread, my app does not call wfcqueue directly.<=
br></div><div><br>My operating system is FreeBSD-10.3, you won&#39;t reprod=
uce the failure in Linux.<br></div> Apparently developers assumed that pthr=
ead_mutex_init cannot fail. This assumption is ok for Linux, but not so wit=
h FreeBSD, which allocates mutexes with calloc.<br><br></div>Could you plea=
se add proper error handling so that (at least) call_rcu threads could cope=
 with memory allocation failures?<br><br></div>Cheers...<br></div>

--001a114ff5d61009a80551ff485c--

--===============1510464821836176539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1510464821836176539==--
