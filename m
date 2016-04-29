From: siddharth teotia <siddharthteotia@gmail.com>
Subject: RCU Question
Date: Fri, 29 Apr 2016 12:07:41 -0700
Message-ID: <CAJw6sH0=pZX__YaeMwozF673u3Dyn7Jzp3g9q2FuYurThO6paw__48017.6683086485$1461972652$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8761534740914208392=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f175.google.com (mail-ig0-f175.google.com
 [209.85.213.175])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 7C5D0A3352
 for <lttng-dev@lists.lttng.org>; Fri, 29 Apr 2016 19:07:43 +0000 (UTC)
Received: by mail-ig0-f175.google.com with SMTP id bi2so31911604igb.0
 for <lttng-dev@lists.lttng.org>; Fri, 29 Apr 2016 12:07:42 -0700 (PDT)
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

--===============8761534740914208392==
Content-Type: multipart/alternative; boundary=f46d0447f12c6c86830531a45bd7

--f46d0447f12c6c86830531a45bd7
Content-Type: text/plain; charset=UTF-8

Hi Guys,

I recently started exploring RCU to build a lock free hash table. I have
read quite a bit of literature from LWN on RCU, its usage, API etc. I have
the following question for which I have had mixed answers online:

Does the user space implementation of RCU liburcu take care of preemptive
v/s non-preemptive flavors of RCU. From what I understand RCU can be
broadly divided into:

1. Classic RCU - High Performance but suitable for non-preemptive
environments.
2. Preemptible RCU - Permits the reader to block on a resource or the read
side critical sections to be preempted. But still does not allow any kind
of sleep(). Moreover there seems to be some sort of limitation on the
nature of blocking that can happen within RCU read side critical section.
3. Sleepable RCU - Seems to me an augmentation of preemptible RCU.

The paper that describes the user space implementation of RCU suggests 4
different flavors -- QSBR, Memory Barrier based, Bullet Proof, and Signal
based.

I don't think so in my application I can afford to not have the readers
block or even sleep. If the reader wants to take some orthogonal lock/latch
on an entirely different resource, it might end waiting for it.

And because

--f46d0447f12c6c86830531a45bd7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div><div>Hi Guys,<br><br></=
div>I recently started exploring RCU to build a lock free hash table. I hav=
e read quite a bit of literature from LWN on RCU, its usage, API etc. I hav=
e the following question for which I have had mixed answers online:<br><br>=
</div>Does the user space implementation of RCU liburcu take care of preemp=
tive v/s non-preemptive flavors of RCU. From what I understand RCU can be b=
roadly divided into:<br><br></div>1. Classic RCU - High Performance but sui=
table for non-preemptive environments.<br></div>2. Preemptible RCU - Permit=
s the reader to block on a resource or the read side critical sections to b=
e preempted. But still does not allow any kind of sleep(). Moreover there s=
eems to be some sort of limitation on the nature of blocking that can happe=
n within RCU read side critical section.<br></div>3. Sleepable RCU - Seems =
to me an augmentation of preemptible RCU.<br><br></div>The paper that descr=
ibes the user space implementation of RCU suggests 4 different flavors -- Q=
SBR, Memory Barrier based, Bullet Proof, and Signal based. <br><br></div>I =
don&#39;t think so in my application I can afford to not have the readers b=
lock or even sleep. If the reader wants to take some orthogonal lock/latch =
on an entirely different resource, it might end waiting for it.<br><br></di=
v>And because <br><div><div><div><div><div><div><div><div><div><br><br clea=
r=3D"all"></div></div></div></div></div></div></div></div></div></div>

--f46d0447f12c6c86830531a45bd7--

--===============8761534740914208392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8761534740914208392==--
