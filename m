From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [PATCH] Fix: tracepoint.h: define SDT_USE_VARIADIC
 in pkg-config CFLAGS
Date: Mon, 29 Jun 2020 12:36:57 -0400 (EDT)
Message-ID: <1076462414.15458.1593448617213.JavaMail.zimbra@efficios.com>
References: <20200624160934.205881-1-stefanha@redhat.com>
 <1673641132.14590.1593205320791.JavaMail.zimbra@efficios.com>
 <20200629162600.GA54368@stefanha-x1.localdomain>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49wY6m1LQMz17Fv
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jun 2020 12:37:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A774C26A583
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jun 2020 12:36:57 -0400 (EDT)
In-Reply-To: <20200629162600.GA54368@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On 29 Jun, 2020, at 12:26, Stefan Hajnoczi stefanha@redhat.com wrote:

> On Fri, Jun 26, 2020 at 05:02:00PM -0400, Michael Jeanson wrote:
>> I proposed a patch here[1] that addresses this problem in a generic way by
>> duplicating the macro and namespacing it under LTTNG_. Honestly this is more
>> of an sdt bug, the STAP_PROBEV should be in it's own include guard outside
>> of _SYS_SDT_H or in it's own header file but we have to work with what's there.
>> 
>> Can you have a look at the patch and confirm that it fixes your problem?
> 
> Great, glad there is already a fix under review.
> 
> When I try out the patch the application does not compile. The error
> messages are the same as without the patch because _LTTNG_SDT_PROBE() is
> not defined. Was that supposed to be _SDT_PROBE() instead?
> 
> The application compiles successfully after replacing _LTTNG_SDT_PROBE()
> with _SDT_PROBE().
> 
> Stefan

Yes indeed, I reworked the patch after testing it and didn't catch this, I've
just pushed an updated patch. Thanks for testing it and catching this.

Cheers,

Michael
