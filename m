Return-Path: <SRS0=ItRG=GP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16ABC433DB
	for <lttng-dev@archiver.kernel.org>; Tue, 12 Jan 2021 16:38:31 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86AF22EBE
	for <lttng-dev@archiver.kernel.org>; Tue, 12 Jan 2021 16:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86AF22EBE
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DFbqQ2xDGzQNj;
	Tue, 12 Jan 2021 11:38:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1610469507;
	bh=WRbL5U8jBrIWFECn6L7flTCyAGxuxl4ax/abM01jWfw=;
	h=To:References:Date:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=x3hsHGhf4fI/CwcToR1ZyCeMgyTWW5vPgz7vTtPPUxVfPPmguwjj+D/bGXU0Nxooy
	 92D8MKPVo6HJOXVqo3MY+NqEMOLmDUK/DIEW+M6jK07eVun5sH7bkscnUO6nD+peQS
	 qn6tts4zb/yxTP9VJTfzEGOWgMLY7Iik+9K/hU/nzALiwfjlH6iwWCNGnrsJMtylx8
	 ovLv94I2ua/7/h6uOJIcbonXoZquHq7eB1QA8NTG/8h6RBrnChjDe1QhxaBPslORbN
	 hMR9A1nvrb4y7QAripQUzQlB6IzCNEM7NBN4s2JTex0ii6+55M3c7QzIvgUO1ijhgZ
	 cJWWaVXZpj1hQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4DFbqN5ZmqzQKy
 for <lttng-dev@lists.lttng.org>; Tue, 12 Jan 2021 11:38:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2D88D27ABF9
 for <lttng-dev@lists.lttng.org>; Tue, 12 Jan 2021 11:38:18 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 9WLA5cPfRMFz; Tue, 12 Jan 2021 11:38:17 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id CB9CE27ABF4;
 Tue, 12 Jan 2021 11:38:17 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CB9CE27ABF4
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id bZH4y3SCAT4w; Tue, 12 Jan 2021 11:38:17 -0500 (EST)
Received: from [10.10.0.241] (96-127-212-112.qc.cable.ebox.net
 [96.127.212.112])
 by mail.efficios.com (Postfix) with ESMTPSA id B51FD27ABF3;
 Tue, 12 Jan 2021 11:38:17 -0500 (EST)
To: lttng-dev@lists.lttng.org
References: <DM6PR15MB407280AC90424B9F52FE57D38FAF0@DM6PR15MB4072.namprd15.prod.outlook.com>
 <c6e9bdf7-3f1b-9ed8-bc3a-239675f69953@efficios.com>
Message-ID: <e32dbf93-c8eb-1621-c7d9-076c4bb10171@efficios.com>
Date: Tue, 12 Jan 2021 11:38:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <c6e9bdf7-3f1b-9ed8-bc3a-239675f69953@efficios.com>
Content-Language: en-US
Subject: Re: [lttng-dev] LTTng 2.12 modules from PPA fail to install
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>


On 2021-01-08 14 h 13, Michael Jeanson via lttng-dev wrote:
> On 2021-01-07 15 h 54, Bernd Hufmann via lttng-dev wrote:
>> Hi LTTng experts,
>>
>> On my Linux Ubuntu 18.04 machine (4.15.0-129-generic kernel) the 
>> installation of the LTTng kernel modules fail using the official PPA. 
>> I found a log file lttng-modules-dkms.0.crash with some details on the 
>> installation failure. See pastebin [1] for the detailed error message.
>>
>> Any ideas what is going on? Please let me know what I can do to 
>> resolve it.
>>
>> In advance thank you very much.
>>
>> BR
>> Bernd
>>
>> [1] https://paste.ubuntu.com/p/747H2V5q7K/ 
>> <https://paste.ubuntu.com/p/747H2V5q7K/>
> 
> Hi,
> 
> There is a fix for this build failure in the stable-2.12 branch but it 
> is not part of a point release yet. In the meantime, you can build 
> modules from the git branch or use the package from the "Latest Stable" 
> ppa [1].
> 
> Once the next point release (2.12.3) happens, it will be uploaded 
> straight away to the 2.12 ppa.
> 
> Regards,
> 
> Michael
> 
> 
> [1] https://launchpad.net/~lttng/+archive/ubuntu/ppa

The new 2.12.4 release has landed in the stable-2.12 ppa, you should now 
be able to simply update the package to fix the build failure.

Cheers,

Michael
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
