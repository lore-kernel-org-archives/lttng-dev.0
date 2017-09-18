From: liguang li <liguang.lee6@gmail.com>
Subject: Babeltrace performance issue in live-reading mode
Date: Mon, 18 Sep 2017 11:32:07 +0800
Message-ID: <CAMYaK0TVYEgM_qxCExiFn6BcgZ58+KXKqx72h_0Gv4g2JN40Yg__36680.5265345194$1505747121$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2520968728707713793=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-x232.google.com (mail-qk0-x232.google.com
 [IPv6:2607:f8b0:400d:c09::232])
 by lists.lttng.org (Postfix) with ESMTPS id 3xwWlY5dKBzDSS
 for <lttng-dev@lists.lttng.org>; Mon, 18 Sep 2017 03:32:09 +0000 (UTC)
Received: by mail-qk0-x232.google.com with SMTP id c69so6151858qke.8
 for <lttng-dev@lists.lttng.org>; Sun, 17 Sep 2017 20:32:09 -0700 (PDT)
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

--===============2520968728707713793==
Content-Type: multipart/alternative; boundary="94eb2c072eba28776f05596e6312"

--94eb2c072eba28776f05596e6312
Content-Type: text/plain; charset="UTF-8"

Hi,

Create a session in live-reading mode, run a application which having very
high event throughput, then prints
the events with babeltrace. We found the live trace viewer are viewing
events a few seconds ago, and as time
goes on, the delay will be bigger and bigger.

I checked the source code, found Babeltrace in live-reading mode will read
the recorded events in the CTF
files, and then parse and print it in a single thread. The process is a
little slow, do you have any ideas to
improve the process.

Thanks,
Liguang

--94eb2c072eba28776f05596e6312
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,<br><br></div></div><div>Create a session in =
live-reading mode, run a application which having very high event throughpu=
t, then prints</div><div> the events with babeltrace. We found the live tra=
ce viewer are viewing events a few seconds ago, and as time</div><div> goes=
 on, the delay will be bigger and bigger.</div><div><br></div><div>I checke=
d the source code, found Babeltrace in live-reading mode will read the reco=
rded events in the CTF</div><div> files, and then parse and print it in a s=
ingle thread. The process is a little slow, do you have any ideas to <br></=
div><div>improve the process. <br></div><div><br></div><div>Thanks,</div><d=
iv>Liguang<br></div></div>

--94eb2c072eba28776f05596e6312--

--===============2520968728707713793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2520968728707713793==--
