From: Evgeniy Ivanov <i@eivanov.com>
Subject: Both liburcu-bp.so and liburcu-qsbr linked to binary
Date: Wed, 23 Nov 2016 12:13:32 +0300
Message-ID: <CAO6Ho0c7RikfKbafPLEMPpEksEr6m=rx-4ipqAn8651MjkodTw__6676.62594137273$1479892433$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3988014804783228043=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-x236.google.com (mail-io0-x236.google.com
 [IPv6:2607:f8b0:4001:c06::236])
 by lists.lttng.org (Postfix) with ESMTPS id 3tNxW45Pc5zlVs
 for <lttng-dev@lists.lttng.org>; Wed, 23 Nov 2016 09:14:56 +0000 (UTC)
Received: by mail-io0-x236.google.com with SMTP id c21so13333391ioj.1
 for <lttng-dev@lists.lttng.org>; Wed, 23 Nov 2016 01:13:34 -0800 (PST)
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

--===============3988014804783228043==
Content-Type: multipart/alternative; boundary=94eb2c11c1a490be9b0541f44dfd

--94eb2c11c1a490be9b0541f44dfd
Content-Type: text/plain; charset=UTF-8

Hi,

My program uses QSBR (together with CDS). Also we use lttng-ust for
performance analyses. In maps I see that both liburcu-bp.so (dependency
from liblttng-ust-tracepoint.so) and liburcu-qsbr.so are linked. Can it
potentially break anything? Is it possible to rebuild lttng-ust with QSBR?

-- 
Cheers,
Evgeniy

--94eb2c11c1a490be9b0541f44dfd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>My program uses QSBR (together with=
 CDS). Also we use lttng-ust for performance analyses. In maps I see that b=
oth liburcu-bp.so (dependency from liblttng-ust-tracepoint.so)=C2=A0and=C2=
=A0liburcu-qsbr.so are linked. Can it potentially break anything? Is it pos=
sible to rebuild lttng-ust with QSBR?<br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">Cheers,<br>Evgeniy</div>
</div></div>

--94eb2c11c1a490be9b0541f44dfd--

--===============3988014804783228043==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3988014804783228043==--
