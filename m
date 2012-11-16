From: David Goulet <dgoulet@efficios.com>
Subject: Re: "No space left on device" results in corrupt trace
 data set
Date: Fri, 16 Nov 2012 10:29:08 -0500
Message-ID: <50A65BC4.3020708__28882.6338052333$1353079789$gmane$org@efficios.com>
References: <50A655A1.6040804@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TZNqx-0006lI-RJ
	for lttng-dev@lists.lttng.org; Fri, 16 Nov 2012 10:29:12 -0500
In-Reply-To: <50A655A1.6040804@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Paul,

The problem here would be that metadata can grow arbitrarily over time
when let say new events are enabled during tracing or a new lib is
dynamically loaded in the application you are tracing. Same goes for the
kernel for loaded module or CPU hotplug...

To achieve a static size of metadata during the whole life of a tracing
session, I guess we need somekind of flag or option set to tell the
tracers to just deny new events once started... which from there, we
need Mathieu's opinion :)

Cheers!
David

Woegerer, Paul:
> Hi,
> 
> embedded users sometimes have to trace to tmpfs (e.g. streaming in not
> an option due to missing network connectivity).
> 
> Ramdisks of 16M to 128M size are created and as long as the ram disk
> does not get full, tracing works fine. Unfortunately if the disk gets
> full things fall apart:
> 
> PERROR: Error in file write: No space left on device [in
> lttng_consumer_on_read_subbuffer_mmap() at consumer.c:1367]
> 
> The consumer daemon will not be able to write the metadata channel and
> therefore the trace data set will be unusable (cannot be read with
> babeltrace).
> 
> -rwxrwxrwx 1 testuser users        0 Nov 16 11:22 metadata
> -rwxrwxrwx 1 testuser users 15728640 Nov 16 11:22 myevents_0
> -rwxrwxrwx 1 testuser users     4096 Nov 16 11:22 myevents_1
> 
> Is it possible to somehow reserve the file size (fallocate) for metadata
> so that in case the disk gets full at least the metadata gets written
> and the resulting trace set is readable with babeltrace ?
> 
> I wonder if that is possible at all. The consumer daemon doesn't know
> upfront how much would need to be reserved for metadata, right ?
> 
> Any ideas ?
> 
> Thanks,
> Paul
> 
> 
