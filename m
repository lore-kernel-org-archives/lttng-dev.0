From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [PATCH lttng-modules 4/4] Fix: btrfs: Remove
 fsid/metadata_fsid fields from btrfs_info
Date: Wed, 9 Jan 2019 15:01:12 -0500
Message-ID: <0d352a89-3c3c-c25c-3c17-f0b779709e85__32799.0674450577$1547063954$gmane$org@efficios.com>
References: <20190109195918.31730-1-mjeanson@efficios.com>
 <20190109195918.31730-4-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43Zg493Lyyz16qd
 for <lttng-dev@lists.lttng.org>; Wed,  9 Jan 2019 15:01:13 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 327FFA2674
 for <lttng-dev@lists.lttng.org>; Wed,  9 Jan 2019 15:01:13 -0500 (EST)
In-Reply-To: <20190109195918.31730-4-mjeanson@efficios.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 2019-01-09 2:59 p.m., Michael Jeanson wrote:
> Introduced in v5.0.
> 
> See upstream commit :
> 
>   commit de37aa513105f864d3c21105bf5542d498f21ca2
>   Author: Nikolay Borisov <nborisov@suse.com>
>   Date:   Tue Oct 30 16:43:24 2018 +0200
> 
>     btrfs: Remove fsid/metadata_fsid fields from btrfs_info
> 
>     Currently btrfs_fs_info structure contains a copy of the
>     fsid/metadata_uuid fields. Same values are also contained in the
>     btrfs_fs_devices structure which fs_info has a reference to. Let's
>     reduce duplication by removing the fields from fs_info and always refer
>     to the ones in fs_devices. No functional changes.
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>

I'll send a version of this patch backported to stable-2.10 soonish, the
others will apply cleanly.

Michael
