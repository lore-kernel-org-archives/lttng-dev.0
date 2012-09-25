From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: CTF model.emf.uri precision
Date: Tue, 25 Sep 2012 14:20:54 -0400
Message-ID: <5061F606.5000504__8778.70909539542$1348597294$gmane$org@gmail.com>
References: <5060C80C.4030600@ericsson.com> <20120925022530.GA12625@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1TGZkj-0006cf-TC
	for lttng-dev@lists.lttng.org; Tue, 25 Sep 2012 14:21:01 -0400
Received: by ieak11 with SMTP id k11so7513905iea.35
	for <lttng-dev@lists.lttng.org>; Tue, 25 Sep 2012 11:20:56 -0700 (PDT)
In-Reply-To: <20120925022530.GA12625@Krystal>
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

On 2012-09-24 22:25, Mathieu Desnoyers wrote:
> * Matthew Khouzam (matthew.khouzam@ericsson.com) wrote:
>> Hi tracing paladins,
>> I was going over the most recent CTF specs. I am curious, at the line:
>> 1176   "model.emf.uri = "string";" this looks like a reference to
>> something from eclipse modeling framework.
>> http://download.eclipse.org/modeling/emf/emf/javadoc/2.7.0/org/eclipse/emf/common/util/URI.html
>>
>> Is this part of the CTF specification? Shouldn't this be called
>> model.uri or model_uri to respect the naming convention?
> if we only call it model.uri, and come up with other model URIs that we
> want to encode in the future (not emf-related), then we would be
> stucked, wouldn't we ?
>
> What is the benefit of removing the "emf" part ?
>
I don't see the benifit of having the "emf". From what I see, its just
an URI, so there is no real link to that an EMF. We could put any kind
of model there?!?.

Also, why not just having a generic way to add a constant string to the
event?

Yannick
