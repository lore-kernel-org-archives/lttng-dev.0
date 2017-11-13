From: Yu Yang <yyangplus@gmail.com>
Subject: Is it safe to use multiple lfht instances?
Date: Mon, 13 Nov 2017 10:44:59 +0000
Message-ID: <CAML2tiS_JpMKH1fJ6EnJ_+OpzeGuEGibfNaDdqd_AoBN=hdK7w__44700.1608823941$1510569928$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4321064629639348117=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x22c.google.com (mail-qt0-x22c.google.com
 [IPv6:2607:f8b0:400d:c0d::22c])
 by lists.lttng.org (Postfix) with ESMTPS id 3yb6jL4yVlz131J
 for <lttng-dev@lists.lttng.org>; Mon, 13 Nov 2017 10:45:10 +0000 (UTC)
Received: by mail-qt0-x22c.google.com with SMTP id e19so14095039qte.8
 for <lttng-dev@lists.lttng.org>; Mon, 13 Nov 2017 02:45:10 -0800 (PST)
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

--===============4321064629639348117==
Content-Type: multipart/alternative; boundary="001a1143c5e8e14750055ddaf672"

--001a1143c5e8e14750055ddaf672
Content-Type: text/plain; charset="UTF-8"

hello
I want to implement a multi-tree using lfht in urcu, every node in the tree
needs a lfht instance to track the children, I'm not sure if it is safe to
use tree like this in multiple threads environments. thanks in advance.

--001a1143c5e8e14750055ddaf672
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>hello</div>I want to implement a multi-tree using lfh=
t in urcu, every node in the tree needs a lfht instance to track the childr=
en, I&#39;m not sure if it is safe to use tree like this in multiple thread=
s environments. thanks in advance.</div>

--001a1143c5e8e14750055ddaf672--

--===============4321064629639348117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4321064629639348117==--
