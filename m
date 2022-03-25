Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A42C433F5
	for <lttng-dev@archiver.kernel.org>; Fri, 25 Mar 2022 14:55:42 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KQ4s91MWMzJYD;
	Fri, 25 Mar 2022 10:55:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1648220141;
	bh=ur69wUDwhRHjTpIxyENoxJokrHeavuTJ+1UviPH29gQ=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=t2rq85NiOtoGcdFr3vWaE/7IjlgMzgNQCf/4QII/s8pyJcXRvH8Inst597VhfsjX7
	 Uz8X/qHipaLvbR4wJZGbcPBvOul1AfTXgr8alLSa/1lSoqjg0MdJAerlnGBgibLFbL
	 +AgC1C4vhmERc+n/ClrCQB6S3TtZdZomJvFSR86HwiOj6Fs6L+nZ00z8DGOprnqxI3
	 YxeQqjZVGcdd34O0MSEbQ/ZdJMkEHAknL6L8YSUrYjQXoLKFZ8vnpJE8nA5KyO657R
	 1NJsMutTwvTa59nJGv9K6sTetoGRmEAiYy4w47mk8hfsB/g7jH1tSWEf/6eyF1Ctzp
	 JQOLO9Tdxy1ww==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KQ4s760hgzJwJ
 for <lttng-dev@lists.lttng.org>; Fri, 25 Mar 2022 10:55:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 859403F7F0F
 for <lttng-dev@lists.lttng.org>; Fri, 25 Mar 2022 10:55:33 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Ky-gtwr7kBGa; Fri, 25 Mar 2022 10:55:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D6AA43F7A7E;
 Fri, 25 Mar 2022 10:55:32 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D6AA43F7A7E
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id PWWRlDprq5A6; Fri, 25 Mar 2022 10:55:32 -0400 (EDT)
Received: from x (unknown [129.222.204.93])
 by mail.efficios.com (Postfix) with ESMTPSA id 5DD353F7B6E;
 Fri, 25 Mar 2022 10:55:32 -0400 (EDT)
Date: Fri, 25 Mar 2022 10:55:29 -0400
To: yaowenbin <yaowenbin1@huawei.com>
Cc: lttng-dev@lists.lttng.org, wuxu.wu@huawei.com,
 "hewenliang (C)" <hewenliang4@huawei.com>
Message-ID: <20220325145529.GA2472424@x>
References: <3d9a8965-c204-ee2b-b59a-e8092f90a71c@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3d9a8965-c204-ee2b-b59a-e8092f90a71c@huawei.com>
Subject: Re: [lttng-dev] how to create a issue about userspace rcu
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
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

You should have access to https://bugs.lttng.org/projects/urcu/issues/new when
you are logged in.

If not ping me in private and we will fix this. But afaik permissions looks good
for the urcu project.

Cheers

On Fri, Mar 25, 2022 at 11:15:02AM +0800, yaowenbin via lttng-dev wrote:
> Hello, I open the urcu webpage:
> https://bugs.lttng.org/projects/urcu.
> But I can not find where to create a issue. I just only can read the issues.
> How to create one.
> Thanks.
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Jonathan Rajotte-Julien
EfficiOS
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
