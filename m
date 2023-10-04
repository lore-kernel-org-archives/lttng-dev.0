Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FD3E7C4E3
	for <lttng-dev@archiver.kernel.org>; Wed,  4 Oct 2023 16:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1696438619;
	bh=16/cQ+LBr6vyBmzfhQjYV6GM965Y2CKc8tq/Jhfp6Nk=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=bibMo5RW7E7dCGSF7lDhhkKhKVfvAMnhLBMLrOR4tsYzcAMxcnTs7Ah8odu+ahm39
	 aYPyFWCQQgLzLVq0Jx994w6HKQtihbErDkt6jnPh2WcnFnCOnyEDiVOEESV28ajHC9
	 CGJJwDHTpBEjI3RO2f9evcniUMP6QhrnHkyEbhFoSz04eb1W8HEZy58CIpILHlRiZh
	 f5o3iSImEAzF7RtwJBXGkns5ZlxIERQtckTlMZMF5ZzLEr9EypzT9tZncWrUEUFypH
	 pDLR7J5pdlKp7/poakC38Tf26k9NaF1I6PlDgz6vOpWlGkBO87+8DWHWkAN3TUkjtL
	 59mmalbyMnRpA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4S117Z6Gm7z2sTj;
	Wed,  4 Oct 2023 12:56:58 -0400 (EDT)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 by lists.lttng.org (Postfix) with ESMTPS id 4S117Y441pz2rmD
 for <lttng-dev@lists.lttng.org>; Wed,  4 Oct 2023 12:56:55 -0400 (EDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id B1B035C0379
 for <lttng-dev@lists.lttng.org>; Wed,  4 Oct 2023 12:56:52 -0400 (EDT)
Received: from imap42 ([10.202.2.92])
 by compute2.internal (MEProxy); Wed, 04 Oct 2023 12:56:52 -0400
X-ME-Sender: <xms:VJkdZYgXMNwTLhUQoKw5_lM74D6u8HehkSNroKQl8gZ6rZ9ex_vGbw>
 <xme:VJkdZRBR9N7g3maVkyq9Wl3HDPCzvj5zOZbpYLT2e9Y7DkD7yzPNa2hwNkzRQl7Uq
 8sKWsDpcaSvyOYKqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgedvgddutdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
 erredtnecuhfhrohhmpedfvehhrhhishhtohhphhgvrhcujfgrrhhvvgihfdcuoegthhhr
 ihhssegtfihhrghrvhgvhidrtggrqeenucggtffrrghtthgvrhhnpeehuefgtdekffeuke
 egtdehgeevleetteejtdeuleevtddtuedtudehfeeuieevveenucevlhhushhtvghrufhi
 iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhrihhssegtfihhrghrvhgvhi
 drtggr
X-ME-Proxy: <xmx:VJkdZQE8-wCaCbenHJK5aD05kj8FkTAG68gxq0KVq7mLWxJPXVYgiQ>
 <xmx:VJkdZZTesJYwxXpvfwy2he_XsnmRkW75vt73gFZq8eOlb0O8ejRC5Q>
 <xmx:VJkdZVyB-9WksoE-a45JQz6dY1Vr4o6LrHD98ruok7tGQ4lFA0Rutg>
 <xmx:VJkdZU_ryKtW6SZk83r3t2KYc72f2ub3TalH7THgeFZqWfC537fHtA>
Feedback-ID: i2d19425f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 6BAFEBC007C; Wed,  4 Oct 2023 12:56:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <0c1fcf2c-c061-4074-a20e-44b870fbeef5@app.fastmail.com>
Date: Wed, 04 Oct 2023 12:56:31 -0400
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] What is DEFINE_LTTNG_UST_SIGBUS_STATE for and other
 beginner questions
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
From: Christopher Harvey via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Christopher Harvey <chris@cwharvey.ca>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi all,

I'm just getting started with lttng and have a couple of questions. My target is getting userspace tracepoints to work in a c++ application I control. I don't need kernel or system tracing. The target is running in a docker container I have control over as well. Running with --privileged is possible in my setup. I could run lttng inside the target container, outside on the host, or in another container on the same host. It's all the same to me. I don't know which setup is best, or if it even matters given that I don't need system or kernel traces.

I am using:
lttng-tools-2.13.11/      and       lttng-ust-2.13.6/
with userspace-rcu-0.14.0/

There is a slight version mismatch there, I just downloaded the "-lastest" from the links in the guide.

Here is my tracepoint provider header:
-----
#undef LTTNG_UST_TRACEPOINT_PROVIDER
#define LTTNG_UST_TRACEPOINT_PROVIDER my_provider

#undef LTTNG_UST_TRACEPOINT_INCLUDE
#define LTTNG_UST_TRACEPOINT_INCLUDE "./myLttngUstProvider.hpp"

#if !defined(_TP_H) || defined(LTTNG_UST_TRACEPOINT_HEADER_MULTI_READ)
#define _TP_H

#include "lttng/tracepoint.h"

LTTNG_UST_TRACEPOINT_EVENT(
    /* Tracepoint provider name */
    my_provider,

    /* Tracepoint name */
    test,

    /* Input arguments */
    LTTNG_UST_TP_ARGS(
        int, arg1
    ),

    /* Output event fields */
    LTTNG_UST_TP_FIELDS(
        lttng_ust_field_integer(int, arg1, arg1)
    )
)

#endif /* _TP_H */

#include "lttng/tracepoint-event.h"
--------

and the cpp:
-------
#define LTTNG_UST_TRACEPOINT_CREATE_PROBES
#define LTTNG_UST_TRACEPOINT_DEFINE

#include "myLttngUstProvider.hpp"
#include "lttng/ust-sigbus.h"

DEFINE_LTTNG_UST_SIGBUS_STATE();
----

I'm suspicious of a couple of things in my setup.

First, if I omit the DEFINE_LTTNG_UST_SIGBUS_STATE(); line, my program fails to compile with the following error:
liblttng-ust-ctl.so: undefined reference to `lttng_ust_sigbus_state'

The getting started guide doesn't say anything about needing DEFINE_LTTNG_UST_SIGBUS_STATE so it makes me wonder if I have done something else wrong somewhere else. I ran a find *.so | xargs nm -D | grep lttng_ust_sigbus_state and nothing in lttng-ust provides that symbol, so it looks like the target application has to define it. Is that normal?

If I leave DEFINE_LTTNG_UST_SIGBUS_STATE in then my program compiles. If I run lttng-sessiond in the target container, then run lttng list --userspace I see no tracepoints in the list.

I tried looking at the lttng source code but there is a lot there. I'm looking for some next steps for debugging this setup. What are some things I could check to make sure the lttng daemon is running properly? What is the mechanism for advertising tracepoints to the lttng daemon? Is it possible that docker has somehow interfered with the lttng ipc mechanism? It would be a tiny bit more convenient for me to simply deploy lttng-tools as a separate container, can I consider doing that instead? I'm not running anything as root, just a normal user.

I appreciate any and all guidance. Looking forward to using this neat looking tool.

-Chris
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
