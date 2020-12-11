Return-Path: <SRS0=dkSF=FP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E21C4361B
	for <lttng-dev@archiver.kernel.org>; Fri, 11 Dec 2020 18:31:20 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63E3823EF5
	for <lttng-dev@archiver.kernel.org>; Fri, 11 Dec 2020 18:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E3823EF5
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CszrN39hPz1X4W;
	Fri, 11 Dec 2020 13:31:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1607711478;
	bh=zMXpTji72VLfNJFDmfo1Trn++rBqUc4kn7bDmgsiNqc=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0FHFUAiTsJCVMMRHA9mivRtvDSsm08UVMBi/U/8DI14ZBRPsQFdm10j5O2ajh8Mta
	 vFsM2M6gQVyMftjV+2ZmGI+JKncOWYjY2ZXwouIujpPsXgZi/WTJ34RwzmdonlpcIh
	 LHk12O/8Cq/x37DmiefzhFvWISbfI091M3A35rQnv9mwDjdNQqNTa7FTYM8ifH9MsN
	 11ChhjHfvh9ETkc5T9Rr2Cmzw9DRlxwN0Cxn3fC/qbZeC11Bv6jQ9VKrc6lGFTNot2
	 VIRQElESM5DWfhvtE6HeR6+vqdG325zQoH8+iCSNHhsHD1seh+Lww8mpu08iIhabxe
	 w0bvt+FeKVt+w==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CszrL640Fz1X1v
 for <lttng-dev@lists.lttng.org>; Fri, 11 Dec 2020 13:31:14 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5D83A2D921D;
 Fri, 11 Dec 2020 13:31:08 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 8u-jKpbMZoXR; Fri, 11 Dec 2020 13:31:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 035472D90DA;
 Fri, 11 Dec 2020 13:31:06 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 035472D90DA
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id kKMlvvaNd89w; Fri, 11 Dec 2020 13:31:05 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id EC82D2D90D7;
 Fri, 11 Dec 2020 13:31:05 -0500 (EST)
Date: Fri, 11 Dec 2020 13:31:05 -0500 (EST)
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>
Message-ID: <2103736312.101332.1607711465872.JavaMail.zimbra@efficios.com>
In-Reply-To: <1681186936.97276.1607538587190.JavaMail.zimbra@efficios.com>
References: <20201209181537.444048-1-mjeanson@efficios.com>
 <1681186936.97276.1607538587190.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF83 (Linux)/8.8.15_GA_3980)
Thread-Topic: bump tests thread limit to 256
Thread-Index: 00UcESq6Kf2rE9fwpl025Y04w8xMT0mt2SB3
Subject: Re: [lttng-dev] [PATCH urcu] fix: bump tests thread limit to 256
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Michael,

After discussion with Paul, we can go for bumping the max nr cpu limit
of this test to 4096.

1536 would cover all the current hardware Paul E. McKenney is aware of.
4096 would cover all hardware he has ever received a bug report on.

Can you try it out and submit an updated patch ?

Thanks,

Mathieu

----- On Dec 9, 2020, at 1:29 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Hi Paul,
> 
> Should I merge this temporary fix for liburcu tests, or should we go
> for dynamic allocation of the array right away instead ?
> 
> Thanks,
> 
> Mathieu
> 
> ----- On Dec 9, 2020, at 1:15 PM, Michael Jeanson mjeanson@efficios.com wrote:
> 
>> Machines with more than 128 CPUs are becomming more common, the proper
>> fix here would be to dynamically allocate the array which we will do,
>> but in the meantime bump the limit to 256 to fix the problem on a 160
>> CPUs ppc64el system where this was reported.
>> 
>> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Change-Id: Ib3cb5d8cb4515e6f626be33c2685fa38cb081782
>> ---
>> tests/common/api.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/tests/common/api.h b/tests/common/api.h
>> index 2b72ec5..b15e588 100644
>> --- a/tests/common/api.h
>> +++ b/tests/common/api.h
>> @@ -108,7 +108,7 @@ static void spin_unlock(spinlock_t *sp)
>> 
>> typedef pthread_t thread_id_t;
>> 
>> -#define NR_THREADS 128
>> +#define NR_THREADS 256
>> 
>> #define __THREAD_ID_MAP_EMPTY ((thread_id_t) 0)
>> #define __THREAD_ID_MAP_WAITING ((thread_id_t) 1)
>> --
>> 2.29.2
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
