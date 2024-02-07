Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D13CC4828F
	for <lttng-dev@archiver.kernel.org>; Wed,  7 Feb 2024 14:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1707315313;
	bh=KbGV1J5BkVnhbsyZwD6Y7+X0t7Ujy7tSF+673Dy5nLI=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=F5MwmBasMZdRL0oFn9t6W2gbF84Gy8/0BZZERNeMGObwB3XzHE8sosiesWx5C97KF
	 1RsxhE72Rs4mz3ed41sw3WGORGpdr75BK6ovcYBZ5qDUTs0adDguxZvGYXofi6J229
	 ZW5iiHKIrHJMPqBU6vF3tCTuO4RE0+xfYIGD6LOwlErO7E/YZA2U5e9CJmoHlBkKpz
	 ZOOE4L9lArSxL/fkG26YCmkGhl426pUW1uUxX8VMAZXn108sFRCO21+DqxP+I5qpgK
	 v/wWej9sfBlp6NR7HxBDuqL18LkDaC6FyfN3nlB03FBru89iSpDz0orjc0wLtMsnoV
	 dX5D4oZbOE33Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TVMZm1KHYz1wK8;
	Wed,  7 Feb 2024 09:15:12 -0500 (EST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 by lists.lttng.org (Postfix) with ESMTPS id 4TVMZj69q2z1wTr
 for <lttng-dev@lists.lttng.org>; Wed,  7 Feb 2024 09:15:09 -0500 (EST)
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-42c3fe0bfddso3471061cf.3
 for <lttng-dev@lists.lttng.org>; Wed, 07 Feb 2024 06:15:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707315309; x=1707920109;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ndxpTNXFrfZ7ACXzk8Swsp1m3YWB8ib5Y1HxjCPK48c=;
 b=EnxjAVxzI1EA+Drbjz4/VRvu9S8xUWvjZlz5QxW61OEYofzcf66Jqfj35djjs95cUB
 BUfWhVvO5mWxTywPw0FTwbT0JPso7CAqTKLTE8NkC5tPdGpWUVIv2VKLmp65z8eNPC8Z
 SPkA2DG7bTEz04hswyLrDOmXEJzp3vcm9m0nr2uD4Hyd0c8YnPIdgynmehXS1ZhU9AF/
 hY8pHb6YZ6r1B7KxWQKES4vdZgCN7SLuAux7/HOv/PAd+PFs8xCKomwRux3khsg7tjpv
 4BLhvlFoqt9CHSziMHYUvPRpwlLBii3psc3nx+PY1DNZW3Aq6Y+WtCeHg55YRScA/zC+
 OP4A==
X-Gm-Message-State: AOJu0YzcOnWzCKEchiAaK64e4Rs2sikmpDR1MvXWRjEdSFLYt0REPPu6
 IdQujh40gGVFBKgzFiRc/AdjdCZnAf0O/kQhGTIQtbXMgUWwJ7zCzTIn1N0kDLo=
X-Google-Smtp-Source: AGHT+IGjstE7Eo0Lj4Ee+4iUwUgEhfRlKFlF5Xc82+0glUMQXOxNfefZPDbTbD6zW/1qVBvfNZDokA==
X-Received: by 2002:a05:6214:240e:b0:68c:499f:f803 with SMTP id
 fv14-20020a056214240e00b0068c499ff803mr6415065qvb.30.1707315308883; 
 Wed, 07 Feb 2024 06:15:08 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUakCCmAAuyrWz4ATkvBUpcS1Rv1Ui9bi/jQ/flDqansGgj5UZLgZMnc0O774hNKUYTU5Nh2k3SDtadeSfQc9un1eLDtWdfqBEtLhtbnVQ=
Received: from martin-pc ([204.101.17.194]) by smtp.gmail.com with ESMTPSA id
 ok29-20020a0562143c9d00b0068cb8019ee6sm620005qvb.34.2024.02.07.06.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 06:15:08 -0800 (PST)
Date: Wed, 7 Feb 2024 09:15:06 -0500
To: Michael Jeanson <mjeanson@efficios.com>
Message-ID: <20240207141506.jnjadvz4u43x3dte@martin-pc>
References: <20240126171833.cppkzs4pl2f4scf6@newton>
 <4a3fa41f-9a61-4c16-a387-c6b996211b8d@efficios.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4a3fa41f-9a61-4c16-a387-c6b996211b8d@efficios.com>
Subject: Re: [lttng-dev] [PATCH] Compile fixes for RHEL 9.3 kernels
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
From: Martin Hicks via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Martin Hicks <martin@sr-research.com>
Cc: lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>


Hi Michael,

On Tue, Feb 06, 2024 at 02:14:14PM -0500, Michael Jeanson wrote:
> On 2024-01-26 12:18, Martin Hicks via lttng-dev wrote:
> Hi Martin,
> 
> I tested your patch and did some minor fixes, I added the base kernel
> version to the RHEL ABI version check in the Kbuild file because the ABI is
> tied to a specific kernel version and it would conflict with other RHEL
> versions. I also adjusted the range for 'kfree_skb' to build on RHEL9.2
> kernels.
> 
> I uploaded the updated patch [1] to our gerrit instance for easier tracking
> on our side. Can you please test this version on your system?
> 
> You can get the patch using these commands:
> 
>   git fetch https://review.lttng.org/lttng-modules refs/changes/50/11750/3
>   git cherry-pick FETCH_HEAD

I cherry-picked, reviewed and compile tested.  Everything still looks good.

Thanks,
mh

--
Martin Hicks
SR Research Ltd.
Fast, Accurate, Reliable Eye Tracking
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
