Return-Path: <SRS0=mc7a=I7=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E41C433B4
	for <lttng-dev@archiver.kernel.org>; Fri,  2 Apr 2021 15:07:31 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7C960FEF
	for <lttng-dev@archiver.kernel.org>; Fri,  2 Apr 2021 15:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7C960FEF
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FBk1Y0jhTz105b;
	Fri,  2 Apr 2021 11:07:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617376049;
	bh=Bm+GBtbyXCRg9jnUTxUjB4OIwSSlu7fykCS6HI+/mWY=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=NYHw1TD/4C8gmHqeJGbU7DX7IIfgvtheBh/LTRh2i3dD8G9DuuW0+wmWFUSqa6Sml
	 a5ANJct6XP1zHOvkNKvi9EBIL1lEmLZR5pxUCPhXvxz8EM+Su11F9h0gEl+DGIGyda
	 4Q5/EJiq4aw8jleDbuEFnbArds30WKEpArlu9iS+TWDIF8d1MatO9RnJbfsnihMSOb
	 zqa0Oie55/I89nq7P7+kNWNkomGQukk622YtKal+OrK4rOCAl54nx4wp3XwGy6dM9Q
	 zEb9h7iivE1x2l3lZPgL4U0tPLVEnLYISEwH7Kxq4M7+3j5C6eyzR2r8ft9z0HLi6x
	 7eCIOR4mIrs0w==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FBk1W64PCz100P
 for <lttng-dev@lists.lttng.org>; Fri,  2 Apr 2021 11:07:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 035B72F5092
 for <lttng-dev@lists.lttng.org>; Fri,  2 Apr 2021 11:07:21 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id yAwK7NaaS62B; Fri,  2 Apr 2021 11:07:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6B7662F508F;
 Fri,  2 Apr 2021 11:07:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6B7662F508F
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id CHGl8A-9J6uG; Fri,  2 Apr 2021 11:07:20 -0400 (EDT)
Received: from joraj-alpa (unknown [107.159.43.215])
 by mail.efficios.com (Postfix) with ESMTPSA id 501922F508E;
 Fri,  2 Apr 2021 11:07:20 -0400 (EDT)
Date: Fri, 2 Apr 2021 11:07:19 -0400
To: Ramesh Errabolu <ramesh.errabolu@gmail.com>
Cc: lttng-dev@lists.lttng.org
Message-ID: <20210402150719.GB79283@joraj-alpa>
References: <CAFGSPrw1Ev1c+Ok7tvyzEJOQNDze6fbpzNKFzmH=9hSVYGF69A@mail.gmail.com>
 <20210331174201.GB28307@joraj-alpa>
 <CAFGSPrwf1EtwuON3J=T6efyL0OLy6ZxqQWOYnwxLwJT88TBiXg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFGSPrwf1EtwuON3J=T6efyL0OLy6ZxqQWOYnwxLwJT88TBiXg@mail.gmail.com>
Subject: Re: [lttng-dev] Can't trace function calls
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
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Wed, Mar 31, 2021 at 12:55:53PM -0500, Ramesh Errabolu wrote:
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin# ls ~/ | grep -i ltt
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin# lttng create
> my-kernel-session --output=~/my-kernel-trace
> Session my-kernel-session created.
> Traces will be output to
> /home/user1/git/compute/out/ubuntu-18.04/18.04/bin/~/my-kernel-trace
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin# *lttng list
> --kerne*l
> *Error: Unable to list kernel events: Kernel tracer not available*

Well this would be the first thing to look at.

First let's deactivate the lttng-sessiond.service installed by the packages.

   systemctl stop lttng-sessiond.service

You might want to reanable it later.

> 
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin# ps -ef | grep ltt
> root      1002     1  0 12:16 ?        00:00:00 /usr/bin/lttng-sessiond
> root      1054  1002  0 12:16 ?        00:00:00 */usr/bin/lttng-sessiond*
> root      3145  2861  0 12:51 pts/0    00:00:00 grep --color=auto ltt
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#

Make sure after the systemctl call that no lttng-sessiond process is running.

Now let's launch a lttng-sessiond by hand with a bit more verbosity. For now
let's stick to the root user.

  # lttng-sessiond -vvv --verbose-consumer -b > /tmp/lttng-sessiond.log 2>&1 
  # pkill lttng-sessiond

Please share the content of /tmp/lttng-sessiond.log using a pasting service
(paste.ubuntu.com).

Also please provide the output of:

 # uname -a
 # find /lib/modules/$(uname -r)/ | grep lttng
 # dmesg | grep lttng


But again, the cyg-profile helper library is meant for Userspace tracing.

With the app running and having the LD_PRELOAD correctly set, and a sessiond
running.

 # lttng list -u 

If there is nothing, well you can start the application with the following and
share the output of it (make sure to remove any output from your application if
sensitive data is present)

 # LD_PRELOAD=.... LTTNG_UST_DEBUG=1 your_application_here

Note that debug log will be outputted on stderr.

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
