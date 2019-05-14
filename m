From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: lttng-tools-2.10.6: Spawning consumerd failed
Date: Tue, 14 May 2019 10:29:48 -0400
Message-ID: <20190514142948.GA10361__18270.7468791463$1557844222$gmane$org@joraj-alpa>
References: <CABRndgyrxUfZqtcu=4Y7U8rvjpBa=0AqcDCkvU3UMxixRfQCoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 453KpD5TSBzySw
 for <lttng-dev@lists.lttng.org>; Tue, 14 May 2019 10:29:56 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id E0186AD35A
 for <lttng-dev@lists.lttng.org>; Tue, 14 May 2019 10:29:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CABRndgyrxUfZqtcu=4Y7U8rvjpBa=0AqcDCkvU3UMxixRfQCoQ@mail.gmail.com>
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

Hi,

On Tue, May 14, 2019 at 03:20:31PM +0300, Zvi Vered wrote:
> Hello,
> 
> I ran the following command on the target (where my kernel is running):
> 
> ~ # ./lttng create my-kernel-session --output=/tmp/my-kernel-trace
> 
> and then:
> 
> 
> ~ # ./lttng enable-event --kernel --syscall open,close
> 
> and got:
> 
> Error: Spawning consumerd failed
> Error: Event open: Kernel consumer start failed (channel channel0,
> session my-kernel-session)
> PERROR - 00:25:59.397308194 [1930/1930]: listen: Invalid argument (in
> lttcomm_listen_unix_sock() at unix.c:173)
> PERROR - 00:25:59.397344426 [1930/1930]: sendmsg: Bad file descriptor
> (in lttcomm_send_unix_sock() at unix.c:292)
> Error: Failed to send data back to client
> PERROR - 00:25:59.397353233 [1930/1930]: close: Bad file descriptor
> (in thread_manage_clients() at main.c:4530)
> Error: Event close: Kernel consumer start failed (channel channel0,
> session my-kernel-session)
> ~ #
> 
> 
> Can you please explain the cause to this error ?

Clearly, lttng is having problem spawning the kernel consumer:

   Error: Spawning consumerd failed

Now for the why, we will need more information from your end.

> 
> 
> I'm running under a 32 bit (x86) vanilla, 4.9.20 kernel with busybox
> with the following lttng versions:

Are you using a distro (yocto/buildroot)?

How can we reproduce the exact environment for this? This will greatly speedup
this, especially if we can spawn such env in qemu.

Also, could you run lttng-sessiond in verbose mode and provide the output
(pastebinit)?

  lttng-sessiond -vvv --verbose-consumer

  ./lttng create my-kernel-session --output=/tmp/my-kernel-trace
  ./lttng enable-event --kernel --syscall open,close

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
