From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: "No space left on device" results in corrupt trace
 data set
Date: Fri, 16 Nov 2012 16:59:02 +0100
Message-ID: <50A662C6.5050507__32897.7703270086$1353081514$gmane$org@mentor.com>
References: <50A655A1.6040804@mentor.com> <50A65BC4.3020708@efficios.com>
	<20121116153029.GB23798@Krystal> <50A65E22.3040203@mentor.com>
	<50A661B4.10009@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1TZOIp-00073c-U7
	for lttng-dev@lists.lttng.org; Fri, 16 Nov 2012 10:58:00 -0500
In-Reply-To: <50A661B4.10009@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <julien.desfossez@polymtl.ca>
Cc: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

On 11/16/2012 04:54 PM, Julien Desfossez wrote:
> On 16/11/12 10:39 AM, Woegerer, Paul wrote:
>> Does that mean that the live tracing feature that currently lives in the
>> lttngtop-live branch will go into lttng-tools and babeltrace any time so=
on ?
> =

> The main change of lttng-tools 2.2 is the live tracing feature.
> The way it is implemented in the lttngtop-live branch is more a
> proof-of-concept, we will be starting the clean implementation
> discussions here as soon as we have lttng-tools 2.1 released (which
> should be around the end of this month).
> =

> In the mean time, to solve the problem you are currently experiencing,
> you could manually add a flush on the metadata channel after the session
> is started to make sure it is written on disk quickly (that's what is
> done in lttngtop-live at the beginning). Of course like David said, if

I will try that. Thanks !

--
Paul

> you have new events/applications enabled during tracing, the metadata
> needs to be flushed again.
> =

> Thanks,
> =

> Julien
> =

> =

>>
>> Thanks
>> Paul
>>
>>>
>>> Thanks,
>>>
>>> Mathieu
>>>
>>>>
>>>> Cheers!
>>>> David
>>>>
>>>> Woegerer, Paul:
>>>>> Hi,
>>>>>
>>>>> embedded users sometimes have to trace to tmpfs (e.g. streaming in not
>>>>> an option due to missing network connectivity).
>>>>>
>>>>> Ramdisks of 16M to 128M size are created and as long as the ram disk
>>>>> does not get full, tracing works fine. Unfortunately if the disk gets
>>>>> full things fall apart:
>>>>>
>>>>> PERROR: Error in file write: No space left on device [in
>>>>> lttng_consumer_on_read_subbuffer_mmap() at consumer.c:1367]
>>>>>
>>>>> The consumer daemon will not be able to write the metadata channel and
>>>>> therefore the trace data set will be unusable (cannot be read with
>>>>> babeltrace).
>>>>>
>>>>> -rwxrwxrwx 1 testuser users        0 Nov 16 11:22 metadata
>>>>> -rwxrwxrwx 1 testuser users 15728640 Nov 16 11:22 myevents_0
>>>>> -rwxrwxrwx 1 testuser users     4096 Nov 16 11:22 myevents_1
>>>>>
>>>>> Is it possible to somehow reserve the file size (fallocate) for metad=
ata
>>>>> so that in case the disk gets full at least the metadata gets written
>>>>> and the resulting trace set is readable with babeltrace ?
>>>>>
>>>>> I wonder if that is possible at all. The consumer daemon doesn't know
>>>>> upfront how much would need to be reserved for metadata, right ?
>>>>>
>>>>> Any ideas ?
>>>>>
>>>>> Thanks,
>>>>> Paul
>>>>>
>>>>>
>>>>
>>>> _______________________________________________
>>>> lttng-dev mailing list
>>>> lttng-dev@lists.lttng.org
>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>>
>>


-- =

Paul Woegerer | SW Development Engineer
http://go.mentor.com/sourceryanalyzer

Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject
to Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and
other countries.
