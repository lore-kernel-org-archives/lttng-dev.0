From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: Merge two LTTng CTF traces into one
Date: Mon, 22 Dec 2014 12:54:22 -0500
Message-ID: <54985ACE.1000502__36417.9815435365$1419270933$gmane$org@ericsson.com>
References: <1431870336.8158578.1419253660346.JavaMail.root@polymtl.ca>
 <549835FE.8090508@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <matthew.khouzam@ericsson.com>) id 1Y37Bk-0006Na-J0
 for lttng-dev@lists.lttng.org; Mon, 22 Dec 2014 12:54:39 -0500
In-Reply-To: <549835FE.8090508@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Sorry, I was a little hasty in my reply. You can export traces, but not
experiments yet, this is a feature to expect soon if people want it.


On 14-12-22 10:17 AM, Matthew Khouzam wrote:
> Michel has hit the nail on the head there.
>
> I would just like to add that one can export an experiment in trace
> compass. This means that the two traces are shipped in a zip with the
> synchronization. You can also apply a constant clock offset if network
> events are unavailable. If you really really want to make a CTF trace as
> an output, perhaps look at the python bound babeltrace?
>
> BR
>
> Matthew
>
>
> On 14-12-22 08:07 AM, Michel Dagenais wrote:
>> Normally, the two traces are stored separately and they are "merged"
>> at display time in TraceCompass. If they were taken on the same host,
>> they use the same clock and should be naturally aligned. If they come
>> from different hosts and you want very fine symchronization, you need
>> some communication events from which to synchronize the traces. TCP
>> packet send and receive events are typically used. If you want to look
>> at two traces simultaneously, it normally implies that the two are
>> related, the two nodes communicating through the network.
>>
>> ------------------------------------------------------------------------
>>
>>     Hi,
>>
>>     Is there any way to merge the two CTF traces and see them in one
>>     with trace synchronization ? 
>>
>>     How it is related to trace synchronization using network events ? 
>>
>>
>>     Thanks,
>>     Divya
>>
>>     _______________________________________________
>>     lttng-dev mailing list
>>     lttng-dev@lists.lttng.org
>>     http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
