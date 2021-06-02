Return-Path: <SRS0=vCtj=K4=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2348C47083
	for <lttng-dev@archiver.kernel.org>; Wed,  2 Jun 2021 13:07:00 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C08961263
	for <lttng-dev@archiver.kernel.org>; Wed,  2 Jun 2021 13:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C08961263
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Fw8SK4PCwz5d9;
	Wed,  2 Jun 2021 09:06:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1622639218;
	bh=/m/IpZW2oQrjIkLRkS6sbvYf933AC8WgFh0yFZoj9EA=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=thUoa/9mwUmduV9XjVAVKxilELwf1/Wl0AMGo3fS/BzmjXB5RjeWENzCBcr2R3YFi
	 vwRNPQRivX/VSpdmresPeMH9K/cbVSgW1KjegoQf6cXBhZs7SUhteW1fOeJUzcKOY0
	 zVLj7h6+sOPgYD51QI7LLKxSsNk4bxVLdUolpqLd7vIPzg35eiPTQZuWFdS2O68Ceh
	 ZqgW96l98fwnUiomB8AOEmQ9+zBOIwflYTumvW708YYExDC03D0l0He4TmxFa0wQK4
	 YiTONWpMBOM8s/kx3TgKH8gPwTKxlYl5FjC78et51IGKao2talX3pG1yIGJkoHBEv8
	 RqUYoMPwkdBkA==
Received: from smtp.avcs-au.com (unknown [144.130.96.35])
 by lists.lttng.org (Postfix) with ESMTP id 4FvyYJ5F4rz5pB
 for <lttng-dev@lists.lttng.org>; Wed,  2 Jun 2021 01:40:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by pac.avcs-au.com (Postfix) with ESMTP id 0386111A6FDF;
 Wed,  2 Jun 2021 15:40:23 +1000 (AEST)
X-Virus-Scanned: amavisd-new at avcs-au.com
Received: from smtp.avcs-au.com ([127.0.0.1])
 by localhost (smtp.avcs-au.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id n2IF0c88PnLr; Wed,  2 Jun 2021 15:39:59 +1000 (AEST)
Received: from HPOmenPAC (unknown [192.168.100.145])
 by smtp.avcs-au.com (Postfix) with ESMTP id 253CD11A6FEC;
 Wed,  2 Jun 2021 15:39:59 +1000 (AEST)
To: "'Jonathan Rajotte-Julien'" <jonathan.rajotte-julien@efficios.com>,
 <public@triplanets.com>
Cc: <lttng-dev@lists.lttng.org>
References: <00e701d7567f$cd20c070$67624150$@triplanets.com>
 <20210601185615.GA388028@joraj-alpa>
In-Reply-To: <20210601185615.GA388028@joraj-alpa>
Date: Wed, 2 Jun 2021 15:40:04 +1000
Message-ID: <011201d75771$bd096730$371c3590$@triplanets.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH4tUIHLekF39bi8lAALZ2oRjjeLwGRJt++qrC2SdA=
Content-Language: en-au
X-Mailman-Approved-At: Wed, 02 Jun 2021 09:06:55 -0400
Subject: Re: [lttng-dev] Syntax error running lttng
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
From: Paul Coward via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Paul Coward <paul@triplanets.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

Thank you for the response.

I have it installed on a small ARM computer that does not feature many
tools, specifically file & which are missing.

I don't have any shell aliases and the output of find is:
    ~ # find / -name "lttng" 2>/dev/null
    /mnt/sd1/modulesLTTNG/lttng
    /mnt/sd1/modulesLTTNG/lttng/usr/local/bin/lttng
    /mnt/sd1/modulesLTTNG/lttng/usr/local/lib/lttng
    ~ #
Limiting it to finding files is only the one:
    ~ # find / -name "lttng" -type f 2>/dev/null
    /mnt/sd1/modulesLTTNG/lttng/usr/local/bin/lttng
    ~ #

head -n 10 /mnt/sd1/modulesLTTNG/lttng/usr/local/bin/lttng
    outputs binary, examining it on the build computer shows it is an ELF
executable built for ARM

I didn't set up the shell so that could be questionable, but I'm not sure
exactly how.

I couldn't find that error message in the lttng source but to me it looked a
little like errors I have seen from libXML (possibly reaching for straws).

The error message looks like it is trying to read some sort of configuration
file and failing.


This is a link to the config.log
https://drive.google.com/file/d/1_3QQEbfMcnS2_jX-MzJFO1JdGAArRRwW/view?usp=s
haring

I don't have the make output available at the moment but I can regenerate it
tomorrow if it will help.



-----Original Message-----
From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com> 
Sent: Wednesday, 2 June 2021 04:56
To: public@triplanets.com
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] Syntax error running lttng

Hi,

On Tue, Jun 01, 2021 at 10:48:13AM +1000, Merlin via lttng-dev wrote:
> Hi,
> 
>  
> 
> I have compiled LTTNG for ARM but when I try to run the executable, I 
> get this error:

Do you have any of the logs for the lttng-tools project?

That would be `config.log` and the output from `make` and `make install`

> 
>  
> 
> lttng: line 1: syntax error: unexpected "("

Hmmm that does not look like an error from a elf executable.

Do you have any bash or shell alias for the lttng command?

Please provide the output of the following commands:
  $ file $(which lttng)
  $ head -n 10 $(which lttng)



> lttng-sessiond

If this happens also on the `lttng-sessiond` via command line but works
using a service, it would point to weird shell setup.
> 
>   all produce the same error.
> 
>  
> 
> There were no compiler errors.  I am at a loss to understand what it 
> is complaining about from the message.

Me too.

> 
>  
> 
> Modules seem to load fine.

Modules are loaded by the lttng-sessiond executable. Here only the CLI
executable seems to be having some problem.

--
Jonathan Rajotte-Julien
EfficiOS

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
