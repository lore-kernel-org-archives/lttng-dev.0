From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: CTF: trying to understand "missing fields"
Date: Thu, 31 Oct 2013 12:34:56 +0000 (UTC)
Message-ID: <106087714.54272.1383222895991.JavaMail.zimbra__7841.50391486964$1383222944$gmane$org@efficios.com>
References: <D45D38CA-AFA7-41E7-8D63-BDD96DBA4E42@demoninsight.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VbrSl-0001sj-HB
	for lttng-dev@lists.lttng.org; Thu, 31 Oct 2013 08:35:01 -0400
In-Reply-To: <D45D38CA-AFA7-41E7-8D63-BDD96DBA4E42@demoninsight.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Vlad <vlad@demoninsight.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org



----- Original Message -----
> From: "Vlad" <vlad@demoninsight.com>
> To: "lttng-dev" <lttng-dev@lists.lttng.org>
> Sent: Monday, October 21, 2013 6:53:21 PM
> Subject: [lttng-dev] CTF: trying to understand "missing fields"
> 
> Greetings,
> 
> 	The CTF spec contains a couple of mentions of how one could define a missing
> 	field bitmask:
> 
> "The header is extended in the rare occasions where the information cannot be
> represented in the ranges available in the standard event header. They are
> also
> used in the rare occasions where the data required for a field could not be
> collected: the flag corresponding to the missing field within the
> missing_fields
> array is then set to 1"
> 
> and
> 
> "An example of event-specific event context is to declare a bitmap of missing
> fields, only appended after the stream event context if the extended event
> header is selected. NR_FIELDS is the number of fields within the event (a
> numeric value).
> 
>   event {
>     context = struct {
>       variant <id> {
>         struct { } compact;
>         struct {
>           uint1_t missing_fields[NR_FIELDS]; /* missing event fields bitmap
>           */
>         } extended;
>       } v;
>     };
>     ...
>   }"
> 
> Is this capability reflected in the current lttng builds?

LTTng does not use this CTF feature at the moment, and the reference implementations don't understand it neither. This was meant mainly for debuggers (gdb), which can have missing data (e.g. caused by optimizations).

> My understanding so
> far is that "missingness" is not part of CTF grammar per se but is rather a
> convention (i.e. declaring an array of uint1_t's with a particular name
> "missing_fields") -- is this correct?

Yes.

> In the extended header example above,
> how is a missing_fields slot mapped to its corresponding field -- are the
> fields assumed to be ordered, with a slot per field in that ordering?

Yes.

> 
> To give some context for my use case:
> 
> - I generate my own binary data and I would like to leverage TMF and/or
> babeltrace to view it
> - my in-memory event format is roughly <event ID> + <missing field bitmap> +
> <fields that are present> (with certain alignment constraints) and I would
> like to understand whether I can describe it using CTF
> - in principle, I can post-process my data as needed so it fits some CTF
> grammar but I simply don't quite understand how this missing fields feature
> works

Extensions to babeltrace and TMF to make them understand the "missing fields" bitfield would be very welcome!

Thanks,

Mathieu

> 
> Any help would be much appreciated.
> 
> Thanks,
> Vlad
> 
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
