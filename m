From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [babeltrace][PATCH] fs.c: initialize the
 other_entry variable
Date: Wed, 11 Mar 2020 09:58:06 -0400 (EDT)
Message-ID: <1707083610.24791.1583935086375.JavaMail.zimbra@efficios.com>
References: <1583933970-68840-1-git-send-email-mingli.yu@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 48ctp72r0cz1GF9
 for <lttng-dev@lists.lttng.org>; Wed, 11 Mar 2020 09:58:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C54EF279336
 for <lttng-dev@lists.lttng.org>; Wed, 11 Mar 2020 09:58:06 -0400 (EDT)
In-Reply-To: <1583933970-68840-1-git-send-email-mingli.yu@windriver.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: mingli yu <mingli.yu@windriver.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Mar 11, 2020, at 9:39 AM, mingli yu mingli.yu@windriver.com wrote:

> From: Mingli Yu <mingli.yu@windriver.com>
> 
> Initialize the pointer other_entry to fix the below error:
>| ../../../../../git/src/plugins/ctf/fs-src/fs.c: In function
>| 'ds_index_insert_ds_index_entry_sorted':
>| ../../../../../git/src/plugins/ctf/fs-src/fs.c:702:5: error: 'other_entry' may
>| be used uninitialized in this function [-Werror=maybe-uninitialized]
>|  702 |    !ds_index_entries_equal(entry, other_entry)) {

It would be good that the commit message documents that the purpose of this
change is only to silence compiler warnings (which is indeed a good thing to
do).

It does not seem to ever be possible to reach a situation where the
uninitialized value is used, because the only case which can leave
this variable uninitialized is if index->entries->len == 0, which means
the "if (i == index->entries->len ||" will be taken (true), which will
therefore skip the second sub-expression of the if:
"!ds_index_entries_equal(entry, other_entry)", which is the only place
where "other_entry" is read.

Thanks,

Mathieu

> 
> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
> ---
> src/plugins/ctf/fs-src/fs.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/plugins/ctf/fs-src/fs.c b/src/plugins/ctf/fs-src/fs.c
> index e87523a..a6b5315 100644
> --- a/src/plugins/ctf/fs-src/fs.c
> +++ b/src/plugins/ctf/fs-src/fs.c
> @@ -680,7 +680,7 @@ void ds_index_insert_ds_index_entry_sorted(
> 	struct ctf_fs_ds_index_entry *entry)
> {
> 	guint i;
> -	struct ctf_fs_ds_index_entry *other_entry;
> +	struct ctf_fs_ds_index_entry *other_entry = NULL;
> 
> 	/* Find the spot where to insert this index entry. */
> 	for (i = 0; i < index->entries->len; i++) {
> --
> 2.7.4
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
