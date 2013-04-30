From: Mats Liljegren <liljegren.mats2@gmail.com>
Subject: Re: Changed scheduling when using lttng
Date: Tue, 30 Apr 2013 15:19:59 +0200
Message-ID: <CA+xJJ19UQ_hh-rfjhor8pHCDL0XRGyW+ZfPzQiYBfdBsj=r0xg__23847.520343452$1367328044$gmane$org@mail.gmail.com>
References: <CA+xJJ18hL16P3gvowveWVfg+ZNh=cjEFOoPisznU0y28YfCdbw@mail.gmail.com>
	<20130425151213.GC7970@Krystal>
	<CA+xJJ1-U_Y0DuLNJ+xwBLPLF+5LyS=mO4f7onpquEHSrbyOUAQ@mail.gmail.com>
	<20130426132639.GA1468@Krystal>
	<CA+xJJ19OE=nrfpEoOEib-7=GrP9hD-RV7bc=aY7nqDwB59auXQ@mail.gmail.com>
	<20130426151444.GA2260@Krystal>
	<CA+xJJ199oic8pmnKM4c674Zf_NJe3AR1YxFtBTjLryv3S67nkQ@mail.gmail.com>
	<20130426153819.GA3026@Krystal>
	<CA+xJJ18ea02rKcfJmw9B2bTOBY0Mz_Wr6c+aszb3HWPDz2zRAQ@mail.gmail.com>
	<20130426161439.GA5547@Krystal>
	<CA+xJJ181-F-36Kw18Z5R9rvhzDeNfUgNQofHrowmY5raZA2Qtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <liljegren.mats2@gmail.com>) id 1UXATV-0004xh-76
	for lttng-dev@lists.lttng.org; Tue, 30 Apr 2013 09:20:05 -0400
Received: by mail-ee0-f46.google.com with SMTP id c13so248750eek.19
	for <lttng-dev@lists.lttng.org>; Tue, 30 Apr 2013 06:19:59 -0700 (PDT)
In-Reply-To: <CA+xJJ181-F-36Kw18Z5R9rvhzDeNfUgNQofHrowmY5raZA2Qtw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

I've done some code diving now, and I feel stupid...

I thought I could get global buffers in kernel traces using option
--buffers-global, as the help text seemed to indicate this:
$ lttng enable-channel --help
usage: lttng enable-channel NAME[,NAME2,...] [-u|-k] [OPTIONS]

Options:
  -h, --help               Show this help
      --list-options       Simple listing of options
  -s, --session NAME       Apply to session name
  -k, --kernel             Apply to the kernel tracer
  -u, --userspace          Apply to the user-space tracer

Channel options:
      --discard            Discard event when buffers are full (default)
      --overwrite          Flight recorder mode
      --subbuf-size SIZE   Subbuffer size in bytes
                               (default: 4096, kernel default: 262144)
                               Needs to be a power of 2 for
                               kernel and ust tracers
      --num-subbuf NUM     Number of subbufers
                               (default: 4)
                               Needs to be a power of 2 for
                               kernel and ust tracers
      --switch-timer USEC  Switch timer interval in usec (default: 0)
      --read-timer USEC    Read timer interval in usec (UST default:
0, kernel default: 200000)
      --output TYPE        Channel output type (Values: mmap, splice)
      --buffers-uid        Use per UID buffer (-u only)
      --buffers-pid        Use per PID buffer (-u only)
      --buffers-global     Use shared buffer for the whole system (-k only)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  -C, --tracefile-size SIZE
                           Maximum size of of each tracefile within a
stream (in bytes).
  -W, --tracefile-count COUNT
                           Used in conjunction with -C option, this
will limit the number
                           of files created to the specified count.

I look in src/bin/lttng/commands/enable_channels.c, the long option
array will point to opt_buffer_global. The only use for this file
private variable is for a single sanity check. I cannot see any other
use of it. Have I missed something here?

But in this file, function enable_channel(), I see:

                dom.buf_type = LTTNG_BUFFER_GLOBAL;

This is executed for the kernel case. But my buffers are still
allocated per-cpu. What is going on? Where did this configuration go?
What does it do?

If I take this from the other end, I'd like to use the line:
    .alloc = RING_BUFFER_ALLOC_GLOBAL
found in
    lttng-ring-buffer-metadata-client.h
How do I make this happen?

Thanks
   Mats
