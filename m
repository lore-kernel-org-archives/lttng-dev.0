From: Julien Desfossez <julien.desfossez@polymtl.ca>
Subject: Re: "No space left on device" results in corrupt trace
 data set
Date: Fri, 16 Nov 2012 10:54:28 -0500
Message-ID: <50A661B4.10009__9903.05208038098$1353081310$gmane$org@polymtl.ca>
References: <50A655A1.6040804@mentor.com> <50A65BC4.3020708@efficios.com>
	<20121116153029.GB23798@Krystal> <50A65E22.3040203@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([93.20.26.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <julien.desfossez@polymtl.ca>) id 1TZOFZ-00071p-2d
	for lttng-dev@lists.lttng.org; Fri, 16 Nov 2012 10:54:37 -0500
In-Reply-To: <50A65E22.3040203@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org



On 16/11/12 10:39 AM, Woegerer, Paul wrote:
> On 11/16/2012 04:30 PM, Mathieu Desnoyers wrote:
>> * David Goulet (dgoulet@efficios.com) wrote:
>>> Hi Paul,
>>>
>>> The problem here would be that metadata can grow arbitrarily over time
>>> when let say new events are enabled during tracing or a new lib is
>>> dynamically loaded in the application you are tracing. Same goes for the
>>> kernel for loaded module or CPU hotplug...
>>>
>>> To achieve a static size of metadata during the whole life of a tracing
>>> session, I guess we need somekind of flag or option set to tell the
>>> tracers to just deny new events once started... which from there, we
>>> need Mathieu's opinion :)
>>
>> live support will eventually allow to side-track this whole issue by
>> flushing metadata to disk periodically during tracing,
> 
> Does that mean that the live tracing feature that currently lives in the
> lttngtop-live branch will go into lttng-tools and babeltrace any time soon ?

The main change of lttng-tools 2.2 is the live tracing feature.
The way it is implemented in the lttngtop-live branch is more a
proof-of-concept, we will be starting the clean implementation
discussions here as soon as we have lttng-tools 2.1 released (which
should be around the end of this month).

In the mean time, to solve the problem you are currently experiencing,
you could manually add a flush on the metadata channel after the session
is started to make sure it is written on disk quickly (that's what is
done in lttngtop-live at the beginning). Of course like David said, if
you have new events/applications enabled during tracing, the metadata
needs to be flushed again.

Thanks,

Julien


> 
> Thanks
> Paul
> 
>>
>> Thanks,
>>
>> Mathieu
>>
>>>
>>> Cheers!
>>> David
>>>
>>> Woegerer, Paul:
>>>> Hi,
>>>>
>>>> embedded users sometimes have to trace to tmpfs (e.g. streaming in not
>>>> an option due to missing network connectivity).
>>>>
>>>> Ramdisks of 16M to 128M size are created and as long as the ram disk
>>>> does not get full, tracing works fine. Unfortunately if the disk gets
>>>> full things fall apart:
>>>>
>>>> PERROR: Error in file write: No space left on device [in
>>>> lttng_consumer_on_read_subbuffer_mmap() at consumer.c:1367]
>>>>
>>>> The consumer daemon will not be able to write the metadata channel and
>>>> therefore the trace data set will be unusable (cannot be read with
>>>> babeltrace).
>>>>
>>>> -rwxrwxrwx 1 testuser users        0 Nov 16 11:22 metadata
>>>> -rwxrwxrwx 1 testuser users 15728640 Nov 16 11:22 myevents_0
>>>> -rwxrwxrwx 1 testuser users     4096 Nov 16 11:22 myevents_1
>>>>
>>>> Is it possible to somehow reserve the file size (fallocate) for metadata
>>>> so that in case the disk gets full at least the metadata gets written
>>>> and the resulting trace set is readable with babeltrace ?
>>>>
>>>> I wonder if that is possible at all. The consumer daemon doesn't know
>>>> upfront how much would need to be reserved for metadata, right ?
>>>>
>>>> Any ideas ?
>>>>
>>>> Thanks,
>>>> Paul
>>>>
>>>>
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
> 
> 
