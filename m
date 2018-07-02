From: Vidushi Vashishth <reachvidu@gmail.com>
Subject: Query reagrding babeltrace generated output
Date: Tue, 3 Jul 2018 00:23:04 +0530
Message-ID: <CAF7HkZNg7yxDne042jNhZn6pmyxw98=0mBuPcx-EsEUTThXUOg__10940.445730421$1530627188$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7320524082561833483=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 by lists.lttng.org (Postfix) with ESMTPS id 41KGbk6KpPztfC
 for <lttng-dev@lists.lttng.org>; Mon,  2 Jul 2018 14:53:06 -0400 (EDT)
Received: by mail-ed1-x542.google.com with SMTP id b12-v6so12402095edt.8
 for <lttng-dev@lists.lttng.org>; Mon, 02 Jul 2018 11:53:06 -0700 (PDT)
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

--===============7320524082561833483==
Content-Type: multipart/alternative; boundary="0000000000002c44bb057008b51e"

--0000000000002c44bb057008b51e
Content-Type: text/plain; charset="UTF-8"

Hi!

I am Vidushi. I am working on adding CTF trace generation capability to the
tracing framework of RTEMS this summer (as a part of my GSoC project). I am
using babeltrace in this regard. While I am able to convert the RTEMS text
output to CTF format using `babeltrace run` on the command line, the output
is stored in a directory which does not have access permissions. I am able
to get inside the directory by changing permissions (chmod) and list its
contents (sudo ls) but I cannot view the metadata and CTF stream output or
delete the said directory. Is there a way I can view/delete the contents of
the trace directory?

I am sorry if this is too obvious. I am new to this.

Thanks
Vidushi Vashishth

--0000000000002c44bb057008b51e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi!</div><div><br></div><div>I am Vidushi. I am worki=
ng on adding CTF trace generation capability to the tracing framework of RT=
EMS this summer (as a part of my GSoC project). I am using babeltrace in th=
is regard. While I am able to convert the RTEMS text output to CTF format u=
sing `babeltrace run` on the command line, the output is stored in a direct=
ory which does not have access permissions. I am able to get inside the dir=
ectory by changing permissions (chmod) and list its contents (sudo ls) but =
I cannot view the metadata and CTF stream output or delete the said directo=
ry. Is there a way I can view/delete the contents of the trace directory?</=
div><div><br></div><div>I am sorry if this is too obvious. I am new to this=
.</div><div><br></div><div>Thanks</div><div>Vidushi Vashishth<br></div></di=
v>

--0000000000002c44bb057008b51e--

--===============7320524082561833483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7320524082561833483==--
