Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5551EC6FA8E
	for <lttng-dev@archiver.kernel.org>; Mon, 26 Sep 2022 19:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1664222318;
	bh=Kjh5wGYEXkfsFF7g9s2gI73PoidY0JG4Mhs1Kap4zfQ=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=cAXHlGZ4gaogpC2dW78Txr0czq8CVQv1sHiEQbZn9KedksCBHoh9Anc9GdXDtgo9W
	 T9PLDsu7rPal52Eox6UqjvDWolDkEaMRJaIrZtomC5+jtigZFO4+ieR+qj5QbLyJlu
	 pq7kMw+vd3rcDZ1gt9n+sSiv2iz8k4c4h4VnwdfRyH11tgm9v7gGtc/cKL6Z/5eq74
	 v+4sQtxcEP8av4CHnY2l7YclzlapyICLFfQPxz9cHS0GnezgvVkleRzf23KDboij+0
	 CavQQp+bSolsICdFp/IkGwLb6tSptWavUqwtXYOUezFkoS/Kw5Xy1tW5mguvBeHjjM
	 WlQ7K1bGvIstw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MbtqK3Qxsz25bB;
	Mon, 26 Sep 2022 15:58:37 -0400 (EDT)
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
 by lists.lttng.org (Postfix) with ESMTPS id 4MbtqH6Dyqz25b8
 for <lttng-dev@lists.lttng.org>; Mon, 26 Sep 2022 15:58:35 -0400 (EDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
 by dcvr.yhbt.net (Postfix) with ESMTP id 571DD1F51E;
 Mon, 26 Sep 2022 19:58:29 +0000 (UTC)
Date: Mon, 26 Sep 2022 19:58:29 +0000
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
Message-ID: <20220926195829.GA10587@dcvr>
References: <20220922091536.GA4597@dcvr>
 <eb0bc02c-904d-1166-ddcc-39bbece70a67@efficios.com>
 <20220923175503.M564483@dcvr>
 <6db30f66-8237-fef3-d92a-2e36be9efdf6@efficios.com>
 <20220923220510.M990534@dcvr>
 <a0d4a174-c210-33d8-9e31-0d7d1b6900c3@efficios.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a0d4a174-c210-33d8-9e31-0d7d1b6900c3@efficios.com>
Subject: Re: [lttng-dev] URCU background threads vs signalfd
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
From: Eric Wong via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Eric Wong <normalperson@yhbt.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> Do you mind if I fold our 2 patches together with a Co-developed-by tag and
> use your Signed-off-by ?

Looks good to me, thanks.

> Then the question that will arise is whether this change is sufficiently
> self-contained that we can push it to stable branches, or if it's master
> branch material only.

It seems self-contained enough and fixes a real problem
encountered in real-world usage, so I think it's suitable for stable.

Thanks.
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
