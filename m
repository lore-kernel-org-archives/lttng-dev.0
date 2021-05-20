Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12604C433ED
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 14:37:32 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCB461059
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 14:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCB461059
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FmC4n6QN9z1rpX;
	Thu, 20 May 2021 10:37:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621521450;
	bh=831NmivGo6fIoj/tqt566/B5vn16TNMTy2NyvflzZ38=;
	h=To:References:Date:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=XjFymusqvZqZaKeyhHcSo+G4IhmRlZIITxNyP77Glp15+9qQCkVpel0tH5pJhZW1i
	 C9oYt5u2aiJErRaMnIbRGxRZaMyfk+jpuOFG8nfdJL8lvGWqzv7cD/08N3ivtx0hWz
	 nvqVlcDLKUIU/oDDqM8gSc7W6UsNzyWVymXC++810O4x+bfrIjcIcy3OF42YFQVtF7
	 6YtS/8dMH7IxwoNSdn/B7zlym/NVgtF39MkS0EP8pUhXkZGVL2R84CykOC3UUXlpYy
	 AHNmgtamDR/JjxFyR0JHC/xAO2QfzeLyVqutIbT4lRrSW8ECxyztkb3DQj7ThH9u3U
	 wD8vGwCLtquog==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FmC4m0pkLz1s0w
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 10:37:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A162E33661A
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 10:37:21 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id kOc3a2fMqZ8h; Thu, 20 May 2021 10:37:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 117CD33650B;
 Thu, 20 May 2021 10:37:21 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 117CD33650B
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id FeFb3JWTeg17; Thu, 20 May 2021 10:37:21 -0400 (EDT)
Received: from [172.16.0.63] (192-222-181-218.qc.cable.ebox.net
 [192.222.181.218])
 by mail.efficios.com (Postfix) with ESMTPSA id DF483336412;
 Thu, 20 May 2021 10:37:20 -0400 (EDT)
To: lttng-dev@lists.lttng.org
References: <CADYdroPf5mcRMvfewsT6SQsWG0RKg6GcV8=T8BupxbooHT2=aA@mail.gmail.com>
Message-ID: <d7833098-93b8-712a-460a-da8ed7a3d044@efficios.com>
Date: Thu, 20 May 2021 10:37:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CADYdroPf5mcRMvfewsT6SQsWG0RKg6GcV8=T8BupxbooHT2=aA@mail.gmail.com>
Content-Language: en-US
Subject: Re: [lttng-dev] 2.13-rc2 fails to build with buildroot crosscompiler
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2021-05-20 9:52 a.m., Norbert Lange via lttng-dev wrote:
> Hello,
> 
> many tests fail to build, apparently because transitive dependencies
> are not found.
> I managed to patch out building the test sub-directory, at which
> points the errors are gone,
> I dont know how to fix it with automake, seems like
> /tmp/ZBuild/build/lttng-libust-2.13.0-rc2/src/lib/lttng-ust/.libs
> should be added to library search paths.
> 
> Norbert

The libtool integration with autotools should be handling these transitive
dependencies but somehow doesn't seem to work in your environment. A
workaround could be to add the liblttng-ust-common.la file to all the test
binaries _LDADD where liblttng-ust.la is already present, for example:

ust_fields_compatapi1_LDADD = \
        $(top_builddir)/src/lib/lttng-ust/liblttng-ust.la \
        $(top_builddir)/src/lib/lttng-ust-common/liblttng-ust-common.la \
        $(DL_LIBS)

Can you check if this works?

Michael
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
