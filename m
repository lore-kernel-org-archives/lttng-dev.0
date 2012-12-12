From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: put_ulong calls in
	lib_ring_buffer_compat_ioctl()	should be compat?
Date: Tue, 11 Dec 2012 21:47:04 -0500
Message-ID: <20121212024704.GB19284__20176.0311880664$1355280761$gmane$org@Krystal>
References: <50C7B110.3040009@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TicLh-0004us-DV
	for lttng-dev@lists.lttng.org; Tue, 11 Dec 2012 21:47:05 -0500
Content-Disposition: inline
In-Reply-To: <50C7B110.3040009@acm.org>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: minyard@acm.org
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Corey Minyard (tcminyard@gmail.com) wrote:
> I was noticing the that some of the put_ulong calls in  
> lib_ring_buffer_compat_ioctl() were not compat_put_ulong.  I can't  
> imagine this is correct.  Here's a patch to fix it, assuming that is  
> wrong.  It seems to work ok.

Merged, thanks!

Mathieu

>
> diff --git a/lib/ringbuffer/ring_buffer_vfs.c  
> b/lib/ringbuffer/ring_buffer_vfs.c
> index c69b64e..899af81 100644
> --- a/lib/ringbuffer/ring_buffer_vfs.c
> +++ b/lib/ringbuffer/ring_buffer_vfs.c
> @@ -331,7 +331,7 @@ long lib_ring_buffer_compat_ioctl(struct file *filp,  
> unsigned int cmd,
>          data_size = lib_ring_buffer_get_read_data_size(config, buf);
>          if (data_size > UINT_MAX)
>              return -EFBIG;
> -        return put_ulong(data_size, arg);
> +        return compat_put_ulong(data_size, arg);
>      }
>      case RING_BUFFER_COMPAT_GET_PADDED_SUBBUF_SIZE:
>      {
> @@ -341,12 +341,12 @@ long lib_ring_buffer_compat_ioctl(struct file  
> *filp, unsigned int cmd,
>          size = PAGE_ALIGN(size);
>          if (size > UINT_MAX)
>              return -EFBIG;
> -        return put_ulong(size, arg);
> +        return compat_put_ulong(size, arg);
>      }
>      case RING_BUFFER_COMPAT_GET_MAX_SUBBUF_SIZE:
>          if (chan->backend.subbuf_size > UINT_MAX)
>              return -EFBIG;
> -        return put_ulong(chan->backend.subbuf_size, arg);
> +        return compat_put_ulong(chan->backend.subbuf_size, arg);
>      case RING_BUFFER_COMPAT_GET_MMAP_LEN:
>      {
>          unsigned long mmap_buf_len;
> @@ -358,7 +358,7 @@ long lib_ring_buffer_compat_ioctl(struct file *filp,  
> unsigned int cmd,
>              mmap_buf_len += chan->backend.subbuf_size;
>          if (mmap_buf_len > UINT_MAX)
>              return -EFBIG;
> -        return put_ulong(mmap_buf_len, arg);
> +        return compat_put_ulong(mmap_buf_len, arg);
>      }
>      case RING_BUFFER_COMPAT_GET_MMAP_READ_OFFSET:
>      {
> @@ -371,7 +371,7 @@ long lib_ring_buffer_compat_ioctl(struct file *filp,  
> unsigned int cmd,
>          read_offset = buf->backend.array[sb_bindex]->mmap_offset;
>          if (read_offset > UINT_MAX)
>              return -EINVAL;
> -        return put_ulong(read_offset, arg);
> +        return compat_put_ulong(read_offset, arg);
>      }
>      case RING_BUFFER_COMPAT_FLUSH:
>          lib_ring_buffer_switch_slow(buf, SWITCH_ACTIVE);
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
