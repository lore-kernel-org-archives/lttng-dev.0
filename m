Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC92DC433EF
	for <lttng-dev@archiver.kernel.org>; Thu, 20 Jan 2022 15:20:40 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JfmRW02vvzKfx;
	Thu, 20 Jan 2022 10:20:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642692039;
	bh=AmDd6HWXL3hPwAzZwUDuRWOS+HkRKgaBFLmnHmfLgf0=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=OmssMTwSrElLb5yDtXQzLwa35ErIFq+6clPanvYKzRd/PTV+n9dmSKG8WqMxxB3RP
	 SfjttrYy8B5Qf+8CsCjpumEjy5A9XnlK67XAdMeEY9mG/V5+FfdvMv6YWO3YT83asU
	 W6lTXL3TMs1cshM6ud4NsGbdcS+qRpMZhPWZ7g0JfGQd4uxKTG2U31p4OhPqPJUMPX
	 DL+TJqA1zYgZCZeUQjYA2equdRW9KlPU4dX0vn/4mhY9xNgyr/IYwYBQQkm81MzOjN
	 5BE9RVJn0jR6T99mmub+TvCPMlw+Vj1idBoQ4ms4yiSi3DrwWAkWoFb9z4O2pfFO36
	 P9WiYlWdMjiwQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JfmRT3DNWzKNm
 for <lttng-dev@lists.lttng.org>; Thu, 20 Jan 2022 10:20:36 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id DAD853227D3;
 Thu, 20 Jan 2022 10:20:30 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id l-rUPE55tWI9; Thu, 20 Jan 2022 10:20:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 535AE322956;
 Thu, 20 Jan 2022 10:20:30 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 535AE322956
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 3j7ToOlEqwTy; Thu, 20 Jan 2022 10:20:30 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 45B56322A23;
 Thu, 20 Jan 2022 10:20:30 -0500 (EST)
Date: Thu, 20 Jan 2022 10:20:30 -0500 (EST)
To: olivier moussavoucotte <olivier.moussavoucotte@mail.mcgill.ca>
Cc: Jeremie Galarneau <jgalar@efficios.com>, 
 Jonathan Rajotte-Julien <joraj@efficios.com>, 
 lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1338660677.61818.1642692030254.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Index: MdjTM5J+pJqA6C4FQZzeZ6aa9M8Czg==
Thread-Topic: Transfer of LTTng copyright ownership: Olivier Cotte
Subject: [lttng-dev] Transfer of LTTng copyright ownership: Olivier Cotte
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
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

Hi Olivier,

In order to facilitate maintenance of the LTTng project, would you agree to
transfer your copyright ownership for LTTng code co-authored with Jonathan
Rajotte at Polytechnique to EfficiOS Inc. ?

The copyright in question is for the files mi-lttng.cpp, mi-lttng.h and
mi-lttng-4.1.xsd in the lttng-tools project:

Copyright (C) 2014 Olivier Cotte <olivier.cotte@polymtl.ca>

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
