From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/2] Do not call posix_fallocate() on uClibc
Date: Tue, 28 May 2013 09:50:00 -0400
Message-ID: <20130528135000.GA4549__43504.4443271638$1369749071$gmane$org@Krystal>
References: <1369747627-21626-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UhKHs-0001KD-CP
	for lttng-dev@lists.lttng.org; Tue, 28 May 2013 09:50:04 -0400
Content-Disposition: inline
In-Reply-To: <1369747627-21626-1-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Thomas Petazzoni (thomas.petazzoni@free-electrons.com) wrote:
> uClibc does not implement posix_fallocate(), and posix_fallocate() is
> mostly only an hint to the kernel that we will need such or such
> amount of space inside a file. So we just don't call posix_fallocate()
> when building against uClibc.

please implement separately in a wrapper header, within a compat or
wrapper directory.

Thanks,

Mathieu

> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  formats/ctf/ctf.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
> index bb94e52..77aef28 100644
> --- a/formats/ctf/ctf.c
> +++ b/formats/ctf/ctf.c
> @@ -43,6 +43,7 @@
>  #include <sys/stat.h>
>  #include <fcntl.h>
>  #include <dirent.h>
> +#include <features.h>
>  #include <glib.h>
>  #include <unistd.h>
>  #include <stdlib.h>
> @@ -723,9 +724,11 @@ void ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
>  		}
>  		pos->content_size = -1U;	/* Unknown at this point */
>  		pos->packet_size = WRITE_PACKET_LEN;
> +#ifndef __UCLIBC__
>  		off = posix_fallocate(pos->fd, pos->mmap_offset,
>  				      pos->packet_size / CHAR_BIT);
>  		assert(off >= 0);
> +#endif
>  		pos->offset = 0;
>  	} else {
>  	read_next_packet:
> -- 
> 1.7.9.5
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
