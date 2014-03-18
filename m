From: Hongbo Zhang <hongbo.zhang@linaro.org>
Subject: Regarding LTTng Support for ARM NO-HZ
Date: Tue, 18 Mar 2014 16:07:19 +0800
Message-ID: <CAOhR-w0_0oy1aOfc64fXmxzpeqtObU4Vv3Pnp810eH+XQrmymw__28298.2623241425$1395130112$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0766015659=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <hongbo.zhang@linaro.org>) id 1WPp3X-0007Af-Fq
	for lttng-dev@lists.lttng.org; Tue, 18 Mar 2014 04:07:33 -0400
Received: by mail-vc0-f172.google.com with SMTP id la4so6739635vcb.17
	for <lttng-dev@lists.lttng.org>; Tue, 18 Mar 2014 01:07:20 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0766015659==
Content-Type: multipart/alternative; boundary=001a11334c387273c004f4dd0656

--001a11334c387273c004f4dd0656
Content-Type: text/plain; charset=ISO-8859-1

Hi Mathieu Desnoyers and all LTTng developers,
This is Hongbo Zhang, working for Linaro. We have to enable the NO-HZ
feature for some special case, and this leads to the question whether the
LTTng can work without kernel ticks on ARM or not.

I found out some clue that LTTng only supports x86 NO-HZ in an old link:
http://git.lttng.org/?p=lttv.git;a=blob_plain;f=doc/developer/lttng-lttv-roadmap.html

I think the the LTTng doesn't support ARM NO-HZ, right?
And I am going to add the ARM NO-HZ support to it now, so could you please
give me some instructions for quick start?

1. Which part of LTTng relies on kernel ticks? currently I only find the
ring-bugger by "grep NO*HZ -i -r" command.
2. How does this part(ring-buffer and maybe others) relies on kernel ticks?
can you give some explanations or do you have any document of it/them?

I will look through the codes, but I think some clear explanations can make
me go to the right way and speed up before reading so many codes without
any dedicated target.

Thanks.

--001a11334c387273c004f4dd0656
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=A0Mathieu Desnoyers and all LTTng developers,<div>This =
is Hongbo Zhang, working for Linaro. We have to enable the NO-HZ feature fo=
r some special case, and this leads to the question whether the LTTng can w=
ork without kernel ticks on ARM or not.</div>
<div><br></div><div>I found out some clue that LTTng only supports x86 NO-H=
Z in an old link:</div><div><a href=3D"http://git.lttng.org/?p=3Dlttv.git;a=
=3Dblob_plain;f=3Ddoc/developer/lttng-lttv-roadmap.html">http://git.lttng.o=
rg/?p=3Dlttv.git;a=3Dblob_plain;f=3Ddoc/developer/lttng-lttv-roadmap.html</=
a><br>
</div><div><br></div><div>I think the the LTTng doesn&#39;t support ARM NO-=
HZ, right?</div><div>And I am going to add the ARM NO-HZ support to it now,=
 so could you please give me some instructions for quick start?</div><div>
<br></div><div>1. Which part of LTTng relies on kernel ticks? currently I o=
nly find the ring-bugger by &quot;grep NO*HZ -i -r&quot; command.</div><div=
>2. How does this part(ring-buffer and maybe others) relies on kernel ticks=
? can you give some explanations or do you have any document of it/them?</d=
iv>
<div><br></div><div>I will look through the codes, but I think some clear e=
xplanations can make me go to the right way and speed up before reading so =
many codes without any dedicated=A0target.</div><div><br></div><div>Thanks.=
</div>
</div>

--001a11334c387273c004f4dd0656--


--===============0766015659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0766015659==--
