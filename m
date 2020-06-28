From: "changcheng.liu--- via lttng-dev" <lttng-dev@lists.lttng.org>
Subject: babeltrace convert call_site addr to func/offset
Date: Sun, 28 Jun 2020 12:05:02 +0800
Message-ID: <20200628040502.GA36830@jerryopenix>
Reply-To: changcheng.liu@aliyun.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by lists.lttng.org (Postfix) with ESMTPS id 49vcbG6tlxz16Gm
 for <lttng-dev@lists.lttng.org>; Sun, 28 Jun 2020 00:10:02 -0400 (EDT)
Content-Disposition: inline
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
Cc: changcheng.liu@aliyun.com
List-Id: lttng-dev@lists.lttng.org

Hi all,
   I checked lttng-ust-cry-profile source code:
   https://github.com/lttng/lttng-ust/blob/master/liblttng-ust-cyg-profile/lttng-ust-cyg-profile.c

   It traced the runtime virtual-address(VA) of the
   1) called function address
   2) caller address

   The value of VA is different from the linked address.
   Due to ASLR, the VA could be different when running the program every
   time.
   The babeltrace could covert the "ip" in the traced context into
   func/offset. However, there's no context to trace the call_site and
   babeltrace also support convert the "call_site" into func/offset.

   Does lttng community has plan to supply the function to support
   "call_site" context and make babeltrace could convert the "call_site"
   into func/offset format?

B.R.
Changcheng
