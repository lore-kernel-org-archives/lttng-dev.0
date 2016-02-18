From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: lttng-modules build issues
Date: Thu, 18 Feb 2016 16:09:10 -0500
Message-ID: <56C632F6.3060409__9525.99889501489$1455829834$gmane$org@efficios.com>
References: <1510306317.5846570.1455790186976.JavaMail.yahoo.ref@mail.yahoo.com>
 <1510306317.5846570.1455790186976.JavaMail.yahoo@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.rajotte-julien@efficios.com>)
 id 1aWVp8-0000BX-MF
 for lttng-dev@lists.lttng.org; Thu, 18 Feb 2016 16:09:24 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 392F23402FD
 for <lttng-dev@lists.lttng.org>; Thu, 18 Feb 2016 21:09:13 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id UdMjXPoTZ0Ws for <lttng-dev@lists.lttng.org>;
 Thu, 18 Feb 2016 21:09:12 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8706F3404A1
 for <lttng-dev@lists.lttng.org>; Thu, 18 Feb 2016 21:09:12 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id r-dVvUQPbWnp for <lttng-dev@lists.lttng.org>;
 Thu, 18 Feb 2016 21:09:12 +0000 (UTC)
Received: from [172.16.0.165] (cable-192.222.213.99.electronicbox.net
 [192.222.213.99])
 by mail.efficios.com (Postfix) with ESMTPSA id 2F42A3402FD
 for <lttng-dev@lists.lttng.org>; Thu, 18 Feb 2016 21:09:12 +0000 (UTC)
In-Reply-To: <1510306317.5846570.1455790186976.JavaMail.yahoo@mail.yahoo.com>
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

Hi Dragos,

Which kernel version ?

Thanks

On 2016-02-18 05:09 AM, Dragos Tarcatu wrote:
> Hello,
>
> I'm encountering these compilation errors while trying to build the 
> lttng-modules on an nvidia tegra arm64 board:
>
>     lttng-modules/2.7.1-r1/git/lttng-syscalls.c:358:3: error: implicit
>     declaration of function
>     '__event_probe__compat_syscall_entry_unknown'
>     [-Werror=implicit-function-declaration]
>     |  __event_probe__compat_syscall_entry_unknown(event, id, args);
>
>     lttng-modules/2.7.1-r1/git/lttng-syscalls.c:360:3: error: implicit
>     declaration of function '__event_probe__syscall_entry_unknown'
>     [-Werror=implicit-function-declaration]
>     |  __event_probe__syscall_entry_unknown(event, id, args);
>
>     lttng-modules/2.7.1-r1/git/lttng-syscalls.c:509:3: error: implicit
>     declaration of function
>     '__event_probe__compat_syscall_exit_unknown'
>     [-Werror=implicit-function-declaration]
>     |  __event_probe__compat_syscall_exit_unknown(event, id, ret,
>
>     lttng-modules/2.7.1-r1/git/lttng-syscalls.c:512:3: error: implicit
>     declaration of function '__event_probe__syscall_exit_unknown'
>     [-Werror=implicit-function-declaration]
>     |    __event_probe__syscall_exit_unknown(event, id, ret, args);
>
>     lttng-modules/2.7.1-r1/git/lttng-syscalls.c:740:2: error: implicit
>     declaration of function 'wrapper_vmalloc_sync_all'
>     [-Werror=implicit-function-declaration]
>     |   wrapper_vmalloc_sync_all();
>
>
>     lttng-modules/2.7.1-r1/git/lttng-syscalls.c:777:5: error:
>     '__event_desc___syscall_entry_unknown' undeclared (first use in
>     this function)
>     | &__event_desc___syscall_entry_unknown;
>
>     lttng-modules/2.7.1-r1/git/lttng-syscalls.c:794:5: error:
>     '__event_desc___compat_syscall_entry_unknown' undeclared (first
>     use in this function)
>     | &__event_desc___compat_syscall_entry_unknown;
>
>     lttng-modules/2.7.1-r1/git/lttng-syscalls.c:811:5: error:
>     '__event_desc___compat_syscall_exit_unknown' undeclared (first use
>     in this function)
>     | &__event_desc___compat_syscall_exit_unknown;
>
>     lttng-modules/2.7.1-r1/git/lttng-syscalls.c:828:5: error:
>     '__event_desc___syscall_exit_unknown' undeclared (first use in
>     this function)
>     |     &__event_desc___syscall_exit_unknown;
>
> If I disable the syscall tracing it builds just fine though. Any idea 
> on why this may be happening?
>
> Regards,
>    Dragos
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Jonathan R. Julien
Efficios
