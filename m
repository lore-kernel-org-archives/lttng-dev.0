From: David Goulet <dgoulet@efficios.com>
Subject: Re: [RFC lttng-tools] Triggers
Date: Mon, 15 Apr 2013 10:54:06 -0400
Message-ID: <516C148E.50907__19655.30671082$1366037682$gmane$org@efficios.com>
References: <5166DFE7.8020802@efficios.com> <516C1072.9030902@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1URknK-0003aA-D5
	for lttng-dev@lists.lttng.org; Mon, 15 Apr 2013 10:54:10 -0400
In-Reply-To: <516C1072.9030902@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

FYI, disable and enable-consumer are gone in 2.2-rc1.

That's an interesting discussion to have. For the last years, we've used
"lttng ACTION OPTIONS" scheme. Now, we choose to change that for the
triggers and snapshots (RFC) is to have less commands and focus on the
"object semantic" like "lttng OBJECT ACTION OPTIONS" mainly because we
are pretty sure that more options and possibilities will come in the
future with these complex commands.

So, the main reasons is that instead of creating 3+ more commands, we go
for one command that allows the user to use triggers with all the
different options under the same "roof".

It's a bit like "git commit" and "git remote". Git is still very usable
but commands are simply different.

Hope that it clarifies why we propose this new scheme.

David

Matthew Khouzam:
> Hey tracing architects,
> Just a thought of consistency.
> we have
> lttng add-context (you can have many)
> lttng disable-context
> lttng enable-consumer (you can only have one)
> lttng disable-consumer
> I would suggest
> lttng add-trigger (you can have many)
> lttng disable-trigger
> lttng modify-trigger ???
> 
> 
> TLDR: there should be a naming convention for lttng commands, there
> probably are but I have not seen them, or maybe I have but I do not
> remember seeing them.
> 
> TLDR-TLDR: name things the same way please. :)
> 
> On 13-04-11 12:08 PM, David Goulet wrote:
>> Hi everyone,
>>
>> Here is the second RFC of the day.
>>
>> By reading this, your imagination will probably go pretty crazy with
>> possibilities ;). The first implementation will only have one option
>> describe in the RFC but note that with this kind of feature, the sky is
>> the limit! and of course world domination is never far.
>>
>> Thanks!
>> David
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> 
> 
> This body part will be downloaded on demand.
