From: Bharath Mourya <bharatmourya123@gmail.com>
Subject: Where not to uses userspace RCU
Date: Sun, 21 Oct 2018 10:55:58 +0530
Message-ID: <CABVL2E54apbuPSFMA0FW0Vb7cAqhy8e-1g8rK7ekoxjR=pKNYg__4205.26411985538$1540099454$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4616548728995280219=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 by lists.lttng.org (Postfix) with ESMTPS id 42d7RR4tpQzgxw
 for <lttng-dev@lists.lttng.org>; Sun, 21 Oct 2018 01:26:11 -0400 (EDT)
Received: by mail-qt1-x835.google.com with SMTP id q40-v6so42852988qte.0
 for <lttng-dev@lists.lttng.org>; Sat, 20 Oct 2018 22:26:11 -0700 (PDT)
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

--===============4616548728995280219==
Content-Type: multipart/alternative; boundary="000000000000c814240578b65f7c"

--000000000000c814240578b65f7c
Content-Type: text/plain; charset="UTF-8"

Hello,

I suppose this is the right place to ask doubts about user-space RCU. I
want to know to what are the specific use cases where user-space RCU is
inappropriate to use even if workload is read intensive.

Readers at the same time can have different view of data which might be
problematic in some cases but I couldn't think of any concrete examples,
please help me understand where using RCU can lead to problems.

Note: Please let me know if this is not the right place to ask URCU doubts

Regards,
Y Bharath Mourya

--000000000000c814240578b65f7c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>I suppose this is the right plac=
e to ask doubts about user-space RCU. I want to know to what are the specif=
ic use cases where user-space RCU is inappropriate to use even if workload =
is read intensive.=C2=A0</div><div><br></div><div>Readers at the same time =
can have different view of data which might be problematic in some=C2=A0cas=
es but I couldn&#39;t think of any concrete examples, please help me unders=
tand where using RCU can lead to problems.</div><div><br></div><div>Note: P=
lease let me know if this is not the right place to ask URCU doubts</div><d=
iv><br></div><div>Regards,</div><div>Y Bharath Mourya</div></div>

--000000000000c814240578b65f7c--

--===============4616548728995280219==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4616548728995280219==--
