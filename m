From: Paul Chavent <paul.chavent@fnac.net>
Subject: Re: Viewing userspace apps traces
Date: Wed, 03 Oct 2012 07:50:29 +0200
Message-ID: <506BD225.3030906__375.158471479331$1349243492$gmane$org@fnac.net>
References: <506B4A21.6080309@fnac.net> <506B4EA4.8050407@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp5-g21.free.fr ([212.27.42.5])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paul.chavent@fnac.net>) id 1TJHqf-0001SC-Vt
	for lttng-dev@lists.lttng.org; Wed, 03 Oct 2012 01:50:22 -0400
In-Reply-To: <506B4EA4.8050407@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi

Thank you for your reply :

On 10/02/2012 10:29 PM, Alexandre Montplaisir wrote:
> Hi Paul,
>
> On 12-10-02 04:10 PM, Paul Chavent wrote:
>> Hi.
>>
>> Today, I've tested the tracing of a user space app.
>>
>> I wonder what is the best solution for viewing it ?
>>
>> I have tried babeltrace that produce a good comprehensive text outpout.
>> I have tried eclipse that isn't able to use the vtid and vpid context.
>> It's unfortunate as i would like to see a timeline representation...
>
> Do you mean the Events view does not show the event contexts? It should,
> afaik. It could be a bug.
>
> As for graphical views, like timegraphs, it's not easy to have a general
> view that can work with any UST trace. Each application defines its own
> event types, so we have no guarantee for any given event type to be there.
>
> What would you like see in your "timeline representation" exactly? Maybe
> we could give you some pointers as to how to implement such a view.
> (We're currently working on making it easy to extend the framework to
> implement new views, so this could be a good exercise!)

I would like to see, eg, one line per tid, and on each line, the value of one context or argument value.

I'm ready to follow an exercise for extending the framework !

>
>> Is it a good solution to use the custom text parser of the eclipse tool ?
>
> Not really, the custom parsers are, for example, when you have a text
> log and want to import it into the TMF framework. LTTng/UST traces are
> in CTF format, and that format is already supported in TMF.
>
>
>
> Cheers,
>
