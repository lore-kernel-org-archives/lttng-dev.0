Return-Path: <SRS0=pPd9=N6=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCBEC433EF
	for <lttng-dev@archiver.kernel.org>; Wed,  8 Sep 2021 19:51:09 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95286604DC
	for <lttng-dev@archiver.kernel.org>; Wed,  8 Sep 2021 19:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 95286604DC
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4H4XnR03VQz16DT;
	Wed,  8 Sep 2021 15:51:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1631130667;
	bh=L0If+d1xgxyyaFgSSQ/K08UdVdldqthB7coy8RKlUbQ=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=sKcu76Dx7FlEfViK4amNMn2rNKjXphMA6ppdhjrMcIV98HHEzRZ73opyX4bVwgU+s
	 +geeI8PaOvNHXzxG2d4t8nsGfuHtBRzKZK/kMyTosBv23cDLsH9Bvsywv5ISOqwM8o
	 TC1DrKORR1QfGxSEEe3NaqtIR4Rb4gCheTvs90uwottSzlHHVLwEhmbWQkC1suTcWm
	 WGyNFiq/C2yS6/AX453RsMw2yem4WwnZYdm99nZWw+RU0lJA0isGHWSFcIOW05cGTJ
	 IrQ7n4kstX55Bo4ps97JWn8IIUXhM2QpZ7pI8JaDTdy//5NPYIa1ZNjXKWYC/0SBSF
	 5pXEQPnxjiVAQ==
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by lists.lttng.org (Postfix) with ESMTPS id 4H4XnN3vxDz1691
 for <lttng-dev@lists.lttng.org>; Wed,  8 Sep 2021 15:51:04 -0400 (EDT)
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 25194603E7;
 Wed,  8 Sep 2021 19:41:53 +0000 (UTC)
Date: Wed, 8 Sep 2021 15:41:46 -0400
To: Linux-trace Users <linux-trace-users@vger.kernel.org>,
 "linux-trace-devel@vger.kernel.org" <linux-trace-devel@vger.kernel.org>,
 lttng-dev <lttng-dev@lists.lttng.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20210908154146.2c1a5348@oasis.local.home>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Subject: [lttng-dev] CFP for Linux Plumbers Tracing microconference ends
 this Friday
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Steven Rostedt via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>


The Tracing MC CfP ends this Friday. If you would like to present a
topic to discuss, please submit it here:

  https://linuxplumbersconf.org/event/11/abstracts/

and select "Tracing MC" for the track.

More information can be found here:

  https://linuxplumbersconf.org/event/11/page/104-accepted-microconferences#cont-tracing

and here:

  https://www.linuxplumbersconf.org/blog/2021/index.php/2021/06/18/tracing-microconference-accepted-into-2021-linux-plumbers-conference/

-- Steve
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
