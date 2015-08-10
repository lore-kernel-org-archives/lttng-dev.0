From: Anand Neeli <anand.neeli@gmail.com>
Subject: Re: 32-bit application crash
Date: Mon, 10 Aug 2015 21:04:41 +0530
Message-ID: <CAM5kDqx75WqM7E8JoL-bmxfoXFNwsXzxyq0216ew3fnE8Y10Vg__22737.822662066$1439220947$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0903282811=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1ZOp67-0000RN-RG
 for lttng-dev@lists.lttng.org; Mon, 10 Aug 2015 11:34:57 -0400
Received: by ykeo23 with SMTP id o23so142097089yke.3
 for <lttng-dev@lists.lttng.org>; Mon, 10 Aug 2015 08:34:42 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, jamieexplorer@gmail.com
List-Id: lttng-dev@lists.lttng.org

--===============0903282811==
Content-Type: multipart/alternative; boundary=001a11378a406c420d051cf6b916

--001a11378a406c420d051cf6b916
Content-Type: text/plain; charset=UTF-8

Hi Jam,

You might be seeing this crash as c++ support may not there for tracepoint
probes.
Seen this note while going through bugfixes  in 2.7
https://github.com/lttng/lttng-ust/commit/c87d0ff28731aa18660cbb076e69ed7677dea3d2

"- Note for C++ support: although an application instrumented with
   tracepoints can be compiled with g++, tracepoint probes should be
   compiled with gcc (only tested with gcc so far)."

But you are seeing this only when using g++ with 32-bit apps. 64-bit apps
compiled g++ dont crash.
Would be good if experts comment here.

Thanks,
Anand Neeli

--001a11378a406c420d051cf6b916
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jam,<div><br></div><div>You might be seeing this crash =
as c++ support may not there for tracepoint probes.</div><div>Seen this not=
e while going through bugfixes =C2=A0in 2.7</div><div><a href=3D"https://gi=
thub.com/lttng/lttng-ust/commit/c87d0ff28731aa18660cbb076e69ed7677dea3d2" t=
arget=3D"_blank">https://github.com/lttng/lttng-ust/commit/c87d0ff28731aa18=
660cbb076e69ed7677dea3d2</a><br></div><div><br></div><div><pre style=3D"ove=
rflow:visible;font-family:Consolas,&#39;Liberation Mono&#39;,Menlo,Courier,=
monospace;font-size:13px;margin-top:10px;margin-bottom:10px;font-stretch:no=
rmal;line-height:1.45;max-width:100%;color:rgb(89,96,99);white-space:pre-wr=
ap;word-wrap:break-word;background-color:rgb(230,241,246)">&quot;- Note for=
 C++ support: although an application instrumented with
   tracepoints can be compiled with g++, tracepoint probes should be
   compiled with gcc (only tested with gcc so far).&quot;</pre><div>But you=
 are seeing this only when using g++ with 32-bit apps. 64-bit apps compiled=
 g++ dont crash.</div><div>Would be good if experts comment here.</div><br>=
Thanks,<br>Anand Neeli</div></div>

--001a11378a406c420d051cf6b916--


--===============0903282811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0903282811==--
