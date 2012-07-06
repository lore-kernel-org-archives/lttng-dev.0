From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH lttng-tools] Fix mmap for
	large	subbuffers and handle EINTR
Date: Fri, 6 Jul 2012 09:31:29 -0400
Message-ID: <20120706133129.GA16033__15394.5582140752$1341581524$gmane$org@Krystal>
References: <20120704161009.GA27758@Krystal> <4FF5AB61.4040205@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Sn8d9-0007rE-AZ
	for lttng-dev@lists.lttng.org; Fri, 06 Jul 2012 09:31:31 -0400
Content-Disposition: inline
In-Reply-To: <4FF5AB61.4040205@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* David Goulet (dgoulet@efficios.com) wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Comments below.
> 
> On 04/07/12 12:10 PM, Mathieu Desnoyers wrote:
> > With large subbuffer (packet) size, if write() returns before copying the
> > entire packet for mmap buffers, the consumerd restarts the write 
> > infinitely, which is not good at all.
> > 
> > This affects both lttng-ust (in default mmap mode) and lttng-kernel (but 
> > only for mmap buffers, which is not the default).
> > 
> > This issue would show up with large subbuffer size.
> > 
> > We need to handle this case, as well as EINTR errors (which need to restart
> > write).
> > 
> > Also fixing the return value of mmap read functions, which were returning
> > the amount of data written by the last invocation of write() rather than
> > the total number of bytes written. splice use had the same issue.
> > 
> > Also now consider a write() that returns more bytes than requested as an 
> > error.
> > 
> > Moreover, assigning error = ret after failed splice and write was a 
> > mistake: error is holding the actual error value. ret just holds -1.
> > 
> > This needs testing. Feedback is welcome.
> > 
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> --- diff
> > --git a/src/common/kernel-consumer/kernel-consumer.c
> > b/src/common/kernel-consumer/kernel-consumer.c index bbc31f8..eca710d
> > 100644 --- a/src/common/kernel-consumer/kernel-consumer.c +++
> > b/src/common/kernel-consumer/kernel-consumer.c @@ -49,7 +49,7 @@ ssize_t
> > lttng_kconsumer_on_read_subbuffer_mmap( struct lttng_consumer_stream
> > *stream, unsigned long len) { unsigned long mmap_offset; -	ssize_t ret =
> > 0; +	ssize_t ret = 0, written = 0; off_t orig_offset =
> > stream->out_fd_offset; int fd = stream->wait_fd; int outfd =
> > stream->out_fd; @@ -64,25 +64,34 @@ ssize_t
> > lttng_kconsumer_on_read_subbuffer_mmap(
> 
> Just before going into the while() loop, there is a call to
> kernctl_get_mmap_read_offset() and, on failure, it goes to the "end:" label
> without setting "written" to a negative value.

OK, fixed.

> 
> > 
> > while (len > 0) { ret = write(outfd, stream->mmap_base + mmap_offset,
> > len); -		if (ret >= len) { -			len = 0; -		} else if (ret < 0) { -			errno
> > = -ret; +		if (ret < 0) { +			if (errno == EINTR) { +				/* restart the
> > interrupted system call */ +				continue; +			} else { +				perror("Error
> > in file write"); +				if (written == 0) { +					written = ret; +				} +
> > goto end; +			} +		} else if (ret > len) { perror("Error in file write"); +
> > written += ret; goto end;
> 
> I'm not sure this case is very useful... write() can not possibly return more
> than "len" (the size_t count argument). If it does, I'm pretty sure the whole
> Linux system will not go very well... hehe. The same applies for splice(),
> checking is ret > len is basically safe guarding the syscall which I don't
> think is necessary.

Better safe than sorry ;) Especially for splice(), given that we
implement our own splice actor, it's better to check for even the
assumed kernel behavior.

> 
> However, according to the man page write(2), a return value of 0 coupled with
> a regular file can return an error status:
> 
>        If  count  is  zero  and  fd refers to a regular file, then write() may
>        return a failure status if one of the errors below is detected.  If  no
>        errors  are  detected,  0  will  be  returned without causing any other
>        effect.  If count is zero and fd refers to a file other than a  regular
>        file, the results are not specified.
> 
> We might want to add a zero/errno check instead.

Done.

> 
> For testing, I can tell you that this patch fixes mmap network streaming (soon
> to be merged upstream) where the old code did not worked.

Great! Will post the updated version in a jiffy.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
