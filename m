From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: String format based events
Date: Thu, 18 Jun 2015 09:43:36 -0400
Message-ID: <CAB4xu_3pvQTvcKmi28fS8159CSSL_Fr8f_DR+j_CdZEomAkMZg__34990.5108836994$1434635140$gmane$org@mail.gmail.com>
References: <BLU169-W69F0861B21CA9AE09E8C75ABA60@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1Z5a73-0003NI-0v
 for lttng-dev@lists.lttng.org; Thu, 18 Jun 2015 09:44:20 -0400
Received: by lbbvz5 with SMTP id vz5so4484125lbb.0
 for <lttng-dev@lists.lttng.org>; Thu, 18 Jun 2015 06:44:07 -0700 (PDT)
In-Reply-To: <BLU169-W69F0861B21CA9AE09E8C75ABA60@phx.gbl>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jeffrey Chen <cpthk@hotmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Wed, Jun 17, 2015 at 7:51 PM, Jeffrey Chen <cpthk@hotmail.com> wrote:
> I have a question while reading the lttng documentation. Could anyone answer
> me? Thanks a lot.
>
> It looks like lttng events are all key-value pairs. Like { my_val1 = 10,
> my_val2 = "OK" }. Does lttng supports regular string format based events,
> like Windows ETW. I want a human readable sentences in the event like "My
> CPU usage is 50 , my memory usage is 100". Of course, I know I could
> manually construct the string myself and pass the result in one string down
> to lttng. But, the idea is that, string format is slow. So, Windows ETW does
> the string formatting only when you read the logs.
> For example, if I want to write many "My CPU usage is {0} , my memory usage
> is {1}" to log. Windows ETW does not write this whole string to log. It only
> writes the 2 variable values of this trace to the log, and construct back
> the original string when you are reading the logs.

Hello Jeffrey!

We (EfficiOS) are currently working on such a feature, which involves
changes to all the following projects:

  * CTF (trace format used by LTTng): allow custom user attributes to
    be assigned to types and events in the trace metadata (this is where
    the format string would go)
  * LTTng-UST: add a macro to be used in tracepoint providers to
    assign a format string to a specific event
  * Babeltrace: upgrade the ctf-text plugin so that it takes into
    account the format string of an event, if available, to print it in a
    custom way

We could also think about a tool, or a Babeltrace input plugin perhaps,
which converts the Windows ETW format to CTF; we would need to
parse the format strings and convert them to our own syntax.

The format string syntax we're intending to use is Python's format()
one [1], or at least a subset of its features. It is very flexible and
allows to name fields, modify them, and place them where you
want, e.g.:

"My field is {field}, which is {field:x} in hex, and also: {other_field}"

Replacement fields may also be empty to be position-based:

"My field is {}, and also: {}"

(you would need exactly two fields here).

[1] https://docs.python.org/3/library/string.html#formatstrings

Phil

>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
