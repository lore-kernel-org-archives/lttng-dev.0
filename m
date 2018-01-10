From: Ronan Amorim <ronanrmo@gmail.com>
Subject: Help getting Loglevel from Babeltrace C API
Date: Tue, 9 Jan 2018 16:45:55 -0800
Message-ID: <CAHqtAXDXUGXhpdhuWi0ccRqUF+ePDHoVuH0shd_SaC6p5xiayQ__17342.4311135479$1515545056$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0842716834673875882=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb0-x22b.google.com (mail-yb0-x22b.google.com
 [IPv6:2607:f8b0:4002:c09::22b])
 by lists.lttng.org (Postfix) with ESMTPS id 3zGVg86WQlzrcf
 for <lttng-dev@lists.lttng.org>; Wed, 10 Jan 2018 00:45:56 +0000 (UTC)
Received: by mail-yb0-x22b.google.com with SMTP id m6so2844324ybk.9
 for <lttng-dev@lists.lttng.org>; Tue, 09 Jan 2018 16:45:56 -0800 (PST)
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

--===============0842716834673875882==
Content-Type: multipart/alternative; boundary="94eb2c06a5a0a462fa0562615a34"

--94eb2c06a5a0a462fa0562615a34
Content-Type: text/plain; charset="UTF-8"

Hi,

Sorry if this being asked before or if this is not the right mailing list
for babeltrace questions.

I am trying to use babeltrace to read traces written using Lttng.
However, I cannot  find a way of reading the loglevel from Babeltrace C API.
I see that babeltrace CLI is able to retrieve this information but the API
does no expose the same things that are used in the cli code.

I appreciate any help or pointers.

Thanks,
Ronan

--94eb2c06a5a0a462fa0562615a34
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Sorry if this being asked before or=
 if this is not the right mailing list for babeltrace questions.</div><div>=
<br></div><div>I am trying to use babeltrace to read traces written using L=
ttng.</div><div>However, I cannot=C2=A0 find a way of reading the loglevel =
from Babeltrace C API.</div><div>I see that babeltrace CLI is able to retri=
eve this information but the API does no expose the same things that are us=
ed in the cli code.</div><div><br></div><div>I appreciate any help or point=
ers.</div><div><br></div><div>Thanks,</div><div>Ronan</div></div>

--94eb2c06a5a0a462fa0562615a34--

--===============0842716834673875882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0842716834673875882==--
