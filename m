From: Vlad <vlad@demoninsight.com>
Subject: Re: CTF: trying to understand "missing fields"
Date: Mon, 28 Oct 2013 17:34:28 -0400
Message-ID: <D87F4B5A-7F81-4A57-B9C2-5B871B8F2445__28587.2139539153$1382996139$gmane$org@demoninsight.com>
References: <D45D38CA-AFA7-41E7-8D63-BDD96DBA4E42@demoninsight.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <vlad@demoninsight.com>) id 1VauSK-0000zr-3C
	for lttng-dev@lists.lttng.org; Mon, 28 Oct 2013 17:34:41 -0400
Received: by mail-qc0-f179.google.com with SMTP id k18so4220667qcv.10
	for <lttng-dev@lists.lttng.org>; Mon, 28 Oct 2013 14:34:30 -0700 (PDT)
Received: from [10.52.5.106] (msmc-64-72-75-194.customer.hvdata.net.
	[64.72.75.194])
	by mx.google.com with ESMTPSA id og1sm47123751qeb.3.2013.10.28.14.34.29
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 28 Oct 2013 14:34:29 -0700 (PDT)
In-Reply-To: <D45D38CA-AFA7-41E7-8D63-BDD96DBA4E42@demoninsight.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


On Oct 21, 2013, at 6:53 PM, Vlad <VLAD@DEMONINSIGHT.COM> wrote:

> Greetings,
> 
> 	The CTF spec contains a couple of mentions of how one could define a missing field bitmask:
> 
> "The header is extended in the rare occasions where the information cannot be
> represented in the ranges available in the standard event header. They are also
> used in the rare occasions where the data required for a field could not be
> collected: the flag corresponding to the missing field within the missing_fields
> array is then set to 1"
> 
> and
> 
> "An example of event-specific event context is to declare a bitmap of missing
> fields, only appended after the stream event context if the extended event
> header is selected. NR_FIELDS is the number of fields within the event (a
> numeric value).
> 
>  event {
>    context = struct {
>      variant <id> {
>        struct { } compact;
>        struct {
>          uint1_t missing_fields[NR_FIELDS]; /* missing event fields bitmap */
>        } extended;
>      } v;
>    };
>    ...
>  }"
> 
> Is this capability reflected in the current lttng builds? My understanding so far is that "missingness" is not part of CTF grammar per se but is rather a convention (i.e. declaring an array of uint1_t's with a particular name "missing_fields") -- is this correct? In the extended header example above, how is a missing_fields slot mapped to its corresponding field -- are the fields assumed to be ordered, with a slot per field in that ordering?


Ok, lack of response probably means I'd stumbled on an unsupported feature.

Cheers,
Vlad
