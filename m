Return-Path: <SRS0=0zlt=6M=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5479C83000
	for <lttng-dev@archiver.kernel.org>; Tue, 28 Apr 2020 18:54:54 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 712E320575
	for <lttng-dev@archiver.kernel.org>; Tue, 28 Apr 2020 18:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="q/lo8SnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712E320575
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49BW6P2w9Fz1mwr;
	Tue, 28 Apr 2020 14:54:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1588100093;
	bh=Ol/Kb+t7T07CtCppRhgHJbpr1qQEsDwosj3KlE+6M4E=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=q/lo8SnBtmkLhJMDpXjZ5MSuUn74Mt5KmibW7gAp8QlNiEQOgyDOVxlF/vywR0MRt
	 QcF/+GdVF+oaQQtylddW1c84vahfjkV5x7mC3Ur6qXnaB3uslaO2Ftq+Z+qEAzgk1w
	 H8MhnkmuDss9sST4CphBDmscMZoRYfcLS7pk56hsoRl9TgI7xN62bJgbtNUybX6pSA
	 qG94c5Hvuhk/XQFENP/gmVnX4XfB6MwQc347ACLBlQBbWeN09+8e/AY0x+UJX35Z9l
	 Z/YVmB+ZTrrGv2zTN/rgM9GlY9Yf2ARdSICs7CxwhL6yU2/+f7eHuAivqqwhNkBnU/
	 85FIVzRgIwvGw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49BW6M41mzz1n4v
 for <lttng-dev@lists.lttng.org>; Tue, 28 Apr 2020 14:54:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E2DDE27F571;
 Tue, 28 Apr 2020 14:54:45 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id GmZ4f-10pnFP; Tue, 28 Apr 2020 14:54:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9A82627F723;
 Tue, 28 Apr 2020 14:54:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9A82627F723
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id oP1Ptg9dnPNp; Tue, 28 Apr 2020 14:54:45 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 8A9D127F81D;
 Tue, 28 Apr 2020 14:54:45 -0400 (EDT)
Date: Tue, 28 Apr 2020 14:54:45 -0400 (EDT)
To: Philippe Proulx <pproulx@efficios.com>
Message-ID: <252145848.72946.1588100085527.JavaMail.zimbra@efficios.com>
In-Reply-To: <1480394831.72907.1588099321783.JavaMail.zimbra@efficios.com>
References: <20200423205226.496-1-mathieu.desnoyers@efficios.com>
 <20200423205226.496-3-mathieu.desnoyers@efficios.com>
 <1480394831.72907.1588099321783.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: Clarify monotonicity requirement on timestamp begin
Thread-Index: N6AKTdmIChPLgLNAHcYNiDvUTQN2wETvbhnO
Subject: Re: [lttng-dev] [RFC PATCH CTF 2/3] Clarify monotonicity
 requirement on timestamp begin
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.29
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
Cc: Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>,
 Genevieve Bastien <gbastien+lttng@versatic.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200428185445.kQa98SdG8tjzT5C511MXyTgbTQcBj8AGYEw6Kok1cAM@z>

----- On Apr 28, 2020, at 2:42 PM, Philippe Proulx pproulx@efficios.com wrote:

> ----- Original Message -----
>> From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
>> To: "gbastien+lttng" <gbastien+lttng@versatic.net>, "Matthew Khouzam"
>> <matthew.khouzam@ericsson.com>,
>> diamon-discuss@linuxfoundation.org, pproulx@efficios.com, "Jeremie Galarneau"
>> <jgalar@efficios.com>
>> Cc: "lttng-dev" <lttng-dev@lists.lttng.org>, "Mathieu Desnoyers"
>> <mathieu.desnoyers@efficios.com>
>> Sent: Thursday, 23 April, 2020 16:52:25
>> Subject: [RFC PATCH CTF 2/3] Clarify monotonicity requirement on timestamp begin
> 
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> ---
>> common-trace-format-specification.md | 10 ++++++----
>> 1 file changed, 6 insertions(+), 4 deletions(-)
>> 
>> diff --git a/common-trace-format-specification.md
>> b/common-trace-format-specification.md
>> index f5fea51..53b70f4 100644
>> --- a/common-trace-format-specification.md
>> +++ b/common-trace-format-specification.md
>> @@ -836,10 +836,12 @@ TSDL metadata):
>>     range between these timestamps should include all event timestamps
>>     assigned to events contained within the packet. The timestamp at the
>>     beginning of an event packet is guaranteed to be below or equal the
>> -    timestamp at the end of that event packet. The timestamp at the end
>> -    of an event packet is guaranteed to be below or equal the
>> -    timestamps at the end of any following packet within the same stream.
>> -    See [Clocks](#spec8) for more detail.
>> +    timestamp at the end of that event packet. The timestamp at the
>> +    beginning of an event packet is guaranteed to be above or equal the
> 
> "greater than or equal to"

done

> 
>> +    timestamps at the beginning of any prior packet within the same
>> +    stream. The timestamp at the end of an event packet is guaranteed to
>> +    be below or equal the timestamps at the end of any following packet
> 
> "less than or equal to"

done,

Thanks!

Mathieu

> 
> Phil
> 
>> +    within the same stream. See [Clocks](#spec8) for more detail.
>>   * **Events discarded count**. Snapshot of a per-stream
>>     free-running counter, counting the number of events discarded that
>>     were supposed to be written in the stream after the last event in
>> --
> > 2.11.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
