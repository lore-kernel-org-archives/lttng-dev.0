Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83018FF8873
	for <lttng-dev@archiver.kernel.org>; Thu, 30 Apr 2026 17:01:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4g60nk73GMz229T
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1777568508;
	b=NYsxBLf+7V/joMl9l7twLPkeh4032qyML99PX43lCr/hLkRBfIsr7Qxj5cZwwAsvgIUI
	 XpKIybUqfGURO0vjtccz+uMJ+5UcNA8lZ+IX6ZHNDiDJpkrNkx6xjQUDIQXisHVQyM7zc
	 57L5mhyc7Dtxilnl9tRLzhUtMZ7ZYEC2vi9/S9DPXUkwwdm70nBlBoORiN+Onv5rAAKs3
	 2SIC+3thJJiBBxEDuXVwpcX8sUUqt0Tu8BZl46sO5fQgIZv7ve/9kkdEgPtMDzfXumhWL
	 dGyxSGK/Mbkj6FnpYAUm92vj6XVL2LWtPY48yZbrweohUWGOyUlH2eV9a24mU4RDF0Q==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1777568508;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=jHFjD/23/umayFTVUnK6UkN0STh2CrdYJgFYS3xyb7c=;
	b=RT9fWMSCM66o1bbaTnPxfgtQkQAtcfxtUKxteDABG5OtAk+cMG97polk+OuvuI+p2gGP
	 tiPADsyLs8o0e2AHiIx5ga6Bv3uUkLn2wePtL5becKYBkEzObyAHUC7PY76YHwlFk3vH5
	 wghBXOcDEXeWOV0FF03MrpnahGwAl07bXEK3ZxZgDRzmgmFBAgYFqvleCWiU6zYeUMJZx
	 AeV/YSGJU9aifyyKQdgPExShLZgnIFd1j8Jje+pwGRkowMvk+GJ17oLvNoaWncsk/mqr2
	 lHR87K84k0dyZIff/UTYTsfPnXmD0FEI0VfX3FQCr9MUma97rYjLLQ+Tu0HkQIbh2Wg==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4g60nk73GMz229T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1777568508;
	bh=66Md/01a1EHoTF5XAdU+DkKpYZniCrTYw8f/qV/HF7M=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=dbBok9KTmF7YidRDbc35DXbou23psCvcm4bZgg1+mlOyUdrZDLBfBzKXaQr3k6dcP
	 hg8xwI1xyGdprfrD1EdIO2cUpda2brHvV9SxpqK/2QLdXJN13KvnNjOyGkaWSsE1uE
	 Sto0R7BWwLksqeTuE3HCGv2s1cQELlL9aFzBgYxMITccU2dFwegZcLRpAkDKaq570w
	 pZyXEqL4TR9wzbud9rAH74I48JmNFAq8oajgeX4rchExwo6rfnyLKSfHa4GjoILxOs
	 PLIPEDcrV2R1rP8oT6giFK8fOvxGXt8anMHHn3a7i3OYWBTn5x27b1JgKjXyMdfG0e
	 Y14yRcV31WEcA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4g60nk73GMz229T;
	Thu, 30 Apr 2026 13:01:46 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4g60nj67Pdz21fZ
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4g60nj67Pdz21fZ
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 by lists.lttng.org (Postfix) with ESMTPS id 4g60nj67Pdz21fZ
 for <lttng-dev@lists.lttng.org>; Thu, 30 Apr 2026 13:01:45 -0400 (EDT)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-7baee75f874so16532737b3.2
 for <lttng-dev@lists.lttng.org>; Thu, 30 Apr 2026 10:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777568503; cv=none;
 d=google.com; s=arc-20240605;
 b=YakqVH2m25vawxLqIz+qbGqLLgxXhllzPnK0f3WsrDUj3BRJ7m0S7X3kDjRfdMNsRJ
 eszYNXG4601CLdfWWANOgrgzs5d9Dt5UeRopfK69/ZTwvEYOoW+rY4b0AQ/OTi5q1VN+
 HvW5CR+fW76te4SxmXrIB5vyonE7N4yPMBGM3SpQm2VZT9K//Ar1lTxvhUwtvsNj3xoK
 iHMz2n7vuWD/W1+3eCGR91RCh6mhUxXzVwWbrsD93BGZtZl5V/pS2i6ISyIwUrWGeg6t
 ZYazyjdO2r4Jl77JG9c2apvdd+owsHF85zBzniRaB1A663XDNudaMdsE2yqs5FFjy1I+
 wOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=66Md/01a1EHoTF5XAdU+DkKpYZniCrTYw8f/qV/HF7M=;
 fh=Vi3MF25LmiCIknQyyhXLxIEZ5vqn+bls1ZIgHxHgtRU=;
 b=UCK6inAgylJurrmKqLJAhYWGNeETidQTrN+uN6t8tB8+aaF/mPBgM766Gp26pGOPUy
 /O9RAwy26iM5UpHfTt7KqctUve0/hK0jhBGITpkhSeqRM0uOnnMXYlXb5DS411I5IOkr
 sEnkE8uoKrNEdeDCFC+61tfC5eoChbX2SUOlMWlGpCUlAn3sTcaAd/TXwisC9SCesgXk
 RyI5DnJCU6j93OZ++Ma5Dx7nkU2ghNjxaq7oHb74Er8s0XGlbyS4LzNVaiY/ctfaTs0U
 KobOlkXiRrYPfAKXfMsKcGu7eFFfaMK795Ty/aebErK098tcidtqY3iIOXpu8cohf2fq
 xDkw==; darn=lists.lttng.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777568503; x=1778173303;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=66Md/01a1EHoTF5XAdU+DkKpYZniCrTYw8f/qV/HF7M=;
 b=jAeIZuwgxYhJBbkuyrIo9AodPW7eRwPAujv9aNM03IO7QA7Q26nPKxHRZQ2vMfemeA
 8aBkkAvN7PTqy5Bus92FACGfYq7zocz7hMJXzmGBaTFjH9pN996dBjSFLoiFx15hObHs
 bU2mDRAPsMr7kYSQD2pgEseqtd+/iFJg4OXmmDVGEBgYu2xs3qPx+MIE6C7gCsjfeh6a
 HTIV5PTf1DmctH5Qu1gl8SF2VzcL1rHjk7yKzt+9TI486UNqJr150UrNifx9EIFyOTWd
 14hPdCg0EvVxa2ixYlVh1dO/4GGs91o96ikOJR09/7KnXa6fqCyy7nw/nvVcJxqb75XS
 XJpw==
X-Gm-Message-State: AOJu0Yx+V2dTqQoAA20eQ7qku5vtmOU6hMaxvw1TcVc3DE1FZQ7Pkfb3
 kIpBR24Yg/guOyFpniBZm2Kh6Mtc6lvVIyYYt0yDjztIW69sB/J6gsSTny8+4xf4l5r0sFKYsQy
 v4eTofJ7lbP0hcJFvbAZdAzX4HPftyoa2FMmv
X-Gm-Gg: AeBDieswSI8UpEVfPyL+73MpEOtCPWi/WPM/TpxaO7UdQpN0gzN2mnOgvGqxkGCJqNI
 MVQBD51sE+MMMgdS8ngyjkprDIpdBlkQx/YVIVK8zAXmomgRlqSMtQllgkeRysN2gieORYNo4ZU
 xkyFUocLnQmUKxrEJruX81uYcOuCESDGwbZ5FRx3BMgolLL7YemEBgNQ19KB1gk1nRO9m+ZaFHm
 qId9MoC7A0P++H/6pNrCyZ9Ue/Z02FeXHk2CPGndKcXmDv+p2k5Jisf+CNGPG9jwA4ndp1h9gEp
 UazQ3QGRouX4bP6D6DU=
X-Received: by 2002:a05:690c:630c:b0:7ba:f6b4:358b with SMTP id
 00721157ae682-7bd52abcdfamr38852657b3.43.1777568503151; Thu, 30 Apr 2026
 10:01:43 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 30 Apr 2026 18:01:32 +0100
X-Gm-Features: AVHnY4K2yxh1MMIQpYjJc6emkRzOHVgubs4KJ8vq0mxGZTvfIQZiYY-It7abe7o
Message-ID: <CAJK_ieix5QAMUEhY4R4Cm5tUwZ_W98fG8wrb947GwCW3YR0tqQ@mail.gmail.com>
Subject: How to show method entry/exit in Trace Compass?
To: lttng-dev@lists.lttng.org
Content-Type: multipart/alternative; boundary="00000000000031c21a0650b06b0f"
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
From: David Aldrich via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: David Aldrich <david.aldrich.ntml@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--00000000000031c21a0650b06b0f
Content-Type: text/plain; charset="UTF-8"

Hi

I'm using LTTng 2.13.11 on Ubuntu 24.04 with Trace Compass 11.3.0
on Windows, to analyse a C++ app.

I have used LTTng and Trace Compass a little to instrument our user space
app using  lttng_ust_tracef(). I now want to show actual method entry/exit
points in a Gantt type view.

With help from AI I instrumented entry/exit for one method. Babeltrace
shows that the trace files contain those points:

<time> sr1  myapp:method_entry: { cpu_id = 4 }, { class = "ThreadPool",
method = "mainLoop" }
<time> sr1 myapp:method_exit: { cpu_id = 6 }, { class = "ThreadPool",
method = "mainLoop" }

But when I import the trace into Trace Compass I see the events but the
trace shows only the app name, not the method name.

What am I missing? Is there a user guide article that would help me?

Best regards
David

--00000000000031c21a0650b06b0f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<br><br>I&#39;m using LTTng 2.13.11 on=C2=A0Ubuntu 24.04=
 with Trace Compass 11.3.0 on=C2=A0Windows,=C2=A0to analyse a C++ app.<div>=
<br>I have used LTTng and Trace Compass a little to instrument our user spa=
ce app using=C2=A0=C2=A0lttng_ust_tracef(). I now want to show actual metho=
d entry/exit points in a Gantt type view.</div><div><br></div><div>With hel=
p from AI I instrumented entry/exit for one method. Babeltrace shows that t=
he trace files contain those points:<br><br>&lt;time&gt; sr1=C2=A0

myapp:method_entry: { cpu_id =3D 4 }, { class =3D &quot;ThreadPool&quot;, m=
ethod =3D &quot;mainLoop&quot; }</div><div>&lt;time&gt; sr1 myapp:method_ex=
it: { cpu_id =3D 6 }, { class =3D &quot;ThreadPool&quot;, method =3D &quot;=
mainLoop&quot; }</div><div><br></div><div>But when I import the trace into =
Trace Compass I see the events but the trace shows only the app name, not t=
he method name.<br><br>What am I missing? Is there a user guide article tha=
t would help me?<br><br>Best regards</div><div>David</div></div>

--00000000000031c21a0650b06b0f--
