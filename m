From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: "No space left on device" results in corrupt trace
 data set
Date: Fri, 16 Nov 2012 16:49:35 +0100
Message-ID: <50A6608F.1000800__36604.4877017432$1353080963$gmane$org@mentor.com>
References: <50A655A1.6040804@mentor.com> <50A65BC4.3020708@efficios.com>
	<50A65F08.5060503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1TZO9l-0006yb-1R
	for lttng-dev@lists.lttng.org; Fri, 16 Nov 2012 10:48:37 -0500
In-Reply-To: <50A65F08.5060503@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 11/16/2012 04:43 PM, Yannick Brosseau wrote:
> It could be interesting to at least reserve the size for the first
> packet, so we have at least a little bit of information on the trace.

I tried that with fallocate but unfortunately tmpfs does not seem to
support fallocating files :(

--
Paul

> =

> On 2012-11-16 10:29, David Goulet wrote:
>> Hi Paul,
>>
>> The problem here would be that metadata can grow arbitrarily over time
>> when let say new events are enabled during tracing or a new lib is
>> dynamically loaded in the application you are tracing. Same goes for the
>> kernel for loaded module or CPU hotplug...
>>
>> To achieve a static size of metadata during the whole life of a tracing
>> session, I guess we need somekind of flag or option set to tell the
>> tracers to just deny new events once started... which from there, we
>> need Mathieu's opinion :)
>>
>> Cheers!
>> David
>>
>> Woegerer, Paul:
>>> Hi,
>>>
>>> embedded users sometimes have to trace to tmpfs (e.g. streaming in not
>>> an option due to missing network connectivity).
>>>
>>> Ramdisks of 16M to 128M size are created and as long as the ram disk
>>> does not get full, tracing works fine. Unfortunately if the disk gets
>>> full things fall apart:
>>>
>>> PERROR: Error in file write: No space left on device [in
>>> lttng_consumer_on_read_subbuffer_mmap() at consumer.c:1367]
>>>
>>> The consumer daemon will not be able to write the metadata channel and
>>> therefore the trace data set will be unusable (cannot be read with
>>> babeltrace).
>>>
>>> -rwxrwxrwx 1 testuser users        0 Nov 16 11:22 metadata
>>> -rwxrwxrwx 1 testuser users 15728640 Nov 16 11:22 myevents_0
>>> -rwxrwxrwx 1 testuser users     4096 Nov 16 11:22 myevents_1
>>>
>>> Is it possible to somehow reserve the file size (fallocate) for metadata
>>> so that in case the disk gets full at least the metadata gets written
>>> and the resulting trace set is readable with babeltrace ?
>>>
>>> I wonder if that is possible at all. The consumer daemon doesn't know
>>> upfront how much would need to be reserved for metadata, right ?
>>>
>>> Any ideas ?
>>>
>>> Thanks,
>>> Paul
>>>
>>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =



-- =

Paul Woegerer | SW Development Engineer
http://go.mentor.com/sourceryanalyzer

Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject
to Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and
other countries.
