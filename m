From: Anup Pemmaiah <anup.pemmaiah@gmail.com>
Subject: Latency tracing using LTTng
Date: Wed, 27 Dec 2017 17:21:30 -0800
Message-ID: <CAF_EZTMO2Npe+aR=OM9pmJ05hGQVZrkY2otDPK_=6+rjoNiZVQ__3223.60707582465$1514423983$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1669675964361107886=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it0-x229.google.com (mail-it0-x229.google.com
 [IPv6:2607:f8b0:4001:c0b::229])
 by lists.lttng.org (Postfix) with ESMTPS id 3z6X4D24khzpLG
 for <lttng-dev@lists.lttng.org>; Thu, 28 Dec 2017 01:21:31 +0000 (UTC)
Received: by mail-it0-x229.google.com with SMTP id p139so26760352itb.1
 for <lttng-dev@lists.lttng.org>; Wed, 27 Dec 2017 17:21:31 -0800 (PST)
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

--===============1669675964361107886==
Content-Type: multipart/alternative; boundary="001a11448e78f8b3ef05615c55f9"

--001a11448e78f8b3ef05615c55f9
Content-Type: text/plain; charset="UTF-8"

Hi,

I am trying to find the reason of a intermittent latency that I am noticing
on my Linux system running on a RT_PREEMPT kernel. I have patched it on a
Ubuntu 16.04 LTS. Have stopped the desktop lightdm service and this is on a
Arm aarch64 platform.

At a very high level, there are two processes interacting with each other.
Process-1 does some work and sends UDP messages to Process-2 (Using the
FASTRTPS real time Publish-Subscribe protocol).
Data is sent from Process-1 to Process-2 every 100ms. I see that often
there is a delay in Process-2 receiving the message.


Trying to use LTTng and along with other supported profiling tools like
latency-tracker, lttng-profile.
Something like the description in this link
http://lttng.org/blog/2015/03/18/full-stack-latencies is what I am looking
for, but I am facing issues. The latency_tracker kernel modules and also
lttng-profile is a bit flaky as it sometimes work and sometimes panics the
kernel.  Simple test cases as provided in
https://github.com/fdoray/latency_tracker_demo works sometimes. And also
profiling Process-1 works by providing some useful traces(intermittently
kernel panics), but profiling Process-2 the process just hangs.

Not sure how updated the above pasted links are, because I notice there is
no more usec_threshold parameter and I use the threshold
in /sys/kernel/debug/latency/syscalls/default/threshold

I understand each situation is different, but was curious if  any of you
have comments/suggestions that would help in debugging latency related
issues using LTTng. I have looked many places to get required info but of
not much help.

Your comments/suggestions will be greatly appreciated.

Thanks
Anup

--001a11448e78f8b3ef05615c55f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I am trying to find the reason of a=
 intermittent latency that I am noticing on my Linux system running on a RT=
_PREEMPT kernel. I have patched it on a Ubuntu 16.04 LTS. Have stopped the =
desktop lightdm service and this is on a Arm aarch64 platform.</div><div><b=
r></div><div>At a very high level, there are two processes interacting with=
 each other. Process-1 does some work and sends UDP messages to Process-2 (=
Using the FASTRTPS real time Publish-Subscribe protocol).</div><div>Data is=
 sent from Process-1 to Process-2 every 100ms. I see that often there is a =
delay in Process-2 receiving the message.</div><div><br></div><div><br></di=
v><div>Trying to use LTTng and along with other supported profiling tools l=
ike latency-tracker, lttng-profile.<br></div><div>Something like the descri=
ption in this link <a href=3D"http://lttng.org/blog/2015/03/18/full-stack-l=
atencies">http://lttng.org/blog/2015/03/18/full-stack-latencies</a> is what=
 I am looking for, but I am facing issues. The latency_tracker kernel modul=
es and also lttng-profile is a bit flaky as it sometimes work and sometimes=
 panics the kernel.=C2=A0 Simple test cases as provided in=C2=A0<a href=3D"=
https://github.com/fdoray/latency_tracker_demo">https://github.com/fdoray/l=
atency_tracker_demo</a> works sometimes. And also profiling Process-1 works=
 by providing some useful traces(intermittently kernel panics), but profili=
ng Process-2 the process just hangs.</div><div><br></div><div>Not sure how =
updated the above pasted links are, because I notice there is no more usec_=
threshold parameter and I use the threshold in=C2=A0/sys/kernel/debug/laten=
cy/syscalls/default/threshold</div><div><br></div><div>I understand each si=
tuation is different, but was curious if=C2=A0 any of you have comments/sug=
gestions that would help in debugging latency related issues using LTTng. I=
 have looked many places to get required info but of not much help.</div><d=
iv><br></div><div>Your comments/suggestions will be greatly appreciated.</d=
iv><div><br></div><div>Thanks</div><div>Anup</div></div>

--001a11448e78f8b3ef05615c55f9--

--===============1669675964361107886==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1669675964361107886==--
