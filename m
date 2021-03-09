Return-Path: <SRS0=0DGv=IH=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA921C433E0
	for <lttng-dev@archiver.kernel.org>; Tue,  9 Mar 2021 14:34:23 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E1016522D
	for <lttng-dev@archiver.kernel.org>; Tue,  9 Mar 2021 14:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1016522D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DvyQN3W36zDxd;
	Tue,  9 Mar 2021 09:34:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1615300461;
	bh=D8XQ/iDT1uXL0JVQQHTnAoJESv1zk0qfRanubDjkaqE=;
	h=To:References:Date:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=YwbS+4MkSKYaqJIgWXnahUj8mdhVoEDnTWwDzmMQk8K/6Lseo0qShxb17MSbn7DGH
	 WKi70FKX6wdxDbVpEjLeJBXFWDy25LGLdjaF4WBNRQgtu1XU+gN6eMqx8SbGTXZjlD
	 trNotqt9jHho+6PZiG5l855TJFIIQFyviZmIoNOTWt6wweKEOTdCl0MVx1q7W+i3uB
	 6PwmWC1NPGlC6XvGda5ZRlqvMzgghQ5UiGLDxWYf3h2Igm2CWQRkvWWVO0irFi84/x
	 zYdguM3DyfdUc3TlaObcipxsSMIAssJAACAitsT3Zzr8+5c+C53LT9i9dE95agOth3
	 4LQj34Rl4P+NQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4DvyQL2DWjzDVm
 for <lttng-dev@lists.lttng.org>; Tue,  9 Mar 2021 09:34:17 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 934BA278952
 for <lttng-dev@lists.lttng.org>; Tue,  9 Mar 2021 09:34:11 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Ed4dDCZ18CmF; Tue,  9 Mar 2021 09:34:10 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B3DC227894D;
 Tue,  9 Mar 2021 09:34:10 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B3DC227894D
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id W3mzNOtftmZ4; Tue,  9 Mar 2021 09:34:10 -0500 (EST)
Received: from [192.168.0.28]
 (cpebc4dfb40f613-cmbc4dfb40f610.cpe.net.cable.rogers.com [174.118.12.38])
 by mail.efficios.com (Postfix) with ESMTPSA id 7C82327894A;
 Tue,  9 Mar 2021 09:34:10 -0500 (EST)
To: Awais Belal <awais_belal@mentor.com>, lttng-dev@lists.lttng.org
References: <f02c9dd6-b95c-19be-a7b0-cca3efda149c@mentor.com>
Message-ID: <a320badd-11ec-a937-ffdb-5ca1e0efcc38@efficios.com>
Date: Tue, 9 Mar 2021 09:34:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <f02c9dd6-b95c-19be-a7b0-cca3efda149c@mentor.com>
Content-Language: en-US
Subject: Re: [lttng-dev] lttng-modules: block: invalid/unknown value for
 rwbs field
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
From: Francis Deslauriers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Francis Deslauriers <francis.deslauriers@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

You see this "Unknown value 33" because there are no label with the 
value 33 in the "block_rq_type" enumeration.

More specifically, you see the value "33" because it's the result of two 
OR-ed bitflags (RWBS_FLAG_WRITE | RWBS_FLAG_SYNC).

The type of the "rwbs" field in the event was changed from integer to 
enum in that commit [0]. That change was made to allow trace readers to 
print OR-ed values more nicely have all they need to do it. In fact, 
babeltrace2 implements such feature and you can try it with the 
following command:

$ babeltrace2 -c sink.text.pretty -p print-enum-flags=true <path-to-trace>

And would print that field as such: ( "RWBS_FLAG_WRITE" | 
"RWBS_FLAG_SYNC" : container = 33 )

I believe this feature is turn off in Babeltrace2 by default to be 
backward compatible with Babeltrace 1.5.

It's important to note that before that change in the kernel tracer 
Babeltrace would have simply printed "rwbs = 33" so you're not losing 
any information here.

So, try it out with Babeltrace2, it should work as you expect.


Cheers,

Francis

[0] 
https://github.com/lttng/lttng-modules/commit/23634515e7271c8c8594ad87a6685232d4eff297


On 3/9/21 8:10 AM, Awais Belal via lttng-dev wrote:
>
> Hi,
>
> I am using lttng-modules 2.12.5 with a 5.4.93 kernel on an aarch64 
> target. After creating a session I run
>
> *lttng enable-event -k block**
>
> to enable all the block_ kernel events but when I run babeltrace on 
> the generated traces I get a handful of
>
> *[warning] Unknown value 33 in enum.
> ...
> ...
> *
>
> with different values in place of 33. This does not happen with any 
> other kernel event type
>
> *BabelTrace Trace Viewer and Converter 1.5.8*
>
> Also if I try to do a 'lttng view' on this session I can identify that 
> this has something to do with the rwbs field as I get
>
> *[14:03:42.649719750] (+0.000005750) imx8qxpmek block_bio_remap: { 
> cpu_id = 3 }, { dev = 187695200, sector = 2460080, nr_sector = 8, rwbs 
> = ( <unknown> : container = 33 ), old_dev = 187695203, old_sector = 
> 2105776 }
> [14:03:42.649722125] (+0.000002375) imx8qxpmek block_bio_queue: { 
> cpu_id = 3 }, { dev = 187695200, sector = 2460080, nr_sector = 8, rwbs 
> = ( <unknown> : container = 33 ), tid = 428, comm = "jbd2/mmcblk1p3-" }
> [14:03:42.649725000] (+0.000002875) imx8qxpmek block_bio_backmerge: { 
> cpu_id = 3 }, { dev = 187695200, sector = 2460080, nr_sector = 8, rwbs 
> = ( <unknown> : container = 33 ), tid = 428, comm = "jbd2/mmcblk1p3-" }
> ...
> ...*
>
> I believe <unknown> in the log points to a symptom? While for the 
> events/container id that do not generate this warning I have in the 
> same trace
>
> *[14:03:44.697572375] (+2.036943500) imx8qxpmek block_bio_remap: { 
> cpu_id = 0 }, { dev = 187695200, sector = 9382032, nr_sector = 8, rwbs 
> = ( "RWBS_FLAG_WRITE" : container = 1 ), old_dev = 187695206, 
> old_sector = 278672 }
> [14:03:44.697584375] (+0.000012000) imx8qxpmek block_bio_queue: { 
> cpu_id = 0 }, { dev = 187695200, sector = 9382032, nr_sector = 8, rwbs 
> = ( "RWBS_FLAG_WRITE" : container = 1 ), tid = 1609, comm = 
> "kworker/u8:0" }
> [14:03:44.697604250] (+0.000019875) imx8qxpmek block_getrq: { cpu_id = 
> 0 }, { dev = 187695200, sector = 9382032, nr_sector = 8, rwbs = ( 
> "RWBS_FLAG_WRITE" : container = 1 ), tid = 1609, comm = "kworker/u8:0" }*
>
> The interesting thing to note with the working events is that all of 
> them have "RWBS_FLAG_WRITE" and no other types from 
> https://github.com/lttng/lttng-modules/blob/stable-2.12/instrumentation/events/lttng-module/block.h#L39 
> which I would expect to see.
>
> I am lost for hints as to what I need to look up... any help would be 
> highly appreciated.
>
> -- 
> BR,
> Awais
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
