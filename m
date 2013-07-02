From: Bernd Hufmann <Bernd.Hufmann@ericsson.com>
Subject: Re: Lttng Tools 2.2.0
Date: Tue, 2 Jul 2013 10:08:30 -0400
Message-ID: <51D2DEDE.1040201__47082.7838559218$1372774146$gmane$org@ericsson.com>
References: <51CDC762.5050002@ericsson.com> <51CDEFC4.50008@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <bernd.hufmann@ericsson.com>) id 1Uu1G1-0007o8-7h
	for lttng-dev@lists.lttng.org; Tue, 02 Jul 2013 10:08:37 -0400
In-Reply-To: <51CDEFC4.50008@efficios.com>
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

Hi David

I have a follow-up question for Simon's second questions:

Initially, when reading the release notes I had the impression that only 
the switch-timer for periodic flush can be configured for the metadata 
channel. Then I tried to configure the read-timer, num-subbuf and 
subbuf-size for the metadata channel and it seemed to be successful. 
Does that mean that it is possible to configure the metadata channel 
like a "regular" channel and all the command-line parameter are supported?

In advance thank you very much.

Best Regards
Bernd


On 06/28/2013 04:19 PM, David Goulet wrote:
> CCing lttng-dev mailing list.
>
> Simon Delisle:
>> Hi,
>>
>> I work  with the tracing team at Ericsson and I actually work on the lttng 2.2
>> support in TMF, but I have two questions about the new feature.
>> 1) Does the periodical metadata flush is only for UST or it work for kernel to ?
> Both.
>
>> 2) What are the parameter for enable-channel command for the metadata ?
> $ lttng enable-channel metadata ...
>
> David
>
>> Thank you
>>
>>
>> Ericsson<http://www.ericsson.com/>
>>
>> *SIMON DELISLE*
>> Software Developer Co-op
>> QSI
>>
>> *Ericsson*
>> 8400 Decarie Blvd
>> Town of Mount-Royal, Qc, H4P 2N2, Canada
>> Phone 514-345-7900 x45931
>> simon.delisle@ericsson.com<mailto:simon.delisle@ericsson.com>
>> www.ericsson.com<http://www.ericsson.com/>
>>
>> Ericsson<http://www.ericsson.com/current_campaign>
>>
>> Legal entity: Ericsson EMC, registered office in Canada. This Communication is
>> Confidential. We only send and receive email on the basis of the terms set out
>> at www.ericsson.com/email_disclaimer
>>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
This Communication is Confidential. We only send and receive email on 
the basis of the terms set out at www.ericsson.com/email_disclaimer
