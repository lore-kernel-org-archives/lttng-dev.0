From: Bernd Hufmann <Bernd.Hufmann@ericsson.com>
Subject: Re: LTTng 2.1: create session errors
Date: Fri, 21 Dec 2012 07:22:07 -0500
Message-ID: <50D4546F.8050501__32807.4810131968$1356092581$gmane$org@ericsson.com>
References: <50D35E5F.6020405@ericsson.com> <50D362FB.2010901@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from imr3.ericy.com ([198.24.6.13])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <bernd.hufmann@ericsson.com>) id 1Tm1cG-0001qm-Il
	for lttng-dev@lists.lttng.org; Fri, 21 Dec 2012 07:22:16 -0500
In-Reply-To: <50D362FB.2010901@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi David

I just restarted working on the LTTng 2.1 integration in Eclipse this 
week. So, I only noticed these things yesterday.

Thanks a lot for the fixes and the explanations.

BR,
Bernd

On 12/20/2012 02:11 PM, David Goulet wrote:
> Just in time before I push for 2.1 sable.
>
> Bernd Hufmann:
>> Hello
>>
>> I'm currently using lttng-tools 2.1.0-RC9. I see some errors when using
>> "lttng create " with streaming options:
>>
>> 1) lttng create mysession -C net://192:1.1.1: -D net://192:1.1.1.1
>>
>> The command output shows:
>>     Session mysession created.
>>     Traces will be written in (null)
>>     Control URL net://192.1.1.1.1 set for session mysession
>>     Data URL net://192.1.1.1.1 set for session mysession
>>
>> The line "Traces will be written in (null)" should show the correct
>> location similar when using the -U option. Also, when typing "lttng list
>> mysession" afterwards the trace path is not displayed correctly.
>> (mysession (net://192.1.1.1:5342/ [data: 5343]) [inactive]).
> Fixed.
>
>> 2) lttng create mysession -C net://192:1.1.1:5342 -D net://192.1.1.1:5343
>>
>> This command output shows:
>>     Session mysession created.
>>     Traces will be written in (null)
>>     Error: Control URL uses the net:// protocol and the data URL is
>> different. Not allowed.
>>     Error: Invalid parameter
>>
>> The command fails with an error. However, the session seems to be
>> created, but no consumer is defined. First of all, it should be possible
>> to define the port with the option -C and -D. Secondly, if an error
>> occurs the session shouldn't be created.
> Both URL are not equal since the port is different here. So, you CAN'T
> use net:// with create session unless both URLs are identical. Use
> tcp:// here. The net:// protocol stands for the default transport layer
> for both port.
>
> The session stays created here and I can't change that for now. You can
> simply use "lttng enable-consumer" after to set the correct thing. This
> could however be changed for next version as a bug fix.
>
>> 3) lttng create mysession -C net://192.1.1.1
>>
>> This command doesn't fail. I expected it to fail since the command help
>> states that -D<data URL>  must be used too. BTW, "lttng create mysession
>> -D net://192.1.1.1" fails.
> Fixed.
>
>> 4) lttng create mysession -C net://192:1.1.1 -D net://192.1.1.2
>> This command fails, because the IP address is not the same. Is this
>> intended?
> It is because URLs are not identical. Use tcp:// here instread.
>
>> 5) In "lttng create -h" and "enable-consumer -h" show "tcp[4|6]" as
>> possible protocols, but "tcp4" doesn't work. I have to use "tcp". The
>> help should be updated for that.
> Fixed
>
>> 6) Why isn't it possible to use "tcp[6]" together with option -U?
>> Instead "net[6]" has to be used, which defaults to TCP as network
>> transport.
> -U is used to specify BOTH url for ports so for now we only allow net://
> that do this job.
>
> Future work will fine grained more the URI parsing but for now, use
> net[6]:// only with -U.
>
> It will be upstream in a jiffy.
>
> Thanks!
> David
>
>> Could someone please look into this?
>>
>> Best Regards
>> Bernd
>>
>>
>>


-- 
This Communication is Confidential. We only send and receive email on 
the basis of the terms set out at www.ericsson.com/email_disclaimer
