Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DD4C54EBE
	for <lttng-dev@archiver.kernel.org>; Mon,  9 Jan 2023 15:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1673276560;
	bh=zkWirOYtcDaYftmsKEEEuscrgNd3Dt7q/p1lNCv83FI=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=A5SY07xSuR1CnPUvcH1PQTD/A0Fg6uN2VW2jZ8hzKiGqyaMdLA7xMkStpOjcy189Z
	 oaenIMeLePvnEJR3OaxPM9e2KgUxiqePppIpLauwjirpkENtc71derZom9EbtOmcsd
	 eOmKCjbBMDvryc6vpBpwu4nzyKVaWZbp/V58FGxRjGGwmR+92Yfy198nfBdUAG1eZ8
	 ceM/B2lvzMA8MybdlcM8CMAD0KM8WAxdDg1vxfmsSjiESeVz1FeQYgStu55QGCenRo
	 0VH2G8Sbr61M8+ne1oFZKBIUW+36Bhdh2MD0+m5EH/FyeHx1zNezWKDP5A1B/mu3rl
	 UP8Yl3xVDpQSg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4NrHHM3GJBz1Nw8;
	Mon,  9 Jan 2023 10:02:39 -0500 (EST)
Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
 by lists.lttng.org (Postfix) with ESMTP id 4NrFyS3D4Tz1Np7
 for <lttng-dev@lists.lttng.org>; Mon,  9 Jan 2023 09:02:55 -0500 (EST)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 by smtpfb2-g21.free.fr (Postfix) with ESMTP id BCC8B4D98F
 for <lttng-dev@lists.lttng.org>; Mon,  9 Jan 2023 15:02:53 +0100 (CET)
Received: from webmail.free.fr (unknown [172.20.243.59])
 by smtp5-g21.free.fr (Postfix) with ESMTP id 683A65FF93
 for <lttng-dev@lists.lttng.org>; Mon,  9 Jan 2023 15:02:16 +0100 (CET)
Received: from [185.105.31.250]
	by webmail.free.fr
MIME-Version: 1.0
Date: Mon, 09 Jan 2023 15:02:16 +0100
To: lttng-dev@lists.lttng.org
Message-ID: <f510dceba69eba9ce6803006b1fa5cd2@free.fr>
X-Sender: chafraysse@free.fr
User-Agent: Webmail Free/1.3.3
X-Mailman-Approved-At: Mon, 09 Jan 2023 10:02:37 -0500
Subject: [lttng-dev] LTTng UST structure support
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
From: chafraysse--- via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: chafraysse@free.fr
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

I'm looking for a CTF writer to serialize instrumentations in an 
embedded Linux/Rust framework
LTTng UST looked like a very strong option, but I want to serialize 
structures as CTF compound type structures and I did not see those 
supported in the doc or api
I'd love to have confirmation that I did not just miss something :)
If LTTng UST is out for me I will probably try to use the ctf-writer 
module of babeltrace 2 instead

Best regards,

Charles
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
