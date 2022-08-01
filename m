Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D0FC00144
	for <lttng-dev@archiver.kernel.org>; Mon,  1 Aug 2022 15:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1659367470;
	bh=EAQhixzFvj41TVVMGLlahLIUtz1p9IwK/uEDMwC+2SM=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=SN5tgk4ywHbFhVtplK/f3j+d9WSvrewwy0AdP8xMV5AMhAB9HyrNbJMm1ReF+0p+p
	 dA+nV20a7U7zh4NewtgszqVP4opqypGN7CZH+tfI8Crhb+XwzF0pcGXWPQuPhqluI3
	 i7XD2vc1b6XofTEYxM+QDnfdI2mK0dPIHnt+aCe1/R3nz/AkGya7C6LS/kcidA/zN0
	 snGrVMb7bl054HU4sQP2VKeDJGDYK30vLMqImb+v92ZcXF9+ZgZ9NpKm+tfWMd/zxi
	 Qwhe3Cy3k9t0OPgCNgyU1RZx5kO9DBmHweG7N7xdgOQF8zG1c0kxCZCWL++z0bmA5/
	 fBcqBXzMP6x3w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LxMNt0TtGz10yy;
	Mon,  1 Aug 2022 11:24:30 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4LxMNr6Dl4z11Gh
 for <lttng-dev@lists.lttng.org>; Mon,  1 Aug 2022 11:24:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 42669355650
 for <lttng-dev@lists.lttng.org>; Mon,  1 Aug 2022 11:24:28 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id j0AmGEC_RLM7; Mon,  1 Aug 2022 11:24:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E606A35582F;
 Mon,  1 Aug 2022 11:24:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E606A35582F
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 1U4p87VQX_lZ; Mon,  1 Aug 2022 11:24:27 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id DAE4135582E;
 Mon,  1 Aug 2022 11:24:27 -0400 (EDT)
Date: Mon, 1 Aug 2022 11:24:27 -0400 (EDT)
To: Norbert Lange <nolange79@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1848659433.93617.1659367467800.JavaMail.zimbra@efficios.com>
In-Reply-To: <CADYdroPCRa92zKoAQfB+DW4vte-srd4+w+=vbLZN_eqwdSXZMw@mail.gmail.com>
References: <20220801143524.160208-1-norbert.lange@andritz.com>
 <CADYdroPCRa92zKoAQfB+DW4vte-srd4+w+=vbLZN_eqwdSXZMw@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4304)
Thread-Topic: Improve tracef/tracelog to use the stack for small strings
Thread-Index: SafkODUwtWhglENnx/QBbqM7VV173w==
Subject: Re: [lttng-dev] [PATCH v2] Improve tracef/tracelog to use the stack
 for small strings
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

----- On Aug 1, 2022, at 10:44 AM, Norbert Lange via lttng-dev lttng-dev@lists.lttng.org wrote:
[...]
> 
> Any chance of not having to link liblttng-ust for the tracelog/tracef functions,
> like all other tracepoints (only hard dependency on liblttng-ust-tracepoint)?
> My involvement is limited to "complain-only" for that one, but think of
> how technically great that would be!

Here is how we could do this:

1) move the implementation of src/lib/lttng-ust/tracelog.c to its own .so, e.g.
   liblttng-ust-tracelog.so,
2) modify the tracelog/tracef public headers so they dlopen() this new .so from
   a library constructor, similarly to what tracepoint.h does.

We'd need to make sure the symbols from tracelog.c are still emitted in
liblttng-ust.so, _and_ have another version (with a prefix/suffix) emitted from
liblttng-ust-tracelog.so, so we don't break ABI.

Thoughts ?

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
