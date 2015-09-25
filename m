From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: Difficulty in viewing kerne traces
Date: Fri, 25 Sep 2015 15:55:48 -0400
Message-ID: <5605A6C4.8030505__23892.7747276195$1443211014$gmane$org@efficios.com>
References: <CAAYE7VVeRWOe7Sn2gGBKgNpcD_3ng++Ookfn75LXGnyxJdWeEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.rajotte-julien@efficios.com>)
 id 1ZfZ65-0006rG-6W
 for lttng-dev@lists.lttng.org; Fri, 25 Sep 2015 15:55:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 17BB53404CB
 for <lttng-dev@lists.lttng.org>; Fri, 25 Sep 2015 19:55:52 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id tPT4it-Z1CHo for <lttng-dev@lists.lttng.org>;
 Fri, 25 Sep 2015 19:55:50 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 958763404CF
 for <lttng-dev@lists.lttng.org>; Fri, 25 Sep 2015 19:55:50 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id CgiQhh_pj2B2 for <lttng-dev@lists.lttng.org>;
 Fri, 25 Sep 2015 19:55:50 +0000 (UTC)
Received: from [172.16.0.141] (cable-192.222.213.99.electronicbox.net
 [192.222.213.99])
 by mail.efficios.com (Postfix) with ESMTPSA id 4309D3404CB
 for <lttng-dev@lists.lttng.org>; Fri, 25 Sep 2015 19:55:50 +0000 (UTC)
In-Reply-To: <CAAYE7VVeRWOe7Sn2gGBKgNpcD_3ng++Ookfn75LXGnyxJdWeEQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Sheetal,

It looks like you are missing libuuid.

 From the README:
To compile Babeltrace, you will need:
...
          uuid development libraries
              (Debian : uuid-dev)
              (Fedora : uuid-devel)

Cheers!


On 2015-09-25 05:38 AM, Sheetal Chawla wrote:
> SIr/Madam,
>
> We are working on a project that involves kernel traces. So we are 
> using LTTng as a tool. We are not able to view the kernel traces using 
> babeltrace as we are getting the following errors while doing 
> ./configure for babeltrace
>
> *checking for uuid_generate in -luuid... no
> checking for uuid_create in -lc... no
> configure: error: Cannot find libuuid uuid_generate nor libc 
> uuid_create. Use LDFLAGS=-Ldir to specify their location.*
>
> Kindly help us with the difficulty.
> Your reply will be of great value to us.
>
> Thanking You
> Regards,
> Sheetal Chawla
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Jonathan R. Julien
Efficios
