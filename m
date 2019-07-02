From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Log semaphore, mutex in CTF
Date: Tue, 2 Jul 2019 10:15:17 -0400
Message-ID: <20190702141517.GA10880__46349.2720549525$1562076947$gmane$org@joraj-alpa>
References: <CABRndgzEX9fyedWgWtoMo9v3VWZRJps3EcF4aetbY4iLDkeKmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45dR8x6x84z17t1
 for <lttng-dev@lists.lttng.org>; Tue,  2 Jul 2019 10:15:29 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 46819202A46
 for <lttng-dev@lists.lttng.org>; Tue,  2 Jul 2019 10:15:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CABRndgzEX9fyedWgWtoMo9v3VWZRJps3EcF4aetbY4iLDkeKmA@mail.gmail.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

HI Zvika,

It all depends on what exactly you traced. Did you trace some userspace
application? Did you trace the kernel?

A trace is as good as its tracepoints. You can use lttng list to get the
available tracepoints for each tracing domain:

From "lttng-list" man page:

  With one or more of the --kernel, --userspace, --jul, --log4j, and --python
  domain options, the command lists the available event sources of the selected
  domain on the system. The JUL, log4j, and Python domains list the names of their
  available loggers. The --syscall option can be used alongside the --kernel
  option to get a list of traceable Linux system calls. The --fields option can be
  used to show the fields of the listed event sources.

AFAIK, lttng-modules does not instrument locking primitive.

lttng-ust does provides overwrite library for pthread_mutex_lock,
pthread_mutex_trylock and pthread_mutex_unlock. You will need to LD_PRELOAD (application start) it.

https://github.com/lttng/lttng-ust/tree/9d4d2a639afc19a1bd705ea560782917ac892596/liblttng-ust-libc-wrapper

Cheers.

On Mon, Jul 01, 2019 at 07:49:16AM +0300, Zvi Vered wrote:
> Hello,
> 
> I converted CTF files created by ltt-ng to text file using babeltrace.
> 
> Can you please tell how semaphore, mutex are logged in this text file ?
> 
> I did not find the terms "sema" or "mutex".
> 
> Thank you,
> Zvika

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Jonathan Rajotte-Julien
EfficiOS
