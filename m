From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: Unable to import big LTTng traces
Date: Fri, 4 Jan 2013 11:43:32 -0500
Message-ID: <50E706B4.7090509__17994.2467985258$1357317974$gmane$org@ericsson.com>
References: <CAMSKo873P7Tm_xGoYfSx1aQMSO7AnQrpUSUCpS-r_mP5EpTOcw@mail.gmail.com>
	<50CA1992.9020706@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from imr4.ericy.com ([198.24.6.9])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1TrAOY-00019H-0O
	for lttng-dev@lists.lttng.org; Fri, 04 Jan 2013 11:45:22 -0500
Received: from EUSAAHC002.ericsson.se ([147.117.188.78])
	by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id
	r04Gx86D006651
	for <lttng-dev@lists.lttng.org>; Fri, 4 Jan 2013 10:59:13 -0600
In-Reply-To: <50CA1992.9020706@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

There is a limit to the actual size of the trace being imported
depending on your ram, the parser reads an index and keeps it in memory.
This requires approx 0.004% of the trace size using default settings.
This means if you load a 1 tb trace, you need 400 mb of ram. 400 mb of
ram needs about 16k of ram plus overhead so let's say 1-2 mb. Is it a
kernel trace? if so then you're also building the state system at the
same time and the statistics... this will take a short while. Normally
under 2 minutes (I have a core 2 duo laptop with a 5400 rpm hdd and it
takes 2min for 433 mb with no state system) , so a coffee/tea break,
when you're back, you will have lightning fast views. :)

Maybe we should put a more descriptive please wait message.


On 12-12-13 01:08 PM, Alexandre Montplaisir wrote:
> On 12-12-12 12:59 AM, Radhika Chowdary wrote:
>> Hi
>>
>> I am using linuxtools plugins for importing LTTng traces. I have a trace
>> folder of size 400MB and when I try to import it in the Traces folder it
>> takes for ever to import it. At the bottom left corner I see Indexing...
>> Events view gets populated soon but not others.
> Hi,
>
> It is expected that the indexing phase takes a while for very large
> trace. It could probably be optimized a bit too, since we haven't spent
> much time on performance improvements. Good news is that once indexed,
> it will be faster to reopen the same trace later on.
>
> We have not yet implemented a percentage progression monitor for the
> indexing job. This is not trivial since it has to be implemented
> differently depending on the trace type, but would definitely be nice to
> have.
>
> If you use the latest master branch, the timestamps for the start and
> end of the histogram are now correctly formatted, so it is possible to
> know roughly where the indexing is at, provided you know the end time of
> your trace. I'd suggest trying that out to make sure it's not stopping
> at some point, which would be a bug.
>
>> Is there a limit on the size of traces that it can import?
> There is no theoretical limit on the trace size that can be imported. It
> is capped only by your patience ;)  and the amount of available disk
> space, since the index files can be quite big too.
>
>
> Cheers,
> Alex
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
