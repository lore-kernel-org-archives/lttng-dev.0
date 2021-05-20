Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418E1C43461
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 15:21:51 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E6EE60698
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 15:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6EE60698
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FmD3x3GkRz1rcy;
	Thu, 20 May 2021 11:21:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621524109;
	bh=nI0yOGK4A6gsKh91fOVME8XCP2iO7dCGDDtedjnFNfs=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=juVZuGcwblCG/rg7c8Kp5uTOzOEPHNi6yAemDnIdrloKtgvPXcmrJA/PQqxprJvrP
	 OYXftz617e72zmoH9negVs34gEXqj+3/KVwZNew/LWi2o29wX68Aq/RMK/8GysMTdO
	 cmJ7ODTkHY8E+shHDrsFz9/pS0t7IsfwM0Rhd5TjBwarIaOBg7hcOH2JkvJc8YXuTI
	 vWlhVWEgT0aJZdcX5vnT9cldXXRODO3PsKZUbFLazbe4GZli78i1g1GCajes5NtRV8
	 jf8IupkRIy+LxwAKaB5IK8p+sm7jxqCzY3/iqFbgLdWI1DYc0Nl/LNH193SCt4qMf7
	 CfJbmHgUW9yHA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FmD3w4Whrz1rxf
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 11:21:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id EE864336BA5
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 11:21:42 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id GXp609mst2TP; Thu, 20 May 2021 11:21:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id ECA8F3363F2;
 Thu, 20 May 2021 11:21:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com ECA8F3363F2
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 9JoGphYqq7IE; Thu, 20 May 2021 11:21:38 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id E138D3369CA;
 Thu, 20 May 2021 11:21:38 -0400 (EDT)
Date: Thu, 20 May 2021 11:21:38 -0400 (EDT)
To: Norbert Lange <nolange79@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <982122605.52445.1621524098787.JavaMail.zimbra@efficios.com>
In-Reply-To: <CADYdroN3FF3Qs_B55s_Un2qOGz3sP=JMpV=QWRFcO7KVzL-8_A@mail.gmail.com>
References: <20210520121807.55428-1-nolange79@gmail.com>
 <1600729511.52338.1621520352970.JavaMail.zimbra@efficios.com>
 <CADYdroN3FF3Qs_B55s_Un2qOGz3sP=JMpV=QWRFcO7KVzL-8_A@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4007)
Thread-Topic: Improve tracelog handling, reduce exported functions
Thread-Index: GslY/UNOys0/jkaoswZB32+9Jp3F7w==
Subject: Re: [lttng-dev] [PATCH lttng-ust] Improve tracelog handling,
 reduce exported functions
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

----- On May 20, 2021, at 10:57 AM, Norbert Lange nolange79@gmail.com wrote:

> Am Do., 20. Mai 2021 um 16:19 Uhr schrieb Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com>:
>>
>> ----- On May 20, 2021, at 8:18 AM, lttng-dev lttng-dev@lists.lttng.org wrote:
>>
>> > Instead of creating functions for each loglevel, simply pass the
>> > callback as argument.
>> >
>> > Further pack all preprocessor information into a struct that
>> > the compiler already can prepare.
>>
>> This introduces an ABI break too late in the cycle.
> 
> So 2.14 would be the next chance I guess

No. The original ABI was introduced about 10 years ago with lttng-ust 2.0,
and lttng-ust 2.13 introduces the first ABI break since. I don't
plan on doing any ABI break in lttng-ust in the foreseeable future.

ABI breaks require that our users recompile all their instrumented
applications, which is really cumbersome for large software deployments.
We don't break ABI lightly.

We should rather introduce new features as extensions (new symbols).

> 
>> Also, I'm not so keen on adding an indirect call on the fast-path
>> when it's not absolutely needed.
> 
> Code seems pretty similar: https://godbolt.org/z/oK1WhWqGT

By fast-path, I also mean:

+        (*callback)(source->file, source->line, source->func, msg, len,
+                LTTNG_UST_CALLER_IP());

Which introduces an indirect call which needs to be taken when tracing
is active.

> 
>> What is wrong with having one symbol per loglevel ?
> 
> Macro-magic is cumbersome to edit, more code, more relocations.

If it was still time for ABI breaks, I would be tempted to consider it
especially given that tracelog and tracef are not expected to be "high-speed",
but now is too late for breaking ABI.

> 
> Easier to adapt aswell, could roll my own tracelog functions while
> using lttng_ust__tracelog_printf (started soind that as I don't want
> to link to lttng-ust.so)

What prevents you from linking against lttng-ust.so again ?

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
