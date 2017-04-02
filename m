From: Mario Demontis <mario.demontis@gmail.com>
Subject: Splitting timestamps
Date: Sun, 2 Apr 2017 13:04:26 +0200
Message-ID: <CAD=N7Ku1Ac3yJKdDuO-cvYAg4aY6n39PUZZN1AASpUno8xykow__16947.9811135263$1491230844$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3682820931711779146=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-x231.google.com (mail-io0-x231.google.com
 [IPv6:2607:f8b0:4001:c06::231])
 by lists.lttng.org (Postfix) with ESMTPS id 3vwsns3VWHzwcZ
 for <lttng-dev@lists.lttng.org>; Sun,  2 Apr 2017 11:04:48 +0000 (UTC)
Received: by mail-io0-x231.google.com with SMTP id l7so60946109ioe.3
 for <lttng-dev@lists.lttng.org>; Sun, 02 Apr 2017 04:04:28 -0700 (PDT)
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

--===============3682820931711779146==
Content-Type: multipart/alternative; boundary=94eb2c07701e920200054c2d01e4

--94eb2c07701e920200054c2d01e4
Content-Type: text/plain; charset=UTF-8

Hi All,
I'm setting up a tracing engine for a MCU with low RAM.
I'm currently stuck trying to specify the timestamps organization in
metadata.

I have 56 bits timestamps split up into:
- a 32 bits (high order) part sent only in the packet header
- a 24 bits (low order) part sent in the event header

Is there a way to do that in CTF 1.8?

Thanks
Mario

--94eb2c07701e920200054c2d01e4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div>I&#39;m setting up a tracing engine for a MCU =
with low RAM.</div><div>I&#39;m currently stuck trying to specify the times=
tamps organization in metadata.</div><div><br></div><div>I have 56 bits tim=
estamps split up into:</div><div>- a 32 bits (high order) part sent only in=
 the packet header</div><div>- a 24 bits (low order) part sent in the event=
 header</div><div><br></div><div>Is there a way to do that in CTF 1.8?</div=
><div><br></div><div>Thanks</div><div>Mario</div></div>

--94eb2c07701e920200054c2d01e4--

--===============3682820931711779146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3682820931711779146==--
