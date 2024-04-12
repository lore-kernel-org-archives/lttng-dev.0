Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D610C4345F
	for <lttng-dev@archiver.kernel.org>; Fri, 12 Apr 2024 00:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1712881275;
	bh=DR5xV96nqxp/87idBcIdg8tD+J5QtdNjXw322uGGCvM=;
	h=To:In-Reply-To:References:Date:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=x9Ec4K2Bfi1Qv2RLTi193xZd+I0MFPpE/PHg+3jTsTe+p0Xwo9v0ecx2wnP0nISK9
	 2Ajwdn1GFB3ZEOetZypGgL464rpoKo+WqKFMemnsDyTUA2uIIFba8JtI1x8EAVIiuU
	 sWz/tEU/YP215Vqt2DQWII2YiPcJKU/3oMqsFWvwCo4A+yh8pPhji5oYzY1dNb2+1G
	 HZFlcWOTruYt8wCnWs0dRmE+HRKKnIuip8X0G6D5DTuPbyqnvj+xBRawZn4jHvE48f
	 +uW2c1eD1jzxxbrI/lOeB9se2JFJtLtmUBjm0egFi+1mhI+mfYCe/FwdR+ivQagNoq
	 LMCXkZMFxqpsQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VFy0V2wxpz2fHZ;
	Thu, 11 Apr 2024 20:21:14 -0400 (EDT)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 by lists.lttng.org (Postfix) with ESMTPS id 4VFy0R6yl2z2gTr
 for <lttng-dev@lists.lttng.org>; Thu, 11 Apr 2024 20:21:11 -0400 (EDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 563BD1BF204;
 Fri, 12 Apr 2024 00:21:07 +0000 (UTC)
Message-ID: <862eb7a4a6ae7141803100b6149b632be50e71e3.camel@softwareheritage.org>
To: Michael Jeanson <mjeanson@efficios.com>, 
 add-forge-now+981.2T8mQOR3uawEg4qPiymRBTnyh9w@archive.softwareheritage.org,
 LTTng development <lttng-dev@lists.lttng.org>
In-Reply-To: <7bacc8ff-c7b8-43ac-89e0-c3036131e1c8@efficios.com>
References: <dcdc31d82b68d1ecff6555f67b6a7c8f6b7032ad.camel@softwareheritage.org>
 <7bacc8ff-c7b8-43ac-89e0-c3036131e1c8@efficios.com>
Organization: Software Heritage
Date: Fri, 12 Apr 2024 08:20:59 +0800
MIME-Version: 1.0
User-Agent: Evolution 3.50.3-1 
X-GND-Sasl: archival@softwareheritage.org
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
From: Paul Wise via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>,
 add-forge-now+981.2T8mQOR3uawEg4qPiymRBTnyh9w@archive.softwareheritage.org,
 LTTng development <lttng-dev@lists.lttng.org>,
 Software Heritage Archival Moderators <archival@softwareheritage.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Thu, 2024-04-11 at 13:45 -0400, Michael Jeanson wrote:

> I see no issues with this, thanks for the heads-up.

Great. I have started the initial archiving, you can follow it here:

https://gitlab.softwareheritage.org/swh/infra/add-forge-now-requests/-/issues/368
https://gitlab.softwareheritage.org/swh/infra/add-forge-now-requests/-/pipelines/8317/builds

-- 
bye,
pabs

https://wiki.softwareheritage.org/wiki/User:PaulWise
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
