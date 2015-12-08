From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: Relayd trace drops
Date: Tue, 8 Dec 2015 14:27:47 -0500
Message-ID: <56672F33.3070808__5297.24466982788$1449602938$gmane$org@efficios.com>
References: <CACd+_b7qEeW1XD1H_0MT4dDqwLv68rfOURfNDRh6SO=xS4k-Og@mail.gmail.com>
 <CA+jJMxsuF+Ywvvhe3L4OqBHTsohyFffPoF4mZWFDqPvBC-P80w@mail.gmail.com>
 <CACd+_b5AGJKWH58Kq3QP8qW8R7Q9JH3fqbEwU=z8pyg5-DL=KQ@mail.gmail.com>
 <CA+jJMxsJReP4ZO2bSJP-rJe+UoJzT09Pix1LhEypbsww_nwrsA@mail.gmail.com>
 <CACd+_b7ScRDo9uL+neOnA2pqVVwexsPsbBd2mBS--yy7Amxbmg@mail.gmail.com>
 <CAF4oYfF2Li4zau0OLE=JZUtGfPZyFT1FciBr7AG1hvzGdeUycA@mail.gmail.com>
 <CACd+_b6byMnZ_oWBqEk44fJOgpVX-oAGMjfh_WV8AV6cKyK9iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.rajotte-julien@efficios.com>)
 id 1a6Nva-0006bu-Sc
 for lttng-dev@lists.lttng.org; Tue, 08 Dec 2015 14:28:00 -0500
In-Reply-To: <CACd+_b6byMnZ_oWBqEk44fJOgpVX-oAGMjfh_WV8AV6cKyK9iw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Aravind HT <aravind.ht@gmail.com>, Jonathan Rajotte <jonathan.r.julien@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Aravind,

There is no README in the archive you sent.

Cheers

On 2015-12-08 07:51 AM, Aravind HT wrote:
> Hi,
>
> I am trying to upgrade in parallel, but this issue may still be =

> present after I upgrade or may be temporarily masked. So I need to =

> find the root cause for this and then see if its available on the =

> latest before committing to upgrade.
>
> There is another issue i'm hitting, the lttng list command hangs after =

> lttng destroy session when running the profiling.
>
> I found that consumerd 64 goes into an infinite loop waiting to flush =

> metadata in lttng_ustconsumer_recv_metadata() :: while =

> (consumer_metadata_cache_flushed(channel, offset + len, timer)) .
> In consumer_metadata_cache, channel->metadata_stream->endpoint_status =

> is CONSUMER_ENDPOINT_ACTIVE, metadata_stream->ust_metadata_pushed is 0 =

> with offset having some value. This call always returns a 1 from the =

> last else{} block resulting in an infinite loop. Upon searching the =

> forum, I found the same issue being reported here :
> https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg07982.html
>
> Regards,
> Aravind.
>
>
> On Tue, Dec 8, 2015 at 12:43 AM, Jonathan Rajotte =

> <jonathan.r.julien@gmail.com> wrote:
>
>     Hi Aravind,
>
>     Did you have the chance to upgrade to 2.6.1.If so where you able
>     to reproduce?
>
>     Cheers
>
>     On Mon, Dec 7, 2015 at 1:07 PM, Aravind HT <aravind.ht@gmail.com>
>     wrote:
>
>         Hi,
>
>         I have attached the complete profiling scripts here, its a bit
>         shabby, im new to python.
>
>         There is a README which has the details on how to execute it.
>         Im using a Yocto 1.6 on x86_64 platforms on both the nodes.
>
>
>         Running this script when there are other sessions running
>         seems to reproduce this problem easily.
>         Please try it and let me know if you have any issues
>         reproducing the problem.
>
>         Regards,
>         Aravind.
>
>         On Sat, Dec 5, 2015 at 5:23 PM, J=E9r=E9mie Galarneau
>         <jeremie.galarneau@efficios.com
>         <mailto:jeremie.galarneau@efficios.com>> wrote:
>
>             On Fri, Dec 4, 2015 at 11:06 PM, Aravind HT
>             <aravind.ht@gmail.com <mailto:aravind.ht@gmail.com>> wrote:
>             > I am using 2.6.0 .I will try to share the code that I'm
>             using here in some
>             > time. If there are any specific fixes that are relevant
>             to this issue, see
>             > if you can provide a link to them. I would ideally like
>             to try them out
>             > before trying a full upgrade to the latest versions.
>
>             Hi,
>
>             Can you provide more information on the system? Which
>             distribution,
>             architecture, kernel version?
>
>             The verbose sessiond logs might help pinpoint any
>             unexpected behaviour
>             here (are all applications registering as expected?).
>
>             J=E9r=E9mie
>
>             >
>             > On Fri, Dec 4, 2015 at 6:11 PM, J=E9r=E9mie Galarneau
>             > <jeremie.galarneau@efficios.com
>             <mailto:jeremie.galarneau@efficios.com>> wrote:
>             >>
>             >> Hi Aravind,
>             >>
>             >> Can't say I have looked at everything you sent yet, but
>             as a
>             >> preemptive question, which version are we talking about
>             here? 2.6.0 or
>             >> 2.6.1? 2.6.1 contains a lot of relay daemon fixes.
>             >>
>             >> Thanks,
>             >> J=E9r=E9mie
>             >>
>             >> On Thu, Dec 3, 2015 at 7:01 AM, Aravind HT
>             <aravind.ht@gmail.com> wrote:
>             >> > Hi,
>             >> >
>             >> > I am trying to obtain the performance characteristics
>             of lttng with the
>             >> > use
>             >> > of test applications. Traces are being produced on a
>             local node and
>             >> > delivered to relayd that is running on a separate
>             node for storage.
>             >> >
>             >> > An lttng session with the test applications producing
>             an initial bit
>             >> > rate of
>             >> > 10 kb/s is started and run for about 30 seconds. The
>             starting sub-buffer
>             >> > size is kept at 128 kb and sub-buf count at 4. The
>             session is then
>             >> > stopped
>             >> > and destroyed and traces are analyzed to see if there
>             are any drops.
>             >> > This is
>             >> > being done in a loop with every subsequent session
>             having an increment
>             >> > of 2
>             >> > kb/s as long as there are no drops. If there are
>             drops, I increase the
>             >> > buffer size by a factor of x2 without incrementing
>             the bit rate.
>             >> >
>             >> > I see trace drops happening consistently with test
>             apps producing traces
>             >> > at
>             >> > less than 40 kb/s, it doesnt seem to help even if I
>             started with 1mb x 4
>             >> > sub-buffers.
>             >> >
>             >> > Analysis :
>             >> >
>             >> > I have attached the lttng_relayd , lttng_consumerd_64
>             logs and the
>             >> > entire
>             >> > trace directory, hope you will be able to view it.
>             >> > I have modified lttng_relayd code to dump the traces
>             being captured in
>             >> > the
>             >> > lttng_relayd logs along with debug info.
>             >> >
>             >> > Each test app is producing logs in the form of  :
>             >> > "TraceApp PID - 31940 THID - 31970 @threadRate - 1032
>             b/s appRate - 2079
>             >> > b/s
>             >> > threadTraceNum - 9 appTraceNum - 18  sleepTime - 192120"
>             >> >
>             >> > The test application PID, test application thread id,
>             thread bit rate,
>             >> > test
>             >> > app bit rate, thread trace number and application
>             trace number s are
>             >> > part of
>             >> > the trace. So in the above trace, the thread is
>             producing at 1 kb/s and
>             >> > the
>             >> > whole test app is producing at 2 kb/s.
>             >> >
>             >> > If we look at the babeltrace out put, we see that the
>             Trace with
>             >> > TraceApp
>             >> > PID - 31940 appTraceNum 2 is missing , with 1, 3, 4,
>             5 and so on being
>             >> > successfully captured.
>             >> > I looked at the lttng_relayd logs and found that
>             trace of "appTraceNum
>             >> > 2" is
>             >> > not delivered/generated by the consumerd to the
>             relayd in sequence with
>             >> > other traces. To rule out that this is not a test
>             application problem,
>             >> > you
>             >> > can look at line ltttng_relayd log : 12778 and see
>             traces from
>             >> > appTraceNum -
>             >> > 1 to appTraceNum - 18 including the appTraceNum 2 are
>             "re-delivered" by
>             >> > the
>             >> > consumerd to the relayd.
>             >> > Essentially, I see appTraceNum 1 through appTraceNum
>             18 being delivered
>             >> > twice, once individually where appTraceNum 2 is
>             missing and once as a
>             >> > group
>             >> > at line 12778 where its present.
>             >> >
>             >> >
>             >> > Request help with
>             >> > 1. why traces are delivered twice, is it by design or
>             a genuine problem
>             >> > ?
>             >> > 2. how to avoid traces being dropped even though
>             buffers are
>             >> > sufficiently
>             >> > large enough ?
>             >> >
>             >> >
>             >> > Regards,
>             >> > Aravind.
>             >> >
>             >> > _______________________________________________
>             >> > lttng-dev mailing list
>             >> > lttng-dev@lists.lttng.org
>             >> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>             >> >
>             >>
>             >>
>             >>
>             >> --
>             >> J=E9r=E9mie Galarneau
>             >> EfficiOS Inc.
>             >> http://www.efficios.com
>             >
>             >
>
>
>
>             --
>             J=E9r=E9mie Galarneau
>             EfficiOS Inc.
>             http://www.efficios.com
>
>
>
>         _______________________________________________
>         lttng-dev mailing list
>         lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
>         http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
>
>     -- =

>     Jonathan Rajotte Julien
>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Jonathan R. Julien
Efficios
