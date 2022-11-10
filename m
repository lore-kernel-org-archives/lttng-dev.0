Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509E5C433FE
	for <lttng-dev@archiver.kernel.org>; Thu, 10 Nov 2022 15:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1668094080;
	bh=uZEh8n0YKsaZGcFdtV73KBo9br4V4XJxXdpPFnlJgYs=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=LAolbxQs/ITim7oYDrk8aSt5yHYz+K1Koaz1ylMJQnH1H2B94nGn71TAmmauGyEIp
	 6EUrkodfOayh6TZ39sZRjblynwSBVm8hgwYwUucyo5UU2Tg6Qdxxv8tx70UM77Wp7u
	 Dtrdx+nAjb3oXoD+JiCeJQkdudct7/z/9TbA32345I9D4T0sCC9LzLRC83s7DIA48v
	 5tv261VzTihqKY5NjonVXu8vTorQt2+SOAu1rMLA/5+hTkxuAuQFurZhZsRvbParO4
	 GhLlh2rmnbs2EB9zr3fTS2Zr41skAP5N/VToEnQj9J4aFkjILdVU135RZH+xIMHuTa
	 6R60nNEctVj9Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4N7QhH35hwzHGy;
	Thu, 10 Nov 2022 10:27:59 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4N7QhG0mYXzHkb
 for <lttng-dev@lists.lttng.org>; Thu, 10 Nov 2022 10:27:57 -0500 (EST)
Received: from [10.1.0.205] (192-222-188-69.qc.cable.ebox.net [192.222.188.69])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4N7QhD72z5zgjN;
 Thu, 10 Nov 2022 10:27:56 -0500 (EST)
Message-ID: <7d74593d-cb7d-74b3-d661-2bd678bb7610@efficios.com>
Date: Thu, 10 Nov 2022 10:28:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To: Yongwei Wu <wuyongwei@gmail.com>, lttng-dev@lists.lttng.org
References: <CADs46id2Mv80raH6xA8mSX3BRdCiNVydC-1G=3xEFD1iC6Ng9Q@mail.gmail.com>
In-Reply-To: <CADs46id2Mv80raH6xA8mSX3BRdCiNVydC-1G=3xEFD1iC6Ng9Q@mail.gmail.com>
Subject: Re: [lttng-dev] README issue of liburcu
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

On 2022-11-02 03:24, Yongwei Wu via lttng-dev wrote:
> I apologize if this is not the right place. I do not see an Issues page 
> on GitHub.
> 
> The README on GitHub now says MacOS is among "Tested on", so should we 
> remove Darwin from "Should also work on"?

Removed from README file in the master branch.

Thanks,

Mathieu

> 
> Best regards,
> 
> Yongwei
> 
> -- 
> Yongwei Wu
> URL: http://wyw.dcweb.cn/ <http://wyw.dcweb.cn/>
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
