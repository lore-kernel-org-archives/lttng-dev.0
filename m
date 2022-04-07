Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D011C433F5
	for <lttng-dev@archiver.kernel.org>; Thu,  7 Apr 2022 00:57:03 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KYjdT57zgz2bK;
	Wed,  6 Apr 2022 20:57:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1649293022;
	bh=BDciyR1SIBlkZ6hbs1KcinB1FYSBKJSl6vSo/rJ5vpg=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=BUh33asLThGKvIV3vL/MryfdCqFTUfgiNnsy2CxGPqQPAo+LzOmWlvu+aTQdWmrye
	 EkLEymb8GIG0Ubp2+VRA4XVFzJpDtg4Nr85NE30MuINkNaOw2Aj7d6M6BmeEfDzgF1
	 20YO0hQmsS7vUM9nKIq6bZ+3upQryhVo8ngxvfXMVBNDZhIopQFXst94ABRfPXV4U+
	 8jW1iWQAK5iGOTnBPpTB7497ykmXU/W8l9h0DWt+Vgl6aDrvQ/W0uv9nI21RkjzRwb
	 nI8e2IefonrR4e3je1/FzSMwMPDVWzpSpB8q8EdSIeZr8ON45HhhXvS95R1N+u+an4
	 HwgU0VZRmAWIw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KYjdS3Z1Tz2NR
 for <lttng-dev@lists.lttng.org>; Wed,  6 Apr 2022 20:57:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2A1173C7FAB
 for <lttng-dev@lists.lttng.org>; Wed,  6 Apr 2022 20:56:54 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id TybMsui8HKXJ; Wed,  6 Apr 2022 20:56:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 86BB63C7EAE;
 Wed,  6 Apr 2022 20:56:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 86BB63C7EAE
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id uRCQgO9sRncL; Wed,  6 Apr 2022 20:56:53 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 791253C7D46;
 Wed,  6 Apr 2022 20:56:53 -0400 (EDT)
Date: Wed, 6 Apr 2022 20:56:53 -0400 (EDT)
To: Aprameya Rao <Aprameya.Rao@microsoft.com>
Cc: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>, 
 lttng-dev <lttng-dev@lists.lttng.org>, 
 tracecompass-dev <tracecompass-dev@eclipse.org>, 
 Eric Warden <ericwarden@microsoft.com>
Message-ID: <646071879.8391.1649293013412.JavaMail.zimbra@efficios.com>
In-Reply-To: <SN6PR2101MB13433DE20434FDD6FECC80B681E69@SN6PR2101MB1343.namprd21.prod.outlook.com>
References: <1481555190.3990.1649187227493.JavaMail.zimbra@efficios.com>
 <SN6PR2101MB13433DE20434FDD6FECC80B681E69@SN6PR2101MB1343.namprd21.prod.outlook.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4257 (ZimbraWebClient - GC97 (Linux)/8.8.15_GA_4257)
Thread-Topic: CTF2-SPECRC-5.0
Thread-Index: nMgR3zVo89XTXbOJAaCfWCEdSjUhvKBwdNbwPCr3JJc=
Subject: Re: [lttng-dev] CTF2-SPECRC-5.0
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
From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Philippe Proulx <pproulx@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- Original Message -----
> From: "Aprameya Rao" <Aprameya.Rao@microsoft.com>
> To: "Philippe Proulx" <pproulx@efficios.com>, "diamon-discuss" <diamon-discuss@lists.linuxfoundation.org>, "Eric Warden"
> <ericwarden@microsoft.com>
> Cc: "lttng-dev" <lttng-dev@lists.lttng.org>, "tracecompass-dev" <tracecompass-dev@eclipse.org>
> Sent: Wednesday, 6 April, 2022 20:51:33
> Subject: RE: CTF2-SPECRC-5.0

> Hi
> 
> Is there a document that provides a diff between CTF1 and CTF2?

The CTF 2 specification proposal does; see
<https://diamon.org/ctf/files/CTF2-PROP-2.0rA.html#_changes_since_ctf1>.

There have been minor changes between CTF2-PROP-2.0 and CTF2-SPECRC-5.0;
see the "Revision history" section of CTF2-SPECRC-5.0 to learn more.

Philippe Proulx
EfficiOS Inc.
https://www.efficios.com/

> 
> Thanks
> Aprameya
> 
> -----Original Message-----
> From: lttng-dev <lttng-dev-bounces@lists.lttng.org> On Behalf Of Philippe Proulx
> via lttng-dev
> Sent: Wednesday, April 6, 2022 1:04 AM
> To: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>
> Cc: lttng-dev <lttng-dev@lists.lttng.org>; tracecompass-dev
> <tracecompass-dev@eclipse.org>
> Subject: [EXTERNAL] [lttng-dev] CTF2-SPECRC-5.0
> 
> Hello,
> 
> This is an update of the CTF 2 specification release candidate from
> v4.0 to v5.0.
> 
> This document, named CTF2-SPECRC-5.0, is available here:
> 
>    <https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdiamon.org%2Fctf%2Ffiles%2FCTF2-SPECRC-5.0.html&amp;data=04%7C01%7Caprameya.rao%40microsoft.com%7C4bfcea22579c423d02be08da173b38b1%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637847840395810150%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=A%2Fyq3aTYQqYaqpfvlL9k17oLOuYm6OxWLMryIKFZnIQ%3D&amp;reserved=0>
> 
> See the first section, "Revision history", to learn what changed.
> 
> As always, please feel free to provide feedback.
> 
> Philippe Proulx
> EfficiOS Inc.
> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fefficios.com%2F&amp;data=04%7C01%7Caprameya.rao%40microsoft.com%7C4bfcea22579c423d02be08da173b38b1%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637847840395810150%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=AhDC1Ux4VudGgiah363vlBDTOmHyc9yJXLH1ccE6Bz8%3D&amp;reserved=0
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.lttng.org%2Fcgi-bin%2Fmailman%2Flistinfo%2Flttng-dev&amp;data=04%7C01%7Caprameya.rao%40microsoft.com%7C4bfcea22579c423d02be08da173b38b1%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637847840395810150%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=ORy9ounXHajWfDfpa6dkokRZC0pkIVJ6s2r0TL4tYr8%3D&amp;reserved=0
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
