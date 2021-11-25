Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBCBC433EF
	for <lttng-dev@archiver.kernel.org>; Thu, 25 Nov 2021 19:18:45 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4J0SN35Wtpz1mvd;
	Thu, 25 Nov 2021 14:18:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1637867924;
	bh=mjC5tgmbbwX2aUBt1piCBX+WSWsBTKshrUpiZTQw75I=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=txYLhnHcUVvRSAc+5vNrrg0IhBucaWKm6mM+4JLhC+F1zzEepkCqMosdQSvG1wK5k
	 LHkdSQ5XYFa2jBxsadeTdjHEFzDL4n5/Dt3wj6r/mmI/D7KGDUct8l1EfvUrhXS+6E
	 Nl2dnvstURFFGPIkj+IOdtcfPGlHfwR0ZQAQYu5gfLDPXIKQzeU8w0PbQgXNpi1d2z
	 6/ZSHZ8Cx4LVesIJ7Dx3suE/buA8Mv6P7/299iLjRYFrF4XL777iiPWC5xzQDVaqAC
	 FuTgAm07Ij2s1bZeJ4xPhD1NtVKM2TuWytWS5/KcVsA/w34/rcI0X8Kl+pv/kzeZyE
	 GXparyefJga4A==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4J0SN30TxJz1mf8
 for <lttng-dev@lists.lttng.org>; Thu, 25 Nov 2021 14:18:42 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id AD55D3BFE7E
 for <lttng-dev@lists.lttng.org>; Thu, 25 Nov 2021 14:18:36 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id q7OeUVStFx8z; Thu, 25 Nov 2021 14:18:36 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1AA79270552;
 Thu, 25 Nov 2021 14:18:36 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1AA79270552
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id FKCUZzuPproi; Thu, 25 Nov 2021 14:18:36 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 101993BFAFF;
 Thu, 25 Nov 2021 14:18:36 -0500 (EST)
Date: Thu, 25 Nov 2021 14:18:36 -0500 (EST)
To: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, 
 tracecompass-dev <tracecompass-dev@eclipse.org>
Message-ID: <2054450980.2273.1637867916015.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4173 (ZimbraWebClient - GC95 (Linux)/8.8.15_GA_4177)
Thread-Index: 3UObKDqnbyO/9q2A21hQbemfxExd3Q==
Thread-Topic: CTF2-SPECRC-1.0: Common Trace Format version 2 release candidate
Subject: [lttng-dev] CTF2-SPECRC-1.0: Common Trace Format version 2 release
 candidate
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
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

Hello,

Today we're releasing the first release candidate of the Common Trace
Format version 2 specification.

This document, named CTF2-SPECRC-1.0, is available here:

    <https://diamon.org/ctf/files/CTF2-SPECRC-1.0.html>

To write CTF2-SPECRC-1.0, many parts of CTF2-PROP-2.0rA [1] were
modified to make the text more easily understood and to formalize some
procedures. I also added a few diagrams to help understand the binary
layout of some fields.

Moreover, the metadata stream and auxiliary streams are now JSON text
sequences [2] instead of a single JSON array/object. This makes decoding
a streamed version of such input easier using any JSON parser, for
example to meet the needs of use cases similar to LTTng live [3].

Feel free to provide feedback!

Philippe Proulx
EfficiOS Inc.
https://efficios.com/

[1]: https://diamon.org/ctf/files/CTF2-PROP-2.0rA.html
[2]: https://datatracker.ietf.org/doc/html/rfc7464
[3]: https://lttng.org/docs/#doc-lttng-live
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
