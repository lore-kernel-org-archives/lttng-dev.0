From: David Goulet <dgoulet@efficios.com>
Subject: Re: Will LTTng overwrite existing trace files after
 reboot, or continue where the previous instance left off?
Date: Wed, 12 Jun 2013 15:18:26 -0400
Message-ID: <51B8C982.50200__2423.37418389997$1371064749$gmane$org@efficios.com>
References: <OFBF5287EA.D7EE217E-ONC2257B88.004F3A88-C2257B88.004FF39E@il.ibm.com>
	<51B88B11.3020401@efficios.com>
	<OF8E263FF5.555C4B70-ONC2257B88.0069603B-C2257B88.006995A6@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UmqYz-00031Z-NM
	for lttng-dev@lists.lttng.org; Wed, 12 Jun 2013 15:18:33 -0400
In-Reply-To: <OF8E263FF5.555C4B70-ONC2257B88.0069603B-C2257B88.006995A6@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hmmmm this is weird because usually you would have
"lttng-traces/<session-name>-<date>-<time>/...." so something is not working right.

Can you open a bug report on bugs.lttng.org and provide the "lttng -vvv" logs
and "lttng-sessiond -vvv" logs also ?

Thanks!
David

Amit Margalit:
> Indeed the path is _not_ different. There is no date-part in the path. I simply
> have ~/lttng-traces/ust/uid/<uid>/64-bit/ ...
> 
> Please remember that I use 2.2.0rc2 and not the latest master. Unfortunately, I
> must retain some level of stability, so if the addition of the date part in the
> path for per-uid buffers is later than 2.2.0rc2 - that would be the cause of the
> difference.
> 
> Amit
> 
> Amit Margalit
> IBM XIV - /Storage Reinvented/
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> 
> 
> 
> From:        David Goulet <dgoulet@efficios.com>
> To:        Amit Margalit/Israel/IBM@IBMIL
> Cc:        lttng-dev@lists.lttng.org
> Date:        06/12/2013 05:51 PM
> Subject:        Re: [lttng-dev] Will LTTng overwrite existing trace files after
> reboot, or continue where the previous instance left off?
> --------------------------------------------------------------------------------
> 
> 
> 
> It's possible yes if the session path is exactly the same but this is why we add
> the date and time to the session directory so we don't end up overwriting old
> traces with the same session name.
> 
> Can you tell me what is the full path of the session directory. It should look
> something like (with some variations).
> 
> ~/lttng-traces/fo-20130612-104743/ust/uid/1000/64-bit
> 
> Upon reboot, can you confirm that the path is different ?
> 
> Thanks!
> David
> 
> Amit Margalit:
>> Hi,
>>
>> My situation is this:
>>
>> lttng-sessiond --no-kernel
>> lttng-create foo
>> lttng enable-channel channel0 -u --tracefile-size 67108864 --tracefile-count 13
>> --buffers-uid --switch-timer 1000000 --num-subbuf 32
>> lttng enable-event -u -a
>> lttng start foo
>>
>> Now this runs for a while collecting traces. I've run du -s on the trace
>> directory, and saw that lttng-traces/ takes 2376KB.
>>
>> The system was reboot, and upon startup, the exact same scenario as above is
>> reproduced.
>>
>> When I ran du to see the size of the lttng-traces/ directory, it was 1740KB.
>>
>> Can you please help explain this? Is LTTng overwriting the existing trace files?
>>
>> Thanks,
>>
>> Amit Margalit
>> IBM XIV - /Storage Reinvented/
>> XIV-NAS Development Team
>> Tel. 03-689-7774
>> Fax. 03-689-7230
>>
>>
>> This body part will be downloaded on demand.
> 
> 
