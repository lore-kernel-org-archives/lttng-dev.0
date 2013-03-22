From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] lttng-abi.c: fix the error check
Date: Fri, 22 Mar 2013 17:57:45 -0400
Message-ID: <20130322215745.GB18746__32703.9129952484$1363989524$gmane$org@Krystal>
References: <1363975622-37401-1-git-send-email-maxin.john@enea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UJ9y9-0002P3-7i
	for lttng-dev@lists.lttng.org; Fri, 22 Mar 2013 17:57:49 -0400
Content-Disposition: inline
In-Reply-To: <1363975622-37401-1-git-send-email-maxin.john@enea.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: maxin.john@enea.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* maxin.john@enea.com (maxin.john@enea.com) wrote:
> From: "Maxin B. John" <maxin.john@enea.com>
> 
> lttng_syscalls_register() may return -ENOMEM or -EINVAL. So fix
> the error path to check for negative values in lttng_abi_create_event()
> and lttng_channel_ioctl().

I don't understand what this is supposed to fix.

The expected return values from lttng_syscalls_register are:

0 -> success
-EINVAL -> error
-ENOMEM -> error

so whether we check for error with

if (ret)

or

if (ret < 0)

should yield to the exact same result, since we don't expect positive
return values.

And for lttng_abi_create_event(), the original code flow is to execute 2
kfree(), and then "return ret", which will return either -EINVAL or
-ENOMEM to the caller.

So by adding this return -ENOMEM, you hide the real cause (-EINVAL or
-ENOMEM), and you add 2 memory leaks.

Or am I missing something ?

Thanks,

Mathieu

> 
> Signed-off-by: Maxin B. John <maxin.john@enea.com>
> ---
>  lttng-abi.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/lttng-abi.c b/lttng-abi.c
> index 25a350a..5613b75 100644
> --- a/lttng-abi.c
> +++ b/lttng-abi.c
> @@ -648,7 +648,7 @@ int lttng_abi_create_event(struct file *channel_file,
>  		if (event_param->name[0] != '\0')
>  			return -EINVAL;
>  		ret = lttng_syscalls_register(channel, NULL);
> -		if (ret)
> +		if (ret < 0)
>  			goto fd_error;
>  		event_fd = 0;
>  		break;
> @@ -753,6 +753,8 @@ long lttng_channel_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  			break;
>  		}
>  		ret = lttng_abi_create_event(file, uevent_param);
> +		if (ret < 0)
> +			return -ENOMEM;
>  
>  old_event_error_free_old_param:
>  		kfree(old_uevent_param);
> -- 
> 1.7.5.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
