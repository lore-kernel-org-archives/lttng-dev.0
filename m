From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: babeltrace
Date: Thu, 8 May 2014 08:16:54 -0400
Message-ID: <CAFXXi0=C3_fSHUNsGYu3xPw8oS84A=bRyeig0R714GfPsvc6=g__22158.7573447779$1399551488$gmane$org@mail.gmail.com>
References: <CAPxN80BCJuB0u_5pk_a=aWw2gQ99eWK_cRnQ4_Kw6Sf8dEaJCg@mail.gmail.com>
 <534FEA8C.8040504@ericsson.com>
 <CA+jJMxum9CmGNDgkqjW3EVCokWx=f-k-iiAjEsXVfY2EjjxmMg@mail.gmail.com>
 <CAPxN80BRHcyEsVPBAQC-xaaYwZv0Mqzik2SehaXtnrs2Wsdoow@mail.gmail.com>
 <536B2BA4.7060107@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thundersim@gmail.com>) id 1WiNGU-0005Pa-IR
 for lttng-dev@lists.lttng.org; Thu, 08 May 2014 08:17:32 -0400
Received: by mail-ie0-f175.google.com with SMTP id rl12so2377626iec.6
 for <lttng-dev@lists.lttng.org>; Thu, 08 May 2014 05:17:25 -0700 (PDT)
In-Reply-To: <536B2BA4.7060107@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 8 May 2014 03:00, Alexandre Montplaisir <alexmonthy@voxpopuli.im> wrote:
> Hi,
>
> Every event type has different fields though. So the "columns" would
> vary from one event to another.
>
> Although I can see that if you add let's say "context.pid" to ALL
> events, then it would be nice in the CSV export to add this as a
> separate column. However, the viewer cannot know for sure that all
> events in the trace have that particular context enabled. Unless you do
> a full pass of the trace first to look for common fields.
>
> Or, you do a first pass to check for all possible existing fields in the
> trace, and add all of those as separate columns. Then you write the
> event information in the relevant columns only, and you end up with a
> CSV with a lot of "holes".

To avoid doing a complete first pass of the trace, you can just
iterate on the event types as described in the metadata, and take note
of all the possible field you can find in the trace. Then, during your
only pass, you already know all your "columns".

As you say, traces such as kernel traces would not play well with a
format based on fixed columns, as most space would be emtpy. It can
make sense if it is your own trace (a userspace trace) and you know
that all events contain more or less the same fields.

> It would be possible to hack ExportToTextRequest.java to have any
> particular behavior. But I'm not sure how this option could be
> implemented and exposed to the user generically.

I think that the babeltrace Python bindings are much better suited for
something like this than TMF though. This can probably be done in a
20-30 lines script.

Simon

> Cheers,
> Alexandre
