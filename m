From: Shehab Elsayed <shehabyomn@gmail.com>
Subject: Processing large trace files
Date: Mon, 9 Jul 2018 18:48:05 -0400
Message-ID: <CAC-H6tsw80-0R+06MJi7k9yz41C=oMp25gZOujVk7JjqEtOpNQ__9977.97866953096$1531176372$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1189981898779460904=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 by lists.lttng.org (Postfix) with ESMTPS id 41PgTh66Lxz19q9
 for <lttng-dev@lists.lttng.org>; Mon,  9 Jul 2018 18:48:08 -0400 (EDT)
Received: by mail-lj1-x229.google.com with SMTP id t21-v6so15286567lji.0
 for <lttng-dev@lists.lttng.org>; Mon, 09 Jul 2018 15:48:08 -0700 (PDT)
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

--===============1189981898779460904==
Content-Type: multipart/alternative; boundary="00000000000093d5b5057098ce3e"

--00000000000093d5b5057098ce3e
Content-Type: text/plain; charset="UTF-8"

Hello All,

I was wondering if anyone had any suggestions on how to speedup trace
processing. Right now I am using babeltrace in python to read the traces
and process them. Some of the traces I am dealing with reach up to 10GB.

I read the trace, extract the info I need and write them to a csv gzipped
file (all in python). I fill up a list first with all extracted info for
each tracked event and then write once after the script has gone through
all events in the trace.

Thanks,
Shehab

--00000000000093d5b5057098ce3e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello All,</div><div><br></div><div>I was wondering i=
f anyone had any suggestions on how to speedup trace processing. Right now =
I am using babeltrace in python to read the traces and process them. Some o=
f the traces I am dealing with reach up to 10GB.</div><div><br></div><div>I=
 read the trace, extract the info I need and write them to a csv gzipped fi=
le (all in python). I fill up a list first with all extracted info for each=
 tracked event and then write once after the script has gone through all ev=
ents in the trace.</div><div><br></div><div>Thanks,</div><div>Shehab<br></d=
iv><div><br></div><div><br></div></div>

--00000000000093d5b5057098ce3e--

--===============1189981898779460904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1189981898779460904==--
