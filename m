From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: HugePages shared memory support in LLTng
Date: Mon, 15 Jul 2019 10:33:02 -0400
Message-ID: <20190715143302.GA2017__45059.7121309087$1563201209$gmane$org@joraj-alpa>
References: <CAO+PNdHdLFk=Q0L2BLGnz8xCvdgMw3aYpZuAZumBOWKraKTnAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45nQxN3JHtz168R
 for <lttng-dev@lists.lttng.org>; Mon, 15 Jul 2019 10:33:12 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id AF13F24AD0A
 for <lttng-dev@lists.lttng.org>; Mon, 15 Jul 2019 10:33:06 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAO+PNdHdLFk=Q0L2BLGnz8xCvdgMw3aYpZuAZumBOWKraKTnAw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yiteng Guo <guoyiteng@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Yiteng,

On Fri, Jul 12, 2019 at 06:18:44PM -0400, Yiteng Guo wrote:
> Hello,
> 
> I am wondering if there is any way for lttng-ust to create its shm on
> hugepages. I noticed that there was an option `--shm-path` which can be
> used to change the location of shm. However, if I specified the path to a
> `hugetlbfs` such as /dev/hugepages, I would get errors in lttng-sessiond
> and no trace data were generated.
> 
> The error I got was
> ```
> PERROR - 17:54:56.740674 [8163/8168]: Error appending to metadata file:
> Invalid argument (in lttng_metadata_printf() at ust-metadata.c:176)
> Error: Failed to generate session metadata (errno = -1)
> ```
> I took a look at lttng code base and found that lttng used `write` to
> generate a metadata file under `--shm-path`. However, it looks like
> `hugetlbfs` does not support `write` operation. I did a simple patch with
> `mmap` to get around this problem. Then, I got another error:

Would you be interested in sharing this patch so we can help you figure out the
problem?

A github branch would be perfect.

> ```
> Error: Error creating UST channel "my-channel" on the consumer daemon
> ```

Make sure to pass "--verbose-consumer" to lttng-sessiond. It will ensure that
the lttng-consumerd output is present in lttng-sesssiond logs. It should help a
bit

I suspect that we fail on buffers allocation.

> This time, I could not locate the problem anymore :(. Do you have any idea
> of how to get hugepages shm work in lttng?
> 
> To give you more context here, I was tracing a performance sensitive
> program. I didn't want to suffer from the sub-buffer switch cost so I
> created a very large sub-buffer (1MB).

If you don't mind, how many core are present? How much memory is available on
the host?

Could you share with us the complete sequence of command you use to setup your
tracing session?

If it is not much trouble could you also share the step you took to setup/mount
your hugetlbfs path?

> I did a benchmark on my tracepoint
> and noticed that after running a certain number of tracepoints, I got a
> noticeably larger overhead (1200ns larger than other) for every ~130
> tracepoints. It turned out that this large overhead was due to a page
> fault. The numbers were matched up (130 * 32 bytes = 4160 bytes, which is
> approximately the size of a normal page 4kB) and I also used lttng perf
> page fault counters to verify it. Therefore, I am looking for a solution to
> have lttng create shm on hugepages.

Quite interesting!

> 
> Thank you very much! I look forward to hearing from you.
> 
> Best,
> Yiteng

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Jonathan Rajotte-Julien
EfficiOS
