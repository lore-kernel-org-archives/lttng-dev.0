Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E613EB64DD
	for <lttng-dev@archiver.kernel.org>; Mon, 14 Aug 2023 21:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1692047111;
	bh=hNSbByIu5Yx+I7MvmiEAOWOLMEfbQG0+mZXG2iW669g=;
	h=To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ZgKtu0js3Tl7MAhUteZ0W3mgg6cdNoeBHhBTQt/Fvl+WZudbDA6y4GTTLuLJuNBQv
	 5Q+V2xUbUPPVp1c5H3WZAX+VAlmVwylb/xewLosSNNCLPxe5XSr83SdO3tAhn55us8
	 kyDoljaaFo1+6PQpkSN/2lqAt5FYHVoO2SM9BLacVFq/I1tjcEYhHqM8Gq1qPufQD+
	 UyvmmD5dN1bZtWaXXbMM2/4rhmkU5St8ztxk4NOYVh13IRhZg/OLdBmdZDMmTALzFt
	 8c/doNO9oxL0ANaamL8glA3D8rRayGBE9CGgAdiVxJU7BK4diJb+TwXW/XA6olhbCi
	 csEA18FngIm0A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RPn3V3CYDz2MGB;
	Mon, 14 Aug 2023 17:05:10 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4RPn3S2GQCz2MCw
 for <lttng-dev@lists.lttng.org>; Mon, 14 Aug 2023 17:05:07 -0400 (EDT)
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4RPn3P2m0Qz1LcY;
 Mon, 14 Aug 2023 17:05:05 -0400 (EDT)
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
In-Reply-To: <87v8gzuc3g.fsf@laura>
Organization: EfficiOS
References: <87v8gzuc3g.fsf@laura>
Date: Mon, 14 Aug 2023 17:05:05 -0400
Message-ID: <87jztxjpxa.fsf@laura>
MIME-Version: 1.0
Subject: Re: [lttng-dev] [RFC] Deprecating RCU signal flavor
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
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>


After discussing it with Mathieu, we agree on the following 3 phases for
deprecating the signal flavor:

 1) liburcu-signal will be implemented in term of liburcu-mb. The only
 difference between the two flavors will be the public header files,
 linked symbols and library name.  Note that this add a regression in
 term of performance, since the implementation of liburcu-mb adds memory
 barriers on the reader side which are not present in the original
 liburcu-signal implementation.

 2) Adding the deprecated attribute to every public functions exposed by
 the liburcu-signal flavor.  At this point, tests for liburcu-signal
 will also be removed from the project.  There will be no more support
 for this flavor.

 3) Removing the liburcu-signal flavor completely from the project.

Finally, here is a tentative versions release of mine for each phase:

 1) 0.15.0 [October 2023] (also TSAN support yay!)

 2) 0.15.1

 3) 0.16.0 || 1.0.0 (maybe a major bump since this is an API breaking
 change)

-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
