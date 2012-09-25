From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: CTF model.emf.uri precision
Date: Tue, 25 Sep 2012 14:39:24 -0400
Message-ID: <5061FA5C.90201__41712.1017504998$1348598462$gmane$org@ericsson.com>
References: <5060C80C.4030600@ericsson.com> <20120925022530.GA12625@Krystal>
	<5061F606.5000504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from imr3.ericy.com ([198.24.6.13])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1TGa31-0006mI-6E
	for lttng-dev@lists.lttng.org; Tue, 25 Sep 2012 14:39:55 -0400
In-Reply-To: <5061F606.5000504@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

A fun solution could be a map of key values where you can put everything:
like
<tsdl>
event{
eventNameherething :={
{"loglevel" , "1"},
{"model.emf.uri" , "www.thingy"},
{"drink.coca.cola.(tm)" , "pepsi"},
...
}
fields:=...
}</tsdl>
On 12-09-25 02:20 PM, Yannick Brosseau wrote:
> On 2012-09-24 22:25, Mathieu Desnoyers wrote:
>> * Matthew Khouzam (matthew.khouzam@ericsson.com) wrote:
>>> Hi tracing paladins,
>>> I was going over the most recent CTF specs. I am curious, at the line:
>>> 1176   "model.emf.uri = "string";" this looks like a reference to
>>> something from eclipse modeling framework.
>>> http://download.eclipse.org/modeling/emf/emf/javadoc/2.7.0/org/eclipse/emf/common/util/URI.html
>>>
>>> Is this part of the CTF specification? Shouldn't this be called
>>> model.uri or model_uri to respect the naming convention?
>> if we only call it model.uri, and come up with other model URIs that we
>> want to encode in the future (not emf-related), then we would be
>> stucked, wouldn't we ?
>>
>> What is the benefit of removing the "emf" part ?
>>
> I don't see the benifit of having the "emf". From what I see, its just
> an URI, so there is no real link to that an EMF. We could put any kind
> of model there?!?.
>
> Also, why not just having a generic way to add a constant string to the
> event?
>
> Yannick
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
