Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0500BC3ABBE
	for <lttng-dev@archiver.kernel.org>; Thu,  8 May 2025 21:31:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZtlgL12CTz1r1r
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1746739870;
	b=JMoSM36iwoZMjuVKFoWnRKYQcutL/cjTLfwCj2isR6B12cubpSk6XWPnFiOEdiHcTvtm
	 sHKuNxOedk5xwilAnwioSN9XvmSdBiJlFetchDnE4+t10ieUh1Q8K8VmAfsFPABMi/vRN
	 R9NrFgkZoie3Z1dE0i/usV9S5YueyHaHsEUzdNwsKfWDRt1fCrQ9/tmb1VN8rG2PeGLJH
	 ti48bVIMfp0AIlka2dHX/JWcapzPJeD0E9p9nDSsOUh6pY3ZSPb+h4vdnCSJOGsEdSQMX
	 EecsBkfYBneQYybRGOOP+K32VWOnX/5JOmg6wuLtcgvMC01QDrI7w46b/hLRo5iWCaQ==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1746739870;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=obp1gm3d/ykg6A9eTT3dfSxwKKarECj4jwcw/vItkoo=;
	b=N+Yv+WmQ4K0EtzfQd9oGnsxpHdRD3FVGQnT4vlmzFIohn4K43kROzg+WhTvirQEEhkPB
	 Mpk/1Pia/ebm70lUzaAJNDD5qURaedG9tCKiC/l/9Wyrp1Jw+ZjaBgQ+KrOng5XHvoVHu
	 4Zs99BV3TE7xYv6sD8aS+JoPPID7Vp+Du7db+rR8E4k9SFYBM4fdSV+LFfuG+/t0E9IL5
	 4KqONcGAfSoPjOeaG6x48jopHdEU277mSes3ua852XtcjRIXR2hU8PP/7X7ZazWb+ldvI
	 mtbIb2aZrrGmM4OfAu2wuOFAJw4ujjd09kE27zWjXxDl/lsHus4aTcSOm8u74DXp9Gg==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZtlgL12CTz1r1r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1746739870;
	bh=obp1gm3d/ykg6A9eTT3dfSxwKKarECj4jwcw/vItkoo=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=yrHuIvlEdlGisgiwtRCFGZU+YDTYTmMM9xxcJfoKSRTsdH/sDBxGeMbMR+CvwjtXD
	 mIKn4hqZ4JTPYmJ+9ZitehfhXD4YxqI3LKjuztCjBfaUoNkNrwhCC6sVFvY0zILK0Z
	 UmHNwnYB9PXtofmTsZ/lpMVg27yUWdWuI2d1/Fj8twUFPf3askt5B3U8rRz5FUvKAL
	 W15yfx4dF5nLwgBxx7Shr+WzKnHn93nejfDNj4/8EvkoFxD/PBibHvVQg07Fr4uGI+
	 Z+sKuPq3PkZCMhKO6LweNt1lcCo2T+uDt8KKo4XuBld0XOFxBE28jmiM4WNn8R748g
	 MDojF2IOtp3uQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZtlgL12CTz1r1r;
	Thu,  8 May 2025 17:31:10 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4Ztfzd5PN9z1nBb
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4Ztfzd5PN9z1nBb
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 by lists.lttng.org (Postfix) with ESMTPS id 4Ztfzd5PN9z1nBb
 for <lttng-dev@lists.lttng.org>; Thu,  8 May 2025 13:59:57 -0400 (EDT)
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-70a1f2eb39aso12980897b3.1
 for <lttng-dev@lists.lttng.org>; Thu, 08 May 2025 10:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746727196; x=1747331996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=obp1gm3d/ykg6A9eTT3dfSxwKKarECj4jwcw/vItkoo=;
 b=W19dXGyliEKc889hV18tzdHKm8qUn05xXYGbUTk4blyKrbQiRVIDReKf/tuyHvJd70
 2mN944RTU4jhAoUiSDiAlpimCed0cHwB64WKG+zIx5k6+hBZas39PJiqOXmobd9DlQom
 OjpyZM1Blp1+T9MFddyoWhSfD/SlqpB1ghHs8eahU4SAo0Fy3M9yhHVDm8YwaIxQXY5a
 /3EVQMVf9PUNGdVBACHrbz19A9/Ki3eFZNf4sNdKA7dAoAx+yoUb2qxqZ8ug/dB3YDNq
 b8II0Q2AYB98cPc65ZAeOY605zd7dHDglDTNyOQhsz0U488GW+DLP7RI8ePkEfLwi2Kn
 G/7Q==
X-Gm-Message-State: AOJu0YytFsY4bzRdgZCbYrLYxNLjlPZfD72JPAVlzyW7aXfxRMhgQkct
 Rn3LU197zdH7I3Fbf5exmRGMw1At4QFGITyw7lxUuKjwIFG13tEhBfXgjl7hjgyVXZtClBN+3aa
 k5AiRZWHSIgrooTQwcJ2SKurTNaRQecvP
X-Gm-Gg: ASbGncvGtZpvKuk+ie1NweO9a2bmzofd1iGH0Hbitdvh/M7XyIPfjM5g2nvuNa40KUA
 32PTFJRcEMy9U8OvvRn3nzi19XQCl7pdPCT0WHtEMowHKomXrG39s566b4Wdor85vdmmnmIDcsY
 /fxcgRpdXRuZSFHTaSy+CBZiE=
X-Google-Smtp-Source: AGHT+IGWa0KqlzHG/xrtyDq9FH4NXFO2FykcYLlgLU/cf4ZUV75pfdFE9EMJXyOkaeqYL/hmrdg/04wBq7JQq/of0Hs=
X-Received: by 2002:a05:690c:6405:b0:709:176d:2b5 with SMTP id
 00721157ae682-70a3f9f371emr5710797b3.2.1746727196472; Thu, 08 May 2025
 10:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJK_iejrz-U0-XK1hmoH9=TCLcErZTVE16XdyKzXX0buJuuoCQ@mail.gmail.com>
 <90aac2a4-0a4f-4d2a-a90f-c96c9be820af@efficios.com>
 <CAJK_ieibZJjJus6PdOnWAiLFOymm6D8AmkG3vdpDnuazG1wAbA@mail.gmail.com>
 <0e6f9c3b-8daa-43ae-a3ee-6d7917b05b2e@efficios.com>
In-Reply-To: <0e6f9c3b-8daa-43ae-a3ee-6d7917b05b2e@efficios.com>
Date: Thu, 8 May 2025 18:59:45 +0100
X-Gm-Features: AX0GCFtHzr-BAjqfty49cDp_u6X--207kR4UI9SrLiqnNRMhB7wRGPQRb2qNUWE
Message-ID: <CAJK_iehC35W7LUWkR4b-+TEuJTOTngzJ_0sV7LSvBT6WcDPN4w@mail.gmail.com>
Subject: Re: Not capturing ust events
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 08 May 2025 17:30:47 -0400
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

Hi Kienan

Thanks again for replying.

> Glad you caught that. I had assumed it was linked in :)

Yes, I should have spotted that earlier!

> Assuming the user you are running the `lttng` commands with is a member
> of the tracing group and a root lttng-sessiond is running, a complete
> example might look like:
>
> ```
> lttng create my_proj
> lttng enable-event --userspace 'lttng_ust_tracef:*' # this will
> automatically create a channel if one doesn't exist in the session
> lttng enable-channel --kernel --session my_proj kernel_channel # [1]
> lttng enable-event --kernel --all --channel kernel_channel --session
> my_proj # [2]
> lttng start
> ./my_app
> lttng stop
> lttng view
> ```

I now see:

$ lttng enable-channel --kernel --session my_proj kernel_channel
Error: Channel kernel_channel: Tracing the kernel requires a root
lttng-sessiond daemon, as well as "tracing" group membership or root
user ID for the lttng client (session my_proj)

I am a member of the tracing group, however I need to understand how
to configure the daemon. I'll have another look at the docs.

Best regards
David
