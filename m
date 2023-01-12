Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1A4C61DB3
	for <lttng-dev@archiver.kernel.org>; Thu, 12 Jan 2023 20:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1673554230;
	bh=x5nCfXTIcyFrHoBvb5xfZnW6IAGVeO/ZNv1YoBdDI58=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Zvud1sWdmzicYRPh5AkjMR7ZFnJONVcqsay3qG85P4HOvMWrePrsNCTataMMk/MlF
	 MkruGihspg5jNY1zZ0KOd+RDY8tGPZ3vXlj3W6sfFjQmqrp4occlwgiQTtMFoN6Yim
	 258w4lqNm5Ov6b2krE83dNJtoTq7mkcJxsLrt9B3EGjTXIFlLJTdsZ9y293sTyVFaH
	 QXUppja8tXb0U5HCC0iMZH3WBH/AOI/GZHcnFLpVdfgGsgUh3t7lFzDV1Y9StMqAda
	 qJJiLe41EeSgoKrlozB7ZeuSbfFYBzRGJwQfV2axXvCmCfXY3su/tDL1LvMmHFTVsY
	 LNRiV/ZBs0Q+w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4NtFz96TNPz1Prr;
	Thu, 12 Jan 2023 15:10:29 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4NtFz56QGkz1Prq
 for <lttng-dev@lists.lttng.org>; Thu, 12 Jan 2023 15:10:25 -0500 (EST)
Received: from [172.16.0.101] (192-222-180-24.qc.cable.ebox.net
 [192.222.180.24])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4NtFz4096VzgNl;
 Thu, 12 Jan 2023 15:10:23 -0500 (EST)
Message-ID: <79319a2d-0898-0243-1572-26e476cac681@efficios.com>
Date: Thu, 12 Jan 2023 15:10:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To: chafraysse@free.fr, lttng-dev@lists.lttng.org
References: <f510dceba69eba9ce6803006b1fa5cd2@free.fr>
In-Reply-To: <f510dceba69eba9ce6803006b1fa5cd2@free.fr>
Subject: Re: [lttng-dev] LTTng UST structure support
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

On 2023-01-09 09:02, chafraysse--- via lttng-dev wrote:
> Hi,
> 
> I'm looking for a CTF writer to serialize instrumentations in an 
> embedded Linux/Rust framework
> LTTng UST looked like a very strong option, but I want to serialize 
> structures as CTF compound type structures and I did not see those 
> supported in the doc or api

This is correct. I am currently working on a new project called 
"libside" (see https://git.efficios.com/?p=libside.git;a=summary) which 
features support for compound types.

However, we still need to do the heavy-lifting implementation work of 
integrating this with LTTng-UST. This is the plan towards supporting 
compound types in LTTng-UST.

> I'd love to have confirmation that I did not just miss something :)
> If LTTng UST is out for me I will probably try to use the ctf-writer 
> module of babeltrace 2 instead

For now the ctf-writer modules of bt2 would be an alternative to 
consider, but remember that it is not designed for low-impact tracing 
such as lttng-ust. So it depends on how much tracer overhead/runtime 
impact you can afford in your use-case.

Thanks,

Mathieu

> 
> Best regards,
> 
> Charles
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
