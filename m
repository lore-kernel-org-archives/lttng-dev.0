Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652FEC00140
	for <lttng-dev@archiver.kernel.org>; Mon, 15 Aug 2022 15:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1660578953;
	bh=smSRSNfXEJP0c6dOShDtS/GGc3hE5gwPy/MIKSMOn20=;
	h=Date:To:References:Cc:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=in7ZjU4FD1Z1bXEpY/VuWvdjWgD21gg4dIwr6LdzD7gSyKKLCE0Fa9bvFQf+LfE5k
	 k8NLmdZX71qwleEaSb3ezOxPCEqXTBXkRK5ra2ZYdTlNPmjGvrVwFiCUl8sXZOLoal
	 +dqNhtI7IvetiHtFmEJYn25uu6ggTKyRKC8mDidjWLTPeNaBALPbD7ZR9V1PNs+ZY0
	 LkvqW8dPfpwZCVw2+NO2ltSXkkvg8EnoMPMzwHs7t+3VBkHUoBQDcwKvtdR+pj8au5
	 o7YYA68E5tLJIcxH1O5209U6HtZKu0oxmNGqt8TueNOOaG7V3qu3yK7L/VDDxopXnx
	 1/AMChoqhgEgQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4M5zQc4Cdbz1GbH;
	Mon, 15 Aug 2022 11:55:52 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4M5zQb16nBz1Gdh
 for <lttng-dev@lists.lttng.org>; Mon, 15 Aug 2022 11:55:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5675F3268B7
 for <lttng-dev@lists.lttng.org>; Mon, 15 Aug 2022 11:55:49 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id wKkv2G9kraab; Mon, 15 Aug 2022 11:55:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id EB3D73268B3;
 Mon, 15 Aug 2022 11:55:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com EB3D73268B3
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 4nhdhpaP2LUb; Mon, 15 Aug 2022 11:55:48 -0400 (EDT)
Received: from [10.10.0.55] (unknown [38.141.136.237])
 by mail.efficios.com (Postfix) with ESMTPSA id C910F32653D;
 Mon, 15 Aug 2022 11:55:48 -0400 (EDT)
Message-ID: <7e3f4047-101e-d8d4-93ed-370c8eaf7494@efficios.com>
Date: Mon, 15 Aug 2022 11:55:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To: Elad Lahav <e2lahav@gmail.com>
References: <CAJbg=FUXDnq0cSLCzhOAO4W44+monQF4s73t_sT4dAPGWt8fPg@mail.gmail.com>
 <dd0df1d0-12ed-a568-839e-7d2ff1fbcff7@efficios.com>
 <CAJbg=FWjjBT1RbGxvCcx1+6qgJfhqtF3h3WpLB11cGSb1Efzqw@mail.gmail.com>
Cc: lttng-dev@lists.lttng.org
In-Reply-To: <CAJbg=FWjjBT1RbGxvCcx1+6qgJfhqtF3h3WpLB11cGSb1Efzqw@mail.gmail.com>
Subject: Re: [lttng-dev] Change to CPU number detection breaks QNX
 compilation
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2022-08-15 10 h 04, Elad Lahav wrote:
> The problem is the use of d_type as a member of the dirent structure.
> POSIX does not define such a member.
> I can provide the necessary code for getting the file type in a
> readdir() loop on QNX, but it seems unnecessary given that there is no
> /sys file system with CPU information. The method for getting
> information on processors is different, and I suspect that is true for
> *BSDs and other non-Linux OSs.
> 
> --Elad

Can you try this patch [1] to see if it fixes the build on QNX? Can you 
also run 'make check' in 'tests/unit', the linux specific tests should 
be skipped.

Michael

[1] https://review.lttng.org/c/userspace-rcu/+/8664
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
