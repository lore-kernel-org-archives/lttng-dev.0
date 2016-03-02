From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: Segfault during process exit
Date: Wed, 2 Mar 2016 17:26:57 -0500
Message-ID: <56D768B1.3040302__29466.5416390218$1456957678$gmane$org@efficios.com>
References: <DM3PR13MB07829B1DB9D8EEE29BE9124BC7BC0@DM3PR13MB0782.namprd13.prod.outlook.com>
 <56D73D48.3070700@efficios.com>
 <DM3PR13MB0782CC28E9FE90AA3B35B8E9C7BC0@DM3PR13MB0782.namprd13.prod.outlook.com>
 <56D74E7B.3090901@efficios.com>
 <DM3PR13MB078236DB9E87094C58A69437C7BC0@DM3PR13MB0782.namprd13.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.rajotte-julien@efficios.com>)
 id 1abFEX-00059v-OJ
 for lttng-dev@lists.lttng.org; Wed, 02 Mar 2016 17:27:07 -0500
In-Reply-To: <DM3PR13MB078236DB9E87094C58A69437C7BC0@DM3PR13MB0782.namprd13.prod.outlook.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jeffrey Chen <cpthk@live.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


On 2016-03-02 05:13 PM, Jeffrey Chen wrote:
>
> Thanks!
>
> I will try to get a sample executable. But, just from the theory point 
> of view, this issue is possible, right?
>

The nice thing with bugs is that in theory there is none.

Make sure you have a reproducer and we will work from there.

Cheers!

>
>
>
> ------------------------------------------------------------------------
> *From:* Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
> *Sent:* Wednesday, March 2, 2016 12:35 PM
> *To:* Jeffrey Chen
> *Cc:* lttng-dev@lists.lttng.org
> *Subject:* Re: [lttng-dev] Segfault during process exit
> Hi,
>
> Don't forget to cc the mailing list.
>
> On 2016-03-02 02:42 PM, Jeffrey Chen wrote:
>>
>> Even I share our executable, you will not be able to run on your 
>> machine, as it depends on our environment.
>>
> This is expected, it's also why I asked you if you could provide a 
> reproducer, a simpler version of your problem that reproduce the 
> behavior even sporadically.
>
>> The idea is that, if you spawn some threads, and these threads keep 
>> writing traces through LTTng. Then, exit the main thread, as in 
>> return main() function. LTTng's logic will do cleanup itself, but my 
>> other threads are still writing to LTTng. This would cause segfault. 
>> It would try to reference address 0x0.
>>
> This could be a good start for a simple reproducer.
>
> Cheers
>>
>>
>> #0 0x0000000000000000 in ?? ()
>> #1  0x00007f7e31fdfd78 in __tracepoint_cb_processor___tracepoint_info (
>>     taskNameArg=0x1cf3c30 "BackgroundTask", dataArg=0x1fd5200 "S")
>>
>> ...
>>
>> ------------------------------------------------------------------------
>> *From:* Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
>> *Sent:* Wednesday, March 2, 2016 11:21 AM
>> *To:* Jeffrey Chen
>> *Cc:* lttng-dev@lists.lttng.org
>> *Subject:* Re: [lttng-dev] Segfault during process exit
>> Hi,
>>
>> Could you provide a reproducer ?
>>
>> Could you give us some context ?
>>
>> Thanks
>>
>> On 2016-03-02 02:07 PM, Jeffrey Chen wrote:
>>>
>>> Hi:
>>>
>>>
>>> Our system process will spawn several background threads to do 
>>> tasks. During the process exit, there is no guarantee that these 
>>> background threads are finished. I have noticed several times that 
>>> the execution would segfault during exiting. The stacktrace is 
>>> showing that the segfault happened at the call to write trace, 
>>> tracepoint(). My guess is that LTTng cleaned up the tracing 
>>> connection, and the background thread was still running. Has anyone 
>>> noticed this issue? I thought about trying wait for all the 
>>> background threads to complete, but this is very difficult to do in 
>>> a complex system, as the background thread could spawn more threads 
>>> during the process. Is there any way to solve this? Thanks.
>>>
>>>
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>> -- 
>> Jonathan R. Julien
>> Efficios
>
> -- 
> Jonathan R. Julien
> Efficios

-- 
Jonathan R. Julien
Efficios
