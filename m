From: Sasha Goldshtein <goldshtn@gmail.com>
Subject: Userspace LTTng tracing in a non-privileged container
Date: Tue, 30 Jan 2018 09:50:06 +0000
Message-ID: <CAJMEX+G4t3vmmkFvcX3ZAbMyrw4AcqGTG1raqNXqyKjK=PFXfA__9383.82116514749$1517305768$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8158028374574639865=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f176.google.com (mail-qk0-f176.google.com
 [209.85.220.176])
 by lists.lttng.org (Postfix) with ESMTPS id 3zW1qB2GW6zCKx
 for <lttng-dev@lists.lttng.org>; Tue, 30 Jan 2018 09:51:17 +0000 (UTC)
Received: by mail-qk0-f176.google.com with SMTP id i141so9296078qke.0
 for <lttng-dev@lists.lttng.org>; Tue, 30 Jan 2018 01:51:17 -0800 (PST)
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

--===============8158028374574639865==
Content-Type: multipart/alternative; boundary="001a11406a223a5ef00563fb4a3b"

--001a11406a223a5ef00563fb4a3b
Content-Type: text/plain; charset="UTF-8"

Hi,

I'd like to use LTTng from within a non-privileged Docker container to
perform
user-space tracing (enable-event --userspace --tracepoint etc.).
Specifically,
I would like to trace a .NET Core application, which uses LTTng events to
trace
GC, JIT, assembly loading, and other events. My testing environment is a
FC25
host with an Ubuntu 14.04 container.

I can install LTTng within the target container, but the session daemon
produces
the following message while loading:

modprobe: ERROR: ../libkmod/libkmod.c:556 kmod_search_moddep() could
not open moddep file '/lib/modules /4.12.9-200.fc25.x86_64/modules.dep.bin'
Error: Unable to load module lttng-tracer
DEBUG1 [1830/1830]: Failed to open /proc/lttng (in init_kernel_tracer() at
main.c:2382)
Error: Unable to remove module lttng-tracer
Warning: No kernel tracer available

Subsequent commands seem to work, but there are no traces produced.
What I ran was:

lttng create mysession --output /tmp
lttng enable-event --userspace --tracepoint DotNETRuntime:GC*
lttng start
lttng stop
lttng destroy

Is there a way to use the LTTng session daemon in non-privileged mode,
if I'm only interested in userspace tracing? I would like to avoid
installing
LTTng on the host system, or running privileged. In fact, the ideal workflow
for me is to have a separate container image with LTTng and "attach" that
container image (using docker --pid --net) to the target container that I
want
to analyze. But I'd settle for having LTTng in the target container if
that's the
only option.

By the way, running LTTng from the host when the target application is in a
container doesn't work either (i.e. no traces are produced). Running LTTng
from the host when the target application is also on the host produces
results successfully.

Any suggestions would be very much appreciated.

Thanks,
Sasha

--001a11406a223a5ef00563fb4a3b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I&#39;d like to use LTTng from with=
in a non-privileged Docker container to perform</div><div>user-space tracin=
g (enable-event --userspace --tracepoint etc.). Specifically,</div><div>I w=
ould like to trace a .NET Core application, which uses LTTng events to trac=
e</div><div>GC, JIT, assembly loading, and other events. My testing environ=
ment is a FC25</div><div>host with an Ubuntu 14.04 container.</div><div><br=
></div><div>I can install LTTng within the target container, but the sessio=
n daemon produces</div><div>the following message while loading:</div><div>=
<br></div><div><div>modprobe: ERROR: ../libkmod/libkmod.c:556 kmod_search_m=
oddep() could</div><div>not open moddep file &#39;/lib/modules /4.12.9-200.=
fc25.x86_64/modules.dep.bin&#39;</div><div>Error: Unable to load module ltt=
ng-tracer</div><div>DEBUG1 [1830/1830]: Failed to open /proc/lttng (in init=
_kernel_tracer() at main.c:2382)</div><div>Error: Unable to remove module l=
ttng-tracer</div><div>Warning: No kernel tracer available</div></div><div><=
br></div><div>Subsequent commands seem to work, but there are no traces pro=
duced.=C2=A0</div><div>What I ran was:</div><div><br></div><div>lttng creat=
e mysession --output /tmp</div><div>lttng enable-event --userspace --tracep=
oint DotNETRuntime:GC*</div><div>lttng start</div><div>lttng stop</div><div=
>lttng destroy</div><div><br></div><div>Is there a way to use the LTTng ses=
sion daemon in non-privileged mode,</div><div>if I&#39;m only interested in=
 userspace tracing? I would like to avoid installing</div><div>LTTng on the=
 host system, or running privileged. In fact, the ideal workflow<br></div><=
div>for me is to have a separate container image with LTTng and &quot;attac=
h&quot; that=C2=A0</div><div>container image (using docker --pid --net) to =
the target container that I want</div><div>to analyze. But I&#39;d settle f=
or having LTTng in the target container if that&#39;s the</div><div>only op=
tion.</div><div><br></div><div>By the way, running LTTng from the host when=
 the target application is in a</div><div>container doesn&#39;t work either=
 (i.e. no traces are produced). Running LTTng</div><div>from the host when =
the target application is also on the host produces</div><div>results succe=
ssfully.</div><div><br></div><div>Any suggestions would be very much apprec=
iated.</div><div><br></div><div>Thanks,</div><div>Sasha</div></div>

--001a11406a223a5ef00563fb4a3b--

--===============8158028374574639865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8158028374574639865==--
