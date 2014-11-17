From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Stress tests added to ctf testsuite
Date: Mon, 17 Nov 2014 16:41:10 -0500
Message-ID: <546A6B76.8050303__16252.1230326549$1416260531$gmane$org@voxpopuli.im>
References: <1259876374.14213.1416156117524.JavaMail.zimbra@efficios.com>
 <54690B90.308@voxpopuli.im>
 <1931444595.14255.1416170973715.JavaMail.zimbra@efficios.com>
 <54692F59.8090102@voxpopuli.im>
 <1516265748.14364.1416198982861.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1XqU2u-0003kC-JT
 for lttng-dev@lists.lttng.org; Mon, 17 Nov 2014 16:41:21 -0500
In-Reply-To: <1516265748.14364.1416198982861.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Trace Compass Developer Discussions <tracecompass-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org


On 11/16/2014 11:36 PM, Mathieu Desnoyers wrote:
> The run.sh scripts are just a convenience for running test in every
> subdirectory with TAP output, and in the case of stress tests, calling
> test.py for every line of param-list.txt in each subdirectory.
>
> AFAIU, the junit tests are the ones driving the traversal in your case,
> so you probably don't want run.sh at all. However, what would prevent
> a junit test from invoking e.g.
>
> ./test.py prepare 512000
> [do test]
> ./test.py clean 512000

The way it works, we just look for all the traces in a directory (like 
let's say regression/metadata/pass/* ), and the parameters just create 
one test for every entry found. So the traces needs to be present on the 
filesystem before the test class is run.

Which is why I suggested a way to run all the "prepare 256", "prepare 
512" etc. in one shot, so that we could do it as part of the test 
preparation phase (before the actual tests are run). If it's not deemed 
useful upstream, we could always do it on our side. But then we'd have 
to list every single one of those tests individually, which we were able 
to avoid doing so far. And we'd always be playing catch-up as new tests 
are added. But hey, such is life ;)

Hope this explains it.

Cheers,
Alexandre

>
> ?
>
> Thanks,
>
> Mathieu
>
> ----- Original Message -----
>> From: "Alexandre Montplaisir" <alexmonthy@voxpopuli.im>
>> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
>> Cc: "Matthew Khouzam" <matthew.khouzam@ericsson.com>, "lttng-dev" <lttng-dev@lists.lttng.org>, "Trace Compass
>> Developer Discussions" <tracecompass-dev@eclipse.org>
>> Sent: Monday, November 17, 2014 12:12:25 AM
>> Subject: Re: Stress tests added to ctf testsuite
>>
>> We can run scripts, yeah. But, as far as I understand it, the ./run.sh
>> scripts require passing a CTF_READER_BIN executable, which we don't have
>> during the testing phase.
>>
>> Another advantage of using parameterized tests is that it creates one
>> JUnit test for every instance that is created at run-time (here, one per
>> test trace to test). This way they show up individually in test reports
>> [1]. And if one of them fails, at the end we know which one did, and not
>> just "something failed in the script".
>>
>> I see how the test files can be big, so generating *everything* may not
>> be desirable. Could it be per test then? Or even part of the Python
>> scripts themselves? (generate -> test -> clean, have a default array of
>> sizes to generate, user can specify other sizes?)
>>
>> Thanks,
>> Alexandre
>>
>>
>> [1] For example:
>> https://hudson.eclipse.org/tracecompass/job/tracecompass-master-nightly/31/testReport/org.eclipse.tracecompass.ctf.core.tests.ctftestsuite/CtfTestSuiteTests/
>>
>> On 2014-11-16 03:49 PM, Mathieu Desnoyers wrote:
>>> Can you modify Junit, or use a different test system,
>>> to allow calling scripts instead ? I expect we will end up having
>>> much more automatically generated test-cases over time, and the more
>>> we will have, the less sense it will make to generate them all at
>>> test start.
>>>
>>> Thanks!
>>>
>>> Mathieu
>>>
>>> ----- Original Message -----
>>>> From: "Alexandre Montplaisir" <alexmonthy@voxpopuli.im>
>>>> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Matthew
>>>> Khouzam" <matthew.khouzam@ericsson.com>
>>>> Cc: "lttng-dev" <lttng-dev@lists.lttng.org>, "Trace Compass Developer
>>>> Discussions" <tracecompass-dev@eclipse.org>
>>>> Sent: Sunday, November 16, 2014 9:39:44 PM
>>>> Subject: Re: Stress tests added to ctf testsuite
>>>>
>>>> Hi Mathieu,
>>>>
>>>> Looks great! Preliminary testing shows that Trace Compass also blows up
>>>> in many different ways, but hey that's expected ;)
>>>>
>>>> If I may suggest, having a script, either shell or Python, to just
>>>> generate/clean the test traces would be very useful.
>>>> We don't use the run.sh scripts in CI (we're within JUnit tests, there
>>>> is no executable at that point), we just look at the trace directories
>>>> and try to run everything in there. If there was a simple way to "create
>>>> everything" and then "clean everything" it would make it easier to
>>>> integrate in our (and I guess others') build system.
>>>>
>>>> Cheers,
>>>> Alexandre
>>>>
>>>>
>>>> On 2014-11-16 11:41 AM, Mathieu Desnoyers wrote:
>>>>> Hi!
>>>>>
>>>>> If you look at
>>>>> https://github.com/efficios/ctf-testsuite
>>>>>
>>>>> I just pushed various CTF stress-tests, and did some
>>>>> general cleanup in the tree (e.g. renaming tests to
>>>>> meaningful names).
>>>>>
>>>>> Have fun!
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Mathieu
>>>>>
>>
