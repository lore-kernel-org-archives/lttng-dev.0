From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Unable to import big LTTng traces
Date: Thu, 13 Dec 2012 13:08:18 -0500
Message-ID: <50CA1992.9020706__7548.29172879017$1355422217$gmane$org@voxpopuli.im>
References: <CAMSKo873P7Tm_xGoYfSx1aQMSO7AnQrpUSUCpS-r_mP5EpTOcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1TjDDv-0006kd-Vx
	for lttng-dev@lists.lttng.org; Thu, 13 Dec 2012 13:09:32 -0500
In-Reply-To: <CAMSKo873P7Tm_xGoYfSx1aQMSO7AnQrpUSUCpS-r_mP5EpTOcw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Radhika Chowdary <radhika.putty@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 12-12-12 12:59 AM, Radhika Chowdary wrote:
> Hi
>
> I am using linuxtools plugins for importing LTTng traces. I have a trace
> folder of size 400MB and when I try to import it in the Traces folder it
> takes for ever to import it. At the bottom left corner I see Indexing...
> Events view gets populated soon but not others.

Hi,

It is expected that the indexing phase takes a while for very large
trace. It could probably be optimized a bit too, since we haven't spent
much time on performance improvements. Good news is that once indexed,
it will be faster to reopen the same trace later on.

We have not yet implemented a percentage progression monitor for the
indexing job. This is not trivial since it has to be implemented
differently depending on the trace type, but would definitely be nice to
have.

If you use the latest master branch, the timestamps for the start and
end of the histogram are now correctly formatted, so it is possible to
know roughly where the indexing is at, provided you know the end time of
your trace. I'd suggest trying that out to make sure it's not stopping
at some point, which would be a bug.

> Is there a limit on the size of traces that it can import?

There is no theoretical limit on the trace size that can be imported. It
is capped only by your patience ;)  and the amount of available disk
space, since the index files can be quite big too.


Cheers,
Alex
