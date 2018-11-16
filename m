From: mrx <patrik.mrx@gmail.com>
Subject: A question on protocols
Date: Fri, 16 Nov 2018 09:49:52 +0100
Message-ID: <CANzOjBhikh_81hsu4b3pvneBNEX+PWjzWfx_K-jc-s0X0==zDQ__3310.48546727306$1542358088$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7519478973990286299=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 by lists.lttng.org (Postfix) with ESMTPS id 42xBkj6pzxzrqg
 for <lttng-dev@lists.lttng.org>; Fri, 16 Nov 2018 03:50:05 -0500 (EST)
Received: by mail-io1-xd29.google.com with SMTP id w7so8858906iom.12
 for <lttng-dev@lists.lttng.org>; Fri, 16 Nov 2018 00:50:05 -0800 (PST)
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

--===============7519478973990286299==
Content-Type: multipart/alternative; boundary="000000000000dd8299057ac44095"

--000000000000dd8299057ac44095
Content-Type: text/plain; charset="UTF-8"

Hi,

I have a need to collect LTTng live-traces from systems with very limited
RAM
and flash resources. This tracing will be running continuesly for months
monitoring our systems. The only way for me to transport those CTF records
somewhere else is via HTTP proxy. LTTng doesn't seem to have support for
sending
over proxies at all. So I think I really have a challenge a head of me, if
this
is at all possible.

The plan is to write my own relayd from which I can then stream the
received CTF
records + metadata to where I can analyze them. For this to work I need
documentation on the protocol between consumerd and relayd. I cannot find
the
documentation for this, where can I find it?

Do you think this is a viable solution?

Once I receive the data where I have the possiblity to analyze it. Then I'm
not
sure if I'm required to write everything to the file system to be able to
analyze the data. How would I then rotate the logs on disc so I can clean
up?
The best for me would be if I didn't have to go via disc at all I think.

Are there any others working on similar solution, if so, how are they
solving this?
How would you recommend I solve this?

The reason the current relayd doesn't work for me is two-fold:
1. I cannot get relayd to not write down the trace to disc. Can you control
this
   at all for live tracing?
2. I cannot find the documentation for the relayd <-> viewer protocol.
Where can
   I find it?

It might be that storing the traces on disc is a pre-requisite for serving a
viewer properly. Perhaps it's just something required by relayd based on
how it
works internally. I don't know.

Do you have any suggestions on how to solve this?

Any insights and/or feedback would be appreciated. Thanks a lot in advance.

Patrik Iselind

--000000000000dd8299057ac44095
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<br><br>I have a need to collect LTTng=
 live-traces from systems with very limited RAM<br>and flash resources. Thi=
s tracing will be running continuesly for months<br>monitoring our systems.=
 The only way for me to transport those CTF records<br>somewhere else is vi=
a HTTP proxy. LTTng doesn&#39;t seem to have support for sending<br>over pr=
oxies at all. So I think I really have a challenge a head of me, if this<br=
>is at all possible.<br><br>The plan is to write my own relayd from which I=
 can then stream the received CTF<br>records + metadata to where I can anal=
yze them. For this to work I need<br>documentation on the protocol between =
consumerd and relayd. I cannot find the<br>documentation for this, where ca=
n I find it?<br><br>Do you think this is a viable solution?<br><br>Once I r=
eceive the data where I have the possiblity to analyze it. Then I&#39;m not=
<br>sure if I&#39;m required to write everything to the file system to be a=
ble to<br>analyze the data. How would I then rotate the logs on disc so I c=
an clean up?<br>The best for me would be if I didn&#39;t have to go via dis=
c at all I think.<br><br>Are there any others working on similar solution, =
if so, how are they solving this?<br>How would you recommend I solve this?<=
br><br>The reason the current relayd doesn&#39;t work for me is two-fold:<b=
r>1. I cannot get relayd to not write down the trace to disc. Can you contr=
ol this<br>=C2=A0=C2=A0 at all for live tracing?<br>2. I cannot find the do=
cumentation for the relayd &lt;-&gt; viewer protocol. Where can<br>=C2=A0=
=C2=A0 I find it?<br><br>It might be that storing the traces on disc is a p=
re-requisite for serving a<br>viewer properly. Perhaps it&#39;s just someth=
ing required by relayd based on how it<br>works internally. I don&#39;t kno=
w.<br><br>Do you have any suggestions on how to solve this?<br><br>Any insi=
ghts and/or feedback would be appreciated. Thanks a lot in advance.<br><br>=
Patrik Iselind<br></div></div>

--000000000000dd8299057ac44095--

--===============7519478973990286299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7519478973990286299==--
