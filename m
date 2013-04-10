From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: [RFC PATCH lttng-tools v3] lttng cli: Accept human
 readable sizes for --subbuf-size
Date: Wed, 10 Apr 2013 14:23:34 -0400
Message-ID: <CAFXXi0=8FxVMz5RjOmL5r9iXmDHKi5mb2eBZkkFv8pktZLvsnQ__36254.7611854554$1365618281$gmane$org@mail.gmail.com>
References: <1365439209-27624-1-git-send-email-simon.marchi@polymtl.ca>
	<51644824.6000505@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1UPzgo-0006sn-L4
	for lttng-dev@lists.lttng.org; Wed, 10 Apr 2013 14:24:10 -0400
Received: by mail-ie0-f178.google.com with SMTP id bn7so948000ieb.23
	for <lttng-dev@lists.lttng.org>; Wed, 10 Apr 2013 11:24:05 -0700 (PDT)
In-Reply-To: <51644824.6000505@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 9 April 2013 12:56, David Goulet <dgoulet@efficios.com> wrote:
>> @@ -77,3 +79,122 @@ void list_cmd_options(FILE *ofp, struct poptOption *options)
>>               }
>>       }
>>  }
>> +
>> +/**
>> + * Prints the error message corresponding to a regex error code.
>> + *
>> + * @param errcode    The error code.
>> + * @param regex              The regex object that produced the error code.
>> + */
>> +static void regex_print_error(int errcode, regex_t *regex)
>> +{
>> +     /* Get length of error message and allocate accordingly */
>> +     size_t length = regerror(errcode, regex, NULL, 0);
>> +     char *buffer = malloc(length);
>
> I know it's not _necessary_ but I would prefer to have the same std
> across the code. So, we usually declare the variables without
> assignation (that comes from a function call), then use assert() for
> given params (if needed) and finally used them.
>
> Here, declare length and buffer without assignation. Assert on "regex !=
> NULL" because a NULL value seems to me that it might break (or
> segfault). Finally, set length, check the return error code and set
> buffer checking also for errors.
>
> Use zmalloc also please.

Ok, no problem.

There is nothing specified for the return value of regerror so there
is nothing to check. Actually, it does abort() if you pass a wrong
error code...

> I wonder if these *_LOG2 should go in default.h ? Thoughts?

I see default.h as a place you put default arbitrary values for buffer
sizes, paths, names, etc. KIBI_LOG2 and al are not values you decide.
I think they are fine in utils.h.

> If regex was uninit like for instance on regcomp error, does this call
> behaves well ?

Good catch, changed.

"Ack" for all other comments.

Thanks,

Simon
