Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E69FC43334
	for <lttng-dev@archiver.kernel.org>; Thu, 23 Jun 2022 09:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1655975353;
	bh=et946XcIkvOPyrTWtSZ5MZEbzgo7G7lKVls5U3fP46M=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=WXTnYtsjDtpAnz8Pu1tVsit5k9h1OzuIm7lALmav1U/OSSfpVKOS30Z1KkhM8hX7A
	 2RtMkP0tdicAzbyy0fvYm+nI7eqTU0IPBjjXwjc/hDbBhH8kqVHvzrnZNjDd0xnNF0
	 eulQDyGhj++JnKj9tVDT6N+fUn7pjRUEmktXh3jUqY6+Y/4hAYQjqqMC83diPnazoQ
	 CxDoEFmIRZsAevmhdBhDUmRa68CC/HeBTxQuT64VDnru4lAm/WNKEhnxH3NcudB9PK
	 /G6BDiAV4rrm0skFjD4n4pJ6yG4L6VbZ8aADjB6eFFcvcQuXZy/qe9z5cKTzt9GEeG
	 +5gKC/25dLXLA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LTDvs207BzDjD;
	Thu, 23 Jun 2022 05:09:13 -0400 (EDT)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by lists.lttng.org (Postfix) with ESMTPS id 4LTDvp12jTzDw4
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jun 2022 05:09:09 -0400 (EDT)
X-QQ-mid: bizesmtp74t1655975336tesqyonf
Received: from localhost.localdomain ( [116.24.154.153])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Jun 2022 17:08:55 +0800 (CST)
X-QQ-SSF: 01400000002000B0G000B00A0000000
X-QQ-FEAT: HvoQuNr4nUojWbiLny9PE8AtlY1uydGBqeDEVn+2h47S31D8s2aBqADgeszpe
 TE+JdDzjvy414Ih4FWiHYvoFiTFInqFe3482TkCFnFIQgmuw35M3yVVn+CosVh1o/Q1FCMD
 GuYILBtQ/W3NeHAhRRVmt2/rW+xqI4RBUBUdAr+MzIDZJwAYwJKedCCtX/SjWDxBNiV7MxW
 sPP27licVMHlxppqyzWO+eg/8Q6IacCue2byt9JjmJMLNyiLMH7fa/Zq2QH/9ts40Khrhg/
 hjpbaDEp6ZwfxTTMMaVUdFQostpZF0UR2fdYYXCs/ZVhgT4FMSEli4e9twcwrgFvXMhJP50
 gPG2/5P0yRfpvZK4EjUui8XFYWqzQ==
X-QQ-GoodBg: 2
Date: Thu, 23 Jun 2022 05:08:52 -0400
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>
Message-ID: <20220623090852.GE271640@localhost.localdomain>+E0224BC1F62E0434
References: <20220614035533.GA174967@localhost.localdomain>
 <20220616080912.GA246781@localhost.localdomain>
 <1711122492.5944.1655473043420.JavaMail.zimbra@efficios.com>
 <20220621035206.GA267474@localhost.localdomain>
 <1843612610.17820.1655817158376.JavaMail.zimbra@efficios.com>
 <20220622074535.GA269641@localhost.localdomain>
 <1420937751.21327.1655903998961.JavaMail.zimbra@efficios.com>
 <1779693726.26841.1655929703853.JavaMail.zimbra@efficios.com>
 <589742415.26853.1655931120526.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <589742415.26853.1655931120526.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:szsandstone.com:qybgforeign:qybgforeign8
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

On Wed, Jun 22, 2022 at 04:52:00PM -0400, Mathieu Desnoyers wrote:
[...]
> remote:   https://review.lttng.org/c/userspace-rcu/+/8441 Fix: workqueue: futex wait: handle spurious futex wakeups [NEW]        
I tried this patch in our environment, it worked fine, the issue does not appear anymore.

B.R
Minlan


_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
