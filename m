From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: babeltrace
Date: Thu, 08 May 2014 03:00:52 -0400
Message-ID: <536B2BA4.7060107__47774.8960526243$1399532510$gmane$org@voxpopuli.im>
References: <CAPxN80BCJuB0u_5pk_a=aWw2gQ99eWK_cRnQ4_Kw6Sf8dEaJCg@mail.gmail.com>
 <534FEA8C.8040504@ericsson.com>
 <CA+jJMxum9CmGNDgkqjW3EVCokWx=f-k-iiAjEsXVfY2EjjxmMg@mail.gmail.com>
 <CAPxN80BRHcyEsVPBAQC-xaaYwZv0Mqzik2SehaXtnrs2Wsdoow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1WiIKB-0003JT-VJ
 for lttng-dev@lists.lttng.org; Thu, 08 May 2014 03:01:00 -0400
In-Reply-To: <CAPxN80BRHcyEsVPBAQC-xaaYwZv0Mqzik2SehaXtnrs2Wsdoow@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jessica Foest <jessica.foest@gmail.com>, =?ISO-8859-1?Q?J=E9r=E9mie_?= =?ISO-8859-1?Q?Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

Every event type has different fields though. So the "columns" would
vary from one event to another.

Although I can see that if you add let's say "context.pid" to ALL
events, then it would be nice in the CSV export to add this as a
separate column. However, the viewer cannot know for sure that all
events in the trace have that particular context enabled. Unless you do
a full pass of the trace first to look for common fields.

Or, you do a first pass to check for all possible existing fields in the
trace, and add all of those as separate columns. Then you write the
event information in the relevant columns only, and you end up with a
CSV with a lot of "holes".

It would be possible to hack ExportToTextRequest.java to have any
particular behavior. But I'm not sure how this option could be
implemented and exposed to the user generically.

Cheers,
Alexandre


On 14-05-07 07:53 PM, Jessica Foest wrote:
> Hi all
>
> i just want to have all the fields in my selected trace represented in a
> separated  column.
> Because when using TMF for example all fields of the context of the event
> are represented in one global field .
>
> i need to have every field in a separate column, that's the point , No
> mystery :)
>
> CSV or excel is just a format , but what i need is a way to parse the CTF
> trace and get every event and every field of the context with its value
> separately.
> Can you help me to do it ?
>
>
>
> 2014-04-17 14:35 GMT-04:00 J=E9r=E9mie Galarneau <jeremie.galarneau@effic=
ios.com
>> :
>> On Thu, Apr 17, 2014 at 10:51 AM, Matthew Khouzam
>> <matthew.khouzam@ericsson.com> wrote:
>>> Hi Jessica,
>>>
>>> <Shameless plug>How about opening it in TMF and right clicking export to
>>> text in the events table?</plug>
>>>
>> The plug may be over, but the shameless tag is still open! ;-)
>>
>>> I am just curious, why do you need to get out of CTF, if a log is ctf,
>>> chances are it's
>>> WAaaaaaaAAAAAAAaaaaaAAAAAAAaaaaaaaaaaaaaayYYYYYyyyyYYYyyyYYYyyyYYYyy to
>>> big for excel, or even calc.
>>>
>> Good point, I'd be curious to know the use case for converting a
>> complete trace to CSV.
>>
>> J=E9r=E9mie
>>
>>> br,
>>> Matthew
>>> On 14-04-16 04:31 PM, Jessica Foest wrote:
>>>> Hi all
>>>>
>>>> i know that the default output format of babeltrace is text .
>>>> what are the others output format supported by babeltrace ?
>>>>
>>>> in my case , i need to convert the CTF log file of lttng to a CSV file
>>>> , did tou have any idea about how can i do it ?
>>>>
>>>> thanks
>>>>
>>>>
>>>> _______________________________________________
>>>> lttng-dev mailing list
>>>> lttng-dev@lists.lttng.org
>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>> --
>> J=E9r=E9mie Galarneau
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
