From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Issue with fadvise on recent kernel
Date: Sun, 16 Jun 2013 15:55:20 -0400
Message-ID: <51BE1828.3060206__15980.547553818$1371412570$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UoJ2w-00034J-JH
	for lttng-dev@lists.lttng.org; Sun, 16 Jun 2013 15:55:30 -0400
Received: by mail-qc0-f180.google.com with SMTP id a1so1209027qcx.39
	for <lttng-dev@lists.lttng.org>; Sun, 16 Jun 2013 12:55:24 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi all,

We discovered a performance regression in recent kernels with LTTng
related to the use of fadvise DONTNEED.
A call to this syscall is present in the LTTng consumer.

The following kernel commit cause the call to fadvise to be sometime
really slower.

Kernel commit info:
mm/fadvise.c: drain all pagevecs if POSIX_FADV_DONTNEED fails to discard
all pages
main tree: (since 3.9-rc1)
commit 67d46b296a1ba1477c0df8ff3bc5e0167a0b0732
stable tree: (since 3.8.1)
https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit?id=bb01afe62feca1e7cdca60696f8b074416b0910d

On the workload test, we observe that the call to fadvise takes about
4-5 us before this patch is applied. After applying the patch, The
syscall now takes values from 5 us up to 4 ms (4000 us) sometime. The
effect on lttng is that the consumer is frozen for this long period
which leads to dropped event in the trace.

If we remove the call to fadvise in src/common/consumer.c, we don't
have any dropped event and we don't observe any bad side effect.
(The added latency seem to come from the new call to
lru_add_drain_all(). We removed this line and the performance went back
to normal.)

It's obviously a problem in the kernel, but since it impacts LTTng, we
wanted to report it here first and ask advice on what should be the
next step to solve this problem.

If you want to see for youself, you can find the trace with the long
call to fadvise here:
http://www.dorsal.polymtl.ca/~rbeamonte/3.8.0~autocreated-4469887.tar.gz

Yannick and Raphael
