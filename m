Return-Path: <SRS0=BY1b=J2=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746D6C433B4
	for <lttng-dev@archiver.kernel.org>; Thu, 29 Apr 2021 14:09:33 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358E66105A
	for <lttng-dev@archiver.kernel.org>; Thu, 29 Apr 2021 14:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358E66105A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FWHSB1dcQz1dpm;
	Thu, 29 Apr 2021 10:09:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1619705370;
	bh=eXF99IL1vX4lJGgf/KtNM7KaUuciGTvYEgd+UxVsBN0=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=lHsyTc0tnAZbNCl5rSbmmkpgbSbG0GIst1siCjTL0Id9Oq4JVr5pZe/02KpJWUhKu
	 WKFE8oKCpCgQJHhyZnfq+YQxiGojEx/zZAxE+CoB6sUWAXC+25cd1U8j9atr6AjBZ1
	 qWJPr9z5uxf9jfgfU7Yyx1lCGWnlagxyUd9IonWRw4Ovlf1JbD1rCRhCnifl96r5kd
	 GgfmZ5Dh2Jkg7EC4m6YNhN/Du+n6yQH9/X5knQQZsMTzC15W2IRu/U5kCqXT7NuYOU
	 tOXscjHF/6YhXh6TZgwl1YIfEnn9mvzI9cQA/ym69HAlmJMdUhkIWuE9qibhDXFreb
	 14IwfvQ14sfzg==
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by lists.lttng.org (Postfix) with ESMTPS id 4FWHKX5H5Qz1dsD
 for <lttng-dev@lists.lttng.org>; Thu, 29 Apr 2021 10:03:44 -0400 (EDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A767FAFEF
 for <lttng-dev@lists.lttng.org>; Thu, 29 Apr 2021 13:49:44 +0000 (UTC)
Message-ID: <ebac01302ecae6cc2dd0ace8fcfffa6ab593e0fe.camel@suse.com>
To: lttng-dev@lists.lttng.org
Date: Thu, 29 Apr 2021 15:49:43 +0200
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 29 Apr 2021 10:09:29 -0400
Subject: [lttng-dev] User-space RCU: call rcu_barrier() before dissociating
 helper thread?
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
From: Martin Wilck via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Martin Wilck <mwilck@suse.com>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

In multipath-tools, we are using a custom RCU helper thread, which is clean=
ed out
on exit:

https://github.com/opensvc/multipath-tools/blob/23a01fa679481ff1144139222fb=
d2c4c863b78f8/multipathd/main.c#L3058

I put a call to rcu_barrier() there in order to make sure all callbacks had=
 finished
before detaching the helper thread.

Now we got a report that rcu_barrier() isn't available before user-space RC=
U 0.8 =

(https://github.com/opensvc/multipath-tools/issues/5) (and RHEL7 / Centos7=
=A0
still has 0.7.16).

Question: was it over-cautious or otherwise wrong to call rcu_barrier() bef=
ore
set_thread_call_rcu_data(NULL)? Can we maybe just skip this call? If no, wh=
at
would be the recommended way for liburcu < 0.8 to dissociate a helper threa=
d?

(Note: I'm not currently subscribed to lttng-dev).

Regards and thanks,
Martin



_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
