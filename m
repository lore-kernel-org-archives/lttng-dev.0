From: Alok Priyadarshi <alokpr@gmail.com>
Subject: lost trace events
Date: Wed, 31 Oct 2018 14:58:37 -0700
Message-ID: <CADwgpi8TmCUgz4uF8CpPs-1-SooENXvYgA2ZqjXbcMgsSwzRdg__19731.0185096741$1541023015$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5135113315816959246=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 by lists.lttng.org (Postfix) with ESMTPS id 42lj0C3dFQzq9S
 for <lttng-dev@lists.lttng.org>; Wed, 31 Oct 2018 17:58:51 -0400 (EDT)
Received: by mail-yb1-xb2b.google.com with SMTP id g75-v6so7301571yba.10
 for <lttng-dev@lists.lttng.org>; Wed, 31 Oct 2018 14:58:51 -0700 (PDT)
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

--===============5135113315816959246==
Content-Type: multipart/alternative; boundary="00000000000036440205798d68b5"

--00000000000036440205798d68b5
Content-Type: text/plain; charset="UTF-8"

We are tracing a multi-process application that generates high-frequency
user-space trace events.

Environment:
- Ubuntu 16.04 LTS
- Lttng 2.10.4 - KeKriek

Session:
- Snapshot mode
- One channel with default config:
overwrite=1, subbuf_size=524288, num_subbuf=4

We have noticed that a few events are missing. I understand that in
overwrite mode we can lose entire sub-buffers but IIUC we would only lose
events at the beginning, not in-between events in a sub-buffer.

Is it not true that only the oldest sub-buffer is overwritten and when
overwrite happens, none of the latest events are discarded?

Few more things to note:
- Before lttng-snapshot-record, we stop tracing as recommended by the
documentation
- Packet context field events_discarded is always set to 0
- Event loss seems to happen around packet transition. I have noticed this
in at least two traces

The snapshot mode seems perfect for our use case. It is OK to lose events
from either ends of the snapshot, but it is essential to not lose any
in-between events. I was under the impression that overwrite mode
guarantees that. If not, is there anything else we can try?

--00000000000036440205798d68b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">We are tracing a multi-process application that generates =
high-frequency user-space trace events.<div><br></div><div>Environment:<br>=
<div>- Ubuntu 16.04 LTS</div><div>- Lttng=C2=A02.10.4 - KeKriek</div><div><=
br></div></div><div>Session:</div><div>- Snapshot mode</div><div>- One chan=
nel with default config: overwrite=3D1,=C2=A0subbuf_size=3D524288,=C2=A0num=
_subbuf=3D4</div><div><br></div><div>We have noticed that a few events are =
missing. I understand that in overwrite mode we can lose entire sub-buffers=
 but IIUC we would only lose events at the beginning, not in-between events=
 in a sub-buffer.</div><div><br></div><div>Is it not true that only the old=
est sub-buffer is overwritten and when overwrite happens, none of the lates=
t events are discarded?</div><div><br></div><div>Few more things to note:</=
div><div>- Before lttng-snapshot-record, we stop tracing as recommended by =
the documentation</div><div>- Packet context field events_discarded is alwa=
ys set to 0</div><div>- Event loss seems to happen around packet transition=
. I have noticed this in at least two traces</div><div><br></div><div>The s=
napshot mode seems perfect for our use case. It is OK to lose events from e=
ither ends of the snapshot, but it is essential to not lose any in-between =
events. I was under the impression that overwrite mode guarantees that. If =
not, is there anything else we can try?</div></div>

--00000000000036440205798d68b5--

--===============5135113315816959246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5135113315816959246==--
