Return-Path: <SRS0=GH8+=BX=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2607C433E1
	for <lttng-dev@archiver.kernel.org>; Thu, 13 Aug 2020 14:43:19 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4568F2078D
	for <lttng-dev@archiver.kernel.org>; Thu, 13 Aug 2020 14:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="k3H0Y8UQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4568F2078D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BS8Sj5lfHz1v0s;
	Thu, 13 Aug 2020 10:43:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1597329798;
	bh=s/j6c7obL9/gaGALZbKHsNpq5Od3XFgxbEQjgC47I4I=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=k3H0Y8UQuaqCxHGdSz+trPKdMdk11ax5wEW+dxmPpkA2yRicoAVHmtt3pnRTQsBzx
	 0tmQOa9jqU3d0SpDX7g9NP4WBtjNLP7KEhkhzuh3j8qdM8IJtng9nPAji4VDtEyUO+
	 hYlm5fq6pBQcUZn7Cn4alAiCqMlqukezB6NrOoquVahn0P25EVhNVJdaRe48CUrhnR
	 4efawqUZclCv0FVAyBPzWhKe1pOuczkdPSyU0u+Lbm55R9m3oTT68ONu+BsA8u/TpT
	 rLg7MKoVLSB1FJQyDxwXx1XKZU6s6gka8LYxON/Eiy8fY4o+WgR+mUUOOSxuWNAM1r
	 +OSd6y+662wEw==
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 by lists.lttng.org (Postfix) with ESMTPS id 4BS8Sg28yjz1v0q
 for <lttng-dev@lists.lttng.org>; Thu, 13 Aug 2020 10:43:15 -0400 (EDT)
Received: by mail-yb1-xb2d.google.com with SMTP id y134so3450895yby.2
 for <lttng-dev@lists.lttng.org>; Thu, 13 Aug 2020 07:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K7upnEOLbmd9A+H3qnos4miw+92fSlJgiEUhnkFwRLM=;
 b=cT6RdDfMIH3ivy1b7y3uPRd/yUuXJduE9HrKImnucW762DdwiXiy9OIhi9HNLRkfaW
 N+VPj92uLJIZ7riFN1b4jZzjq06MZGHWFtZCO//ZjH7DYGkIyZq46JWb/BB4Sl1usbBx
 q59vvZzYcC16+3BeUENV4SZz5F6M1wQI5YiRWesjDH9poWWKF1KydJmZh1ZzxdJZJR7w
 WYaZUhGCIGkX5Lfhfx0+YhjHSRJ7Ei+f3qLvnbEDQyP462mha1YyxcV912vTcUBiFVfT
 I54y78lcTuUAu7trFxkvVnGJHAPWKVQ5IgX6b+PeG66LunevhACaPJOnrroke+s8JVlX
 y7vA==
X-Gm-Message-State: AOAM530j3cLbFvOjQ5SIZjg9veO1wPTb/Ui/6ZPc8LT0wRbmDHpt8Xgv
 jRXXyGgunfXBAdBUkWp42dld782SJ3S/Qg4lNGE=
X-Google-Smtp-Source: ABdhPJw2g5MA93jtAYdFuuyp4dc9QL0teBCF6M669DKszlDFnSCd25MInLO2laM3Kb0a3rxSqc/4c14Whbwbs7JfY6w=
X-Received: by 2002:a25:da02:: with SMTP id n2mr6914717ybf.316.1597329794456; 
 Thu, 13 Aug 2020 07:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <CABhb4uuzDD1srWvRbC915wGfpsWt9LAAue942-ppaKH3FJt6Gw@mail.gmail.com>
In-Reply-To: <CABhb4uuzDD1srWvRbC915wGfpsWt9LAAue942-ppaKH3FJt6Gw@mail.gmail.com>
Date: Thu, 13 Aug 2020 10:42:47 -0400
Message-ID: <CAB4xu_2jqauCzzWDC=khcCGA7YZDJqxz31sZntG8coU+yiQTXA@mail.gmail.com>
To: Valentin Grigorev <valentin.grigorev@jetbrains.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] LTTng event identification
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

On Thu, Aug 13, 2020 at 9:52 AM Valentin Grigorev via lttng-dev
<lttng-dev@lists.lttng.org> wrote:
>
> Hello!
>
> I'm using LTTng live session and Babeltrace 2 C API to analyze events
> in online mode.
>
> I would like to route event processing statically (using IDs, without
> parsing strings). And currently, I don't understand if it is possible
> with LTTng.
>
> Babeltrace 2 C API provides bt_event_class_get_id function, but the
> only guarantee about IDs received from this function is "All the event
> classes of a given stream class have unique numeric IDs". And even
> more, it is mentioned further that stream class can automatically
> assign event class IDs in some cases (q.v.
> https://babeltrace.org/docs/v2.0/libbabeltrace2/group__api-tir-ev-cls.html).
> If I understand correctly, it means, that these IDs are assigned by
> Babeltrace library, not by LTTng itself or tracepoint provider, and as
> result, the same tracepoints can produce events with different event
> class IDs even within the same tracing session. Am I right?

In LTTng's case, which generates CTF traces, LTTng assigns the event
class IDs. A Babeltrace 2 `src.ctf.lttng-live` component simply uses
them as is to create event class objects. But LTTng assigns those event
class IDs dynamically, so, indeed, there's no guarantee that you'll
always get the same.

We generally use event class names to identify event classes.

>
> At the same time, in ETW (Event Tracing for Windows) event type is
> fully identified by 3 parameters: provider GUID, event id, event
> version. I would like to have something like this. At least I need to
> know that ID for the same tracepoint is constant, unique within a
> tracepoint provider, and not depends on a session configuration, other
> providers, etc.

It is very likely that CTF 2 will introduce a similar concept to
uniquely identify an event class without having to rely on its name
exclusively. Some namespace (based on a domain name and year, for
example; think XML/YAML/etc.) + a name + a version would be a good
start. For example:

    ns: lttng.org/ns/ctf/modules
    name: sched_switch
    version: 3

We could also merge all that into a single URI. I need to reflect on
this with other developers.

>
> Summarizing, I'm interested in the following questions:
>   * Do event class IDs depend on a session configuration (which events were enabled)?

Yes, in that LTTng assigns event class IDs sequentially, as needed,
without any relation to the tracepoints.

>   * If so, maybe there are some other IDs satisfying the above requirements in LTTng/Babeltrace?

No.

>   * Do any IDs for tracepoint providers exist in LTTng? Or parsing event name is the only way to identify it?

The usual strategy is for a Babeltrace 2 component to map event class
IDs to some private event class identifications somewhere (using a hash
table, for example). In LTTng live's case, it's possible that new event
classes appear later, so you need to take this into account.

Then when consuming an event message, the component first tries to find
its class's identification using its class's ID (hash table lookup, for
example). If the component cannot find the event class identification,
it uses its name to determine its identification and then maps its ID to
this identification.

Tell me if you want more details about this strategy.

Hope this helps,

Phil

>
> Best regards,
> Valentin Grigorev
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
