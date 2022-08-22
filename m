Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F61C28D13
	for <lttng-dev@archiver.kernel.org>; Mon, 22 Aug 2022 14:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1661178945;
	bh=jesPgisKHxBEgQ6kAKo3dy9EU47U9HcpuF4ib7cXpFg=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=eIccqYOvDnE4CSKVJJ8gmIoA3kgZuhoZyZtkveJ6WmePw2pMXAucC0WmHkwJH3pTm
	 hdsdSxz9OTJPkJ0ZNDsyLv2R+2CWrslAZMK1mJVDuW0iIc4WqA6qKBZ9/k5EsDWKcY
	 R7F2R+gNrQiNO/aEX5Cm2Vousk/CrfDGledFRvgt9eUwz6nXdvceAxV35rskeqKiK5
	 rdAfyp0kNqPDb3s7CeQv5CJ5gSbyXScPKMr01NUYOx7TzPsVLplBX5R1VWIGeDcEyV
	 yMSe/3zjJ9HZZCPfvy8rRIjz5ZpHHkdV3sl8WJWw3jbDgZpUZ9eYvFuaCJkMhNFV1O
	 JaY1lUdgYWXCg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MBFJw5vPbz1LW1;
	Mon, 22 Aug 2022 10:35:44 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4MBFJv4z5Lz1LVx
 for <lttng-dev@lists.lttng.org>; Mon, 22 Aug 2022 10:35:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 54BEB32DCDC
 for <lttng-dev@lists.lttng.org>; Mon, 22 Aug 2022 10:35:43 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id ntOHcrFJgtMk; Mon, 22 Aug 2022 10:35:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B1BEE32DAFB;
 Mon, 22 Aug 2022 10:35:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B1BEE32DAFB
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 8hZ0o-uvhs2n; Mon, 22 Aug 2022 10:35:42 -0400 (EDT)
Received: from [172.16.0.63] (192-222-180-24.qc.cable.ebox.net
 [192.222.180.24])
 by mail.efficios.com (Postfix) with ESMTPSA id 88EC032DAFA;
 Mon, 22 Aug 2022 10:35:42 -0400 (EDT)
Message-ID: <12ef14f0-c09e-5fb6-1114-e814521a79ab@efficios.com>
Date: Mon, 22 Aug 2022 10:35:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To: Eric Wong <normalperson@yhbt.net>, lttng-dev <lttng-dev@lists.lttng.org>
References: <20220820191348.GC5248@dcvr>
In-Reply-To: <20220820191348.GC5248@dcvr>
Subject: Re: [lttng-dev] efficios MX problems? (was: urcu 7ca7fe9c03 +
 _LGPL_SOURCE regression?)
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

On 2022-08-20 15:13, Eric Wong via lttng-dev wrote:
> I'm not sure why b.barracudacentral.org doesn't like my MTA.
> I got something similar in my initial message to Simon but
> brushed it off thinking it was a fluke, but I just got this
> again with Mathieu in the recipient list, as well.
> 
> dcvr.yhbt.net was recently forced to get a new IP address,
> but DKIM + SPF are set up and it manages to deliver fine to
> at least one major email provider:
> 
>> Reporting-MTA: dns; dcvr.yhbt.net
>> X-Postfix-Queue-ID: 343331F54E
>> X-Postfix-Sender: rfc822; normalperson@yhbt.net
>> Arrival-Date: Sat, 20 Aug 2022 18:51:43 +0000 (UTC)
>>
>> Final-Recipient: rfc822; mathieu.desnoyers@efficios.com
>> Original-Recipient: rfc822;mathieu.desnoyers@efficios.com
>> Action: failed
>> Status: 5.7.1
>> Remote-MTA: dns; mail.efficios.com
>> Diagnostic-Code: smtp; 550 5.7.1 Service unavailable; client [173.255.242.215]
>>      blocked using b.barracudacentral.org
>>
>> Final-Recipient: rfc822; simon.marchi@efficios.com
>> Original-Recipient: rfc822;simon.marchi@efficios.com
>> Action: failed
>> Status: 5.7.1
>> Remote-MTA: dns; mail.efficios.com
>> Diagnostic-Code: smtp; 550 5.7.1 Service unavailable; client [173.255.242.215]
>>      blocked using b.barracudacentral.org
> 
> I wonder if any other self-hosters are hitting this problem...

Hi Eric,

The ip address of your mx server (173.255.242.215) is blacklisted at Barracuda 
and SORBS, since you mention the address was recently changed this is probably 
because of the previous owners. Both of those blacklists should provide ways 
to get delisted, this is something I had to handle previously with other 
blacklists when setting up a new mx.

A good tool to check the reputation of your mx ip is mxtoolbox.com [1].

I will manually whitelist the address of you mx on our server since I know 
it's legitimate but you should have the people managing it look into this 
since you'll probably have issues with other servers.

Hope this helps, cheers,

Michael

[1] https://mxtoolbox.com/SuperTool.aspx?action=blacklist%3ayhbt.net&run=toolpage

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
