Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B1FC36000
	for <lttng-dev@archiver.kernel.org>; Fri, 21 Mar 2025 14:10:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZK49L6Bt5z155b
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1742566248;
	b=TKz9NM8Cp1HSHRnbYCACvwXzbQYuaPZDqJ7vEFjeoKa9XK+622Me2aRU6GDxIZYwmI9U
	 QUNUhNqn48pDvrkvng4etvGWzAz9DMFsrZISsbHdK/ghDS9CrrDDdUlH1eJI/TNsGnfWO
	 2UcuZRXhhFP0Vr8L2A3YIIXfsVVkxDCUT6ZmdSf0v9pm0VM2P0L5WIaE1+mBoN71tDv60
	 5y1BKXH4XL/uHl84zIzi5xurenF2AgaVD3o7kM71348+Hy3G45Uwx5P4polIrINvDEj+V
	 kntBkvKiBgq4Yk/Funxqwu1NeFvvf5wMVFlx087oyce+rZOSGp08Iu/2k/tiVC28hQQ==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1742566248;
	h=DKIM-Signature:To:Subject:Date:Message-ID:MIME-Version:From:From;
	bh=GnvvywXot0MwlHCmh81YQUgyXK7kauxhxVWdEgBMooQ=;
	b=grdo9vDRH5kY8VsK2bNu09bQAc1cn4WicdfWFswqfYigeUQCRQ5VT5ILcWNvnxYQYJjW
	 BScI7YN5j+HaYa92hiHdnv3XxFAugmjzMj2Ugst12Quw6GvK7P6mFHPjjDp/JzKgX5nGu
	 CPDSRF3WLivwiM/5hn+XqvQ9agrTbBEF280B72uyk6vnG7hyP9x3bwfdqH6n9mfVoBrFy
	 FupUi0Fy3aCgNBd7nIt6gpZ2wkwAxJyAfl54//Imh8RlT0XlRsDId3WI+Z+msMfs65QLZ
	 VX0j3apeTUU0agcwmybnXJ++iWsDegmtj7MQG0pcPsdn7jxsSHUMShukbWF5ACWrKRg==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZK49L6Bt5z155b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1742566248;
	bh=GnvvywXot0MwlHCmh81YQUgyXK7kauxhxVWdEgBMooQ=;
	h=To:Subject:In-Reply-To:References:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=FIQSgbaxUNuG2GUgKvgmjQCpjNgbMR4lO+okfKYkegYEJ3pOm/mjexGtbEJCeC0mC
	 GLaHQs5sHXae5DHRoig0BiVXpNs66V6JD/dd0a3vBS1HDu1XRqos+rSo5J0S+yCX3h
	 24GLOyafKvIJsyndx3rPBCp1t4UMRvtabj4CdlTQVOvYMYnvz/GIMwlA04+GwV4j0O
	 DW3H8ViCoUJO/Gc9PuTMKqHNu4vae1zK9gCuHfu1umh/pkVg6g5ftkcARd8rue22IC
	 A8/UDLphNc87OOZE2fjmNOTBaDWZ2A/ZATuYYnOq54EmQ9wOnnomvtslnRXl6girng
	 I9AVFNRGVo/Dg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZK49L6Bt5z155b;
	Fri, 21 Mar 2025 10:10:46 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZK49K3FFVz155Y
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZK49K3FFVz155Y
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZK49K3FFVz155Y
 for <lttng-dev@lists.lttng.org>; Fri, 21 Mar 2025 10:10:45 -0400 (EDT)
Received: from localhost (199-193-172-8.cpe.axion.ca [199.193.172.8])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4ZK49J4qRcz42Z;
 Fri, 21 Mar 2025 10:10:44 -0400 (EDT)
To: Kienan Stewart <kstewart@efficios.com>, Gour DEV
 <lakshyagour10@gmail.com>, lttng-dev@lists.lttng.org
Subject: Re: lttng-dev Digest, Vol 203, Issue 7
In-Reply-To: <09086109-a0fd-4b38-817e-b5bd2cbd9c2f@efficios.com>
Organization: EfficiOS
References: <mailman.58.1741790192.282.lttng-dev@lists.lttng.org>
 <CAE9Jrzj_A8AwR80s-2_Wnv+vSpgqp4m6jKmJAAVg5VP4SKASEA@mail.gmail.com>
 <605bbc18-bb08-4a72-b470-fc0c34e67acd@efficios.com>
 <CAE9JrzgEisZUcV4ek+bUJriXj3=8ufMYDyHxWYaYVAV5OHor4w@mail.gmail.com>
 <09086109-a0fd-4b38-817e-b5bd2cbd9c2f@efficios.com>
Date: Fri, 21 Mar 2025 10:10:44 -0400
Message-ID: <87pliamq3f.fsf@laura>
MIME-Version: 1.0
Content-Type: text/plain
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
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Fri, 21 Mar 2025, Kienan Stewart via lttng-dev <lttng-dev@lists.lttng.org> wrote:
> Hi Lakshya,
>
> On 3/21/25 8:52 AM, Gour DEV wrote:
>> Thanks Kienan for digging this and explaining the behaviour,
[...]
>> Also, I thought using --buffers-global
>> <https://lttng.org/man/1/lttng-enable-channel/v2.8/#doc-opt--buffers-global>
>> would
>> be better for me as I could know how much memory will be required but looks
>> like that option is only available for kernel tracking, it would be very
>> good if this option could be available for user buffering also, but that
>> could come later.
>> 
>
> Global buffers for UST is planned for the next release. The trade-off of 
> using it is that tracing overhead will increase (as the buffers are no 
> longer per-CPU), but in exchange for a potentially lower memory 
> footprint particularly in situations where not all possible CPUs are online.
>

Little correction here.  `--buffers-global' is the ownership of the
buffers (UID vs PID vs system).  The next release introduces the buffers
allocation policies `per-{cpu,channel}'.  Therefore `--buffers-global'
will still be only available for the kernel domain, AFAIK.

User-space however will be able to allocate a single ring-buffer for a
given channel (actually it depends on the buffer ownership UID vs PID),
thus reducing the amount of memory used, for that channel, by a factor
proportional to the number of CPUs possible on the system.

[...]
 
Thanks,
Olivier
-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com

