From: Anand Neeli <anand.neeli@gmail.com>
Subject: Warning: HOME environment variable not set
Date: Tue, 10 Feb 2015 12:25:14 +0530
Message-ID: <CAM5kDqwOHYBAt_=7eeXrm_xHZPMVizMWaT1NiBtQQmxK2d_tsA__40838.1784022369$1423551369$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0687003328=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f172.google.com ([74.125.82.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1YL4j9-00047k-W8
 for lttng-dev@lists.lttng.org; Tue, 10 Feb 2015 01:55:20 -0500
Received: by mail-we0-f172.google.com with SMTP id k48so10556690wev.3
 for <lttng-dev@lists.lttng.org>; Mon, 09 Feb 2015 22:55:14 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0687003328==
Content-Type: multipart/alternative; boundary=f46d0418254a69bce1050eb65e2a

--f46d0418254a69bce1050eb65e2a
Content-Type: text/plain; charset=UTF-8

Hi All,
I get the following warning in my app.
App has included lttng libraries, but doesnt have any instrumented code
with trace points.

Can anyone tell me the issue here?
i'm using 2.4.1 version

app: libust[2628/2628]: Warning: HOME environment variable not set.
Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
lttng-ust-comm.c:305)

app: libust[2634/2634]: Warning: HOME environment variable not set.
Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
lttng-ust-comm.c:305)

app: libust[2636/2636]: Warning: HOME environment variable not set.
Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
lttng-ust-comm.c:305)

app: libust[2638/2638]: Warning: HOME environment variable not set.
Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
lttng-ust-comm.c:305)


Thanks,

Anand Neeli

--f46d0418254a69bce1050eb65e2a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div>I get the following warning in my app.</div><d=
iv>App has included lttng libraries, but doesnt have any instrumented code =
with trace points.</div><div><br></div><div>Can anyone tell me the issue he=
re?</div><div>i&#39;m using 2.4.1 version</div><div><br></div><div>







<p class=3D"">app: libust[2628/2628]: Warning: HOME environment variable no=
t set. Disabling LTTng-UST per-user tracing. (in setup_local_apps() at lttn=
g-ust-comm.c:305)</p><p class=3D"">app: libust[2634/2634]: Warning: HOME en=
vironment variable not set. Disabling LTTng-UST per-user tracing. (in setup=
_local_apps() at lttng-ust-comm.c:305)</p>
<p class=3D"">app: libust[2636/2636]: Warning: HOME environment variable no=
t set. Disabling LTTng-UST per-user tracing. (in setup_local_apps() at lttn=
g-ust-comm.c:305)</p>
<p class=3D"">app: libust[2638/2638]: Warning: HOME environment variable no=
t set. Disabling LTTng-UST per-user tracing. (in setup_local_apps() at lttn=
g-ust-comm.c:305)</p><p class=3D""><br></p><p class=3D"">Thanks,</p><p clas=
s=3D"">Anand Neeli</p></div></div>

--f46d0418254a69bce1050eb65e2a--


--===============0687003328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0687003328==--
