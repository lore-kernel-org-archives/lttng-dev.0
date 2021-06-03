Return-Path: <SRS0=cZOi=K5=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221D1C47082
	for <lttng-dev@archiver.kernel.org>; Thu,  3 Jun 2021 20:58:05 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB46613AE
	for <lttng-dev@archiver.kernel.org>; Thu,  3 Jun 2021 20:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB46613AE
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FwysQ2NM6z6GP;
	Thu,  3 Jun 2021 16:58:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1622753883;
	bh=sOfKzru3CZqAkSQnCrRQmsete2Sp5c6iyJoYMBshi+4=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=quJKILqzTOgg9UYevPqBYgJppPbV4Rw6mL1N2lPnj7/044GGxvNAVkAeGNcIVA+aV
	 5aaxL51dEUbyKgq0wbxVG335ehCnzAMPJ96q0FHMRqw+6ZKIWEE1cuwbSApqPPrpC5
	 6OBRnI1mWbeoEi4FYBLLXAdmbeFCHLZP18j79ufsPAspuQ81T3JHp5jKkoOmm5aB6X
	 XCLs74EcbJB3R04ISGrAqTDKqAcawzk8LZZYS+WjaHvFEKihcu+lBDlEQYCMSXdR/Z
	 Ht7e7u9Efi1xN3HRZ+BHLfwpYGV1kxtlzrntmgX7Tb+FPCERX7ygXnhZi10roRsL4Z
	 om7kaxNBHXrXQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FwysN2z6Dz6GM
 for <lttng-dev@lists.lttng.org>; Thu,  3 Jun 2021 16:58:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D5D0331F52D
 for <lttng-dev@lists.lttng.org>; Thu,  3 Jun 2021 16:57:53 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id NAhXqpSvLK0Q; Thu,  3 Jun 2021 16:57:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 40D7B31F447;
 Thu,  3 Jun 2021 16:57:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 40D7B31F447
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id slnI4CuQ0G_G; Thu,  3 Jun 2021 16:57:53 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 3168231EFFB;
 Thu,  3 Jun 2021 16:57:53 -0400 (EDT)
Date: Thu, 3 Jun 2021 16:57:53 -0400 (EDT)
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Lai Jiangshan <jiangshanlai@gmail.com>
Message-ID: <293749719.7760.1622753873071.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4026)
Thread-Index: sEBXQE/MhfBlDpmhebxv28mTBCxeXg==
Thread-Topic: Userspace RCU 0.13.0
Subject: [lttng-dev] [RELEASE] Userspace RCU 0.13.0
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

The Userspace RCU 0.13 release is mostly a library soname version bump
to address an ABI incompatibility between the 0.10 and { 0.11, 0.12 }
releases.

The observed application vs library compatibility problem occurs as follows:

- An application executable is built with _LGPL_SOURCE defined, includes
  any of the Userspace RCU 0.10 urcu flavor headers, and is built
  without the -fpic compiler option.

- The Userspace RCU 0.10 library shared objects are updated to 0.11
  or 0.12 without rebuilding the application.

- The application will hang, typically when RCU grace period
  (synchronize_rcu) is invoked.

Some possible work-arounds for this are:

- Rebuild the application against Userspace RCU 0.11+,
- Rebuild the application with -fpic.
- Upgrade Userspace RCU to 0.13+ without installing 0.11 nor 0.12.


* Explanation of the issue

In URCU 0.11, we introduced new symbols to clean up the library symbol
namespacing, using the "alias" attribute to keep emitting the old
symbols, expecting to preserve ABI backward compatibility.
Unfortunately, it turns out that even though it works well for function
symbols, it is broken for public global variables due to the way ELF
copy relocation works.

When building a non-PIC executable that uses an extern variable, a .bss
symbol is emitted in the executable. This will take precedence over the
symbol implemented within the library in the Global Symbol Table.
Unfortunately, the alias within the library will not be aware that the
actual GST symbol differs from its alias within the library, and the
addresses for the symbol and its alias will differ at runtime.

Considering that this compatibility issue affects official library
releases, there is little we can do beyond documenting this issue, and
bumping the Userspace RCU major soname for the next (0.13) release.

In summary, do not upgrade from Userspace RCU 0.10 to 0.11 or 0.12 if 
you have applications which:

- define _LGPL_SOURCE
- use Userspace RCU 0.10 headers
- are not compiled with -fpic

We recommend instead to upgrade to Userspace RCU 0.13, which bumps the
library soname major number.

Thanks,

Mathieu

Project website: http://liburcu.org
Git repository: git://git.liburcu.org/urcu.git

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
