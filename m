From: Bernd Hufmann <Bernd.Hufmann@ericsson.com>
Subject: Re: Missing tracepoint entries when listing fields in
 LTTng Tools 2.1
Date: Mon, 17 Sep 2012 10:59:19 -0400
Message-ID: <50573AC7.4040304__29388.3440354422$1347893999$gmane$org@ericsson.com>
References: <5050CD26.6020707@ericsson.com> <20120912191400.GA31291@Krystal>
	<505321EA.1060007@ericsson.com> <505716DF.60505@ericsson.com>
	<20120917141455.GA8071@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from imr4.ericy.com ([198.24.6.9])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <bernd.hufmann@ericsson.com>) id 1TDcnN-0002J4-8n
	for lttng-dev@lists.lttng.org; Mon, 17 Sep 2012 10:59:33 -0400
Received: from eusaamw0712.eamcs.ericsson.se ([147.117.20.181])
	by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id
	q8HF4LVV002617
	for <lttng-dev@lists.lttng.org>; Mon, 17 Sep 2012 10:04:22 -0500
In-Reply-To: <20120917141455.GA8071@Krystal>
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

thanks for the quick fix. I tried it and it works as expected.

BR,
Bernd


On 09/17/2012 10:14 AM, Mathieu Desnoyers wrote:
> * Bernd Hufmann (Bernd.Hufmann@ericsson.com) wrote:
>> Hello
>>
>> I wondering if the described problem below will be fixed for the release
>> of 2.1? I think the behaviour is not correct and should be corrected in
>> the release.
>> Any comments?
> Fixed by commit:
>
> commit 26329f266af91824651fe32df3003c45c71985b8
> Author: Mathieu Desnoyers<mathieu.desnoyers@efficios.com>
> Date:   Mon Sep 17 10:11:09 2012 -0400
>
>      Fix: add events with 0 field to field list
>
>      Signed-off-by: Mathieu Desnoyers<mathieu.desnoyers@efficios.com>
>
> It will be in 2.1.
>
> Thanks,
>
> Mathieu
>
>
>> Best Regards
>> Bernd
>>
>> On 09/14/2012 08:24 AM, Bernd Hufmann wrote:
>>> Hi
>>>
>>> I executed command "lttng list -u -f" (in LTTng Tools 2.1 RC2) to list
>>> all the available UST tracers and their tracepoints/fields. I noticed
>>> that some tracepoints are not listed when they don't have any fields. I
>>> think this is not  correct because the "-f" option should just give more
>>> detailed information, but should not remove information.
>>>
>>> To re-produce, use the hello.cxx test application delivered with LTTng UST.
>>> "lttng list -u" shows:
>>> PID: 6056 - Name: /home/bernd/git/lttng-ust/tests/hello.cxx/.libs/lt-hello
>>>          ust_tests_hello:tptest_sighandler (loglevel: TRACE_DEBUG_LINE
>>> (13)) (type: tracepoint)
>>>          ust_tests_hello:tptest (loglevel: TRACE_DEBUG_LINE (13)) (type:
>>> tracepoint)
>>>
>>> "lttng list -u -f shows:
>>> PID: 6056 - Name: /home/bernd/git/lttng-ust/tests/hello.cxx/.libs/lt-hello
>>>          ust_tests_hello:tptest (loglevel: TRACE_DEBUG_LINE (13)) (type:
>>> tracepoint)
>>>            field: doublefield (float)
>>>            field: floatfield (float)
>>>            field: stringfield (string)
>>>            field: seqfield2 (string)
>>>            field: seqfield1 (unknown)
>>>            field: arrfield2 (string)
>>>            field: arrfield1 (unknown)
>>>            field: netintfieldhex (integer)
>>>            field: netintfield (integer)
>>>            field: longfield (integer)
>>>            field: intfield2 (integer)
>>>            field: intfield (integer)
>>>
>>> Best Regards
>>> Bernd
>>>
>>>
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
