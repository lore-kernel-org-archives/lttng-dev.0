Return-Path: <SRS0=aBhz=CR=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D1DC433E2
	for <lttng-dev@archiver.kernel.org>; Tue,  8 Sep 2020 14:54:29 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B1DE21D82
	for <lttng-dev@archiver.kernel.org>; Tue,  8 Sep 2020 14:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="WSQ2lAbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1DE21D82
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Bm7TZ11bFz96K;
	Tue,  8 Sep 2020 10:54:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1599576867;
	bh=9xLnRlFNruDIc2jQVQlaQwqYjcAHGrcy96lCqlA0uAA=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=WSQ2lAbZ+aA8mc5BqwWq5HQU+EpHZGKB9z/QywqLHEr8lyuP9PrEoR9hsO3EVKkyd
	 dRmm67bGL0Db09FzWdcI8Ea6yTim2iA4AtuDU+5QiKpHVH/cxUZiqxp28bZIetVrsM
	 ZyEJgpU9RPKZAbIGyv0HkZFuO9oI+xTtU6JJj8LkhhRfKoBZd1wFqDZ1iTOCYhsuJ3
	 w2KPdMOG906Hj8HqncFg3wccaxFFbqmyo/af0kSikIvx10YM6RTM5I6641ZkY2vlVr
	 k3x8VB/pkR6PSRsXxi8+ssUnazPP3Nmu4ydzFhIIEUOb7TVxW6PPA/VJeUHuUrsmvc
	 qe0ucFKG+FsYg==
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 by lists.lttng.org (Postfix) with ESMTPS id 4Bm7TX3b29z96J
 for <lttng-dev@lists.lttng.org>; Tue,  8 Sep 2020 10:54:24 -0400 (EDT)
Received: by mail-yb1-xb30.google.com with SMTP id h20so11435296ybj.8
 for <lttng-dev@lists.lttng.org>; Tue, 08 Sep 2020 07:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iwN83UNYZEv/4t+zQl+98ejYtSFCsXTDbk3X044q1yY=;
 b=q/F84o1lkNOEX4FYHazu4KNmAtoi6IfxV2SCZZK7vm0DawHmA9/FT9E8YGDlgYDx+J
 IDbWEfMOKQ458e0W5t3jLc72s4zq6fvsbyZ2q/PCpZCaNpe4gtTdpG17jrLJ6Dm2MrF7
 KyoUN/+U4rZRdD8SSbkjoh/qv3GvIYyDPcScwiDcshqHwo8R5srZPcJSOuNCppUsk13x
 IrT0PgR6GeEI1oZV465h4CnXMGTAfsr4r4ahqnrL/mnkn3hirdVwDkIQDsRp/eKePEkc
 Fs/VO0QNFWz4hmxnrIJFcC0dLbldDMmiIQSSKVoAqjnhxhkwliokzE09qc4uxepi0q4z
 kKUQ==
X-Gm-Message-State: AOAM530wYE9gKC3BEfn8pd0m+NRUV5hqD7jjaJgvpDZvnpSRIkOplNYX
 trelA+lCKDDuHx+Luc9aTgdY/ulzldb45W4EFKE=
X-Google-Smtp-Source: ABdhPJzX9U2w3BzN/oYZ9EzM/hyCGWrksNOGec9wx0C+uS5b/0esdxh3+y1mCauIC68zw/5uLq0glsDUMxKrPNtKSlM=
X-Received: by 2002:a25:3416:: with SMTP id b22mr30886001yba.361.1599576863547; 
 Tue, 08 Sep 2020 07:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAM-pDOyr2VN94eWJahkRX47rTp=YSOwvyZL5iVO2bETaaLx+1Q@mail.gmail.com>
In-Reply-To: <CAM-pDOyr2VN94eWJahkRX47rTp=YSOwvyZL5iVO2bETaaLx+1Q@mail.gmail.com>
Date: Tue, 8 Sep 2020 10:53:57 -0400
Message-ID: <CAB4xu_32eMKy2sndQNtHmVZ4go3rs2Wu-hBv09xjTYu_U8fPGg@mail.gmail.com>
To: Dave Bort <dbort@dbort.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] babeltrace2: reading metadata + events from a
 single CTF file
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
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
Reply-To: Philippe Proulx <eeppeliteloop@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Mon, Sep 7, 2020 at 8:35 AM Dave Bort via lttng-dev
<lttng-dev@lists.lttng.org> wrote:
>
> Hello! I'm adding CTF-compatible tracing to a custom/experimental OS and have a question:
>
> Can babeltrace2 read from a single CTF output file that contains both the metadata stream and the binary trace streams?

No.

>
> My little trace system would like to bundle everything related to a trace into a single file, making it easier to pass around (since there's not much filesystem/network support yet). The CTF spec provides a way to embed the metadata stream in the same bitstream as the data streams, but https://babeltrace.org/docs/v2.0/man7/babeltrace2-source.ctf.fs.7/ says that the `metadata` file needs to be separate. I see that LTTng manages trace output as a collection of files, with a separate `metadata` file.
>
> I'd rather avoid writing a custom tool to find and extract the metadata stream from the full stream before passing the data on to babeltrace2 or TraceCompass, but so far it looks like I may need to.

You will need to.

>
> Would it be appropriate to add support for this to babeltrace2-source.ctf.fs? Or would this warrant a new source.ctf plugin? If I'm going to write some new code to handle this situation, I may as well try to add it to the project.

This would need to be specified at the CTF level.

Storing a CTF trace on the file system as a single file has been
requested a few times, so we _might_ come up with a specified way to do
it as an addendum to CTF 2 (which is on the roadmap, but not
finalized/released yet).

As of CTF 1.8, the de facto standard way to store a trace on the file
system is to write its metadata stream to the `metadata` file and each
individual data stream to its own file of which the name doesn't begin
with `.`. This is also explained in the "Input" section of
`babeltrace2-source.ctf.fs(7)` [1].

>
> Thank you! I'm really looking forward to benefiting from the CTF/babeltrace/LTTng/TraceCompass work you've all done over the years. :)

I can assure you that the EfficiOS team is very glad to hear that.

Phil

[1]: https://babeltrace.org/docs/v2.0/man7/babeltrace2-source.ctf.fs.7/#doc-input

>
> --Dave Bort
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
