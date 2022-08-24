Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E0BC00140
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Aug 2022 15:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1661356578;
	bh=7/Iv6rr3z3aDMj87+cAJ8rapmiQubTAe8YYbth79TBg=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=A6VT4XxdKtdyoFub78+Jg8w0+yCUuAN5Brk7lrB8DKh3u+GloCBIi4QUG8ykmTPrw
	 7w82BV97AdHvSLwtjTgU1AtFYg0F8aIids1ExD3AA+WaVMkwSQXgHTlO3KRvJ6M8cl
	 jldTfEa4hYB2QYnw+QEX/wm1B71m+F2zr5bhrEqR4Iouw2iH2uSrVAVSUPH5w5oZu6
	 hMixP6Rmh/YdaC1s6ybGCQkJVVA2xkoV28sexzWhC9Yk+ryWQIdsp2K+UQUo8N2/1d
	 zht07yZtIIMAWKS/ffA9jidfBmKhWHj+y5a1l3Kp/w3mprk5TjkiLfuHUeSWsZLKUj
	 vHe2qScPOtjuA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MCW0x680bz1Mh3;
	Wed, 24 Aug 2022 11:56:17 -0400 (EDT)
Received: from simark.ca (simark.ca [158.69.221.121])
 by lists.lttng.org (Postfix) with ESMTPS id 4MCW0w2vcQz1N6W
 for <lttng-dev@lists.lttng.org>; Wed, 24 Aug 2022 11:56:16 -0400 (EDT)
Received: from [172.16.0.64] (192-222-180-24.qc.cable.ebox.net
 [192.222.180.24])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by simark.ca (Postfix) with ESMTPSA id 9D0A51E21F;
 Wed, 24 Aug 2022 11:56:09 -0400 (EDT)
Message-ID: <9464af1b-abd9-16ad-886d-d1bfb7a88b8d@simark.ca>
Date: Wed, 24 Aug 2022 11:56:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: fr
To: Maksim Khmelevskiy <mk.void.mail@gmail.com>
Cc: lttng-dev@lists.lttng.org
References: <CACXehJBBkAm-7U2fwOd-qaGE5OgbsAZEci5v57XkmUp=7vtKNA@mail.gmail.com>
 <87a1bad5-9942-3d6a-9726-1e4e74bea4d2@simark.ca>
 <CACXehJA_FDBvnyUTSJ7k0fOOcFgPbr-7s9m-J8kdNVn=Vk28Xw@mail.gmail.com>
In-Reply-To: <CACXehJA_FDBvnyUTSJ7k0fOOcFgPbr-7s9m-J8kdNVn=Vk28Xw@mail.gmail.com>
Subject: Re: [lttng-dev] C API message iterator example for libbabeltrace2
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
From: Simon Marchi via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Simon Marchi <simark@simark.ca>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 8/20/22 12:14, Maksim Khmelevskiy via lttng-dev wrote:
> Hi Simon,
> thanks for the reply!

> What I came up with for now is this example
> <https://github.com/ImMax/babeltrace/commit/2082a0f4d77d2edeec6fb95c308a79fb313f7a02>.
> It's probably has a lot of design mistakes but it's at least runnable.

Looks like a good prototype, it seems right.  Some hopefully
constructive comments:

 - You can probably use bt_plugin_find to find a plugin by name instead
   of your code that does it by hand
 - When you instantiate a src.ctf.fs component, it may have more than
   one port (there is one port per data stream), in which case you want
   to connect them all to a flt.utils.muxer component (which is what the
   CLI and the Python TraceCollectionMessageIterator class do) to funnel
   all the messages to a single output port.  Of course, if you know
   the CTF traces you deal with have a single data stream, that is not
   necessary.

> I also see that examples for C API aren't build, but maybe I'm wrong.

C API examples in the documentation indeed aren't built.

> Another thing, if you have lack of resources I would be happy to help, I could make a PR with your guidance and review.
>

> Answers to the questions:
> 1) Not sure that I completely understand the question, I wanted to parse events(name, fields), not the metadata file aligned with the CTF trace file.
> 2) Because I wanted to get C-structs directly from the CTF traces. I'm sure that it's very niche requirement, sane people would not need it.
> 3) I would do something like that, but I have a requirement of providing C structs. I guess to apply filters or do something else with traces (I'm not sure, not my idea, but I also find it weird)

Ok, I understand.  When you said you need to write "C structs", I
thought you meant that you needed to output some generated C code, for
instance convert event types to structures, for use in a program later.
But that's not the case, you want to take event payload and fill out
some structures at runtime, from what I can see.  That explains why you
want to use the C API and why you want to create and run a graph in your
own application.

Following your questions, I have written an example of creating and
running a graph, which I just submitted for review here:

  https://review.lttng.org/c/babeltrace/+/8741

It is roughly equivalent to this Python example:

  https://babeltrace.org/docs/v2.0/python/bt2/examples.html#build-and-run-a-trace-processing-graph

Simon
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
