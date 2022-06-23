Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658EAC433EF
	for <lttng-dev@archiver.kernel.org>; Thu, 23 Jun 2022 03:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1655956667;
	bh=bkoqyYq1y6cNxSAhUXBRNeGq87Dw9EXAmN5lXnqSmrw=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=KbWR9jIoUs2uKvbvnn0r/esb3L4eNV1ETKYUUUXGIz8y3XvdEjkBmAd5VU5t4AKVa
	 ZGK6g4ygST6iA8yOAXd+nVf2DAuoSGI8fVjH0XTw0tBXCsx4wkUNU/WZiSt5191oM/
	 ZgFCd1lvChGN0+SXFbiS4Zje8LR8oRcjPk1UbVwUSy4Fe9Q2cFCH4DTL2DrElORakJ
	 fJs0fYTtDJwSZTJrC/jJ3hjDuxCulTE5/0o+zDh8cslMId7XO9n3c2kIh2z2/wvTcc
	 FKzkiG4LwK93GUspKlhYSRHQaz9h5mLxFSNxOKKS9nlNZ9M9ptQXoDj1plgAES+6gl
	 ARbkmCw1LFIUg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LT60V3hVlzCqm;
	Wed, 22 Jun 2022 23:57:46 -0400 (EDT)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by lists.lttng.org (Postfix) with ESMTPS id 4LT60R63nRzCh5
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jun 2022 23:57:43 -0400 (EDT)
X-QQ-mid: bizesmtp71t1655956647t5mchksv
Received: from localhost.localdomain ( [116.24.154.153])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Jun 2022 11:57:25 +0800 (CST)
X-QQ-SSF: 01400000000000B0G000000A0000000
X-QQ-FEAT: shjifG7MkPUvzLcQ9RvSXcvSbS0YYw/Hp0E1j9/EShpbSL3qJoqqwH3TqTypX
 25/i/MgXylwGJdIKcNoBfSn73U4ivZ1JmU5qd9CKosq2wGmjQjP3NkoTMJpcf3pjmTwXZgn
 a4JNzGq2kcVTwtJB+L/EoZ10NcSP+nlARcB5DyBzGBLRhdoFQDB8e6alQhCdMXKuWLiKweM
 uUB+QdPJxn/PI0VwFdO+LPQ4l9vugDEdbFMNWUqSs2gisqemKBXX8mBWeKVNMRP4KvER7bt
 hN0b01d3KrdB5a1bXn2Kusa9KoCoYq/e2hMt7DcngB8LYruD/A2+96t4bKubRFMk43lnJeR
 Fw91mpDyJ771+T9BPk=
X-QQ-GoodBg: 2
Date: Wed, 22 Jun 2022 23:57:22 -0400
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>
Message-ID: <20220623035722.GA271206@localhost.localdomain>+CCEFE5C72E6CA40A
References: <20220614035533.GA174967@localhost.localdomain>
 <20220615034900.GA187807@localhost.localdomain>
 <396090936.61897.1655302558168.JavaMail.zimbra@efficios.com>
 <20220616080912.GA246781@localhost.localdomain>
 <1711122492.5944.1655473043420.JavaMail.zimbra@efficios.com>
 <20220621035206.GA267474@localhost.localdomain>
 <1843612610.17820.1655817158376.JavaMail.zimbra@efficios.com>
 <20220622074535.GA269641@localhost.localdomain>
 <1420937751.21327.1655903998961.JavaMail.zimbra@efficios.com>
 <20220623034528.GA271179@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220623034528.GA271179@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:szsandstone.com:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Subject: Re: [lttng-dev] ***UNCHECKED*** Re: Re: urcu workqueue thread uses
 99% of cpu while	workqueue is empty
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
From: Minlan Wang via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Minlan Wang <wangminlan@szsandstone.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Wed, Jun 22, 2022 at 11:45:28PM -0400, Minlan Wang wrote:
> The session output is in attachment: 0623_futex-20220623-112754.tar.bz2
Hi, Mathieu,
There are several workqueues in the process i tracked.
The one used to trigger the issuse is this:
thread with vtid=21054, and futex = 0x5652A1035C40

B.R
Minlan


_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
