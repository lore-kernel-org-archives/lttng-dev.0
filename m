Return-Path: <SRS0=8WX2=D3=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C62AC4363A
	for <lttng-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:34:08 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E1022251
	for <lttng-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="wm25YURD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E1022251
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CFx2j0wHfz14RV;
	Tue, 20 Oct 2020 10:34:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1603204445;
	bh=LawwaptwgqOpTfMHqocuDqhE2t0Dkwh5sUPeYIsipOA=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=wm25YURDrKQ2kyeJ7ISm0k6tVP5x0Kk+Do5uxFO50nKedLZ4I0iSeYPuG/wu0yho0
	 vQDzX3diSbMJUxDFljC0odCTCTzXRMVeb6rGZtexBunKmkLAqfOY1KbH3sf3R5DgMn
	 rWtPPHBj5MI9kVv0HhhkrizsdcUedNAMF4QHJJdwATa1YzyYB5nisttVmiXNPEU20v
	 QuQMHTUkkb+l3fM/7ii5SRB3F2sWTKpModhWVACYy9FPlUvBOx8ucSha4PBDk/EoUx
	 iQnA8unQxkoGre/erO+0heUaG2WlZb1u5+aKu7qmC7b25V660e0rxDrDmejc+Gmfe4
	 keL4jaK+QXc0Q==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CFx2h17vPz14mK
 for <lttng-dev@lists.lttng.org>; Tue, 20 Oct 2020 10:34:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B7E5A2D9A6B
 for <lttng-dev@lists.lttng.org>; Tue, 20 Oct 2020 10:33:57 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 6Gl8yKGrzOkY; Tue, 20 Oct 2020 10:33:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3B5272D98D1;
 Tue, 20 Oct 2020 10:33:57 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3B5272D98D1
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id q30KjHKc0AyT; Tue, 20 Oct 2020 10:33:57 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 2FA832D9A66;
 Tue, 20 Oct 2020 10:33:57 -0400 (EDT)
Date: Tue, 20 Oct 2020 10:33:57 -0400 (EDT)
To: "Naaz, Syeda Shagufta" <SyedaShagufta_Naaz@mentor.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <428174244.30175.1603204437087.JavaMail.zimbra@efficios.com>
In-Reply-To: <697bafac905e4a9fa3633a4b088979a3@SVR-IES-MBX-03.mgc.mentorg.com>
References: <697bafac905e4a9fa3633a4b088979a3@SVR-IES-MBX-03.mgc.mentorg.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF81 (Linux)/8.8.15_GA_3968)
Thread-Topic: Error in lttng-modules after pulling in commit 'writeback: Fix
 sync livelock due to b_dirty_time processing'
Thread-Index: Adamrcb+ZR7BLc1eRcez7r7xkdSzaJ/hHUgz
Subject: Re: [lttng-dev] Error in lttng-modules after pulling in commit
 'writeback: Fix sync livelock due to b_dirty_time processing'
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: multipart/mixed; boundary="===============7314042646885961563=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============7314042646885961563==
Content-Type: multipart/alternative; 
	boundary="=_212ddf4b-a4b3-4f2e-8e37-2a5ab7b49fc5"

--=_212ddf4b-a4b3-4f2e-8e37-2a5ab7b49fc5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Oct 20, 2020, at 2:59 AM, lttng-dev <lttng-dev@lists.lttng.org> wr=
ote:=20

> Hi All,

> I=E2=80=99m facing compilation error in build after pulling in the stable=
 kernel
> LTS(4.14.y) commit - [
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?=
h=3Dlinux-4.14.y&id=3D77322edb99f0176ec67a300b9f263719ba391b89
> |
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?=
h=3Dlinux-4.14.y&id=3D77322edb99f0176ec67a300b9f263719ba391b89
> ]

Hi,=20

lttng-modules tracks the stable kernels through their versions (e.g. 4.14.1=
65). There are ifdefs in the=20
lttng-modules code to choose the right instrumentation implementation based=
 on the kernel version it is=20
built against.=20

Of course, if you don't follow the versioning scheme of the stable kernels =
and cherry-pick random commits,=20
there is little lttng-modules can do to track those changes. We have worked=
 with Ubuntu, Redhat and Debian=20
distributions to ensure their kernels are versioned in a way which is also =
detected by lttng-modules, in the=20
situations where the kernels diverge from upstream. If you want to create y=
our own kernel which also=20
differs from all other existing kernels out there, you will also need to ta=
ke care of versioning it and adapt=20
lttng-modules accordingly.=20

Thanks,=20

Mathieu=20

> I tried this solution - [
> https://github.com/lttng/lttng-modules/commit/7318a1e88c8097733f5a0552906=
9e4e03c142cae
> |
> https://github.com/lttng/lttng-modules/commit/7318a1e88c8097733f5a0552906=
9e4e03c142cae
> ]

> But this also didn=E2=80=99t resolve my problem.

>| In file included from
>| /home/snaaz/elm/8up/main/build_zcu/tmp/work/zcu102_zynqmp_mel-mel-linux/=
lttng-modules/2.10.9-r0/lttng-modules-2.10.9/probes/../probes/define_trace.=
h
> | =F0=9F=92=AF 0,

>| from
> | /home/snaaz/elm/8up/main/build_zcu/tmp/work/zcu102_zynqmp_mel-mel-linux=
/lttng-modules/2.10.9-r0/lttng-modules-2.10.9/probes/../instrumentation/eve=
nts/lttng-module/writeback.h:735,

>| from
> | /home/snaaz/elm/8up/main/build_zcu/tmp/work/zcu102_zynqmp_mel-mel-linux=
/lttng-modules/2.10.9-r0/lttng-modules-2.10.9/probes/lttng-probe-writeback.=
c:51:

>| /home/snaaz/elm/8up/main/build_zcu/tmp/work/zcu102_zynqmp_mel-mel-linux/=
lttng-modules/2.10.9-r0/lttng-modules-2.10.9/probes/../probes/lttng-tracepo=
int-event-impl.h:143:6:
> | error: conflicting types for 'trace_writeback_queue_io'

> | void trace_##_name(_proto);

> | ^

>| /home/snaaz/elm/8up/main/build_zcu/tmp/work/zcu102_zynqmp_mel-mel-linux/=
lttng-modules/2.10.9-r0/lttng-modules-2.10.9/probes/../probes/lttng-tracepo=
int-event-impl.h:55:2:
> | note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP'

> | LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(map, name, map, PARAMS(proto), PARA=
MS(args))

> | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

>| /home/snaaz/elm/8up/main/build_zcu/tmp/work/zcu102_zynqmp_mel-mel-linux/=
lttng-modules/2.10.9-r0/lttng-modules-2.10.9/probes/../probes/lttng-tracepo=
int-event-impl.h:97:2:
> | note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_MAP'

> | LTTNG_TRACEPOINT_EVENT_MAP(name, name, \

> | ^~~~~~~~~~~~~~~~~~~~~~~~~~

>| /home/snaaz/elm/8up/main/build_zcu/tmp/work/zcu102_zynqmp_mel-mel-linux/=
lttng-modules/2.10.9-r0/lttng-modules-2.10.9/probes/../instrumentation/even=
ts/lttng-module/writeback.h:375:1:
> | note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT'

> | LTTNG_TRACEPOINT_EVENT(writeback_queue_io,

> | ^~~~~~~~~~~~~~~~~~~~~~

>| In file included from
> | /home/snaaz/elm/8up/main/build_zcu/tmp/work-shared/zcu102-zynqmp-mel/ke=
rnel-source/include/trace/events/writeback.h:8:0,

>| from
> | /home/snaaz/elm/8up/main/build_zcu/tmp/work/zcu102_zynqmp_mel-mel-linux=
/lttng-modules/2.10.9-r0/lttng-modules-2.10.9/probes/lttng-probe-writeback.=
c:33:

>| /home/snaaz/elm/8up/main/build_zcu/tmp/work-shared/zcu102-zynqmp-mel/ker=
nel-source/include/linux/tracepoint.h:187:21:
> | note: previous definition of 'trace_writeback_queue_io' was here

> | static inline void trace_##name(proto) \

> | ^

>| /home/snaaz/elm/8up/main/build_zcu/tmp/work-shared/zcu102-zynqmp-mel/ker=
nel-source/include/linux/tracepoint.h:352:2:
> | note: in expansion of macro '__DECLARE_TRACE'

> | __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args), \

> | ^~~~~~~~~~~~~~~

>| /home/snaaz/elm/8up/main/build_zcu/tmp/work-shared/zcu102-zynqmp-mel/ker=
nel-source/include/linux/tracepoint.h:488:2:
> | note: in expansion of macro 'DECLARE_TRACE'

> | DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))

> | ^~~~~~~~~~~~~

>| /home/snaaz/elm/8up/main/build_zcu/tmp/work-shared/zcu102-zynqmp-mel/ker=
nel-source/include/trace/events/writeback.h:361:1:
> | note: in expansion of macro 'TRACE_EVENT'

> | TRACE_EVENT(writeback_queue_io,

> Kindly look into it and do the needful. Thanks!

> Regards,

> Syeda Shagufta Naaz

> Software Development Engineer | Mentor Embedded Linux

> Mentor , A Siemens Business

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_212ddf4b-a4b3-4f2e-8e37-2a5ab7b49fc5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><style>/*<![CDATA[*/p.MsoNormal, li.MsoNorm=
al, div.MsoNormal {
=09margin: 0.0cm;
=09font-size: 11.0pt;
=09font-family: Calibri , sans-serif;
}
a:link, span.MsoHyperlink {
=09color: rgb(5,99,193);
=09text-decoration: underline;
}
a:visited, span.MsoHyperlinkFollowed {
=09color: rgb(149,79,114);
=09text-decoration: underline;
}
pre {
=09margin: 0.0cm;
=09font-size: 10.0pt;
=09font-family: "Courier New";
}
span.EmailStyle17 {
=09font-family: Calibri , sans-serif;
=09color: windowtext;
}
span.HTMLPreformattedChar {
=09font-family: "Courier New";
}
*.MsoChpDefault {
}
div.WordSection1 {
=09page: WordSection1;
}
/*]]>*/</style></div><div><br></div><div><br></div><div><span id=3D"zwchr" =
data-marker=3D"__DIVIDER__">----- On Oct 20, 2020, at 2:59 AM, lttng-dev &l=
t;lttng-dev@lists.lttng.org&gt; wrote:<br></span></div><div data-marker=3D"=
__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-=
left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;t=
ext-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"=
>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi All,</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">I=E2=80=99m facing compilation error in build after =
pulling in the stable kernel LTS(4.14.y) commit -
<a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git=
/commit/?h=3Dlinux-4.14.y&amp;id=3D77322edb99f0176ec67a300b9f263719ba391b89=
" target=3D"_blank" rel=3D"nofollow noopener noreferrer">
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dlinux-4.14.y&amp;id=3D77322edb99f0176ec67a300b9f263719ba391b89</a><br da=
ta-mce-bogus=3D"1"></p>
<p class=3D"MsoNormal">&nbsp;</p></div></blockquote><div><br></div><div>Hi,=
<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>ltt=
ng-modules tracks the stable kernels through their versions (e.g. 4.14.165)=
. There are ifdefs in the<br data-mce-bogus=3D"1"></div><div>lttng-modules =
code to choose the right instrumentation implementation based on the kernel=
 version it is<br data-mce-bogus=3D"1"></div><div>built against.<br data-mc=
e-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Of course, if =
you don't follow the versioning scheme of the stable kernels and cherry-pic=
k random commits,</div><div>there is little lttng-modules can do to track t=
hose changes. We have worked with Ubuntu, Redhat and Debian<br data-mce-bog=
us=3D"1"></div><div>distributions to ensure their kernels are versioned in =
a way which is also detected by lttng-modules, in the<br data-mce-bogus=3D"=
1"></div><div>situations where the kernels diverge from upstream. If you wa=
nt to create your own kernel which also<br data-mce-bogus=3D"1"></div><div>=
differs from all other existing kernels out there, you will also need to ta=
ke care of versioning it and adapt<br data-mce-bogus=3D"1"></div><div>lttng=
-modules accordingly.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-b=
ogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-m=
ce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010FF;mar=
gin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:norm=
al;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12=
pt;"><div class=3D"WordSection1">
<p class=3D"MsoNormal">I tried this solution - <a href=3D"https://github.co=
m/lttng/lttng-modules/commit/7318a1e88c8097733f5a05529069e4e03c142cae" targ=
et=3D"_blank" rel=3D"nofollow noopener noreferrer">
https://github.com/lttng/lttng-modules/commit/7318a1e88c8097733f5a05529069e=
4e03c142cae</a><br data-mce-bogus=3D"1"></p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">But this also didn=E2=80=99t resolve my problem. </p=
>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">| In file inc=
luded from
 /home/snaaz/elm/8up/main/build_zcu/tmp/work/zcu102_zynqmp_mel-mel-linux/lt=
tng-modules/2.10.9-r0/lttng-modules-2.10.9/probes/../probes/define_trace.h<=
/span><span style=3D"font-size:10pt;font-family:'segoe ui symbol' , sans-se=
rif;color:#7f7f7f">=F0=9F=92=AF</span><span style=3D"font-size:10pt;font-fa=
mily:'consolas';color:#7f7f7f">0,</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">|&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; from
 /home/snaaz/elm/8up/main/build_zcu/tmp/work/zcu102_zynqmp_mel-mel-linux/lt=
tng-modules/2.10.9-r0/lttng-modules-2.10.9/probes/../instrumentation/events=
/lttng-module/writeback.h:735,</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">|&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; from
 /home/snaaz/elm/8up/main/build_zcu/tmp/work/zcu102_zynqmp_mel-mel-linux/lt=
tng-modules/2.10.9-r0/lttng-modules-2.10.9/probes/lttng-probe-writeback.c:5=
1:</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">| /home/snaaz=
/elm/8up/main/build_zcu/tmp/work/zcu102_zynqmp_mel-mel-linux/lttng-modules/=
2.10.9-r0/lttng-modules-2.10.9/probes/../probes/lttng-tracepoint-event-impl=
.h:143:6:
 error: conflicting types for 'trace_writeback_queue_io'</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">|&nbsp; void =
trace_##_name(_proto);</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">|&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; ^</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">| /home/snaaz=
/elm/8up/main/build_zcu/tmp/work/zcu102_zynqmp_mel-mel-linux/lttng-modules/=
2.10.9-r0/lttng-modules-2.10.9/probes/../probes/lttng-tracepoint-event-impl=
.h:55:2:
 note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP'</span></=
p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">|&nbsp;&nbsp;=
 LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(map,
 name, map, PARAMS(proto), PARAMS(args))</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">|&nbsp;&nbsp;=
 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">| /home/snaaz=
/elm/8up/main/build_zcu/tmp/work/zcu102_zynqmp_mel-mel-linux/lttng-modules/=
2.10.9-r0/lttng-modules-2.10.9/probes/../probes/lttng-tracepoint-event-impl=
.h:97:2:
 note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_MAP'</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">|&nbsp;&nbsp;=
 LTTNG_TRACEPOINT_EVENT_MAP(name,
 name,&nbsp;&nbsp;&nbsp; \</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">|&nbsp;&nbsp;=
 ^~~~~~~~~~~~~~~~~~~~~~~~~~</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">| /home/snaaz=
/elm/8up/main/build_zcu/tmp/work/zcu102_zynqmp_mel-mel-linux/lttng-modules/=
2.10.9-r0/lttng-modules-2.10.9/probes/../instrumentation/events/lttng-modul=
e/writeback.h:375:1:
 note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT'</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">|&nbsp; LTTNG=
_TRACEPOINT_EVENT(writeback_queue_io,</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">|&nbsp; ^~~~~=
~~~~~~~~~~~~~~~~~</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">| In file inc=
luded from
 /home/snaaz/elm/8up/main/build_zcu/tmp/work-shared/zcu102-zynqmp-mel/kerne=
l-source/include/trace/events/writeback.h:8:0,</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">|&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; from
 /home/snaaz/elm/8up/main/build_zcu/tmp/work/zcu102_zynqmp_mel-mel-linux/lt=
tng-modules/2.10.9-r0/lttng-modules-2.10.9/probes/lttng-probe-writeback.c:3=
3:</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">| /home/snaaz=
/elm/8up/main/build_zcu/tmp/work-shared/zcu102-zynqmp-mel/kernel-source/inc=
lude/linux/tracepoint.h:187:21:
 note: previous definition of 'trace_writeback_queue_io' was here</span></p=
>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">|&nbsp;&nbsp;=
 static inline void trace_##name(proto)&nbsp;&nbsp;&nbsp;
 \</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">|&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">| /home/snaaz=
/elm/8up/main/build_zcu/tmp/work-shared/zcu102-zynqmp-mel/kernel-source/inc=
lude/linux/tracepoint.h:352:2:
 note: in expansion of macro '__DECLARE_TRACE'</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">|&nbsp;&nbsp;=
 __DECLARE_TRACE(name,
 PARAMS(proto), PARAMS(args),&nbsp; \</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">|&nbsp;&nbsp;=
 ^~~~~~~~~~~~~~~</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">| /home/snaaz=
/elm/8up/main/build_zcu/tmp/work-shared/zcu102-zynqmp-mel/kernel-source/inc=
lude/linux/tracepoint.h:488:2:
 note: in expansion of macro 'DECLARE_TRACE'</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">|&nbsp;&nbsp;=
 DECLARE_TRACE(name,
 PARAMS(proto), PARAMS(args))</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">|&nbsp;&nbsp;=
 ^~~~~~~~~~~~~</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">| /home/snaaz=
/elm/8up/main/build_zcu/tmp/work-shared/zcu102-zynqmp-mel/kernel-source/inc=
lude/trace/events/writeback.h:361:1:
 note: in expansion of macro 'TRACE_EVENT'</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:7.5pt;background:#f1f8ff"><span =
style=3D"font-size:10pt;font-family:'consolas';color:#7f7f7f">|&nbsp; TRACE=
_EVENT(writeback_queue_io,</span></p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">Kindly look into it and do the needful. Thanks!</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">Regards,</p>
<p class=3D"MsoNormal">Syeda Shagufta Naaz</p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
10pt;font-family:'arial' , sans-serif;color:#191919;background:white">Softw=
are Development Engineer | Mentor Embedded Linux</span></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:18pt;font-family:'arial'=
 , sans-serif;color:#c00000;background:white">Mentor</span></b><b><span sty=
le=3D"font-family:'arial' , sans-serif;color:#191919;background:white">,</s=
pan></b><span style=3D"font-size:10pt;color:#2e74b5;background:white">A
 Siemens Business</span></p>
<p class=3D"MsoNormal">&nbsp;</p>
</div>

<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_212ddf4b-a4b3-4f2e-8e37-2a5ab7b49fc5--

--===============7314042646885961563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7314042646885961563==--
