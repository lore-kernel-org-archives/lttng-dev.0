Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC612C83F1B
	for <lttng-dev@archiver.kernel.org>; Wed, 16 Jul 2025 04:09:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bhjHl3x76z23rq
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1752638981;
	b=U+4AsIg15rd7ufBXPiS2CUIrn/hd//XUM+84q9e1indkGQih77lohvuB7S5+e0Cp4DII
	 GaXWnLgsCR84AsIRBK6gJMW9C89kjFzTeh1mt68C97bAgev8XfEaM/y3B26L2LtsSEihc
	 OLkNDsnBkcYXD9ON2SwZ08LyA4mpIysUQnWgDjIcgH9+xMgXu8BgKN6hy6MMiE5OnvzbP
	 FDKLiFp9kYbYSmjxAJdEnGYtVPtN7cJwqQsWjt8Cl+UKIz+ubgiV3/RSn3oRBDRqaQgSd
	 9/nNNsqyiP460bIZb66xvb87vC94Ozf1EhMnKZVV7u5wwBeC1j6+JLfkabpP78BuvUQ==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1752638981;
	h=DKIM-Signature:Mime-Version:Date:Subject:Message-Id:To:From:From;
	bh=yBpfr3f093naAb7ph/5kFXmukZjpAfghSmzd6lRrsLU=;
	b=OzT8dG1O7//BDl7+7MBWNaO0HViaZiSIm2i7hOa6EtRMeKkyiw4N7IQ7c50z28JCOsor
	 KUwYvAqEEaD/d4g/mVU4bWoZ7dbkyaJalD5AlX1glBqpCWYFC8s1dE8gvqYvsSqUjja8j
	 7SNFg3sIjPcD4ZJIZ7yGxcVND1quMske0itRC+JsH4t/ZfIVXVnGK58kMN5G/MHHNgWJ+
	 uFT9Xi2O8NuXy1pCiUZmWEcZ6KUR8KhIQZXBCb8eZnU9SPgY7YJdmDa5U++b+/PUSnlsW
	 EssIRaMfYkg2BflzpO3RjHEZGKnn5CCePpTrdqEXu3V/kf6LiJTKKNDOZGlRYz6dXoQ==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bhjHl3x76z23rq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1752638981;
	bh=yBpfr3f093naAb7ph/5kFXmukZjpAfghSmzd6lRrsLU=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=Z6gsN9+0koS2QHrBT3KDnyzq6OP0aTW36RJANv3JIqMn+s859URRtuSwvC1QzdmtM
	 r/1RH5ljML3QI3W2k6LSmt5psuSehJas9bWpCTeibXMCVOodmENwEBUC7ODs4ok2n7
	 gpmw4bKUg/gFI5knnICYLvXZvOehPdTG6DgRWxBiZGfnhftJ8RiEwVP0CTeraHBw5H
	 2dtPkPfgOunUZinnFRUalrs2KgE6QrdnIKPGK814CU1mUOV1zpJlCA335Mx6V+pnB2
	 LktbO82NIM9OdbHb4oZ2YQ/uAlHHcWiM4l7iHHk03FZQfP46mfu+BE64+gObqqpw8j
	 vu3X62RCabfPw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bhjHl3x76z23rq;
	Wed, 16 Jul 2025 00:09:39 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bhjHj34MBz23rY
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bhjHj34MBz23rY
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by lists.lttng.org (Postfix) with ESMTPS id 4bhjHj34MBz23rY
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jul 2025 00:09:36 -0400 (EDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 76D1BEC010C
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jul 2025 00:09:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 16 Jul 2025 00:09:35 -0400
X-ME-Sender: <xms:_yV3aLgu_IjNwmfzb0UwnY7p_pjRh1P44XbRvApredZvpEmOKNRjvw>
 <xme:_yV3aKCfGwNl0HK4u1iML3E1PRUBbIExKAw3OvyPOaiQjPRNUNz1_dBhDBVSvN48y
 ZWDRKOKR820b-ydWTs>
X-ME-Received: <xmr:_yV3aEc4InRxyuZU-PnjIxv1jpySAZ3b_kRrQTevSyAH0OOE5fF8P890age_F-12KBS9T9Ys_SSac9rUFRECe9fxmemS83MvZxu4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehieejvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecuqfhnlhihuchonhgvuchprghrthculdehuddmnecujfgurh
 eptgfghfggfffukffvofesrgejmherhhdtjeenucfhrhhomhepqfhnughrvghjucfuuhhr
 upcuoehonhgurhgvjhesshhurhihrdhorhhgqeenucggtffrrghtthgvrhhnpedvkeffgf
 evkeeugefffeejteekgfdvgffgvdejteefhfeffeffveetgffhfeduhfenucffohhmrghi
 nhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepohhnughrvghjsehsuhhrhidrohhrghdpnhgspghrtghpthhtohep
 uddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhtthhnghdquggvvheslhhish
 htshdrlhhtthhnghdrohhrgh
X-ME-Proxy: <xmx:_yV3aKe1ukXQmoaksdeU5QUxUTd105ssXqBjprtYuSxak9DHd0MYYw>
 <xmx:_yV3aAhPUnkmeIRE9CjxBnctaVmcBLnW-bFSR1dO4JIbWqxzVxLqGw>
 <xmx:_yV3aOTfa3XA_rIZtSWxXCfGF_YL76EzMjyVUbbmtUgM6GGbeT1FTA>
 <xmx:_yV3aJzL2OAui-yrB_D7lXpxgyQ0_E0xzv3wdceBCpnRDOD_Mue3Kg>
 <xmx:_yV3aMVJUFQlVMo8gYBm7Yc4l9qeOS-x3Sy-zXKy3qqtet0E7mB6K1ec>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <lttng-dev@lists.lttng.org>; Wed, 16 Jul 2025 00:09:34 -0400 (EDT)
Content-Type: multipart/alternative;
 boundary=Apple-Mail-9E68AFA5-920A-425B-9A53-6E4953BE8C5C
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (1.0)
Date: Wed, 16 Jul 2025 06:09:22 +0200
Subject: Integrating QSBR with libuv
Message-Id: <FBE0CAA6-64F4-48A1-9F69-ECDB6B5E809C@sury.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
X-Mailer: iPhone Mail (22F76)
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: =?utf-8?q?Ond=C5=99ej_Sur=C3=BD_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?utf-8?Q?Ond=C5=99ej_Sur=C3=BD?= <ondrej@sury.org>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>


--Apple-Mail-9E68AFA5-920A-425B-9A53-6E4953BE8C5C
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto"><div>Hi,</div><div><br></div><div>currently=
, the BIND 9 design involves multiple threads with per-thread event loop fro=
m libuv (uv_loop).</div><div><br></div><div>We are using the default rcu var=
iant, but it seems like an ideal place to switch to QSBR as we can call quie=
scent state periodically before polling on the loop.</div><div><br></div><di=
v>This comes with one trouble though. The incoming traffic is distributed us=
ing SO_REUSEPORT load-balancing in the kernel and if the hashing algorithm i=
s too simple or the traffic just hashes only into 1..n-1 threads, the memory=
 reclamation will never trigger (means indefinite wait for synchronize_rcu()=
 or indefinite queue in the call_rcu).</div><div><br></div><div>Now, I have b=
asically two solutions I can think of:</div><div><br></div><div>1. Bring the=
 threads offline before polling and online after polling. This has two probl=
ems: a) there=E2=80=99s overhead related to calling thread_offline/thread_on=
line and it is unclear to me how big overhead this is; b) currently, there i=
s no way to bring the thread online before libuv callbacks are called -&nbsp=
;<a href=3D"https://github.com/libuv/libuv/issues/4839#issuecomment-30764932=
38">https://github.com/libuv/libuv/issues/4839</a></div><div><br></div><div>=
2. Add short per event loop periodic timer that would call the quiescent sta=
te every &lt;n&gt; ms, but I have a vague recollection that unneeded periodi=
c timers mess with the power management as they wake up the process even whe=
n it would be otherwise completely idle.</div><div><br></div><div>The bonus t=
hird option is to give up on this because there are lower hanging fruits to i=
mprove the performance than the membarrier vs QSBR. That=E2=80=99s certainly=
 true, but it is an interesting software engineering problem, so I am not re=
ady to give this up easily ;). And coming up with a solution to this could l=
ead to at least a blog post that more project could benefit from a solution t=
o this. (For a moment, pausing from the grim world we live in now where ever=
y idea gets sucked into LLM and venture capital.)</div><div><br></div>Ondrej=
<br id=3D"lineBreakAtBeginningOfSignature"><div dir=3D"ltr"><span style=3D"b=
ackground-color: rgba(255, 255, 255, 0);">--</span><div><span style=3D"backg=
round-color: rgba(255, 255, 255, 0);">Ond=C5=99ej Sur=C3=BD (He/Him)</span><=
/div></div></body></html>=

--Apple-Mail-9E68AFA5-920A-425B-9A53-6E4953BE8C5C--
