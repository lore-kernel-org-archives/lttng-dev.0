From: Sukanya Sekar <ssekar@andrew.cmu.edu>
Subject: Clarification on SCHED_FIFO support
Date: Tue, 27 Jun 2017 19:36:05 -0400
Message-ID: <CAJ+0M9Mh8DOmSD41iY2Ds46YfWn4q+-UQpdV08msv7k4PdSvSQ__8301.66914170167$1498658616$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6473402930683016512=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-x233.google.com (mail-io0-x233.google.com
 [IPv6:2607:f8b0:4001:c06::233])
 by lists.lttng.org (Postfix) with ESMTPS id 3wy2Q80832z12q3
 for <lttng-dev@lists.lttng.org>; Tue, 27 Jun 2017 23:37:03 +0000 (UTC)
Received: by mail-io0-x233.google.com with SMTP id z62so26762471ioi.3
 for <lttng-dev@lists.lttng.org>; Tue, 27 Jun 2017 16:36:07 -0700 (PDT)
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

--===============6473402930683016512==
Content-Type: multipart/alternative; boundary="001a113973be0ad3e90552f988d2"

--001a113973be0ad3e90552f988d2
Content-Type: text/plain; charset="UTF-8"

Greetings!

We are exploring the LTTng Kernel Tracer (version 2.9) on Ubuntu 16.04. We
are particularly interested in real-time applications. As far as we
explored, we couldn't find support for SCHED_FIFO events. Also, we found a
comment in the source code (.../sched.h) indicating that the
sched_stat support to SCHED_FIFO/RR is yet to be added.

*So we would like to confirm if SCHED_FIFO isn't supported in the latest
version of the tool.*

Thanks,
Sukanya

--001a113973be0ad3e90552f988d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Greetings!<div><br></div><div>We are exploring the LTTng K=
ernel Tracer (version 2.9) on Ubuntu 16.04. We are particularly interested =
in real-time applications. As far as we explored, we couldn&#39;t find supp=
ort for SCHED_FIFO events. Also, we found a comment in the source code (...=
/sched.h) indicating that the sched_stat=C2=A0support to SCHED_FIFO/RR is y=
et to be added.=C2=A0</div><div><b><br></b></div><div><b>So we would like t=
o confirm if SCHED_FIFO isn&#39;t supported in the latest version of the to=
ol.</b></div><div><br></div><div>Thanks,</div><div>Sukanya</div></div>

--001a113973be0ad3e90552f988d2--

--===============6473402930683016512==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6473402930683016512==--
