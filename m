From: "Yu, Mingli via lttng-dev" <lttng-dev@lists.lttng.org>
Subject: Re: [babeltrace][PATCH] fs.c: initialize the
 other_entry variable
Date: Thu, 12 Mar 2020 03:37:18 +0000
Message-ID: <E6F6D39CB834524199A3A6D928AB146553A0A5EC@ALA-MBD.corp.ad.wrs.com>
References: <1583933970-68840-1-git-send-email-mingli.yu@windriver.com>,
 <a2a63a78-f39b-b64a-f09a-08e096dc6563@simark.ca>
Reply-To: "Yu, Mingli" <Mingli.Yu@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
 by lists.lttng.org (Postfix) with ESMTPS id 48dGCL5pJwz1GjY
 for <lttng-dev@lists.lttng.org>; Thu, 12 Mar 2020 00:32:46 -0400 (EDT)
In-Reply-To: <a2a63a78-f39b-b64a-f09a-08e096dc6563@simark.ca>
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
To: Simon Marchi <simark@simark.ca>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Simon,

The compiler: GCC 9.2.0
The error can occur when additionally add " -Og".

Thanks,
Mingli
________________________________________
From: Simon Marchi [simark@simark.ca]
Sent: Wednesday, March 11, 2020 9:52 PM
To: Yu, Mingli; lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] [babeltrace][PATCH] fs.c: initialize the other_entry variable

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
