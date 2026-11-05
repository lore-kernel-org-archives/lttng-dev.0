Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F695606A329
	for <lttng-dev@archiver.kernel.org>; Thu,  5 Nov 2026 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.lttng.org header.i=@lists.lttng.org header.a=rsa-sha256 header.s=default header.b=l7JWvATg
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4jLCXr4K4Vz1yMG
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1793908110;
	b=SuJeuUOhYW9Ftv0JVUoPoWx/VYp+tnXy0GS6eRQrFIqo/Nr532WLHB2EIWMu7ClI8pnM
	 8fcsPyR7qhd7FWM1aGhdVhFPiHD9tceapLkp4JdaimKyO8pkb+W0L6n6i5n7xNoh/e2mz
	 uKV/m0Q23hWgIlmiNgXJdHd5AjchTJlS08XfKKz8cSbylVAuzJKdDFlCPd/j0d9oOcvGo
	 ma+mDuOW3VBrxy2eljrqvoM4oSv6rBeTarUstufVfW2XE8DOFhZ8JkUfQXF+ZM7rCF8FI
	 K3CAvRSj445FVO2Ai/Ew7vNa+n0AlJZhgq3KXFf9gHSKT0RTGYTL+2/YVNk7W+JCU/A==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1793908110;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From:From;
	bh=fsRu2SBKcmMT+8al5m5FWnedz5U9nlJFv5tmcrbr39M=;
	b=m0cjJxbSrD8gV9EHxQxcNUUdQc3YFXMYwP673sGf+h89AdHYMArOGom0qy05iUgqQ41Z
	 Vj+Binn7HzAaef20/+PvE3yM3TAXNmFNx5D4ZysA1wc1sKV7e2qcBsB7vScVCu1kG/Qyt
	 HMhHS1vevynlXMzw1nc0zTYhsiPsfFKJpNGZ7LurnpJCom1S3rWwpWH1CQSnULeGFKKCm
	 OyncpLNeId1cvM0CxONTxbml+AtXsRfMSTtcuX6ZioL0NHsi4dk2ipaJ2/6IF5Nrttiiw
	 4Uf7XOHyPjt7k/Lttp6vC3fHmj+YWfaED2BJvyjqa+0XRyOghTAu83Dsllr6UAWSfgQ==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4jLCXr4K4Vz1yMG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1793908110;
	bh=ivxPLPzdy0PS1AVCiEKWQwxC9MlyWnbTKgBP5TBKuQM=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=l7JWvATgbWQVNb+qkonheaToBS9DiIQkzoYXJZhiyyEZRga8nmcnRwFrB4JVlnYqx
	 eMaXQmY8Gr67W7PVBY1+r3t0fxt+Bh06RemZkgvu2yHcKhMTnPOQzicI1jrK+fjajS
	 ApupCSSjvGzMN6yYLeAEJfCNh1oxxVQbKxe0zzLNb9zmQ6RccwtLTc8qG637wJ5yrz
	 H3A09anQbgK2NhWAs71iz5C8YkzypSguZKOQbz2+90uqgTAe6zgynvRU2RIhqy8Fw7
	 nnGH3UDYXFlXXIMR24tkAbNGKy0y6LICASbcu7G2098ZB16rkYsUxBB4SHr9dUFJAA
	 092+jMXZ09jnQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4jLCXr4K4Vz1yMG;
	Thu,  5 Nov 2026 14:48:28 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4jLCXq0bcRz1y8P
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4jLCXq0bcRz1y8P
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
 by lists.lttng.org (Postfix) with ESMTPS id 4jLCXq0bcRz1y8P
 for <lttng-dev@lists.lttng.org>; Thu,  5 Nov 2026 14:48:26 -0500 (EST)
Received: from simark.ca (simark.ca [158.69.221.121]) (authenticated bits=0)
 by smtp.polymtl.ca (8.14.7/8.14.7) with ESMTP id 6A5JmKgq225230
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT); 
 Thu, 5 Nov 2026 14:48:25 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.polymtl.ca 6A5JmKgq225230
Received: by simark.ca (Postfix) id 31D201E043;
 Thu, 05 Nov 2026 14:48:20 -0500 (EST)
Message-ID: <401fff05-cde1-4cb0-b421-132192bb7366@polymtl.ca>
Date: Thu, 5 Nov 2026 14:48:19 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: libbabeltrace2: question about thread safety
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <44074c36528ca4a30909e21072ae67f37b0c244b.camel@siemens.com>
Content-Language: fr
In-Reply-To: <44074c36528ca4a30909e21072ae67f37b0c244b.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Poly-FromMTA: (simark.ca [158.69.221.121]) at Thu, 5 Nov 2026 19:48:20 +0000
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Simon Marchi via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Simon Marchi <simon.marchi@polymtl.ca>
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 4:11 AM, MOESSBAUER, Felix via lttng-dev wrote:
> Hi,
> 
> I just noticed that the reference counting in libbabeltrace2 is not
> atomic - and by that not thread safe. As I can't know where reference
> counting on global objects (like the plugin or component instances) is
> done internally, I'm assuming I can't execute two (independent) graphs
> in parallel. Some quick tests with tsan seem to confirm my assumption.
> 
> Is there any (documented) way to run two graphs in parallel? Or shall
> the whole library just be used behind a global mutex?

(resending from another address to try to avoid the spam filter)

I think the idea was that running two graphs simultaneously in two
threads would not be a problem, because they don't share anything.  But
you are right that plugins and component classes are actually shared.
The action of adding a component to a graph touches the component class'
refcount, and so does destroying the graph (and there is the "freeze"
status too, if the lib is built in dev mode).

I think it would make sense for libbabeltrace2 to have some
synchronization in the plugin / component class area to allow for two
threads to build, run and destroy graphs without requiring any locking
on the user side.  But that won't be trivial, and it's not on the
roadmap as we speak.

In the mean time, you could try having a global lock but only for the
graph building and destruction phases?  Or have a single thread
responsible for building and destroying graphs.  I'd be curious to know
if this is enough or if there are other concurrent accesses we haven't
spotted.

Simon
