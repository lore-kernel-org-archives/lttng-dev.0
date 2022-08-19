Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C32DC32771
	for <lttng-dev@archiver.kernel.org>; Fri, 19 Aug 2022 15:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1660921752;
	bh=0fz9FvP5vHykXo6T5/KqzoXGQYvzBpRWjEcXRT5hKHg=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=VBCCbVYkEM6ITTQRzNNJq/p9smcGtihpK/yNsMgSmaKrMp0sOIhVp5fc15NAG+/ZK
	 KLh7R4pZwP25aVL+Xnu8qOxO1Et6YXzm3r+D2yf3Rrqf6e+ZMZjCV5eZYuE8o+cwfz
	 hjHrl3qQYMN8FhQP37bPbI2tgfBDtOwjvdToBKN4XcyIvOYZ08yurIGDSeKScjSP2H
	 jPhF3gTi6IpLr9hoCgshsNE1vNT7wBCJ96h0eXZ1P6zyzA1eq6LdPcf6vsKZyRwqsf
	 1fvhI2evNBoG91eKjFgr+qyQ5ukiIEdXHJqgE86drTc1Mwpq7vSrYrqSMV/kRrOsZW
	 yCLQqrUP46NzA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4M8QBv6sqfz1JdZ;
	Fri, 19 Aug 2022 11:09:11 -0400 (EDT)
Received: from simark.ca (simark.ca [158.69.221.121])
 by lists.lttng.org (Postfix) with ESMTPS id 4M8QBs5RQcz1Jqh
 for <lttng-dev@lists.lttng.org>; Fri, 19 Aug 2022 11:09:09 -0400 (EDT)
Received: from [172.16.0.95] (192-222-180-24.qc.cable.ebox.net
 [192.222.180.24])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by simark.ca (Postfix) with ESMTPSA id 8BD471E13B;
 Fri, 19 Aug 2022 11:00:19 -0400 (EDT)
Message-ID: <87a1bad5-9942-3d6a-9726-1e4e74bea4d2@simark.ca>
Date: Fri, 19 Aug 2022 11:00:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: fr
To: Maksim Khmelevskiy <mk.void.mail@gmail.com>, lttng-dev@lists.lttng.org
References: <CACXehJBBkAm-7U2fwOd-qaGE5OgbsAZEci5v57XkmUp=7vtKNA@mail.gmail.com>
In-Reply-To: <CACXehJBBkAm-7U2fwOd-qaGE5OgbsAZEci5v57XkmUp=7vtKNA@mail.gmail.com>
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

On 8/12/22 09:19, Maksim Khmelevskiy via lttng-dev wrote:
> Hi,
>

> there is a nice py message iterator example
> <https://babeltrace.org/docs/v2.0/python/bt2/examples.html> but for C
> API only plugins are covered with examples, do you think it would make
> sense to create an example of a standalone application which simply
> uses `source.ctf.fs` as source and iterates over all messages? It
> would be nice hint for those who want to see an example of graph
> creation with all the code in one file.

Hi Maksim,

I'm not sure which example you are referring to exactly.  But in Python,
we have the high-level TraceCollectionMessageIterator object, which does
roughly:

 - Instantiate source and filter components according to the provided
   specs, including automatic source discovery
 - Instantiate a flt.utils.muxer component to merge the streams from all
   sources ports
 - Instantiate a sink component that presents the events as a Python
   iterable
 - Connect the ports of all these components
 - More things that are irrelevant here

There is no such high-level object in the C interface, so you have
to do all this by hand, it will necessarily be much more verbose.  It
would be nice to have the equivalent of TraceCollectionMessageIterator
in the C API, it is just not done yet due to lack of resources.

I did search in the documentation for an example program that uses the C
API to create and run a graph, and I haven't found one.  I agree that
adding one would be nice.  I'll look into writing one.

Regarding your use case:

> I'm interested in that example because I want to transform CTF file
> into list of C structures representing messages.

I have some questions:

 - Is the data you want to convert found in the metadata of the traces
   (description of event types) of in the payload of events?
 - Why do you want to write this in C instead of Python?  It sounds like
   it would be much faster to write in Python (with
   TraceCollectionMessageIterator), and it doesn't sound like something
   where the performance is critical (but of course I don't have the
   full context).
 - Why do you need to write an application where you create and run the
   graph yourself?  Could you instead just write your sink component
   class (which reads the messages and writes your output files),
   packaged in a plugin and use it through the babeltrace2 command-line:

     $ babeltrace2 /path/to/ctf/trace -c sink.foo.bar -p 'output="out.h"'

   ?  This way, you just have to care about writing your component
   class, which does the conversion you need.

Simon
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
