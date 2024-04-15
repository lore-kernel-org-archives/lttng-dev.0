Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8147AC4345F
	for <lttng-dev@archiver.kernel.org>; Mon, 15 Apr 2024 14:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1713191585;
	bh=dyePE2Vl5QtExCYjzrBRyqITDOc4ez0vYB/v1aSRvDo=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=MusP3rrDcQjPyUNdX1PcA1B5Mye2SmDr4izw3BYvB9zev/yH4D0jy9Z66XBhrJJn8
	 Z479FMH1MYaVOU3tbT2re/b7A9nhULGF9AXjw0ReZmcfy80lYKzubiFV9uclgX46I2
	 ULiVmf0K4eNQLoh2aU7ybBOvn1a3bYDPIwTPprNWk8UHuFoewlT9cxrXQf/OCr7d5O
	 yUhx/GfQ8jCK+UKuEvWB8UEX5UdLUzxe4vSGfrDLDFQwbUEqmd+CxCot3/89nBrys7
	 MP7NLOYEK0ZfEdNz3fLcKCkl7taLZJjK9hxbwcjcgpnR4zcTezI14cksscGq+OA341
	 StlEPntQxHAmQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VJ8m050cLz2gZ7;
	Mon, 15 Apr 2024 10:33:04 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com
 [IPv6:2607:5300:203:b2ee::31e5])
 by lists.lttng.org (Postfix) with ESMTPS id 4VJ8m004Fvz2h0R
 for <lttng-dev@lists.lttng.org>; Mon, 15 Apr 2024 10:33:03 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4VJ8lz1V83zvS0;
 Mon, 15 Apr 2024 10:33:03 -0400 (EDT)
Message-ID: <90f6516f-6487-4940-a715-504caa76831b@efficios.com>
Date: Mon, 15 Apr 2024 10:33:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Michael Jeanson <mjeanson@efficios.com>,
 Paul Wise <archival@softwareheritage.org>,
 LTTng development <lttng-dev@lists.lttng.org>
References: <dcdc31d82b68d1ecff6555f67b6a7c8f6b7032ad.camel@softwareheritage.org>
 <7bacc8ff-c7b8-43ac-89e0-c3036131e1c8@efficios.com>
 <d1d8d46ef56ca05206ca673804cbd651eeacc4e5.camel@softwareheritage.org>
 <edd5722d-8103-4ef0-a53e-58d8d03ed928@efficios.com>
Content-Language: en-US
In-Reply-To: <edd5722d-8103-4ef0-a53e-58d8d03ed928@efficios.com>
Subject: Re: [lttng-dev] Software Heritage archival notification for
 git.liburcu.org
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2024-04-15 10:20, Michael Jeanson via lttng-dev wrote:
> On 2024-04-14 20:39, Paul Wise wrote:
>> On Thu, 2024-04-11 at 13:45 -0400, Michael Jeanson wrote:
>>
>>> I see no issues with this, thanks for the heads-up.
>>
>> PS: I note that git.liburcu.org and git.lttng.org seem to have
>> identical contents. I wonder if SWH should be archiving just one of
>> them or if we should archive both just in case they get split up?
> 
> At the moment 'git.liburu.org' is just a CNAME for 'git.lttng.org', we 

Typo: git.liburcu.org

Thanks,

Mathieu

> don't have plans to split them up so far.
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
