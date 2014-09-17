From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: Live reading without using disk
Date: Wed, 17 Sep 2014 13:36:16 -0400
Message-ID: <5419C690.6050708__14377.5727869526$1410975428$gmane$org@efficios.com>
References: <CAD+1jo_H23O5HiJ9n6VWFDfe7xMTN+26j_0PqXkZjXSYPRO7+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([85.12.144.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1XUJ9U-0003IE-JK
 for lttng-dev@lists.lttng.org; Wed, 17 Sep 2014 13:36:25 -0400
In-Reply-To: <CAD+1jo_H23O5HiJ9n6VWFDfe7xMTN+26j_0PqXkZjXSYPRO7+g@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Elie Abi Saad <abisaad.elie@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

On 14-09-17 06:50 AM, Elie Abi Saad wrote:
> Hi,
> 
> I want to make statistics on tracepoints at runtime and would like to know if
> there is a way to do live reading on traces without flushing them on disk.
> 
> Live mode seems good to me, but do continuously write traces on disk, and
> snapshot mode sounds perfect with the ring buffer mechanism, but we still need
> to record snapshots to read traces.

For now, there is no easy way to extract the trace data directly from
the memory. There are old prototypes and ideas to create a consumerd
that can process the traces in memory but nothing in the mainline. I'm
currently working on ideas around this area but nothing solid yet.

So yes for now, the traces (live or snapshots) must be written on disk
before being available to a viewer.

If space is the problem (especially for the live mode), you can have a
look at the -C and -W options of the "lttng enable-channel" command.
They allow you to limit the maximum disk space that a trace can occupy.
If the problem is the disk I/O, I suggest for now to have a dedicated
disk to store the traces or extract them on the network.
Finally, if the problem is the latency between the event produced and
available to the viewer (and a lower footprint on the system), there is
no easy solution there for now.

Julien
