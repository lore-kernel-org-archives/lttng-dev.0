From: Sebastien Boisvert <sboisvert@gydle.com>
Subject: perf dynamic tracepoints and lttng
Date: Mon, 29 Jul 2019 15:35:06 -0400
Message-ID: <90e98f76-861e-003a-2fc4-14635d3fb4fb__3951.61392386711$1564428937$gmane$org@gydle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.gydle.com (mail.gydle.com [64.18.173.180])
 by lists.lttng.org (Postfix) with ESMTPS id 45y8zY3Vkkz1G21
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 15:35:21 -0400 (EDT)
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
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

Can lttng (LTTng-UST) see perf dynamic probes ?


# perf probe --list probe_libc:malloc_8
  probe_libc:malloc_8  (on __libc_malloc@glibc-2.27/malloc/malloc.c in /lib/x86_64-linux-gnu/libc-2.27.so)

# lttng list -u
UST events:
-------------
None


(Yes, I am doing this as root..., since libc-2.27.so is owned by root)



I know that perf.data and CTF are 2 different formats though.


Thanks
