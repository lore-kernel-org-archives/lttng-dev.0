From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: babeltrace
Date: Thu, 08 May 2014 11:53:08 -0400
Message-ID: <536BA864.10608__35941.2955389873$1399564728$gmane$org@voxpopuli.im>
References: <CAPxN80BCJuB0u_5pk_a=aWw2gQ99eWK_cRnQ4_Kw6Sf8dEaJCg@mail.gmail.com>
 <534FEA8C.8040504@ericsson.com>
 <CA+jJMxum9CmGNDgkqjW3EVCokWx=f-k-iiAjEsXVfY2EjjxmMg@mail.gmail.com>
 <CAPxN80BRHcyEsVPBAQC-xaaYwZv0Mqzik2SehaXtnrs2Wsdoow@mail.gmail.com>
 <536B2BA4.7060107@voxpopuli.im>
 <CAFXXi0=C3_fSHUNsGYu3xPw8oS84A=bRyeig0R714GfPsvc6=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1WiQd4-0006fa-NA
 for lttng-dev@lists.lttng.org; Thu, 08 May 2014 11:53:03 -0400
In-Reply-To: <CAFXXi0=C3_fSHUNsGYu3xPw8oS84A=bRyeig0R714GfPsvc6=g@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


> To avoid doing a complete first pass of the trace, you can just
> iterate on the event types as described in the metadata, and take note
> of all the possible field you can find in the trace. Then, during your
> only pass, you already know all your "columns".

That's true. Although right now TMF doesn't have an API to ask a trace 
"give me all the event types you have", other than just reading the 
trace ;)

wrt CTF, it's possible to have events in the metadata that don't 
actually show up in the trace. But that's not really a problem, at worst 
you'd end up with empty columns.
