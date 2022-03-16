Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D02BC433F5
	for <lttng-dev@archiver.kernel.org>; Wed, 16 Mar 2022 19:48:43 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KJgnP5d9lzFN4;
	Wed, 16 Mar 2022 15:48:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1647460122;
	bh=TCLf3clEFQH+gi9O61D3Ozl+jw8g9mbX9An1bMm/JvI=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=E2Lgyky2fPhT7qyzo54CMnIHKMCiUrWOeXNTfphQkASoIeQUgzxVfHWq5q5JFGzOd
	 K42lPadNbImaCpwDrgIQrSQR8ZC1dHd3Vnht12uxwMepqJe7SLTla4R65y4iYddGRZ
	 2i9N8OAyMqHLbxQsnSzwgzPnmKq9hD4T2d93wtvV+6YajAKbjPHAWjpGgGzOt3gTaZ
	 LYxJm9ck+Bj5k27XeOzJTbPLT/Tyc2Ud7LR5vRaUqtkMWcO86EtvNlEn4mZ2ThNtmQ
	 SBx42zscbIPT4C2qooyeHnOhguF8IAjLRLpF5+n+t5OQWOAGpH8UzVMvLsMSttZtp2
	 J8KVh6boLSHKw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KJgnN6C2wzFHy
 for <lttng-dev@lists.lttng.org>; Wed, 16 Mar 2022 15:48:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4B8063E9121;
 Wed, 16 Mar 2022 15:48:28 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id PJYYoRRrgEEF; Wed, 16 Mar 2022 15:48:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B5CB43E9020;
 Wed, 16 Mar 2022 15:48:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B5CB43E9020
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id qIrNyxNguRmx; Wed, 16 Mar 2022 15:48:27 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id AC9773E901F;
 Wed, 16 Mar 2022 15:48:27 -0400 (EDT)
Date: Wed, 16 Mar 2022 15:48:27 -0400 (EDT)
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1022626074.154650.1647460107562.JavaMail.zimbra@efficios.com>
In-Reply-To: <ea1def8e-07af-9bc5-eb0b-7b2bfdb35f09@efficios.com>
References: <CAB9=ZW6FEj+zXnVcSaCGCSWF54cZDEv5_25-F0D1SEZHZaZ=rw@mail.gmail.com>
 <795806806.151478.1647359382157.JavaMail.zimbra@efficios.com>
 <CAB9=ZW6nDGJ+xv+6h4FHL2-63J9YE5P1KoAyvB+yWAx0rr46wA@mail.gmail.com>
 <239772948.153082.1647437108628.JavaMail.zimbra@efficios.com>
 <ea1def8e-07af-9bc5-eb0b-7b2bfdb35f09@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF98 (Linux)/8.8.15_GA_4232)
Thread-Topic: call trace while using lttng in petalinux 2019.2 (kernel 4.19)
Thread-Index: 4o2B6IGfZ24ZJELIqrokrht7Dv5jSw==
Subject: Re: [lttng-dev] call trace while using lttng in petalinux 2019.2
 (kernel 4.19)
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- On Mar 16, 2022, at 10:54 AM, lttng-dev lttng-dev@lists.lttng.org wrote:

> On 2022-03-16 09:25, Mathieu Desnoyers via lttng-dev wrote:
>> An alternative to query the lttng-modules version, if you really cannot
>> install modinfo, would
>> be:
>> 
>> strings /lib/modules/$(uname -r)/extra/lttng-tracer.ko | grep "^version="
> 
> Assuming a somewhat recent version of lttng-modules, the version will also be
> printed to dmesg when the modules are loaded.

This "LTTng: Loaded modules..." printk was added in v2.9.10 in the stable-2.9 branch of
lttng-modules. I suspect that the version of lttng-modules is even older here.

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
