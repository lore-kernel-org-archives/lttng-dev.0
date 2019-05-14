From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: lttng-tools-2.10.6: Spawning consumerd failed
Date: Tue, 14 May 2019 14:04:33 -0400
Message-ID: <20190514180433.GB10361__24744.5801667467$1557857094$gmane$org@joraj-alpa>
References: <CABRndgyrxUfZqtcu=4Y7U8rvjpBa=0AqcDCkvU3UMxixRfQCoQ@mail.gmail.com>
 <20190514142948.GA10361@joraj-alpa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 453QYv4RVczykF
 for <lttng-dev@lists.lttng.org>; Tue, 14 May 2019 14:04:35 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 493E2BA9BB
 for <lttng-dev@lists.lttng.org>; Tue, 14 May 2019 14:04:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20190514142948.GA10361@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Zvi Vered <veredz72@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

> 
> > 
> > 
> > I'm running under a 32 bit (x86) vanilla, 4.9.20 kernel with busybox
> > with the following lttng versions:

I took some time to at least test on a 32 bit system (buildroot) just in case
and everything seems to be working fine on a base installation.

The log from lttng-sessiond should provides more information on why we fail to
spawn the consumerd (wrong path, etc.).

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
