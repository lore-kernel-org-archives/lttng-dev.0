From: Bernd Hufmann <Bernd.Hufmann@ericsson.com>
Subject: Re: list configured filters in LTTng Tools 2.1
Date: Thu, 13 Sep 2012 08:42:22 -0400
Message-ID: <5051D4AE.8040201__21985.5516720147$1347540185$gmane$org@ericsson.com>
References: <5050CD26.6020707@ericsson.com> <20120912191400.GA31291@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from imr4.ericy.com ([198.24.6.9])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <bernd.hufmann@ericsson.com>) id 1TC8kc-0005GJ-8A
	for lttng-dev@lists.lttng.org; Thu, 13 Sep 2012 08:42:34 -0400
Received: from eusaamw0711.eamcs.ericsson.se ([147.117.20.178])
	by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id
	q8DCkisk021554
	for <lttng-dev@lists.lttng.org>; Thu, 13 Sep 2012 07:46:46 -0500
In-Reply-To: <20120912191400.GA31291@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Mathieu

Thanks for the info. I've opened a feature request (#334).

Best Regards
Bernd

On 09/12/2012 03:14 PM, Mathieu Desnoyers wrote:
> * Bernd Hufmann (Bernd.Hufmann@ericsson.com) wrote:
>> Hello
>>
>> I configured a filter for UST events (lttng enable event -u ust*
>> --filter 'signal==10101') and I want to retrieve that information
>> afterwards. I used "lttng list mySession" and it only shows [with
>> filters]. Is it possible to retrieve the actual filter expression? If
>> not, it would be good to add this possibility.
> We could. Please add a feature request on the bugs.lttng.org bugtracker
> against the lttng-tools project.
>
> Thanks,
>
> Mathieu
>
>> Best Regards
>> Bernd
>>
>>
>> -- 
>> This Communication is Confidential. We only send and receive email on
>> the basis of the terms set out at www.ericsson.com/email_disclaimer
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
This Communication is Confidential. We only send and receive email on 
the basis of the terms set out at www.ericsson.com/email_disclaimer
