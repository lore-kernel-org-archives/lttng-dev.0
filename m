Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476E6C5AC67
	for <lttng-dev@archiver.kernel.org>; Thu,  6 Aug 2026 18:46:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4hGGTK2qB2z1l51
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1786041991;
	b=XUkmdotC/Ce62JFZ3NvTapiKEx+dihZUfVKmlRX++BLVD9VM1c/+3L2XTSTMWVPhRtfC
	 Rp9De0PZ9FrIOItUzjevoKtpJJDoqlR4WLIR23MsGcawJfnE20HgHBvCmumRRga87RyWR
	 VEgPP/NodmXLBQG88A4zMuaAVM26VYsng6r0pJWNCehNDN2q6m3yN3AFla4Z+khffLWbc
	 NLwHI/B/UgPtUyEzAfQhM12gZQvndGVmselSt4WUhHzIq5PqWZfhojkZjiqAFrmASvmmp
	 wAgNW3yTfkxGJpB0SmFi5EbgRRkc0UyIDh8cC6ezacPpEmTcyEFjG6ceqv9mrA+3YlA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1786041991;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=Ly13BbjUrYUDD2EYUpJi4CgFd5YoK09DF9M8MruC2h4=;
	b=hz6t/vXX8t+R4VJ0dsj2sFQCZu4a3X7pEnGBmy87FucUtNuX0vhtfn5Zw6x/VAdpq1y+
	 ml6z2gc7o4SNEJ9nZ+ap1ux3GD0VAi+1/RZMnNnwRg/5wNEqqd3iqQ1ITOIvwvhy/dCRs
	 4jJu5ClF6FwTRWCQhgeJkxiJ07OFpBfpHSx/OLsANrtKOsV2X/3tdOR+xTEVb2pCLowfd
	 NFuTjywr82cH/i7J1NMjkQPzGMeTzl/8LYKjLB83m+qLYBMfAlYIOgwDzR7+yXamHLfpw
	 uipRIdcjq8gLp4bd2msIGvX0esNXAjN655FjaeLUCOSRb32tbikcbX5sRMiRdKimDUQ==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4hGGTK2qB2z1l51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1786041991;
	bh=IKk1Z0Dm4u7t6vAWCFG70hyPsShZpm0a0ULx7imG7wI=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=MzEdmm8coNRN7TkxTdSPJz5QMFGt7osCeSl0jXQJCfm6+EpwVRzo4Ro9gtAsr8q9C
	 Iopwq+FGtadCVsVGfli4jiHBqd/gFvtKMzFLdj/DFHkf2hqYtE1WrpLeWpjEQt/qxd
	 UkI8cQ9zlSNzxRHm/GBi47mRS6JQS5yyzDrOAP18D52FM4S4sH7zGDpNb2Lu09red8
	 cMPvvT3FaqhUKLcFwseIbXhxzsesGeHhNPJVaqNIpHdVFzoLoBm2wWaZHV2lSx2rNc
	 /DycKp6XBd0XJ2am2egu6sAzBhsEp4G+MRDHlshmyK1H38ianZGZm4nYDaPevd9V0o
	 g25LeFIP2cCOw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4hGGTK2qB2z1l51;
	Thu,  6 Aug 2026 14:46:29 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4hGGTG5qyxz1l7h
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4hGGTG5qyxz1l7h
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 by lists.lttng.org (Postfix) with ESMTPS id 4hGGTG5qyxz1l7h
 for <lttng-dev@lists.lttng.org>; Thu,  6 Aug 2026 14:46:26 -0400 (EDT)
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-669944f5ef1so2929405d50.1
 for <lttng-dev@lists.lttng.org>; Thu, 06 Aug 2026 11:46:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786041981; cv=none;
 d=google.com; s=arc-20260327;
 b=aL9fgnpbwhmyon4h5BRLe+et5pyti8b27FeYzjKGgOVmgjwn9khPuzGmzj3njjApmT
 76SmDIRq5jBt3Sirz1+b1VaFp6+lN00xZLRzObx/M2mEWgIO+4epeGS3VKaHb4edKx2a
 LzQo54GmvAttkbZfgaoyBkc9JyrAwD4Ciyl69aflhxGnB/4jnqJdTC3NSCsP2hx/uoLK
 Kv3TYmW/SZPBj0j86C74z/rEk5NrXat7vXiQf0TH3s78gAW9bi5NGS7keNI3nlmc3eHF
 0Yqy+UEJb/8vFvF71BR/MbuN461mzOlTtL7h0crI4JvyZK2S5ac6R42wbJnBtHuThiOs
 CgtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IKk1Z0Dm4u7t6vAWCFG70hyPsShZpm0a0ULx7imG7wI=;
 fh=1Vik1agtZhBIlGZ2swS0tVK1RrASytr6HSq6q93Y7mg=;
 b=rtcIdX8xelFLWfPEgvqzJYWpTCdc1L79LlqEYSAnFYGF3u/4dyovOzPUsmPUPoqSdg
 EKo61d0MIWUaQt5bC6t3AsnprzFcAFXA/VBBaVBKec9PJTcF0q7la/7AbYk7zXRQc2p7
 SMaStVXRSGZN6Pe3gLQB2Die42QMZjJYNVeWrVP//XFNQ7JKpBGmQMHZL2djAj6S1dyp
 oJshPdtxNeLMsxPXglOLfQNTICRHw/Kjerll/Vpt5xxmpmrn/Pt5yGof0ScwylgkoRKX
 toGnRAQvKqsQPaz11wwcdqh+ScLZqGSiUpftCbm8qwHQp72XGYnN6yW6ftIFThWf8ttv
 jxqQ==; darn=lists.lttng.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786041981; x=1786646781;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IKk1Z0Dm4u7t6vAWCFG70hyPsShZpm0a0ULx7imG7wI=;
 b=PbDUdiJdFGyPRncPnWqLJ/JGfyjySvnFqChLDWD7SCTeLSTKDeeEdkKiEaRPdc3+WE
 JzT07CkVnbbJ0MbvLHfoPoBDxaXKapfTNgKggFURIKLnN20IzkILu2p0cX9fwubuOGOc
 C4uyJSkn50514PD4sDOsntUIBp0PdtNQh2/Tlpsqww/KiF+Le2Sx6aY+b08cmPUwjpOZ
 Tt/o+WDxYHyg6litK3mBfplCZ4wD+AGD69d47kmJ2oBR+MeDSkj8/EKQMaOLqLRjK0+5
 s4nwkjaYRaDT4IkeuSoep4ZFuyVszplWvlET+T5dy3jyvs9uOBGVL/CpxIOyrqMh8jGl
 zf4A==
X-Gm-Message-State: AOJu0YyG6+es1N923P9xqFvkRn/tJ7/bwb28nAoA4tjBPMlNCzmWzjgy
 J+hVEia7Tc/TRlxZroL9xfK0lJbtxVb549q7FTcgC3Fv3Vw695c5WWlq3GtoFCgfPMc/vkEJe8o
 9i7VjP4JupKH8SUO0riXxVthVLulCg0DTdOMo
X-Gm-Gg: AR+sD11MrS+tn8RtjqzvtSOLYxKfopXGbc1hEXTs9CpVqEFShAqkwF3vdzCv4vkOUZU
 elK4Nz+IigdyfrdIVrtC5ObfVzSD8/6bkrfcp6dSCL/6XKWhrNHDKIUobYd6gMDxgr+zO4JNwC6
 8+ppRVeWyXjqc1n/gaNSDIWzkEBb9EvFVryRJb2Zzq8mVTGDGUk4RXIFb2g93w17C1ga5NTPqEj
 fedbHTAvuKmhiP7wscvl45O6ak637kqNfW7563pSvkcszkdnQJxWAsVsgvDx541de29xvEN8oPy
 ygmZXatIswuKeEc7Dt+H6EphRSUXy06UtF+JU4QorZ8j7A==
X-Received: by 2002:a05:690e:4810:b0:669:4c6d:a19c with SMTP id
 956f58d0204a3-6699aa49381mr8880165d50.24.1786041980612; Thu, 06 Aug 2026
 11:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <d0e142586819e25725452b2849308829c38216fb.camel@siemens.com>
In-Reply-To: <d0e142586819e25725452b2849308829c38216fb.camel@siemens.com>
Date: Thu, 6 Aug 2026 14:45:53 -0400
X-Gm-Features: AUfX_mxFn2B4aJcKkKrpPdz7OwzWtjnhradiS2sUHQZJcMCBWWtzakh5X1Cqlj0
Message-ID: <CAB4xu_3zXGL4a20TRK2m2OwfC7NPqVW6tJvM397er0w6dBwSLw@mail.gmail.com>
Subject: Re: babeltrace 2.1.2: sink.ctf.fs does not deduplicate identical
 clocks
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
Cc: "MOESSBAUER, Felix via lttng-dev" <lttng-dev@lists.lttng.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Philippe Proulx <eeppeliteloop@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Tue, Aug 4, 2026 at 11:28=E2=80=AFAM MOESSBAUER, Felix via lttng-dev
<lttng-dev@lists.lttng.org> wrote:
>
> Hi,
>
> while porting the bt2-ftrace-to-ctf [1] plugin to babeltrace 2.1, I
> noticed that the sink.ctf.fs creates invalid clock definitions if
> multiple stream-classes share the same clock-class. In this case, the
> clock definition is added multiple times to the CTF 2 metadata,
> resulting in the following assertion on read-back:
>
> ERROR:    [Babeltrace CLI] (babeltrace2.c:2705)
>   Command-line error: retcode=3D1
> CAUSED BY [Source auto-discovery] (autodisc/autodisc.c:493)
>   babeltrace.support-info query failed.
> CAUSED BY [libbabeltrace2] (lib/graph/query-executor.c:233)
>   Component class's "query" method failed: query-exec-
> addr=3D0x55cba00c12e0, cc-addr=3D0x55cba00b4100, cc-type=3DSOURCE, cc-
> name=3D"fs", cc-partial-descr=3D"Read CTF traces from
>   the file sy", cc-is-frozen=3D0, cc-so-handle-addr=3D0x55cba00b1930, cc-
> so-handle-path=3D"<...>/build/babeltrace-plugin-ctf.so",
>   object=3D"babeltrace.support-info", params-addr=3D0x55cba00cd470, param=
s-
> type=3DMAP, params-element-count=3D2, log-level=3DWARNING
> CAUSED BY ['source.ctf.fs'] (plugins/ctf/common/src/metadata/json/ctf-
> 2-metadata-stream-parser.cpp:130)
>   [1:1 @ 8512 bytes] Invalid fragment #12.
> CAUSED BY ['source.ctf.fs'] (plugins/ctf/common/src/metadata/json/ctf-
> 2-metadata-stream-parser.cpp:367)
>   [1:1 @ 17024 bytes] Duplicate clock class fragment with ID `local`.

See <https://review.lttng.org/c/babeltrace/+/18460>.

Let's continue the discussion on Gerrit if need be.

Thank you for the report and reproducer.

Philippe

>
> When running with MIP=3D0, the CTF 1.8 data does not have this issue (or
> the reader ignores the duplicated definitions).
>
> [1] https://github.com/siemens/bt2-ftrace-to-ctf
>
> Attached you will find an AI generated reproducer using just the
> babeltrace2 Python bindings.
>
> Best regards,
> Felix Moessbauer
>
> --
> Siemens AG
> Linux Expert Center
> Friedrich-Ludwig-Bauer-Str. 3
> 85748 Garching, Germany
>
