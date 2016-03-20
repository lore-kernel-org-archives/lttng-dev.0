From: Sean Heelan <seanheelan@gmail.com>
Subject: Restriction on channel sub-buffer size?
Date: Sun, 20 Mar 2016 19:52:36 +0000
Message-ID: <CAL90rL99uHxGLtXJo7UVb5yAp39QFvr_qeH4uFd4p9r1e0dbRA__14208.3127903335$1458670316$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2760195140714178411=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f181.google.com (mail-lb0-f181.google.com
 [209.85.217.181])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 0EDB3A0A2F
 for <lttng-dev@lists.lttng.org>; Sun, 20 Mar 2016 19:52:37 +0000 (UTC)
Received: by mail-lb0-f181.google.com with SMTP id bc4so116058868lbc.2
 for <lttng-dev@lists.lttng.org>; Sun, 20 Mar 2016 12:52:36 -0700 (PDT)
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

--===============2760195140714178411==
Content-Type: multipart/alternative; boundary=001a11c23888610a37052e8052be

--001a11c23888610a37052e8052be
Content-Type: text/plain; charset=UTF-8

Hi all,

I recently encountered a situation whereby tracing in a tight loop was
generating a very large number of events, thus resulting in quite a few
discarded events. To resolve this I attempted to create a new channel with
a larger buffer size as follows:

lttng create cc_session -o $trace_output_path
lttng enable-channel -u custom-channel--subbuf-size 4M
lttng enable-event -u -c custom-channel cc_provider:*
lttng start

/run/target

lttng stop
lttng destroy

After running the above the trace is empty. However, if I change the size
to 1M or 2M it works fine. Is there a restriction on the sub-buffer size? I
also notice a similar behaviour if I increase the number of subbuffers
above 8 while using a 1M buffer size.

I'm still losing around 80k events at a sub-buffer size of 2M (down from
1.2 million at the default buffer size buffer size of 4096) so ideally I'd
like to use a larger buffer size (assuming it's possible).

Some potentially relevant details:
* I'm running the target inside docker, version 1.10.3
* The container is Ubuntu 14.04
* I'm using LTTng from git HEAD

If I can provide any other useful information let me know!

Thanks,
Sean

--001a11c23888610a37052e8052be
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>I recently encountered a situat=
ion whereby tracing in a tight loop was generating a very large number of e=
vents, thus resulting in quite a few discarded events. To resolve this I at=
tempted to create a new channel with a larger buffer size as follows:</div>=
<div><br></div><div><div>lttng create cc_session -o $trace_output_path</div=
><div>lttng enable-channel -u custom-channel--subbuf-size 4M</div><div>lttn=
g enable-event -u -c custom-channel cc_provider:*</div><div>lttng start</di=
v><div><br></div><div>/run/target</div><div><br></div><div>lttng stop</div>=
<div>lttng destroy</div></div><div><br></div><div>After running the above t=
he trace is empty. However, if I change the size to 1M or 2M it works fine.=
 Is there a restriction on the sub-buffer size? I also notice a similar beh=
aviour if I increase the number of subbuffers above 8 while using a 1M buff=
er size.=C2=A0</div><div><br></div><div>I&#39;m still losing around 80k eve=
nts at a sub-buffer size of 2M (down from 1.2 million at the default buffer=
 size buffer size of 4096) so ideally I&#39;d like to use a larger buffer s=
ize (assuming it&#39;s possible).</div><div><br></div><div>Some potentially=
 relevant details:</div><div>* I&#39;m running the target inside docker, ve=
rsion 1.10.3</div><div>* The container is Ubuntu 14.04</div><div>* I&#39;m =
using LTTng from git HEAD</div><div><br></div><div>If I can provide any oth=
er useful information let me know!</div><div><br></div><div>Thanks,</div><d=
iv>Sean</div></div>

--001a11c23888610a37052e8052be--

--===============2760195140714178411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2760195140714178411==--
