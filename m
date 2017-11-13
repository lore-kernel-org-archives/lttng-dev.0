From: Nalin Pai <nalinpai@gmail.com>
Subject: Channel buffer allocation
Date: Mon, 13 Nov 2017 10:40:14 -0800
Message-ID: <CALVR4zA3F2RWH+Zc4Nddn59JnOfqxjjDJtS_0rJs1=+xjtZk6A__5787.84528556771$1510599202$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3965789768567252138=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ua0-x22a.google.com (mail-ua0-x22a.google.com
 [IPv6:2607:f8b0:400c:c08::22a])
 by lists.lttng.org (Postfix) with ESMTPS id 3ybKFX2ZNQz13mf
 for <lttng-dev@lists.lttng.org>; Mon, 13 Nov 2017 18:40:15 +0000 (UTC)
Received: by mail-ua0-x22a.google.com with SMTP id e10so9377528uah.10
 for <lttng-dev@lists.lttng.org>; Mon, 13 Nov 2017 10:40:15 -0800 (PST)
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

--===============3965789768567252138==
Content-Type: multipart/alternative; boundary="f403045f8ef0ef96a6055de19912"

--f403045f8ef0ef96a6055de19912
Content-Type: text/plain; charset="UTF-8"

Hi,

In the per-pid buffer scheme, when are the ring buffers allocated for each
pid? Is it when a channel is created or is it an event provided by that
process is enabled for a specific channel.

I am trying to understand whether there is an overhead to creating many
channels. Will a process incur the allocation of buffers for a channel that
is not interested in any of the events that the process is providing?

-Nalin

--f403045f8ef0ef96a6055de19912
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>In the per-pid buffer scheme, when =
are the ring buffers allocated for each pid? Is it when a channel is create=
d or is it an event provided by that process is enabled for a specific chan=
nel.</div><div><br></div><div>I am trying to understand whether there is an=
 overhead to creating many channels. Will a process incur the allocation of=
 buffers for a channel that is not interested in any of the events that the=
 process is providing?</div><div><br></div><div>-Nalin</div><div><br></div>=
</div>

--f403045f8ef0ef96a6055de19912--

--===============3965789768567252138==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3965789768567252138==--
