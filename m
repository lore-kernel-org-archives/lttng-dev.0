From: =?utf-8?Q?D=C3=A1vid_Beck?= <david.beck.priv@gmail.com>
Subject: Re: Patch for lttng tools to build on Mac OSX 10.11.6
Date: Thu, 1 Jun 2017 23:03:48 +0100
Message-ID: <EF993367-57FA-41C2-A147-A9A7BC1439D6__36898.8521550365$1496354671$gmane$org@gmail.com>
References: <A82E93B1-509F-424C-B36F-7011D685BDC9@gmail.com>
 <CA+jJMxvpuZHDpOF2QvePMihbLRPFme_XpaLmWgzVOmx7QnWhYQ@mail.gmail.com>
 <CAA85PfLgiW329AhYcSbup+8jBz=25-pEM7LUC962ucUc3M6Gkw@mail.gmail.com>
 <CA+jJMxs-d6vZ4Q3t6UvDeqOqwYyyoVHtqrEw1uGuomovB_ohLw@mail.gmail.com>
 <eb2eec76-8ad8-bea2-5933-629ac1f1df07@efficios.com>
 <CA+jJMxs2=ua4LsaPS9DqBGY6gdLQqjCaibhnPYLt5k9d7Ke42Q@mail.gmail.com>
 <019415e6-017c-09b9-7f4a-0df71b51fc1a@efficios.com>
 <CA+jJMxvnbQuvPTR0uWw=XNXR-FARxyErDJhkND9kUwDUrLvNzQ@mail.gmail.com>
 <9EB290C2-A968-4B16-9A1D-AA7BC38E2DE5@gmail.com>
 <CA+jJMxuYV8nN0kgseMnO6Psgpk_XYsndyM93Rus5xv4Z-GX1_w@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/mixed; boundary="===============6248116315359786477=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3wf1c42QKxz12Mr
 for <lttng-dev@lists.lttng.org>; Thu,  1 Jun 2017 22:05:08 +0000 (UTC)
Received: by mail-wm0-x242.google.com with SMTP id g15so14595290wmc.2
 for <lttng-dev@lists.lttng.org>; Thu, 01 Jun 2017 15:03:49 -0700 (PDT)
In-Reply-To: <CA+jJMxuYV8nN0kgseMnO6Psgpk_XYsndyM93Rus5xv4Z-GX1_w@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?utf-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============6248116315359786477==
Content-Type: multipart/alternative; boundary="Apple-Mail=_DA9468F0-431F-436E-8A33-CB96566F4F33"


--Apple-Mail=_DA9468F0-431F-436E-8A33-CB96566F4F33
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


>>=20
>> I had a quick look into this pull request and I haven=E2=80=99t found =
how this relates the issues I found:
>>=20
>> 1, HOST_NAME_MAX was not defined
>> 2, errno.h was needed on Mac
>>=20
>> May be it is only my lack of auto tools knowledge, I don=E2=80=99t =
know. Anyways, thank you again.
>=20
> Indeed, it doesn't fix those issues directly; it disables the build of
> everything except the lttng-relayd on macOS in the default build
> configuration.

I see. But the fixes I sent you are actually fixing the build of relayd.

I don=E2=80=99t understand how this PR helps then.

> I'm not sure it is worth addressing the build issues, except if
> someone can confirm whether or not the rest of the toolchain actually
> works on macOS.


--Apple-Mail=_DA9468F0-431F-436E-8A33-CB96566F4F33
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><br class=3D"">I had a quick look into this pull request and =
I haven=E2=80=99t found how this relates the issues I found:<br =
class=3D""><br class=3D"">1, HOST_NAME_MAX was not defined<br =
class=3D"">2, errno.h was needed on Mac<br class=3D""><br class=3D"">May =
be it is only my lack of auto tools knowledge, I don=E2=80=99t know. =
Anyways, thank you again.<br class=3D""></blockquote><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">Indeed, it doesn't =
fix those issues directly; it disables the build of</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">everything except =
the lttng-relayd on macOS in the default build</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" =
class=3D"">configuration.</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""></div></blockquote><div><br class=3D""></div>I see. But the =
fixes I sent you are actually fixing the build of relayd.</div><div><br =
class=3D""></div><div>I don=E2=80=99t understand how this PR helps =
then.<br class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D""><div class=3D""><span style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: =
none; display: inline !important;" class=3D"">I'm not sure it is worth =
addressing the build issues, except if</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">someone can confirm whether or not the =
rest of the toolchain actually</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">works on macOS.</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""></div></blockquote></div><br =
class=3D""></body></html>=

--Apple-Mail=_DA9468F0-431F-436E-8A33-CB96566F4F33--

--===============6248116315359786477==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6248116315359786477==--
