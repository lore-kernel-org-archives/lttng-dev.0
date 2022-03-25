Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F70C433F5
	for <lttng-dev@archiver.kernel.org>; Fri, 25 Mar 2022 14:53:27 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KQ4pY5SHpzJpp;
	Fri, 25 Mar 2022 10:53:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1648220006;
	bh=GKgMcn/lYhdhU9jwPYwqBSYp5UjVsOXQx05ayP9CBys=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=rJaXGXUF4cxSXoKuaRVwMP0s6tdjhjYQYc2UdRJ2q4J1B30lV03cxwSR0ijve2Z8U
	 REOYsFlDqGXZXGaQ0gUlf+kp7nQ9TwS3HlJ5J4EcDVhZlXP000jV8qrke7cveOrjkM
	 JNSRHqPMXhboFjqWiNoqLZtEkr7qNAs1ZSF07jPedOxryqmwP5ohX7vjPzx9bT90lL
	 iOwHTqIv6+i4lLeJk8NGs8lAgmcySp+1HIz8LYYtVFciO1+4AbAHHaEu1X98HDPGiT
	 qnyTHqahA3TwOOYldFEGBu79fppRhVBn1BeKM9yKlKYGL8FdkMXMlvJJAkxXbPvpW6
	 WsZD9ysQUwlTw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KQ4pW5wpSzJfH
 for <lttng-dev@lists.lttng.org>; Fri, 25 Mar 2022 10:53:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 762DC3F7F06
 for <lttng-dev@lists.lttng.org>; Fri, 25 Mar 2022 10:53:17 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id x8YqfHm_gYpK; Fri, 25 Mar 2022 10:53:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1BD613F7F81;
 Fri, 25 Mar 2022 10:53:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1BD613F7F81
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id p0MrHRc6rvOq; Fri, 25 Mar 2022 10:53:17 -0400 (EDT)
Received: from [10.10.0.55] (unknown [38.141.136.237])
 by mail.efficios.com (Postfix) with ESMTPSA id E1B073F7E3E;
 Fri, 25 Mar 2022 10:53:16 -0400 (EDT)
Message-ID: <cf05740a-f0c1-c23e-99da-574bb5f1eac1@efficios.com>
Date: Fri, 25 Mar 2022 10:53:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: yaowenbin <yaowenbin1@huawei.com>, lttng-dev@lists.lttng.org
Cc: wuxu.wu@huawei.com, "hewenliang (C)" <hewenliang4@huawei.com>
References: <3d9a8965-c204-ee2b-b59a-e8092f90a71c@huawei.com>
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2022-03-24 23 h 15, yaowenbin via lttng-dev wrote:
> Hello, I open the urcu webpage:
> https://bugs.lttng.org/projects/urcu.
> But I can not find where to create a issue. I just only can read the issues.
> How to create one.
> Thanks.

Hi,

I activated your account on bugs.lttng.org, you can now login and create 
bugs. We had to put manual account activation in place because of spam 
accounts.

Cheers,

Michael

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
