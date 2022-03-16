Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193B0C433F5
	for <lttng-dev@archiver.kernel.org>; Wed, 16 Mar 2022 14:55:00 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KJYGW1dZnzFKV;
	Wed, 16 Mar 2022 10:54:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1647442499;
	bh=rKPLj006XlVdEpW5CoTNuNARL2HtB/lB0F4HBPOUpvs=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=YoMT1fjqxJLsBrT5IG2Obo5PREIAIAHlUOWZaFnZeIQnMzyGYeUhgjBnwwMsVICxo
	 8gSvl5ATm1eTBqch0iP8zEYDMbpcwEcSZ8WsfpSNhhHO5p6psUgB+sz0tnY/MaN78c
	 VnuVAvplxm7ttAZw1o9aP90K996dDbF/mVMluVKHNfUz2XnwAywp005uLmCSzWSj8H
	 5i8+0TcfQ+4ZMgRo7i+Ko6tOg/KOp24nLeWlUOqKUHwIMFCiz/WA2pMUvVbcE6Hqz2
	 /Ygo0QCaa72EOMyK2Nds5EfV8AQSoWYpXjgzETOZd9hJK2W9NLwIz6wQdCmC5SVWxa
	 UNjGrNSqmxLiw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KJYGT4X40zDpZ
 for <lttng-dev@lists.lttng.org>; Wed, 16 Mar 2022 10:54:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 40DF23E6C21
 for <lttng-dev@lists.lttng.org>; Wed, 16 Mar 2022 10:54:51 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id FBSHFbehdex9 for <lttng-dev@lists.lttng.org>;
 Wed, 16 Mar 2022 10:54:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A2DF63E6C20
 for <lttng-dev@lists.lttng.org>; Wed, 16 Mar 2022 10:54:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A2DF63E6C20
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id oHtOVxGZTVxn for <lttng-dev@lists.lttng.org>;
 Wed, 16 Mar 2022 10:54:50 -0400 (EDT)
Received: from [172.16.0.63] (192-222-180-24.qc.cable.ebox.net
 [192.222.180.24])
 by mail.efficios.com (Postfix) with ESMTPSA id 92D853E6C1F
 for <lttng-dev@lists.lttng.org>; Wed, 16 Mar 2022 10:54:50 -0400 (EDT)
Message-ID: <ea1def8e-07af-9bc5-eb0b-7b2bfdb35f09@efficios.com>
Date: Wed, 16 Mar 2022 10:54:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: lttng-dev@lists.lttng.org
References: <CAB9=ZW6FEj+zXnVcSaCGCSWF54cZDEv5_25-F0D1SEZHZaZ=rw@mail.gmail.com>
 <795806806.151478.1647359382157.JavaMail.zimbra@efficios.com>
 <CAB9=ZW6nDGJ+xv+6h4FHL2-63J9YE5P1KoAyvB+yWAx0rr46wA@mail.gmail.com>
 <239772948.153082.1647437108628.JavaMail.zimbra@efficios.com>
In-Reply-To: <239772948.153082.1647437108628.JavaMail.zimbra@efficios.com>
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2022-03-16 09:25, Mathieu Desnoyers via lttng-dev wrote:
> An alternative to query the lttng-modules version, if you really cannot
> install modinfo, would
> be:
> 
> strings /lib/modules/$(uname -r)/extra/lttng-tracer.ko | grep "^version="

Assuming a somewhat recent version of lttng-modules, the version will also be
printed to dmesg when the modules are loaded.
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
