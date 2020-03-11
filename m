From: Simon Marchi <simark@simark.ca>
Subject: Re: [babeltrace][PATCH] fs.c: initialize the
 other_entry variable
Date: Wed, 11 Mar 2020 09:52:27 -0400
Message-ID: <a2a63a78-f39b-b64a-f09a-08e096dc6563@simark.ca>
References: <1583933970-68840-1-git-send-email-mingli.yu@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from simark.ca (simark.ca [158.69.221.121])
 by lists.lttng.org (Postfix) with ESMTPS id 48ctsq3Yx2z1G64
 for <lttng-dev@lists.lttng.org>; Wed, 11 Mar 2020 10:01:18 -0400 (EDT)
In-Reply-To: <1583933970-68840-1-git-send-email-mingli.yu@windriver.com>
Content-Language: en-US-large
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: mingli.yu@windriver.com, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 2020-03-11 9:39 a.m., mingli.yu@windriver.com wrote:
> From: Mingli Yu <mingli.yu@windriver.com>
> 
> Initialize the pointer other_entry to fix the below error:
> | ../../../../../git/src/plugins/ctf/fs-src/fs.c: In function 'ds_index_insert_ds_index_entry_sorted':
> | ../../../../../git/src/plugins/ctf/fs-src/fs.c:702:5: error: 'other_entry' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> |  702 |    !ds_index_entries_equal(entry, other_entry)) {
> 
> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>

Hi Mingli,

Thanks for the patch.  Could you please mention the compiler you are using
(which architecture and which version), as well as the full command line
used to compile that file (shown with "make V=1"?

Thank you,

Simon
