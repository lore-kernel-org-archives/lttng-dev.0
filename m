From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules stable-2.10] fix: missing
 'lttng_fs_info_fsid' wrapper in btrfs backport
Date: Wed, 11 Dec 2019 16:00:13 -0500 (EST)
Message-ID: <1339411647.2911.1576098013169.JavaMail.zimbra__29396.6340411984$1576098036$gmane$org@efficios.com>
References: <20191211202917.28820-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 47Y8TH4cMpz16WH
 for <lttng-dev@lists.lttng.org>; Wed, 11 Dec 2019 16:00:19 -0500 (EST)
In-Reply-To: <20191211202917.28820-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged, thanks!

Mathieu

----- On Dec 11, 2019, at 3:29 PM, Michael Jeanson mjeanson@efficios.com wrote:

> The following backported patch was missing the use of the
> 'lttng_fs_info_fsid' wrapper to enable compatibility with upstream
> stable kernels.
> 
>  commit 065436fd07d58a9a17427ad386ffcc8d29e25a9d
>  Author: Michael Jeanson <mjeanson@efficios.com>
>  Date:   Mon Jun 18 14:53:18 2018 -0400
> 
>    Fix: btrfs: use fs_info for btrfs_handle_em_exist tracepoint
> 
>    See upstream commit:
> 
>      commit f46b24c9457143a367c6707eac82d546e2bcf280
>      Author: David Sterba <dsterba@suse.com>
>      Date:   Tue Apr 3 21:45:57 2018 +0200
> 
>        btrfs: use fs_info for btrfs_handle_em_exist tracepoint
> 
>        We really want to know to which filesystem the extent map events belong,
>        but as it cannot be reached from the extent_map pointers, we need to
>        pass it down the callchain.
> 
>    Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
>    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> instrumentation/events/lttng-module/btrfs.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/instrumentation/events/lttng-module/btrfs.h
> b/instrumentation/events/lttng-module/btrfs.h
> index fbedd6c..c8c494a 100644
> --- a/instrumentation/events/lttng-module/btrfs.h
> +++ b/instrumentation/events/lttng-module/btrfs.h
> @@ -318,7 +318,7 @@ LTTNG_TRACEPOINT_EVENT(btrfs_handle_em_exist,
> 	TP_ARGS(fs_info, existing, map, start, len),
> 
> 	TP_FIELDS(
> -		ctf_array(u8, fsid, fs_info->fsid, BTRFS_UUID_SIZE)
> +		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
> 		ctf_integer(u64, e_start, existing->start)
> 		ctf_integer(u64, e_len, existing->len)
> 		ctf_integer(u64, map_start, map->start)
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
