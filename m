From: =?UTF-8?Q?Christophe_B=C3=A9dard?= <bedard.christophe@gmail.com>
Subject: gcc plugin for instrumenting individual functions
Date: Mon, 29 Jul 2019 20:56:15 +0200
Message-ID: <CAAS9doaz=dF_42vWaKO9mnRgua8hTNrgx+aHQZ0j9XTAhy0vmw__33849.5971330971$1564426770$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7037082290779282648=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 by lists.lttng.org (Postfix) with ESMTPS id 45y8783nN2z1Ftf
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 14:56:52 -0400 (EDT)
Received: by mail-io1-xd34.google.com with SMTP id k8so122451335iot.1
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 11:56:52 -0700 (PDT)
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

--===============7037082290779282648==
Content-Type: multipart/alternative; boundary="000000000000730392058ed674bd"

--000000000000730392058ed674bd
Content-Type: text/plain; charset="UTF-8"

Hi,

Sharing this just in case it can help someone!

gcc only lets you disable instrumentation, using the
`no_instrument_function` attribute, or by matching file names. It does not
let you explicitly choose the individual functions you want to instrument.

I've searched many times for a way to do it, but never found anything for
some reason, so I wrote this plugin:
https://github.com/christophebedard/instrument-attribute-gcc-plugin

It simply enables instrumentation for functions with the
`instrument_function` attribute, and disables instrumentation for all other
functions.


Christophe

--000000000000730392058ed674bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Sharing this just in case it can he=
lp someone!<br></div><div><br></div><div>gcc only lets you disable instrume=
ntation, using the `no_instrument_function` attribute, or by matching file =
names. It does not let you explicitly choose the individual functions you w=
ant to instrument.</div><div><br></div><div>I&#39;ve searched many times fo=
r a way to do it, but never found anything for some reason, so I wrote this=
 plugin:=C2=A0<a href=3D"https://github.com/christophebedard/instrument-att=
ribute-gcc-plugin" target=3D"_blank">https://github.com/christophebedard/in=
strument-attribute-gcc-plugin</a></div><div><br></div><div>It simply enable=
s instrumentation for functions with the `instrument_function` attribute, a=
nd disables instrumentation for all other functions.</div><div><br></div><d=
iv><br></div><div>Christophe</div><div><br></div></div>

--000000000000730392058ed674bd--

--===============7037082290779282648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7037082290779282648==--
