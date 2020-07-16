Return-Path: <SRS0=9aER=A3=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657EDC433E0
	for <lttng-dev@archiver.kernel.org>; Thu, 16 Jul 2020 13:07:11 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF422065F
	for <lttng-dev@archiver.kernel.org>; Thu, 16 Jul 2020 13:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="Bz3fmYcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF422065F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4B6vfj4CZzz1YJB;
	Thu, 16 Jul 2020 09:07:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1594904829;
	bh=3W+fkrclHH6t5mwBOQs+FMFsaaGU/yWXDlwDonxSdBU=;
	h=References:In-Reply-To:Date:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Bz3fmYcRUdfVXGoDFSx/1733foXnaBACl/W2NghUWC5ytwDXMix6wRB7xPucjzDF4
	 fMn76wqjSUbFyvkmfQeD8lpiSkdTWs0DY50o3kVd4+rCa7xNpU20cyQ4wP/N+TQtUd
	 nZX/knH1pGVcY1uc1E0NW2HTUKBuPEQTWaLOBSPlLkpqPKyxKFFBPLELx02Jeuif/N
	 DYo4ExI79qdaeFuqKsuHjL8sAPre7vx+dj83K/8PSxnS4Y3RRSI3YRO4IkdFO8G/xj
	 gt+jV7/QJgCgxEHpKO/AmAt4vWLXMCxTeJlde87rScLUrIQYB+6UFixMWaYru+MK3M
	 eEZChWXvU+ryw==
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by lists.lttng.org (Postfix) with ESMTPS id 4B6bcr0gGcz1Xjx
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jul 2020 21:04:27 -0400 (EDT)
Received: by mail-wr1-f66.google.com with SMTP id z15so5033935wrl.8
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jul 2020 18:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R3WQKO9ff74TDp0o71oyL9/ZiJ5upum8roG9fFyqByU=;
 b=nXg7JzAWAUIvxUVdRuIYJbHT5F8QVVxMnatIwg9LRBKsFUkXg6jtL2bIV6YGz69NEm
 nuGIhFMTcMoOFWPm4wgNtEsPrrXsZsKy48NPnszfTlW6027YnwmLum6HamQgBokUY3k0
 SFWAVNBB9R56qlgD/1unqY8A5WvFE1t5VQ3UZbeVhUKa9A2PKa4e3MBNnRbNUAm+Udf6
 k9wSulU1fDALhDLrGBYtey0pjDUB26oo3pknA0RwLdNKGZsr2MzQqfyKsFYVTLBo3n4z
 XkpeO9vdgdJ2AcoCevOoH/OICVANpzyQFIHVufLLfoLVl/Dzg6q7lw6MZE3ktpxILEsx
 1/TQ==
X-Gm-Message-State: AOAM531JMuh/6P/+L7iIq6x8dWJlE4OvPrk8Tp9DnyDvkr/S7yvaXl+W
 3cZQQImzPbwaOLF4r+C/vSxzEqWDg9cyqspDXi0=
X-Google-Smtp-Source: ABdhPJwLxBC8+Wt/qiTVi6+dQvWhvYxZbP9HEPZxfahJ5EHfYrTrPUCURbhwgwMx4vAedGpU87KKtVHlELCXtr/eOjQ=
X-Received: by 2002:a05:6000:1006:: with SMTP id
 a6mr2167022wrx.332.1594861466727; 
 Wed, 15 Jul 2020 18:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <e9c7400ff0075f3beba2863c4432a905@ut.ac.ir>
 <20200715142849.0bfe909a@oasis.local.home>
In-Reply-To: <20200715142849.0bfe909a@oasis.local.home>
Date: Thu, 16 Jul 2020 10:04:15 +0900
Message-ID: <CAM9d7chE3WQm2e4EA4i09Q1hOaGt2hrPHoF2d0tjqhciPceB9g@mail.gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
X-Mailman-Approved-At: Thu, 16 Jul 2020 09:07:01 -0400
Subject: Re: [lttng-dev] Capturing User-Level Function Calls/Returns
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
From: Namhyung Kim via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Namhyung Kim <namhyung@kernel.org>
Cc: ahmadkhorrami <ahmadkhorrami@ut.ac.ir>,
 Linux-trace Users <linux-trace-users@vger.kernel.org>,
 lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200716010415.qoDJoYJ4W9OhBmQxIvdVPMtFbWMdzpaHfiRyvfFZk34@z>

Hi all,

On Thu, Jul 16, 2020 at 3:28 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 15 Jul 2020 20:37:16 +0430
> ahmadkhorrami <ahmadkhorrami@ut.ac.ir> wrote:
>
> > Hi,
> > What is the most efficient way to capture occurrence of a function
> > call/return of a binary program in userspace?
> > It seems the answer is Uprobes. 1) Am I right?
> > But Uprobes use "int" instruction which leads to a switch into kernel
> > mode. 2) Wouldn't it be better to avoid this transition?
> > I'm looking forward to your reply and will be happy to read your
> > opinions.
> > Regards.
>
>
> Hi, I believe LTTng has utilities that can help you trace user space
> programs.
>
> I think there's also a users ftrace like utility that Namhyung was
> working on. But I don't know where in the development that is.

It's in https://github.com/namhyung/uftrace

Basically it also requires recompilation to add mcount calls for each function.
But it now also supports dynamic tracing without any recompilation.. :)
It's still experimental and has some limitation, but the idea is to copy
first 5 bytes (on x86_64) somewhere and replace it to a call instruction.

Thanks
Namhyung
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
