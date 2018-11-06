From: Alok Priyadarshi <alokpr@gmail.com>
Subject: Re: lost trace events
Date: Tue, 6 Nov 2018 14:48:24 -0800
Message-ID: <CADwgpi8CooU1uKTzFFRwaBzBVHVbM_jkTRjucajTJ5Y=JKjcYQ__505.411453969096$1541544402$gmane$org@mail.gmail.com>
References: <CADwgpi8TmCUgz4uF8CpPs-1-SooENXvYgA2ZqjXbcMgsSwzRdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1754865192524586104=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 by lists.lttng.org (Postfix) with ESMTPS id 42qPps5f59zq78
 for <lttng-dev@lists.lttng.org>; Tue,  6 Nov 2018 17:48:37 -0500 (EST)
Received: by mail-yb1-xb34.google.com with SMTP id u103-v6so4508717ybi.5
 for <lttng-dev@lists.lttng.org>; Tue, 06 Nov 2018 14:48:37 -0800 (PST)
In-Reply-To: <CADwgpi8TmCUgz4uF8CpPs-1-SooENXvYgA2ZqjXbcMgsSwzRdg@mail.gmail.com>
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

--===============1754865192524586104==
Content-Type: multipart/alternative; boundary="000000000000486fff057a06cde3"

--000000000000486fff057a06cde3
Content-Type: text/plain; charset="UTF-8"

Any advice on how to debug lost events? Thanks in advance!


On Wed, Oct 31, 2018 at 2:58 PM Alok Priyadarshi <alokpr@gmail.com> wrote:

> We are tracing a multi-process application that generates high-frequency
> user-space trace events.
>
> Environment:
> - Ubuntu 16.04 LTS
> - Lttng 2.10.4 - KeKriek
>
> Session:
> - Snapshot mode
> - One channel with default config:
> overwrite=1, subbuf_size=524288, num_subbuf=4
>
> We have noticed that a few events are missing. I understand that in
> overwrite mode we can lose entire sub-buffers but IIUC we would only lose
> events at the beginning, not in-between events in a sub-buffer.
>
> Is it not true that only the oldest sub-buffer is overwritten and when
> overwrite happens, none of the latest events are discarded?
>
> Few more things to note:
> - Before lttng-snapshot-record, we stop tracing as recommended by the
> documentation
> - Packet context field events_discarded is always set to 0
> - Event loss seems to happen around packet transition. I have noticed this
> in at least two traces
>
> The snapshot mode seems perfect for our use case. It is OK to lose events
> from either ends of the snapshot, but it is essential to not lose any
> in-between events. I was under the impression that overwrite mode
> guarantees that. If not, is there anything else we can try?
>

--000000000000486fff057a06cde3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Any advice on how to debug lost events? Thanks in advance!=
<div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed=
, Oct 31, 2018 at 2:58 PM Alok Priyadarshi &lt;<a href=3D"mailto:alokpr@gma=
il.com">alokpr@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex"><div dir=3D"ltr">We are tracing a multi-process application that gener=
ates high-frequency user-space trace events.<div><br></div><div>Environment=
:<br><div>- Ubuntu 16.04 LTS</div><div>- Lttng=C2=A02.10.4 - KeKriek</div><=
div><br></div></div><div>Session:</div><div>- Snapshot mode</div><div>- One=
 channel with default config: overwrite=3D1,=C2=A0subbuf_size=3D524288,=C2=
=A0num_subbuf=3D4</div><div><br></div><div>We have noticed that a few event=
s are missing. I understand that in overwrite mode we can lose entire sub-b=
uffers but IIUC we would only lose events at the beginning, not in-between =
events in a sub-buffer.</div><div><br></div><div>Is it not true that only t=
he oldest sub-buffer is overwritten and when overwrite happens, none of the=
 latest events are discarded?</div><div><br></div><div>Few more things to n=
ote:</div><div>- Before lttng-snapshot-record, we stop tracing as recommend=
ed by the documentation</div><div>- Packet context field events_discarded i=
s always set to 0</div><div>- Event loss seems to happen around packet tran=
sition. I have noticed this in at least two traces</div><div><br></div><div=
>The snapshot mode seems perfect for our use case. It is OK to lose events =
from either ends of the snapshot, but it is essential to not lose any in-be=
tween events. I was under the impression that overwrite mode guarantees tha=
t. If not, is there anything else we can try?</div></div>
</blockquote></div>

--000000000000486fff057a06cde3--

--===============1754865192524586104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1754865192524586104==--
