Return-Path: <SRS0=ctY1=KA=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F341BC433ED
	for <lttng-dev@archiver.kernel.org>; Wed,  5 May 2021 02:03:34 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0877F613B4
	for <lttng-dev@archiver.kernel.org>; Wed,  5 May 2021 02:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0877F613B4
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FZg3m3LHMz1h2n;
	Tue,  4 May 2021 22:03:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1620180212;
	bh=Zgwq91aU7xixqSw2L/odjlB389ujJvDYwhX/FdFqARU=;
	h=To:References:Date:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=F81uW5EkDMcsOaNRWmJmVlzdiROQOXTs4ta5/j35xgPaYVf2CXBE6nBOzHShsISoC
	 fzuHFrbOk7BX1bFjOP3uR3cf2JyH/prO4Mfg+wxZtuoregFpLi5vUS73DmZMj9hvTr
	 T4A20YpK5V3IFbQbac6P2wpExU/fuoGyDhEd4bhAQTQgadvqPQswKVVrKQTaIZ/73H
	 pQE7J5mGTajabC6kudtSNlV3UpMIec+VjQMGIwcQ3o84jP2KUzri2eMut/PphrS7BQ
	 sJK+GKqGtlNXQpnwLxpy2NWgJKDPJQj+Ug9b0kMZAnRXIMLr27n3gd18Ep1bqFMlXO
	 2ZfsSGDgGrU6w==
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
 by lists.lttng.org (Postfix) with ESMTPS id 4FZg3k3YWyz1hMQ
 for <lttng-dev@lists.lttng.org>; Tue,  4 May 2021 22:03:30 -0400 (EDT)
Received: from simark.ca (simark.ca [158.69.221.121]) (authenticated bits=0)
 by smtp.polymtl.ca (8.14.7/8.14.7) with ESMTP id 1451vEMJ019262
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT); 
 Tue, 4 May 2021 21:57:19 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.polymtl.ca 1451vEMJ019262
Received: from [10.0.0.11] (192-222-157-6.qc.cable.ebox.net [192.222.157.6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by simark.ca (Postfix) with ESMTPSA id 6652E1E01F;
 Tue,  4 May 2021 21:57:14 -0400 (EDT)
To: Dimitri Scheftelowitsch <dimitri.scheftelowitsch@esrlabs.com>,
 lttng-dev@lists.lttng.org
References: <CANQXvtRR1HvzQkwmzH_HMGGJjx2PP_XAiOgLZxjMWbuyhzjH6g@mail.gmail.com>
Message-ID: <69a2d37a-d60d-deba-02d2-c3084f62b84f@polymtl.ca>
Date: Tue, 4 May 2021 21:57:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CANQXvtRR1HvzQkwmzH_HMGGJjx2PP_XAiOgLZxjMWbuyhzjH6g@mail.gmail.com>
Content-Language: en-US
X-Poly-FromMTA: (simark.ca [158.69.221.121]) at Wed, 5 May 2021 01:57:14 +0000
Subject: Re: [lttng-dev] Babeltrace trimmer segfaults on custom trace
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
From: Simon Marchi via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Simon Marchi <simon.marchi@polymtl.ca>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2021-05-04 10:21 a.m., Dimitri Scheftelowitsch via lttng-dev wrote:
> 
> Hi,
> 
> as mentioned on the IRC channel, babeltrace2 (both HEAD and current release in the lttng Ubuntu 20 repo) aborts with a violated precondition in `bt_clock_snapshot_get_ns_from_origin` on some custom traces we created. One of these traces is attached. It seems that the offending message is of type `BT_MESSAGE_TYPE_PACKET_BEGINNING`. What is confusing is that the pretty-printer does not seem to be influenced by this, and furthermore, I am not sure that this type of message actually requires a timestamp (at least if I understood the CTF spec correctly). Is this an issue with the trace itself or rather with babeltrace2?
> 
> To reproduce: `babeltrace2 nvctf --timerange="17:09:13.034123470,17:29:18.034216302"`.
> 
> Any help would be appreciated.

Hi Dimitri,

Thanks for providing a trace, the issue was very easy to reproduce.

There are indeed some missing checks in the trimmer code and the lib
code to avoid hitting some asserts when dealing with packets that have
no timestamps (clock snapshots).  I have a beginning of a patch here:

  https://review.lttng.org/c/babeltrace/+/5677

However, once that is fixed, I hit:

  https://github.com/efficios/babeltrace/blob/534d93a8b2ba86f56dfdf6aa7a10911da5f6432c/src/plugins/utils/trimmer/trimmer.c#L1284-L1290

If the trace has packets, the trimmer component currently requires
packets to have timestamps.   It would be possible for the trimmer to
support packet messages without timestamps, but support for it is not
implemented right now.  I tried to see if it would be possible for you
to just not use packets, but unfortunately I stumbled on what looks like
a bug in the CTF metadata parser, it hardcodes whether streams classes
have packets to true:

  https://github.com/efficios/babeltrace/blob/534d93a8b2ba86f56dfdf6aa7a10911da5f6432c/src/plugins/ctf/common/metadata/ctf-meta-translate.c#L576

So when I tried removing the packet from your trace, trimmer was still
unhappy about it.

The easiest immediate fix for you would probably be to add some
timestamps to your packets.  Looking at an LTTng trace, we can see:

struct packet_context {
        uint64_clock_monotonic_t timestamp_begin;
        uint64_clock_monotonic_t timestamp_end;
        uint64_t content_size;
        uint64_t packet_size;
        uint64_t packet_seq_num;
        unsigned long events_discarded;
        uint32_t cpu_id;
};

and

stream {
        id = 0;
        event.header := struct event_header_large;
        packet.context := struct packet_context;
};

So you can try adding a packet context with the two "timestamp" fields.
Just make sure that timestamp_begin is <= your first event's timestamp
and timestamp_end is >= your last event's timestamp.

And of course, the other option is to fix Babeltrace, if you have some
cycles to spare.

Simon
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
